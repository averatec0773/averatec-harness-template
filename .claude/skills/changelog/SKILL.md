---
name: changelog
description: Update CHANGELOG.md when the user explicitly asks to record a change, or when committing a meaningful change — a feature, fix, or breaking change with real user or project impact. Do not trigger for minor edits, refactors, or internal cleanups. Always mention to the user when writing to changelog.
metadata:
  version: 1.0.0
  category: workflow
  dangerous: false
---

# Changelog

## When to use this skill

After any meaningful unit of work: a new feature, bug fix, breaking change, or harness update. Not needed for minor typo fixes or internal refactors with no external impact.

## Format

```
## [YYYY-MM-DD] vX.X.X — optional version label

### Added / Changed / Fixed / Removed
- [description of what changed and why it matters]
```

Use `Added`, `Changed`, `Fixed`, or `Removed` — only include the sections that apply.

## What to record

| Change type | Record it? |
|-------------|-----------|
| New feature or behavior | Yes |
| Bug fix | Yes |
| Breaking change | Yes — note what breaks and how to migrate |
| Harness skill or convention update | Yes — prefix with `[harness]` |
| Dependency update with impact | Yes |
| Internal refactor, no behavior change | No |
| Typo fix | No |

## DO NOT

- Do not describe *what* the code does — describe *what changed* and *why it matters* to someone picking up the project.
- Do not leave entries vague: "fixed bug" is not useful. "Fixed login redirect loop on expired sessions" is.

## Acceptance Criteria

- [ ] Entry is dated and describes the change from a user or agent perspective
- [ ] Breaking changes include migration notes
- [ ] Harness-only changes are prefixed with `[harness]`

## After writing

Always tell the user what was recorded in one line.
