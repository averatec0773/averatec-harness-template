---
name: git
description: Use before any commit, push, or branch/PR decision. Classifies the change as low- or high-risk to pick the right path (direct commit vs branch + PR), and runs a pre-commit checklist so related docs (CHANGELOG / ROADMAP / conventions / memory) move with the code. Does not replace the harness skill — it defers to it for doc sync.
metadata:
  version: 1.0.0
  category: workflow
  dangerous: true
---

# Git

Commit hygiene plus a risk gate for how work lands. Goal: small changes ship fast,
risky changes get a branch and review, and docs never drift from code.

## Global rules (never violate)

- **Never commit unless the user explicitly asks.**
- **Never force-push to `main` / `master`.**
- **Never skip hooks** (`--no-verify`).

## Risk classification

Decide the path *before* you commit. When unsure, treat it as high-risk.

| | Low-risk | High-risk |
|---|---|---|
| **Examples** | typo, copy, single-file fix, additive non-breaking change, docs | schema / migration, public API or contract change, cross-cutting refactor, dependency bump, anything touching auth / payments / data deletion |
| **Blast radius** | one file / one screen | multiple modules or other repos |
| **Path** | commit on the working branch | new branch → PR → review before merge |

## Pre-commit checklist

Before staging, confirm related files move with the code. The
[harness](../harness/SKILL.md) skill owns the detailed sync logic — this is the trigger.

- [ ] Code change complete and verified (build / tests / manual check, as applicable)
- [ ] `CHANGELOG.md` — user-facing change recorded? → harness skill
- [ ] `ROADMAP.md` — shipped item pruned? → harness skill
- [ ] `conventions/` — new module / pattern / layering rule documented? → harness skill
- [ ] `memory/` — new rule or gotcha worth recording? → memory skill
- [ ] No secrets, debug logs, or commented-out code staged

## Commit message

- Imperative, present tense: `add X`, `fix Y` — not `added` / `fixes`.
- Prefix harness-only changes with `[harness]`.
- Body explains *why* when the change isn't self-evident.

## DO NOT

- Do not bundle an unrelated refactor into a feature commit — separate commits (or branches).
- Do not commit generated / build artifacts.
- Do not push directly to `main` / `master` for high-risk changes.
