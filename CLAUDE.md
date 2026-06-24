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

## Core Rules

1. Read the skill file before any dangerous or irreversible operation.
2. Follow conventions. Do not invent new patterns unless explicitly asked.
3. Read `memory/rules.md` and apply all rules for the duration of this session.

## Loop protocol

When running under a self-paced `/loop`, treat [loop/STATE.md](loop/STATE.md) as the single source of truth:

1. Read STATE first → pick the next actionable item → do it → update its row → stop. The next firing repeats.
2. **DECISION-GATED items are not implemented** — write a proposal in STATE's "Needs decision" and ask the user.
3. Idempotent: never redo a `DONE` item; leave interrupted work as `DOING` with a note on where you stopped.
4. Stop the loop when every item is `DONE` / `BLOCKED` / `DECISION-GATED`, and report.

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
- [loop/STATE.md](loop/STATE.md) — self-paced `/loop` state; single source of truth across iterations

### Roadmap & history
- [ROADMAP](ROADMAP.md) — pending work, by version
- [CHANGELOG](CHANGELOG.md) — what shipped, per version (older series archived in [changelog/](changelog/README.md))

### Memory
- [rules](memory/rules.md) — standing project rules; read every session
- [notes](memory/notes.md) — discoveries and session notes

### Docs
- `docs/` — long-form specs, plans, design notes (organize per project)
