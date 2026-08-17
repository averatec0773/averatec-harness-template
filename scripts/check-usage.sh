#!/bin/bash
# check-usage.sh — 统一读取 Claude 订阅 5 小时 / 7 天额度
# 输出一行 JSON: {"source":..., "five_hour_pct":..., "five_hour_resets_at":..., "seven_day_pct":..., "seven_day_resets_at":...}
# 数据源优先级: 1) statusline 落盘文件(官方数据,免鉴权)  2) OAuth 用量端点(官方数据,需 CLI 登录)  3) ccusage 离线估算(仅参考)

STATUSLINE_FILE="$HOME/.claude/usage-latest.json"
MAX_AGE_SECS=600

# --- 1. statusline tee 文件 ---
if [ -f "$STATUSLINE_FILE" ]; then
  age=$(( $(date +%s) - $(stat -f %m "$STATUSLINE_FILE" 2>/dev/null || echo 0) ))
  if [ "$age" -lt "$MAX_AGE_SECS" ]; then
    result=$(/usr/bin/python3 - "$STATUSLINE_FILE" <<'EOF'
import sys, json
try:
    d = json.load(open(sys.argv[1]))
    rl = d.get("rate_limits") or {}
    fh, sd = rl.get("five_hour") or {}, rl.get("seven_day") or {}
    if fh.get("used_percentage") is None: sys.exit(1)
    print(json.dumps({
        "source": "statusline",
        "five_hour_pct": fh.get("used_percentage"),
        "five_hour_resets_at": fh.get("resets_at"),
        "seven_day_pct": sd.get("used_percentage"),
        "seven_day_resets_at": sd.get("resets_at"),
    }))
except Exception:
    sys.exit(1)
EOF
)
    [ -n "$result" ] && { echo "$result"; echo "{\"ts\":\"$(date -u +%FT%TZ)\",\"data\":$result}" >> "$HOME/.claude/usage-log.jsonl"; exit 0; }
  fi
fi

# --- 2. OAuth 用量端点 (依次尝试 .credentials.json 和 Keychain 里的 token, 以 API 响应为准) ---
CANDIDATES=""
T1=$(/usr/bin/python3 -c "
import json
d = json.load(open('$HOME/.claude/.credentials.json'))
print((d.get('claudeAiOauth') or d).get('accessToken', ''))
" 2>/dev/null)
T2=$(security find-generic-password -s "Claude Code-credentials" -w 2>/dev/null | /usr/bin/python3 -c "
import sys, json
print(json.load(sys.stdin).get('claudeAiOauth', {}).get('accessToken', ''))
" 2>/dev/null)
for TOKEN in $T1 $T2 REFRESH; do
  [ "$TOKEN" = "REFRESH" ] && TOKEN=$(/usr/bin/python3 "$(dirname "$0")/refresh-oauth.py" 2>/dev/null)
  [ -z "$TOKEN" ] && continue
  result=$(curl -s --max-time 15 "https://api.anthropic.com/api/oauth/usage" \
    -H "Authorization: Bearer $TOKEN" \
    -H "anthropic-beta: oauth-2025-04-20" \
    -H "User-Agent: claude-code/2.1.177" | /usr/bin/python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    fh, sd = d.get('five_hour') or {}, d.get('seven_day') or {}
    if fh.get('utilization') is None: sys.exit(1)
    print(json.dumps({
        'source': 'oauth_endpoint',
        'five_hour_pct': fh.get('utilization'),
        'five_hour_resets_at': fh.get('resets_at'),
        'seven_day_pct': sd.get('utilization'),
        'seven_day_resets_at': sd.get('resets_at'),
    }))
except Exception:
    sys.exit(1)
" 2>/dev/null)
  [ -n "$result" ] && { echo "$result"; echo "{\"ts\":\"$(date -u +%FT%TZ)\",\"data\":$result}" >> "$HOME/.claude/usage-log.jsonl"; exit 0; }
done

# --- 3. 原生离线估算 (纯 python3 标准库, 扫描本地转录 JSONL, 零第三方依赖) ---
result=$(/usr/bin/python3 "$(dirname "$0")/usage-estimate.py" 2>/dev/null)
[ -n "$result" ] && { echo "$result"; echo "{\"ts\":\"$(date -u +%FT%TZ)\",\"data\":$result}" >> "$HOME/.claude/usage-log.jsonl"; exit 0; }

# --- 4. ccusage 离线估算 (第三方兜底, 仅当原生估算器失败) ---
result=$(npx -y ccusage@latest blocks --json 2>/dev/null | /usr/bin/python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    active = [b for b in d.get('blocks', []) if b.get('isActive')]
    if not active: sys.exit(1)
    b = active[0]
    print(json.dumps({
        'source': 'ccusage_estimate',
        'five_hour_pct': None,
        'block_total_tokens': b.get('totalTokens'),
        'block_end_time': b.get('endTime'),
        'note': 'official pct unavailable; token count is an estimate only',
    }))
except Exception:
    sys.exit(1)
" 2>/dev/null)
[ -n "$result" ] && { echo "$result"; echo "{\"ts\":\"$(date -u +%FT%TZ)\",\"data\":$result}" >> "$HOME/.claude/usage-log.jsonl"; exit 0; }

echo '{"source":"none","error":"no usage data available: statusline file stale/missing, CLI not logged in, ccusage failed"}'
exit 1
