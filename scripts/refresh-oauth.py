#!/usr/bin/env python3
"""Refresh the Claude Code OAuth access token in ~/.claude/.credentials.json.

Uses the standard Claude Code sign-in refresh flow. On success, atomically
rewrites the credentials file (preserving unknown fields) and prints the new
access token to stdout. Exits 1 on any failure without touching the file.
"""
import json, os, sys, tempfile, urllib.request

CRED = os.path.expanduser("~/.claude/.credentials.json")
CLIENT_ID = "9d1c250a-e61b-44d9-88ed-5944d1962f5e"
TOKEN_URL = "https://console.anthropic.com/v1/oauth/token"
COOLDOWN_MARKER = os.path.expanduser("~/.claude/scripts/.refresh-attempt")
COOLDOWN_SECS = 900  # the token endpoint rate-limits aggressively; never hammer it

try:
    import time
    if os.path.exists(COOLDOWN_MARKER) and \
            time.time() - os.path.getmtime(COOLDOWN_MARKER) < COOLDOWN_SECS:
        sys.exit(1)
    open(COOLDOWN_MARKER, "w").close()
except Exception:
    pass

try:
    with open(CRED) as f:
        cred = json.load(f)
    oauth = cred.get("claudeAiOauth") or {}
    rt = oauth.get("refreshToken")
    if not rt:
        sys.exit(1)

    req = urllib.request.Request(
        TOKEN_URL,
        data=json.dumps({
            "grant_type": "refresh_token",
            "refresh_token": rt,
            "client_id": CLIENT_ID,
        }).encode(),
        headers={"Content-Type": "application/json",
                 "User-Agent": "claude-code/2.1.177"},
    )
    with urllib.request.urlopen(req, timeout=20) as resp:
        tok = json.load(resp)

    access = tok.get("access_token")
    if not access:
        sys.exit(1)

    oauth["accessToken"] = access
    if tok.get("refresh_token"):
        oauth["refreshToken"] = tok["refresh_token"]
    if tok.get("expires_in"):
        import time
        oauth["expiresAt"] = int((time.time() + tok["expires_in"]) * 1000)
    cred["claudeAiOauth"] = oauth

    fd, tmp = tempfile.mkstemp(dir=os.path.dirname(CRED))
    with os.fdopen(fd, "w") as f:
        json.dump(cred, f)
    os.chmod(tmp, 0o600)
    os.replace(tmp, CRED)
    print(access)
except Exception:
    sys.exit(1)
