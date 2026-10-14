# Module: ui

**Adds:** `conventions/style.md` — visual direction (north star, anti-patterns, surface modes), tokens with reasons, typography, components, spacing, interactions, checks.

**Needed by:** projects with a user interface (web, desktop, CLI output with a deliberate look).

**Install:** copy `conventions/style.md` onto the project root, then add to `CLAUDE.md`:

- Index → Conventions: `- [style](conventions/style.md) — visual / UX direction: tokens, components, patterns, checks`
- Component Map: a row for where the tokens live.

The harness skill already treats a pattern shipped in 3+ places as a reason to update `conventions/`.

**Remove:** delete `conventions/style.md` and the two lines above.

## Optional external skills

Not part of the module and not tested in a project built from this template; listed so a project can choose. When one is installed, `conventions/style.md` still wins.

| Skill | What it does | Notes |
|---|---|---|
| [Vercel web-design-guidelines](https://github.com/vercel-labs/agent-skills/tree/main/skills/web-design-guidelines) | review only: ~100 rules (accessibility, focus, forms, motion, performance), reports file:line | never changes the look; fetches its rules from a URL at run time; the rules are MIT ([web-interface-guidelines](https://github.com/vercel-labs/web-interface-guidelines)), the wrapper repo had no license file (2026-10-14) |
| [Anthropic frontend-design](https://github.com/anthropics/skills/tree/main/skills/frontend-design) | building new pages: choose a direction, avoid generic AI looks, build, check | for new pages or a redesign; on an existing look it pulls towards its own taste; Apache-2.0 |

Install from the source rather than copying files into the project: copies go stale.
