# Naming Conventions

Consistent naming reduces cognitive load. Follow these rules across the entire codebase.

## Files and Directories

| Type | Convention | Example |
|------|-----------|---------|
| Source files | [e.g., kebab-case] | `user-profile.ts` |
| Test files | [e.g., same name + .test] | `user-profile.test.ts` |
| Directories | [e.g., kebab-case] | `user-profile/` |
| Config files | [e.g., dot files] | `.eslintrc.json` |

## Variables and Functions

| Type | Convention | Example |
|------|-----------|---------|
| Variables | [e.g., camelCase] | `userName` |
| Functions | [e.g., camelCase, verb prefix] | `getUserById()` |
| Constants | [e.g., SCREAMING_SNAKE_CASE] | `MAX_RETRY_COUNT` |
| Classes | [e.g., PascalCase] | `UserRepository` |
| Interfaces/Types | [e.g., PascalCase] | `UserProfile` |
| Private fields | [e.g., _camelCase prefix] | `_cachedUser` |

## Database

| Type | Convention | Example |
|------|-----------|---------|
| Tables | [e.g., snake_case, plural] | `user_profiles` |
| Columns | [e.g., snake_case] | `created_at` |
| Indexes | [e.g., idx_table_column] | `idx_users_email` |

## API Routes

| Type | Convention | Example |
|------|-----------|---------|
| Endpoints | [e.g., kebab-case, plural nouns] | `/api/user-profiles` |
| Query params | [e.g., snake_case] | `?page_size=20` |

## Git

See [git-workflow.md](git-workflow.md) for branch and commit naming.

## What NOT to do

- Do not abbreviate names unless the abbreviation is universally understood (e.g., `id`, `url`, `api`).
- Do not use single-letter variable names outside of loop counters (`i`, `j`).
- Do not use meaningless names like `data`, `temp`, `stuff`, `helper`.
