---
name: harness
description: Keep harness docs in sync with shipped code. **MANDATORY before any `git tag -a vX.Y.Z`, `git push origin v*`, or when the user says "ship / release / cut vX.Y.Z"** — verify `CHANGELOG.md` has an entry for that exact version, prune the matching item from `ROADMAP.md`, and review whether `conventions/` needs an update. Also use after committing a new feature, a new structural component, a new pattern reused 3+ times, a breaking change, or whenever the user says "update changelog / roadmap / conventions". Skip for typo fixes and internal refactors with no external impact. Always tell the user one line per file touched.
metadata:
  version: 2.0.0
  category: workflow
  dangerous: false
---

# Harness sync

Keeps the canonical agent-instruction files aligned with what actually shipped: `CHANGELOG.md`, `ROADMAP.md`, `conventions/architecture.md`, `conventions/style.md`. The harness IS the agent's spec — drift here means future sessions get stale context.

## When to use

**Mandatory** (no judgment — run before the action):

- About to `git tag -a vX.Y.Z …` or `git push origin vX.Y.Z`
- User says "ship", "release", "cut v0.X.Y", "tag and push", or equivalent
- User says "update changelog", "update roadmap", "update conventions", or asks to sync any of these docs

**Discretionary** (use judgment after a meaningful commit):

- New user-facing feature, behavior, or bug fix → CHANGELOG candidate
- New module / migration / IPC channel / cross-cutting component → `architecture.md` candidate
- New visual pattern (color token, component variant, layout rule) reused or about to be reused in 3+ places → `style.md` candidate
- Breaking change → CHANGELOG entry with migration notes required
- Skip entirely: typo fixes, internal refactors with no external impact, comment-only changes, formatting-only commits

## What each file owns

| File | Purpose | When to update |
|---|---|---|
| `CHANGELOG.md` | What shipped, per version, from a user perspective | Every shipped version. Bug fixes, features, breaking changes, harness updates (prefix `[harness]`). |
| `ROADMAP.md` | What's planned, by version. Past versions live in CHANGELOG. | When a version ships → remove the corresponding bullet. When scope shifts → update the candidate bullets. |
| `conventions/architecture.md` | Code-level layering rules, directory map, "what NOT to change", per-version capability notes | When a version introduces a new module, migration, IPC channel, cross-cutting component, or layering rule. |
| `conventions/style.md` | Canonical visual / UX direction: tokens, components, patterns | Only when a real artifact ships and reveals a token gap, a pattern is reused in 3+ places, or the user reverses a prior direction. Not per-version. |

Vocab / glossary files and platform-specific maps update only when the underlying external source changes — not on every ship.

## Steps (ship path — mandatory triggers)

1. **Identify the version** (`vX.Y.Z`) and the commits in it: `git log <prev-tag>..HEAD --oneline`.
2. **Update `CHANGELOG.md`** following the format below. Newest entry at top under the file header.
3. **Update `ROADMAP.md`**:
   - If a roadmap item shipped, remove the bullet. Default: remove (CHANGELOG already serves as history).
   - If only part of an item shipped, rewrite the remaining sub-bullets.
   - If the version contained scope outside the roadmap, mention it briefly in CHANGELOG only — don't backfill ROADMAP.
4. **Check `conventions/`**:
   - Did this version introduce a new module / migration / IPC channel / cross-cutting helper / layering rule? → update `conventions/architecture.md`.
   - Did this version introduce a visual pattern already shipped in 3+ places? → update `conventions/style.md`. Don't add speculative patterns.
   - Neither applies → state that explicitly to the user ("conventions unchanged this version").
5. **Tell the user** one line per file touched: `CHANGELOG: added v0.X.Y entry · ROADMAP: pruned <bullet> · architecture: added <thing> · style: unchanged`.

## Steps (commit / discretionary path)

After a non-trivial commit, run the same check in lightweight form:

1. Did the commit add user-facing behavior worth a CHANGELOG bullet in the unreleased section?
2. Did the commit add a new structural element worth an architecture note?
3. Did the commit reveal a pattern worth style-doc codification?

If yes to any → make the edit in the same session, mention it. If no to all → don't fabricate work.

## CHANGELOG format

Follows [Keep a Changelog 1.1.0](https://keepachangelog.com/en/1.1.0/). New entries at top.

```
## [0.X.Y] - YYYY-MM-DD — Optional theme

### Architecture / Added / Changed / Fixed / Removed / Migration / Notes
- Bullets ≤ ~100 chars per line; long lines OK over many short ones.
- Backticks for code refs: `/api/...`, `migrations/00X_*.sql`, file paths.
- User-facing framing — "what changed", not "what the commit did".
```

Section order when present: `Architecture` → `Added` → `Changed` → `Fixed` → `Removed` → `Migration` → `Notes`. Include only what applies.

Harness-only changes (skill updates, convention restructure, template tweaks) → prefix entries with `[harness]`.

## DO NOT

- Do not vague-describe ("fixed bug" — useless). State the symptom and what was changed.
- Do not duplicate the same point between `Changed` and `Notes`.
- Do not auto-archive ROADMAP items into a separate history list — CHANGELOG is already that history.
- Do not invent architecture notes for changes that don't actually introduce a new structural element. Padding the file defeats the point of making drift visible.
- Do not add style-doc entries for hypothetical patterns. Wait for 3+ shipped instances.
- Do not bump version numbers, create tags, or push tags as part of this skill — those are the user's actions; this skill prepares the docs that gate them.

## Acceptance criteria

- [ ] CHANGELOG entry exists for the version about to ship, dated, with user-perspective bullets
- [ ] Breaking changes have migration notes
- [ ] ROADMAP no longer claims as pending anything that just shipped
- [ ] `conventions/architecture.md` reflects any new structural additions (or explicit no-change confirmation given)
- [ ] `conventions/style.md` updated only if a new pattern crossed the 3-shipped-instances threshold
- [ ] One-line summary told to the user per file touched
