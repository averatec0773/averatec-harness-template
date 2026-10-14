---
name: harness
description: Keeps the harness true. MANDATORY before any `git tag`, `git push origin v*`, or "ship / release / cut vX.Y.Z" (CHANGELOG, ROADMAP, conventions). Also use after a commit adding a feature or structure, at a checkpoint or handoff (status board), when the owner sets a rule or corrects how the agent works (memory), on a process gotcha, and when adding or editing a skill or CLAUDE.md.
metadata:
  version: 3.0.0
  category: workflow
  dangerous: false
---

# Harness

Keeps the agent-facing files aligned with what shipped and with how the owner wants work done. Tell the user one line per file touched.

## Checklist by moment

| Moment | Do |
|---|---|
| Release / tag (mandatory) | "Release" below |
| After a non-trivial commit | user-facing change → CHANGELOG bullet; new structure → `conventions/architecture.md`; a pattern reused in 3+ places → the matching convention. If none, don't invent work |
| Starting work on shared files | add your row to `docs/status.md` (CLAUDE.md "Parallel work") |
| A stage of work finished | update your row's "now"; item done (last commit) → delete the row |
| Owner sets a rule or corrects you | "Memory" below |
| Process gotcha found | `memory/notes.md` |
| Starting a subagent | paste [references/agent-brief.md](references/agent-brief.md), then the task |
| Skill or CLAUDE.md change | "Skills" below |

## What each file owns

| File | Purpose | Update when |
|---|---|---|
| `CHANGELOG.md` | what shipped, per version, from a user's view | every shipped version; harness-only entries prefixed `[harness]` |
| `ROADMAP.md` | open work only, by version | an item ships → remove it; scope shifts → rewrite it; never checkpoints |
| `conventions/*.md` | layering rules, directory map, what not to change (+ module conventions) | a new module, layer rule, build/deploy change, or a pattern shipped in 3+ places |
| `docs/status.md` | board of open work across sessions | rows only; never a log |
| `memory/rules.md`, `memory/notes.md` | owner-approved rules; cross-cutting gotchas | "Memory" below |
| CLAUDE.md Component Map | "to change X, edit Y" | an answer changed |

## Release

1. Identify the version (`vX.Y.Z`) and its commits: `git log <prev-tag>..HEAD --oneline`.
2. Update `CHANGELOG.md`, newest first (format below).
3. Prune shipped items from `ROADMAP.md`; rewrite partially shipped ones.
4. Check `conventions/`, or say "conventions unchanged".
5. Tell the user one line per file touched. Do not choose a version, create tags or push on your own.

CHANGELOG format: `## Unreleased` collects changes until the owner names a version, then becomes the heading. Sections are themes users recognise; bullets say what changed for the user, with the old behaviour when it matters; backticks for paths.

```
## 0.X.Y (YYYY-MM-DD)

### Theme in plain words
- What changed, from the user's view.
```

When `CHANGELOG.md` exceeds ~10 released versions or ~250 lines, move the oldest series to `changelog/0.X.Yx.md`, add a row to [changelog/README.md](../../../changelog/README.md), and leave an "Older releases → `changelog/`" pointer.

## Memory

Three kinds of things get written down; each has one home.

| Kind | What it is | Where | When |
|---|---|---|---|
| **Rule** | how the agent works on every future task | `memory/rules.md`: `- [rule] — [reason] (YYYY-MM-DD)` | only when the owner says it applies going forward ("always / never / from now on / remember") or corrects the same thing a second time. Propose the wording in one line ("Record as a rule: …?") and write after a yes |
| **Decision** | a choice for one piece of work (a decision-card answer such as "1A") | the plan doc's decision lines, the commit message, or the code it shaped | at the moment it is made; never in `rules.md`. A decision that keeps coming back may be proposed as a rule |
| **Gotcha** | a tooling or environment trap a fresh agent would hit again | `memory/notes.md`: `[YYYY-MM-DD] — [what was found]`; a gotcha of one work area goes into that area's skill | at the moment it is found |

- Keep `rules.md` under ~40 lines. Over that, list merge / delete candidates and let the owner pick.
- Do not record what the code, git history, CLAUDE.md or a skill already says.
- A rule a script can check belongs in `.claude/scripts/precheck.sh` or a hook, not in prose.
- Repo `memory/` is the one memory (shared with Codex, versionable); `autoMemoryEnabled` is off in `.claude/settings.json`.
- Edit memory and harness files with Edit / Write. A scripted edit anchors on a string that occurs exactly once (assert the count) and is checked with grep afterwards.

## Skills

- Live in `.claude/skills/<name>/SKILL.md`; detail in `references/`, linked one level deep from SKILL.md.
- Frontmatter: `name` (kebab-case), `description`, `metadata` (`version`, `category`, `dangerous: true` when any step is irreversible).
- Description: what it does + when to use, specific trigger terms, distinct from the other skills, at most ~400 characters.
- Body: a short checklist first, then only what an agent would not know; well under 150 lines.
- One rule in one place: CLAUDE.md holds each hard rule as one line with a pointer to the skill that holds the procedure; other skills point instead of copying.
- Test a changed skill with a fresh subagent that sees only the skill descriptions and a realistic task: does it pick the skill and find the steps?
- After renaming or removing a skill, grep CLAUDE.md, `conventions/`, `memory/`, `docs/` and the other skills for the old name.

## DO NOT

- Do not write vague CHANGELOG bullets ("fixed bug"); state the symptom and the change.
- Do not append to `docs/status.md` as a log, or keep finished rows.
- Do not add a rule the owner did not approve.
- Do not invent architecture or style notes for patterns that have not shipped.
