# Changelog

<!-- Format: [YYYY-MM-DD] vX.X.X — description -->

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
