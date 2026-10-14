# Modules

Optional parts for projects that need them. Template only: during setup, copy the modules the project needs onto the project root, then delete `modules/` from the project.

Paths inside a module mirror the project root: `modules/ui/conventions/style.md` becomes `conventions/style.md`. Each module's README says what it adds, which projects need it, the lines to add to `CLAUDE.md`, and how to remove it.

| Module | Adds | Needed by |
|---|---|---|
| [ui](ui/README.md) | `conventions/style.md` (visual direction, tokens, components, checks) | projects with a user interface |

## Candidates (not modules yet)

A part becomes a module only after it has run in a real project for a while and a second project needs it. Until then it is listed here.

| Candidate | What it is | Which projects would need it | Proven in |
|---|---|---|---|
| Multi-repo / public boundary | routing table (which path goes to which repo), a public-boundary check script, a "never stage" list | private data or code next to a public or deployed repo | nivalis-nights-wiki |
| Fact base | claims with evidence status, sources, open questions, lint, independent review | projects whose output states facts about a system they do not own (game wiki, research, third-party API docs) | nivalis-nights-wiki (game-specific tooling) |
| Weekly dashboard | per-page cards, weekly notes, a generated dashboard page | long-running products with a weekly owner review | nivalis-nights-wiki (new, 2026-10-13) |
| Public copy voice | voice rules for user-facing text, AI tells to remove | projects with public copy | nivalis-nights-wiki |
