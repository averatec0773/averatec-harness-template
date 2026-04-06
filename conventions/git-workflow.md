# Git Workflow

Read `skills/git/SKILL.md` for the step-by-step operational guide. This file defines the *rules*; that file explains *how to execute them*.

## Branching strategy

**Main branches:**

| Branch | Purpose | Direct commits allowed |
|--------|---------|----------------------|
| `main` | Production-ready code | No — PRs only |
| `develop` | Integration branch (if used) | No — PRs only |

**Working branches** (created by developers, deleted after merge):

| Prefix | When to use | Example |
|--------|------------|---------|
| `feat/` | New feature | `feat/user-authentication` |
| `fix/` | Bug fix | `fix/login-redirect-loop` |
| `chore/` | Maintenance, deps, config | `chore/update-dependencies` |
| `docs/` | Documentation only | `docs/api-reference` |
| `refactor/` | Code restructure, no behavior change | `refactor/extract-user-service` |

## Commit message format

```
<type>: <short description>

[optional body — explain WHY, not what]

[optional footer — e.g., Closes #123]
```

**Types:** `feat`, `fix`, `chore`, `docs`, `refactor`, `test`, `ci`

**Rules:**
- Subject line: 72 characters max, imperative mood ("add" not "added")
- Do not end subject with a period
- If the why is not obvious, include a body

**Examples:**
```
feat: add email verification on signup

fix: prevent duplicate submissions on payment form

refactor: extract auth middleware into separate module
Motivation: middleware was duplicated across 3 route files
```

## Pull request rules

- PRs target `main` (or `develop` if the project uses it)
- Title follows the same format as commit messages
- PR must be linked to the relevant issue if one exists
- Self-review before requesting others
- Do not merge your own PR unless explicitly allowed

## Merge strategy

- Default: **Squash and merge** (keeps `main` history clean)
- For release branches: **Merge commit** (preserves release history)
- **Rebase and merge:** Only if the branch history tells a clear story worth preserving

## What NOT to do

- Do not commit directly to `main` or `develop`.
- Do not force-push to shared branches.
- Do not merge with failing CI.
- Do not bypass pre-commit hooks (`--no-verify`).
- Do not include unrelated changes in a PR.
