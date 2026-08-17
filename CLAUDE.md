# Project Harness

## Project

<!-- TEMPLATE STATE: fields below are placeholders. If any field still reads [like this], the harness has not been configured for a real project yet. Do not proceed with project work until these are filled in. -->

**Name:** [PROJECT_NAME]
**Description:** [What this project does]
**Stack:** [Language / framework / infra]
**Owner:** [Team or person]

> All files except `README.md` are agent instructions. Treat them as authoritative.

## Agents

This harness is read by multiple AI agents from **one shared spec**:

- **Claude Code** reads `CLAUDE.md` (this file) + `.claude/` (skills, settings, hooks).
- **Codex** reads `AGENTS.md` — a symlink to `CLAUDE.md`, so both agents get identical instructions — plus `.codex/` (`config.toml`, `hooks.json`).

Edit `CLAUDE.md` only; `AGENTS.md` follows automatically. Agent-specific behavior lives in config (`.claude/` vs `.codex/`), never in the shared spec.

## Session Start Protocol

At the start of every session:

1. Run `git fetch && git status` — confirm the local repo is up to date with remote. If behind, pull before proceeding.
2. Run `git log --oneline -10` — orient to recent history.
3. Confirm working directory before any write or destructive operation.

<!-- FILL: Add project-specific checks (e.g., verify a service is running, check env vars). -->

## First commit (one-time)

<!-- Bootstrap, not standing guidance — delete this whole section once the project has its first real commit. -->

Before this repo's first real commit, decide what to track:

1. **Sort files into three buckets** (adapt to what is present):
   - **Agent / harness** — `CLAUDE.md`, `AGENTS.md`, `.claude/`, `.codex/`, `conventions/`, `memory/`, `loop/`, `docs/`, `ROADMAP.md`, `CHANGELOG.md`: track (shared with the team) or keep private (gitignored, bare-overlay style)?
   - **Sensitive / machine-local** — `.env*`, credentials, tokens, keys, `*.local.*`, personal data, large binaries, generated output, and scripts that read local machine state (e.g. `scripts/refresh-oauth.py` reads `~/.claude` credentials — useful only on a machine that already has them). Almost always gitignored; confirm none are staged.
   - **Everything else** — source, config, assets: normally tracked.
2. **Ask the user, per bucket: track / gitignore / keep local-untracked.** Flag anything surprising (a secret-looking file, a big binary, harness files they may prefer private).
3. **Check commit attribution.** Report whether commits will credit the AI agent as a contributor (Claude Code: `includeCoAuthoredBy` in `.claude/settings.json`; other agents have their own setting) and confirm with the user. **Default: do not attribute the AI agent as a contributor** — this template ships with `includeCoAuthoredBy: false`.
4. **Apply and consume.** Update `.gitignore` (`git rm --cached <path>` anything already tracked that should now be ignored); record the outcome as a one-line tracking policy in `memory/rules.md`; then **delete this section**. Preference remembered, bootstrap steps gone.

## Core Rules

1. Read the skill file before any dangerous or irreversible operation.
2. Follow conventions. Do not invent new patterns unless explicitly asked.
3. Read `memory/rules.md` and apply all rules for the duration of this session.

## Proactive optimization (early / ambiguous phases only)

A user's prompt may be incomplete or miss an angle. Read for the **intent** behind the request, and stay aware of options that would serve the project better than the literal ask. When you see a materially better path the user likely hasn't weighed, **surface it in a line or two and let the user choose** — don't silently substitute your own idea, and don't silently drop it.

**Scope this tightly.** It applies during project inception, brainstorming, or when the goal is genuinely ambiguous. Once the user has set a defined plan, a long task, or a `/loop`, do **not** interrupt that continuity with optimization detours — follow the agreed path and park ideas in `ROADMAP.md` or the loop's Decisions Log instead of derailing. When unsure whether you are still in the open phase, default to not interrupting.

## Verification: reality outranks its description

Everything written here — this file, `conventions/`, a docstring, a test name, a brief you were handed — is a **belief about the system, not the system itself**. Docs drift from code: a map can describe features that no longer exist or miss ones that do, a comment can claim a guard the code skips, a green test can lock in a wrong assumption. Use written context as a starting point to verify, not a source of truth to obey blindly — and flag stale-looking content rather than following it off a cliff.

