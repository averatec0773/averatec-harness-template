# Changelog

<!-- Format: [YYYY-MM-DD] vX.X.X — description -->

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
