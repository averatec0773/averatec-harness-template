# Project Harness

<!-- SCAFFOLD — one-time template setup; work top to bottom, then delete this block:
  [ ] Run "## Setup (one-time)" — pick modules, keep / adapt / delete core files
  [ ] Fill Project fields (name / description / stack / owner)
  [ ] Run "## First commit (one-time)" — tracking + commit attribution — then delete that section
  [ ] Fill Component Map, `.claude/scripts/precheck.sh` checks, `.claude/settings.local.json.example`, and every remaining `FILL:` marker in retained files
  List what's left anytime: grep -rn "SCAFFOLD\|FILL\|TEMPLATE STATE" --exclude-dir=.git . -->

## Project

<!-- TEMPLATE STATE: fields below are placeholders. If any retained field still reads [like this], the harness has not been configured for a real project yet. -->

**Name:** [PROJECT_NAME]
**Description:** [What this project does]
**Stack:** [Language / framework / infra]
**Owner:** [Team or person]

> Template files are starting points, not required project features. After setup, treat all retained files except `README.md` as authoritative.

## Agents

This harness is read by multiple AI agents from **one shared spec**:

- **Claude Code** reads `CLAUDE.md` (this file) + `.claude/` (skills, settings, hooks).
- **Codex** reads `AGENTS.md` — a symlink to `CLAUDE.md` — plus `.codex/` (`config.toml`, `hooks.json`).

Edit `CLAUDE.md` only; `AGENTS.md` follows automatically. Agent-specific behavior lives in config (`.claude/` vs `.codex/`), never in the shared spec.

## Setup (one-time)

<!-- SCAFFOLD: delete this whole section once the template fits the real project. -->

Before filling placeholders, inspect the actual source, configs, docs, tests/CI, history and development workflow. A template file is not evidence that its capability exists or is needed.

1. **Pick modules.** Read [modules/README.md](modules/README.md); for each module the project needs, copy the module folder's contents onto the project root (paths inside a module mirror the root) and add the lines its README lists. Then delete `modules/` (also when no module is picked).
2. **Keep / adapt / delete core files.** Keep only what has a real ongoing purpose; rewrite useful parts around the actual workflow; delete irrelevant stubs instead of inventing a use for them.
3. **Repair references.** After a deletion or rename, update the Component Map, Index, README tree, settings/hooks and links; verify documented commands against the repository.
4. **Apply and consume.** Fill markers only in retained files (including the checks in `.claude/scripts/precheck.sh`, which fails until filled); replace the template's history in `CHANGELOG.md` with `## Unreleased`; then delete this section.

## Session Start Protocol

1. `git fetch && git status -sb` (skip the fetch when there is no remote) — confirm the local repo is up to date. If behind, pull before proceeding.
2. `git log --oneline -10` — orient to recent history.
3. Read `memory/rules.md` and `docs/status.md`; reconcile the status board ("Parallel work" below).
4. Confirm the working directory before any write or destructive operation.

<!-- FILL: project-specific checks (e.g., a service is running, env vars are set). -->

## First commit (one-time)

<!-- SCAFFOLD: delete this whole section once the project has its first real commit. -->

1. **Sort files into three buckets** (adapt to what is present):
   - **Agent / harness** — `CLAUDE.md`, `AGENTS.md`, `.claude/`, `.codex/`, `conventions/`, `memory/`, `docs/`, `ROADMAP.md`, `CHANGELOG.md`: track (shared) or keep private (gitignored)?
   - **Sensitive / machine-local** — `.env*`, credentials, tokens, keys, `*.local.*`, personal data, large binaries, generated output. Almost always gitignored; confirm none are staged.
   - **Everything else** — source, config, assets: normally tracked.
2. **Ask the user, per bucket: track / gitignore / keep local-untracked.** Flag anything surprising.
3. **Check commit attribution.** Report whether commits will credit the AI agent (Claude Code: `attribution` in `.claude/settings.json`; other agents have their own setting) and confirm with the user. **Default: no AI attribution** — the template ships `attribution` with empty `commit` and `pr`.
4. **Apply and consume.** Update `.gitignore` (`git rm --cached <path>` anything already tracked that should now be ignored); record the owner's tracking policy as one rule in `memory/rules.md`; then delete this section.

## Core Rules

1. Read the skill file before any dangerous or irreversible operation.
2. Follow conventions. Do not invent new patterns unless explicitly asked.
3. Read `memory/rules.md` and apply all rules for the duration of this session.

## Working with the owner

- **Reports:** outcome first (done / blocked / needs you), then decision cards, then short details; full detail goes in a file, linked. Say which check actually ran.
- **Ask only at a real fork:** two valid approaches, something that cannot be undone or leaves the machine (push, publish, send), or a change of scope. Otherwise do it and report.
- **Decision cards**, one per decision:
  - First line: the question and the recommended option.
  - Now: one or two sentences on what happens today.
  - Each option, the same three parts so options compare line by line: **Result** (what the owner or a user will see), **Change** (what gets edited, in plain words, with rough size; file names when they help), **Cost / undo** (effort, risk, whether it can be reverted).