- **Passing tests prove self-consistency, not correctness.** A test written from the same understanding as the code only confirms that understanding. Green is necessary, not sufficient.
- **"Done" means it did the thing, on realistic data, with the result observed** — not "the gates are green". When you report something works, say which check you actually ran.
- **Prefer the cheapest real observation over another round of reasoning** — run the code, open the page, read the actual output or rows. Real data carries shapes fixtures don't.
- **When a written conclusion drives a decision, check what it was measured against and when.** Facts age; conclusions rot faster.

This raises the bar on *evidence*, not on caution: it should make you check more, not do less. Don't manufacture ceremony or refuse to act where a quick look settles it.

<!-- FILL: the project's own cheap, non-destructive way to "consult reality" — e.g. a throwaway-data run, a read-only query, a smoke command. Keep it safe to run repeatedly. -->

## Loop protocol

Long-running loops are launched with the canonical input at the top of
[loop/PROMPT.md](loop/PROMPT.md) — a single fixed line that only says "read
loop/PROMPT.md and run one iteration". All real logic lives in that file, so it
can be hot-edited between iterations without breaking the wake-up chain.
[loop/STATE.md](loop/STATE.md) is the single source of truth across iterations:

1. Read STATE first → pick the next actionable item → do it → update its row → stop. The next firing repeats.
2. **Unattended by default** — never ask the user anything mid-loop. Decide
   autonomously (best confidence × reversal-cost), record every non-obvious
   decision in STATE's "Decisions Log", tag `[REVIEW]` for later human eyes.
   Only if the user explicitly requested an *attended* loop do DECISION-GATED
   items exist: park them under "Decisions Log" as proposals and ask.
3. Idempotent: never redo a `DONE` item; leave interrupted work as `DOING` with a note on where you stopped.
4. Every iteration runs the usage-budget protocol in loop/PROMPT.md PART 1 before any task work.
5. Stop the loop when every item is `DONE` / `BLOCKED`, and report.

## Component Map

Quick lookup — "to change X, edit Y." Fill in as the project grows; the goal is one-glance navigation.

| To change… | Edit | Notes |
|------------|------|-------|
| FILL | FILL | FILL |

## Settings

- Shared permissions → [.claude/settings.json](.claude/settings.json)
- Personal overrides → `.claude/settings.local.json` (gitignored, auto-created on first session from `.claude/settings.local.json.example`)
- Codex config → [.codex/config.toml](.codex/config.toml) + [.codex/hooks.json](.codex/hooks.json) (mirrors the Claude SessionStart hook)

## Index

### Skills
<!-- Auto-loaded by Claude Code based on each skill's description field. -->
- [git](.claude/skills/git/SKILL.md) — commit risk classification + pre-commit checklist
- [memory](.claude/skills/memory/SKILL.md) — record/recall rules and discoveries
- [harness](.claude/skills/harness/SKILL.md) — keep CHANGELOG / ROADMAP / conventions in sync
- [skill-creator](.claude/skills/skill-creator/SKILL.md) — author or revise skills

### Conventions
- [architecture](conventions/architecture.md) — directory map, layering rules, what NOT to change
- [style](conventions/style.md) — visual / UX direction: tokens, components, patterns

### Loop
- [loop/PROMPT.md](loop/PROMPT.md) — canonical launch line, usage-budget protocol, task protocol; hot-editable between iterations
- [loop/STATE.md](loop/STATE.md) — self-paced `/loop` state; single source of truth across iterations
- [scripts/check-usage.sh](scripts/check-usage.sh) — subscription quota check used by PART 1 (official API first, native offline estimate as fallback)

### Roadmap & history
- [ROADMAP](ROADMAP.md) — pending work, by version
- [CHANGELOG](CHANGELOG.md) — what shipped, per version (older series archived in [changelog/](changelog/README.md))

### Memory
- [rules](memory/rules.md) — standing project rules; read every session
- [notes](memory/notes.md) — discoveries and session notes

### Docs
- [docs/](docs/README.md) — **default home for any doc an agent writes or reads back** (specs, plans, notes, research), unless the project defines another location or the user says otherwise. Group by kind in subfolders (`docs/specs/`, `docs/plans/`, …) as categories appear; don't pile files in the root. See [docs/README.md](docs/README.md).
