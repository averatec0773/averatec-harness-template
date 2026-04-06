---
name: memory
description: When and how to update memory files after completing work
metadata:
  version: 1.0.0
  category: workflow
  dangerous: false
---

# Memory Update

## When to use this skill

After completing any meaningful unit of work: a feature, a fix, a deployment, or any session end.

## Which file to update

| What happened | Update |
|--------------|--------|
| Session ended or task progressed | `memory/progress.md` |
| Discovered something non-obvious about the project | `memory/lessons.md` |
| Project scope, architecture, or environment changed | `memory/context.md` |

## Steps

1. FILL: Define what counts as "meaningful work" in this project.
2. FILL: Any additional memory files specific to this project.
3. Before ending a session, always update `memory/progress.md` — set Status, Last Session, and Next.

## DO NOT

- Do not record information that is already derivable from the code or git history.
- Do not record ephemeral state (current PR number, temporary workarounds) — only durable facts.
- Do not update memory mid-task; batch updates to the end of a work unit.

## Acceptance Criteria

- A fresh agent starting a new session can orient itself using only `memory/progress.md` + `git log`.
