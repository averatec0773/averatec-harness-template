# Roadmap

Pending and future work. Past versions: see [CHANGELOG.md](CHANGELOG.md). Code context: [conventions/architecture.md](conventions/architecture.md).

<!-- TEMPLATE STATE: replace the sample versions below with the real plan. Keep the principles at the bottom — they are project-agnostic and apply from day one. -->

---

## v0.X — <current minor theme>

### v0.X.Y (next) — <short title>

- **<feature>** — FILL: one line of intent, plus any concrete constraint (deadline, blast radius, dependency).
- **<feature>** — FILL.

### v0.X.Y+1 — <short title>

- FILL.

---

## v0.(X+1) — <next minor theme>

FILL: the next coherent slice. Don't pre-plan past what is concretely known; vague items belong in v1+ or below.

---

## v1+ — Future (deferred until current minor ships)

### vA — <theme>

- FILL — high-level intent, not implementation.

### vB — <theme>

- FILL.

### vN — Decisions still open

- FILL: things you may or may not build. Mark each with "decide by <version>" or "decide when <trigger>".

---

## Open design candidates

Use this section for items that need a brainstorm before they're scheduled. Each entry should be one short paragraph + option list.

**Example shape:**

> **<feature name>** — FILL: why it's needed, why scheduling is blocked on a design decision.
>
> - **Option A** — FILL. Tradeoff: FILL.
> - **Option B** — FILL. Tradeoff: FILL.
>
> Decide via short brainstorm before v0.X.Y.

---

## Roadmap principles

- **One PR / branch = one version.** No phase-crossing.
- **Every version produces a runnable, demonstrable artifact** — no half-shipped features.
- **Refactor lives in its own version**, never bolted onto a feature commit.
- **Anything not on this list is YAGNI** until requested.
- **Past versions live in `CHANGELOG.md`**, not here. When a version ships, prune its bullet from this file (the `harness` skill enforces this).
