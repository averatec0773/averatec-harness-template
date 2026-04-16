# Git Workflow

## Branch Prefixes

| Prefix | When to use |
|--------|-------------|
| `feat/` | New feature |
| `fix/` | Bug fix |
| `chore/` | Maintenance, deps, config |
| `docs/` | Documentation only |
| `refactor/` | Code restructure, no behavior change |

## Commit Format

```
<type>: <short description>

[optional body — explain WHY, not what]
```

Types: `feat` `fix` `chore` `docs` `refactor` `test` `ci`

- Subject: 72 chars max, imperative mood ("add" not "added"), no trailing period.
- Include a body only when the reason is not obvious from the diff.

## DO NOT

- Do not commit directly to `main` or `develop`.
- Do not force-push to shared branches.
- Do not merge with failing CI.
- Do not bypass pre-commit hooks (`--no-verify`).
- Do not include unrelated changes in a single commit or PR.
