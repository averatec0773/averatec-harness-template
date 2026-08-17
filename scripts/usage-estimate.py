#!/usr/bin/env python3
"""Native 5-hour-block token estimator. Zero third-party deps.

Replicates ccusage's core logic: scan ~/.claude/projects/**/*.jsonl,
sum token usage of assistant entries, bucket into 5-hour blocks
(block starts at the UTC hour floor of the first activity after the
previous block ends or after a >5h gap). Prints the active block as JSON,
or exits 1 if there is no active block / no data.
"""
import json, os, sys, glob, time
from datetime import datetime, timezone, timedelta

HOME = os.path.expanduser("~")
LOOKBACK_H = 48
BLOCK = timedelta(hours=5)

now = datetime.now(timezone.utc)
cutoff = now - timedelta(hours=LOOKBACK_H)

entries = []  # (ts, tokens)
seen = set()
for path in glob.glob(os.path.join(HOME, ".claude", "projects", "*", "*.jsonl")):
    try:
        if os.path.getmtime(path) < cutoff.timestamp():
            continue
        with open(path, errors="replace") as f:
            for line in f:
                if '"usage"' not in line:
                    continue
                try:
                    d = json.loads(line)
                except Exception:
                    continue
                if d.get("type") != "assistant":
                    continue
                msg = d.get("message") or {}
                u = msg.get("usage") or {}
                ts_raw = d.get("timestamp")
                if not u or not ts_raw:
                    continue
                key = (d.get("requestId"), msg.get("id"))
                if key != (None, None):
                    if key in seen:
                        continue
                    seen.add(key)
                try:
                    ts = datetime.fromisoformat(ts_raw.replace("Z", "+00:00"))
                except Exception:
                    continue
                if ts < cutoff:
                    continue
                tok = sum(u.get(k) or 0 for k in (
                    "input_tokens", "output_tokens",
                    "cache_creation_input_tokens", "cache_read_input_tokens"))
                if tok:
                    entries.append((ts, tok))
    except OSError:
        continue

if not entries:
    sys.exit(1)

entries.sort(key=lambda e: e[0])
blocks = []  # [start, end, total]
last_ts = None
for ts, tok in entries:
    if not blocks or ts >= blocks[-1][1] or (last_ts and ts - last_ts > BLOCK):
        start = ts.replace(minute=0, second=0, microsecond=0)
        blocks.append([start, start + BLOCK, 0])
    blocks[-1][2] += tok
    last_ts = ts

active = [b for b in blocks if b[0] <= now < b[1]]
if not active:
    sys.exit(1)
b = active[-1]
print(json.dumps({
    "source": "local_estimate",
    "five_hour_pct": None,
    "block_total_tokens": b[2],
    "block_end_time": b[1].strftime("%Y-%m-%dT%H:%M:%S.000Z"),
    "note": "native offline estimate from local transcripts; official pct unavailable",
}))
