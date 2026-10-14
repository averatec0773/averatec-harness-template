# Style

> **Audience**: AI agents (and humans) producing any user-facing surface in this project — UI components, CLI output, generated docs, marketing artifacts.
> **Read this** before generating a component, page, color, font choice, or any styled output. If a generated artifact does not match this direction, it is wrong even if the code is correct.
>
> This is **direction**, not pixel-perfect spec. It tells you the shape of the right answer; it does not pre-decide every screen.
>
> **This file wins** over any installed design skill or generic taste advice. Refining a surface keeps its look; a redesign replaces it, and happens only when the owner asks for one.

<!-- TEMPLATE STATE: every section below contains FILL placeholders. Replace them as the project finds its visual identity. Sections that genuinely do not apply (e.g. no UI in a CLI project) — delete them, do not leave them as stubs. -->

---

## 1. North star

**Visual reference**: FILL — name a real product whose look this project should evoke (e.g., "Linear desktop app, dark theme", "Stripe Dashboard", "Apple's developer docs"). When in doubt, ask "what would <reference> do here?" then adapt.

**Mood keywords**: FILL — 3-5 words that capture the feel (e.g., *calm · focused · dense-but-breathing · pro-tool*).

**Anti-patterns** (what this project must NOT look like):

- FILL: list the aesthetic traps to avoid. Examples: shadcn beige, Bootstrap drop-shadows, Material ripples, glassmorphism, pastel marketing palettes, AI-generic gradient hero.
- FILL: AI-default looks seen in this project's own generated output (add them as they show up; generic lists go stale as models change).

**Surface modes** — what each kind of page is for decides how much flourish it gets:

| Page type | Mode (read / operate / persuade) | Implication |
|---|---|---|
| FILL | FILL | FILL (e.g. "read: long text, quiet chrome, no motion") |

---

## 2. Layout

FILL: describe the dominant layout pattern. If it's a web UI, sketch the primary screen as ASCII; if it's a CLI, describe the output blocks; if it's a doc site, describe page anatomy.

| Region | Contains | Source of truth |
|---|---|---|
| FILL | FILL | FILL |

**Layout rules**:

- FILL: breakpoints, min widths, what collapses when, what stays visible.

---

## 3. Color tokens

Every color used in code must come from a token. Inline hex literals are a smell.

| Token | Value | Used for | Why this value |
|---|---|---|---|
| `--bg-base` | FILL | Window / page background | FILL |
| `--bg-elevated` | FILL | Cards, panels | FILL |
| `--text-primary` | FILL | Titles, primary content | FILL |
| `--text-secondary` | FILL | Subtitles, secondary metadata | FILL |
| `--text-tertiary` | FILL | Disabled, placeholder | FILL |
| `--border-subtle` | FILL | Dividers, separators | FILL |
| `--accent` | FILL | Primary CTAs, selection, brand highlight | FILL |
| `--accent-soft` | FILL | Hover trails, subtle accent backgrounds | FILL |
| `--danger` | FILL | Destructive actions, errors | FILL |
| `--success` | FILL | Confirmation, success states | FILL |

**Token location**: FILL — where these are defined (`app/globals.css`, `tailwind.config.ts`, `tokens.ts`, etc.).

---

## 4. Typography

| Role | Font | Size | Weight | Line height |
|---|---|---|---|---|
| Display | FILL | FILL | FILL | FILL |
| H1 | FILL | FILL | FILL | FILL |
| H2 | FILL | FILL | FILL | FILL |
| Body | FILL | FILL | FILL | FILL |
| Metadata / sub | FILL | FILL | FILL | FILL |
| Label / caption | FILL | FILL | FILL | FILL |
| Numeric / monospace | FILL | FILL | FILL | FILL |

- **Default font**: FILL — name + why.
- **Numeric / monospace font**: FILL (or "none — body font handles it").
- **Never** use OS default font / serif faces / FILL.

---

## 5. Component patterns

Codify a pattern here only after it has shipped in **3+ places**. Earlier than that → it's an experiment, not a convention.

### Buttons

| Variant | Use | Style |
|---|---|---|
| Primary | The single most important action on screen | FILL |
| Secondary | Common non-primary actions | FILL |
| Ghost | In-row / icon-only actions | FILL |
| Destructive | Delete, discard, irreversible | FILL |

- Border radius: FILL everywhere (note any exceptions).
- No FILL (text-shadow / inner-shadow / gradient / pill / etc.) on buttons unless listed above.

### FILL: <next reusable component — e.g., Card, Row, Modal, Form Field>

FILL: structure, dimensions, hover/selected/disabled states, do/don't.

---

## 6. Density & spacing

- **Base grid**: FILL px (typically 4 or 8). All paddings and gaps are multiples.
- **Default page padding**: FILL.
- **Default gap between rows / items**: FILL.
- **Section spacing**: FILL.

---

## 7. Interactions

| Action | Trigger | Result |
|---|---|---|
| FILL | FILL | FILL |

- **Keyboard**: FILL — global shortcuts, focus model.
- **Drag-and-drop**: FILL — first-class or not, library used.
- **Tooltips**: FILL — when to use, when not to.
- **Animation timing**: FILL — base duration + easing, or "deferred to vX.Y.Z".

---

## 8. What this doc explicitly does NOT prescribe

Things deliberately deferred — list them so future contributors know not to invent answers here:

- FILL (e.g., motion timings, dark/light toggle, i18n/RTL, onboarding illustration, custom icon set, persistence of view state)

---

## 9. Checks

A rule a script can check (raw hex outside the token file, off-grid spacing, missing focus styles, contrast) goes into `.claude/scripts/precheck.sh` instead of staying prose here; prose rules alone are often not followed.

- FILL: the checks this project runs, or "none yet".

---

## 10. When to update this file

Update when:

- A real artifact ships and reveals a token gap (e.g., a needed `--bg-row-dragover`).
- A pattern repeats across 3+ surfaces and deserves codifying.
- The user reverses a prior direction (e.g., adds light theme, swaps accent color).

Do **not** update for:

- One-off page-specific styling.
- Experiments that did not ship.
- Hypothetical future patterns.
- Per-version changelog entries (that's `CHANGELOG.md`).
