#!/usr/bin/env bash
# One-command pre-commit check. Prints one line per check, then ALL PASS or FAILED: <names>.
# Full output of a failed check: $TMP/precheck-<name>.log
# Usage: bash .claude/scripts/precheck.sh
cd "$(dirname "$0")/../.." || exit 2
OUT="${TEMP:-/tmp}"
fails=""; ran=0
check() { # check <name> <pattern that must appear in the output> <command...>
  local name="$1" must="$2"; shift 2
  local log="$OUT/precheck-$name.log"; ran=$((ran+1))
  if "$@" >"$log" 2>&1 && grep -qE "$must" "$log"; then echo "  ok    $name"; rm -f "$log"
  else echo "  FAIL  $name  ($log)"; fails="$fails $name"; fi
}
echo "precheck $(date '+%Y-%m-%d %H:%M') · $(git status -sb | head -1 | sed 's/^## //') · $(git status -s | wc -l | tr -d ' ') changed"
# FILL: one line per check, e.g.
# check tests '.'  npm test
# check lint  '.'  npm run lint
if [ "$ran" -eq 0 ]; then echo "NO CHECKS: fill in precheck.sh"; exit 1; fi
if [ -z "$fails" ]; then echo "ALL PASS"; else echo "FAILED:$fails"; exit 1; fi
