# Modules

Optional parts for projects that need them. Template only: during setup, copy the modules the project needs onto the project root, then delete `modules/` from the project.

Paths inside a module mirror the project root: `modules/ui/conventions/style.md` becomes `conventions/style.md`. Each module's README says what it adds, which projects need it, the lines to add to `CLAUDE.md`, and how to remove it.

| Module | Adds | Needed by |
|---|---|---|
| [ui](ui/README.md) | `conventions/style.md` (visual direction, tokens, components, checks) | projects with a user interface |
