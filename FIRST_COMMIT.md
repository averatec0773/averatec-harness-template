# First-commit protocol (one-time)

Run this **once**, before this project's first real commit, then consume it (step 4).
It decides what gets tracked, ignored, or kept local — so nothing sensitive is pushed and
nothing needed is lost. If the git history already holds real project commits, this
protocol is done — delete this file.

## Steps

1. **Inventory the repo into three buckets** (adapt to what is actually present):
   - **Agent-reading / harness files** — `CLAUDE.md`, `AGENTS.md`, `.claude/`, `.codex/`,
     `conventions/`, `memory/`, `loop/`, `docs/`, `ROADMAP.md`, `CHANGELOG.md`. Track
     (shared with the team) or keep private (gitignored, like a bare-repo overlay)?
   - **Sensitive / local-only** — `.env*`, credentials, tokens, keys, `*.local.*`,
     personal data, large binaries, generated output. These are almost always gitignored;
     confirm none are already staged.
   - **Everything else** — source, config, assets. Normally tracked.
2. **Present the buckets to the user and ask, per bucket: track / gitignore / keep
   local-untracked.** Call out anything surprising — a secret-looking file, a big binary,
   harness files they may prefer to keep private.
3. **Apply the answers.** Update `.gitignore`; `git rm --cached <path>` anything already
   tracked that should now be ignored. Do not commit yet unless the user asked.
4. **Consume this protocol.** Replace this file's contents with the short record below
   (filled in), so the one-time steps stop loading into future sessions but the preference
   is remembered. Then delete the "One-time (fresh template)" line from `CLAUDE.md`'s
   Session Start Protocol.

<!-- After consumption, this file should contain ONLY the block below (steps above deleted).
     Alternatively, move the policy into memory/rules.md and delete this file entirely —
     either one keeps the preference without the verbose protocol. -->

## Tracking policy (template — fill on consumption)

```
# Tracking policy (decided YYYY-MM-DD)
- Harness / agent files (CLAUDE.md, .claude/, .codex/, conventions/, memory/, loop/, docs/): <tracked | private>
- Sensitive / local: gitignored — <patterns, e.g. .env*, *.local.*, credentials>
- Notable exceptions: <anything non-obvious a future session should know>
```
