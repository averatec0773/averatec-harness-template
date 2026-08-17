# Changelog

<!-- Format: [YYYY-MM-DD] vX.X.X — description -->

## [0.4.2] - 2026-08-17 — Scaffold marker convention

### [harness] Changed
- `CLAUDE.md` ephemeral content is now greppable: delete-after content tagged `SCAFFOLD:` (First commit section), replace content stays `FILL:` / `TEMPLATE STATE:`. Added a top-of-file `SCAFFOLD` setup checklist listing the one-time tasks, ending with `grep -n "SCAFFOLD\|FILL\|TEMPLATE STATE" CLAUDE.md` to list what's left. Convention kept in-file, not in the harness skill.

## [0.4.1] - 2026-08-17 — Inline first-commit, attribution default, proactive optimization

### [harness] Added
- **`## Proactive optimization` rule in `CLAUDE.md`** — when a prompt is incomplete or misses an angle, read for intent and surface a materially better option in a line or two for the user to choose. Scoped tightly to project inception / brainstorming / ambiguous goals; explicitly must **not** interrupt a defined plan or a `/loop` (park ideas in `ROADMAP.md` or the loop's Decisions Log instead).
- **Commit-attribution step** in the first-commit section — report whether commits credit the AI agent as a contributor and confirm with the user; **default is not to attribute the AI**. Template now ships `includeCoAuthoredBy: false` in `.claude/settings.json`.

### [harness] Changed
- **First-commit protocol moved from `FIRST_COMMIT.md` into `CLAUDE.md`** as a self-deleting `## First commit (one-time)` section (consumes into a one-line tracking policy in `memory/rules.md`, then deletes itself). `FIRST_COMMIT.md` removed; README tree and Session Start pointer updated.
- First-commit "sensitive / machine-local" bucket now calls out scripts that read local machine state (e.g. `scripts/refresh-oauth.py` → `~/.claude`) as usable only where those credentials exist.

## [0.4.0] - 2026-08-17 — Verification, docs convention, first-commit protocol

### [harness] Added
- **`## Verification` section in `CLAUDE.md`** — "reality outranks its description": docs/tests are beliefs about the system, green proves self-consistency not correctness, "done" means observed on realistic data. Distilled (project-agnostic) from offeros; closes with an explicit anti-overfit note ("raises the bar on evidence, not caution — check more, don't do less") plus a `FILL` for the project's own cheap way to consult reality.
- **`docs/` convention** — new `docs/README.md` documents the organizing rule: `docs/` is the default home for any doc an agent writes or reads back; group by kind in subfolders (`docs/specs/`, `docs/plans/`, …) as categories appear rather than piling files in the root. `CLAUDE.md` Docs index entry expanded to match; redundant `docs/.gitkeep` removed.
- **`FIRST_COMMIT.md`** — one-time, self-consuming protocol run before a project's first real commit: inventory files into agent/harness · sensitive/local · everything-else buckets, ask the user track/ignore/keep-local per bucket, apply to `.gitignore`, then rewrite itself into a terse "Tracking policy" record (and drop its `CLAUDE.md` pointer) so the verbose steps stop loading while the preference is remembered. Gated pointer added to `CLAUDE.md` Session Start Protocol.
- **Loop infrastructure (full)** — `loop/PROMPT.md` (canonical launch line + usage-budget protocol PART 1 + task protocol, hot-editable between iterations); `scripts/check-usage.sh` (subscription 5h/7d quota check, official API → native offline fallback), `scripts/usage-estimate.py` (native 5h-block token estimator), `scripts/refresh-oauth.py` (refresh the local Claude Code OAuth token). Extends the lightweight loop shipped in 0.3.0.

### [harness] Changed
- `loop/STATE.md` reworked to **unattended-by-default**: autonomous decisions recorded in a "Decisions Log" with rationale + `[REVIEW]` tags; `DECISION-GATED` items exist only in explicitly-attended loops. `CLAUDE.md` Loop protocol and Index updated to match (adds `loop/PROMPT.md`, `scripts/check-usage.sh`).
- `README.md` "What's in this template" tree refreshed: added `FIRST_COMMIT.md`, `docs/README.md`, `scripts/refresh-oauth.py`.

## [0.3.0] - 2026-06-24 — Multi-agent + loop support

### [harness] Added
- **Codex / multi-agent support** — `AGENTS.md` symlink → `CLAUDE.md` (one shared spec for both agents), plus `.codex/config.toml` (personality + `codex_hooks`) and `.codex/hooks.json` (mirrors the Claude SessionStart git-status hook). New `## Agents` section in `CLAUDE.md` explains the shared-spec model.
- **Loop support (lightweight)** — `loop/STATE.md` template: single source of truth for the self-paced `/loop` (MODE flag, backlog table, status legend, DECISION-GATED gate). New `## Loop protocol` section in `CLAUDE.md` (read STATE → act → update → stop; gated items ask the user).
- **`.claude/skills/git/`** — re-added as a workflow skill: low/high-risk classification matrix + pre-commit checklist that defers to the `harness` skill for doc sync (ported from averatec-website, generalized).
- **`changelog/` archive** — `changelog/README.md` index + rolling rule; the `harness` skill now documents when to roll older series out of `CHANGELOG.md` (~10 versions / ~250 lines).
- **Component Map** — `CLAUDE.md` gains a "to change X, edit Y" lookup-table skeleton (ported from averatec-website).

### [harness] Changed
- `CLAUDE.md` index restructured: added `git` skill, a `Loop` section, a `.codex` settings entry, and a `changelog/` archive pointer.
- `README.md` "What's in this template" tree refreshed to current reality (removed stale `setup`/`changelog` skills and `git-workflow`/`testing` conventions; added `.codex/`, `loop/`, `changelog/`, `ROADMAP.md`, `docs/`). Use-this-template steps note symlink preservation and `core.symlinks`.

## [0.2.0] - 2026-05-17 — Template restructure

### [harness] Added
- `ROADMAP.md` at repo root — versioned plan template with roadmap principles (one PR = one version, refactor in its own version, YAGNI)
- `conventions/style.md` — visual / UX direction template (north star, color tokens, typography, components, density, anti-patterns) ported and generalized from beatos `design-direction.md`
- `docs/` folder — empty placeholder for long-form specs / plans / design notes
- `LICENSE` — MIT placeholder at repo root
- `.claude/skills/harness/` — new skill that supersedes `changelog`; covers CHANGELOG + ROADMAP pruning + conventions drift check in one workflow, with mandatory triggers on `git tag` / `git push origin v*` / "ship / release / cut vX.Y.Z"

### [harness] Removed
- `conventions/git-workflow.md` — superseded by global `commit-commands:*` and `superpowers:*` skills
- `conventions/testing.md` — projects bring their own testing conventions; no template value
- `.claude/skills/git/` — superseded by global skills
- `.claude/skills/setup/` — projects bring their own setup; no template value
- `.claude/skills/changelog/` — replaced by `harness` skill

### [harness] Changed
- `CLAUDE.md` index restructured: skills trimmed to memory / harness / skill-creator; conventions trimmed to architecture / style; new sections for Roadmap & history and Docs

## v0.1.0 — 2026-04-16

Initial release of averatec-harness-template.

- CLAUDE.md with project placeholder, session start protocol, core rules, and harness index
- Skills moved to .claude/skills/ for Claude Code auto-loading: setup, git, memory, changelog, skill-creator
- Memory restructured: rules.md (agent behavior rules) and notes.md (discoveries and manual notes)
- Conventions: git-workflow, testing
- TODO.md template (gitignored in active projects)
- README with Claude Code compatibility note and harness engineering references