- **Numbering:** numbers are for decision cards only, options inside a card are A / B / C, other content that needs labels uses letters; each card's title names its subject. At most 3 cards per message, answered as "1A 2B"; when options change, re-issue the whole set.
- **Only an explicit choice counts;** an unclear answer means ask again. A push or publish still needs its own yes, as one plain line at the end of the message.

## Proactive optimization (early / ambiguous phases only)

A user's prompt may be incomplete or miss an angle. Read for the **intent** behind the request. When you see a materially better path the user likely hasn't weighed, **surface it in a line or two and let the user choose** — don't silently substitute your own idea, and don't silently drop it.

This applies during project inception, brainstorming, or when the goal is genuinely ambiguous. Once the user has set a plan or a long task is under way, do **not** interrupt it with optimization detours; park ideas in `ROADMAP.md`. When unsure whether you are still in the open phase, default to not interrupting.

## Verification: reality outranks its description

Everything written here — this file, `conventions/`, a docstring, a test name, a brief you were handed — is a **belief about the system, not the system itself**. Use written context as a starting point to verify, not a source of truth to obey blindly, and flag stale-looking content.

- **Passing tests prove self-consistency, not correctness.** Green is necessary, not sufficient.
- **"Done" means it did the thing, on realistic data, with the result observed.** When you report something works, say which check you actually ran.
- **Prefer the cheapest real observation over another round of reasoning** — run the code, open the page, read the actual output.
- **When a written conclusion drives a decision, check what it was measured against and when.**

This raises the bar on *evidence*, not on caution: check more, don't do less.

<!-- FILL: the project's own cheap, non-destructive ways to "consult reality" — a smoke command, a read-only query, a dev server URL. `bash .claude/scripts/precheck.sh` runs the pre-commit checks. -->

## Parallel work

Several sessions and subagents may work at once. Messages between sessions reach only sessions that are running; the status board is what survives a session going quiet.

- **Status board** ([docs/status.md](docs/status.md)): one row per open item (item, session, files / area, now, waiting on, updated). Add your row before editing shared files, update "now" when a stage finishes, delete the row when the item is done (its last commit) — history lives in git, `CHANGELOG.md` and plan docs.
- **Before touching files in another row:** list running sessions; if that session is running, message it and wait for its answer; if not, the row is the only record.
- **Reconcile at session start:** a row whose session is not running and has not been updated for 2 days → check git and the session list, then write `paused (YYYY-MM-DD)` in its "now" or remove it, and say so in one line.
- **Agreements reached by message** that matter after the conversation go into the row or the plan doc in the same turn.
- **Subagents:** start each with [the agent brief](.claude/skills/harness/references/agent-brief.md), then the task.
- **Staging:** stage explicit paths from `git status -s`, never `git add -A` or a whole folder; check `git status -s` shows every intended path before committing. Stop only processes you started.

## Component Map

Quick lookup — "to change X, edit Y." Fill in as the project grows.

| To change… | Edit | Notes |
|------------|------|-------|
| FILL | FILL | FILL |

## Settings

- Shared permissions and hooks → [.claude/settings.json](.claude/settings.json)
- Personal overrides → `.claude/settings.local.json` (gitignored, auto-created on first session from `.claude/settings.local.json.example`)
- Codex config → [.codex/config.toml](.codex/config.toml) + [.codex/hooks.json](.codex/hooks.json) (mirrors the Claude SessionStart hook)

## Index

### Skills
- [git](.claude/skills/git/SKILL.md) — commit risk classification + pre-commit checklist
- [harness](.claude/skills/harness/SKILL.md) — CHANGELOG / ROADMAP / conventions sync, status board, memory, skills

### Conventions
- [architecture](conventions/architecture.md) — directory map, layering rules, what NOT to change

### Roadmap & history
- [ROADMAP](ROADMAP.md) — open work, by version
- [CHANGELOG](CHANGELOG.md) — what shipped, per version (older series archived in [changelog/](changelog/README.md))
- [docs/status.md](docs/status.md) — board of open work across sessions; rows deleted when done

### Memory
- [rules](memory/rules.md) — standing rules the owner approved; read every session
- [notes](memory/notes.md) — cross-cutting gotchas

### Docs
- [docs/](docs/README.md) — **default home for any doc an agent writes or reads back** (specs, plans, notes, research), grouped by kind in subfolders.

### Scripts
- [.claude/scripts/precheck.sh](.claude/scripts/precheck.sh) — one command for the pre-commit checks; prints ALL PASS or the failing checks
