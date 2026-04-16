# Project Harness

## Project

<!-- TEMPLATE STATE: fields below are placeholders. If any field still reads [like this], the harness has not been configured for a real project yet. Do not proceed with project work until these are filled in. -->

**Name:** [PROJECT_NAME]
**Description:** [What this project does]
**Stack:** [Language / framework / infra]
**Owner:** [Team or person]

## About this repo

This repo is a harness for AI-assisted project management. All files except `README.md` are written for AI agent consumption: optimized for clarity and parseability, not human prose. `README.md` is the only file intended for human readers.

## Session Start Protocol

At the start of every session:

1. Run `git fetch && git status` — confirm the local repo is up to date with remote. If behind, pull before proceeding.
2. Read `memory/progress.md` — understand current state and next task.
3. Run `git log --oneline -10` — orient to recent history.
4. Confirm working directory before any write or destructive operation.

<!-- FILL: Add project-specific checks (e.g., verify a service is running, check env vars). -->

## Core Rules

1. Read the skill file before any dangerous or irreversible operation.
2. Follow conventions. Do not invent new patterns unless explicitly asked.
3. Add non-obvious discoveries to `memory/lessons.md`.
4. Update `memory/progress.md` before ending a session.

## Index

### Skills
→ [SKILL_INDEX.md](skills/SKILL_INDEX.md)
- [setup](skills/setup/SKILL.md)
- [git](skills/git/SKILL.md)
- [memory](skills/memory/SKILL.md)
- [skill-creator](skills/skill-creator/SKILL.md)

### Conventions
- [git-workflow](conventions/git-workflow.md)
- [testing](conventions/testing.md)

### Memory
- [context](memory/context.md)
- [progress](memory/progress.md)
