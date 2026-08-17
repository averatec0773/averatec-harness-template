# Loop — STATE

Single source of truth for the self-paced `/loop`. **Edited in place each iteration** —
this file IS the loop's memory between firings. A fresh agent must be able to resume the
loop by reading only this file, so keep it current and self-contained.

<!--
HOW THE LOOP USES THIS FILE
- Each iteration: read STATE → pick the next actionable item → do it → update its row
  (status + a one-line result / commit ref) → stop. The next firing repeats.
- Idempotent: never redo a DONE item. If interrupted mid-item, leave it DOING with a
  note on where you stopped.
- UNATTENDED BY DEFAULT: never ask the user mid-loop. Decide autonomously, record
  every non-obvious decision under "Decisions Log" with one line of rationale, and
  tag [REVIEW] where a human should double-check later. Keep moving.
- ATTENDED MODE (only if the user explicitly asked for it): items needing a human
  call are marked DECISION-GATED, parked under "Decisions Log" as proposals, and
  not implemented until the user picks.
- Know when to stop: when every row is DONE / BLOCKED, report and end the loop.
-->

MODE: <FILL — optional phase flag, e.g. AUDIT | EXECUTE. Delete this line if the loop has no phases.>

Legend — status: `TODO` | `DOING` | `DONE` | `BLOCKED` | `DECISION-GATED` (attended mode only)
Value / Effort / Risk: `H` | `M` | `L`

---

## Backlog

| id | item | V | E | R | status |
|----|------|---|---|---|--------|
| 1  | FILL: one concrete, independently-shippable task | M | L | L | TODO |
| 2  | FILL | M | M | L | TODO |

## Decisions Log

<!-- Unattended mode (default): one line per non-obvious autonomous decision —
     `[YYYY-MM-DD] <decision> — <rationale>`, tag [REVIEW] if a human should check.
     Attended mode only: DECISION-GATED proposals live here (context + options);
     do NOT implement until the user picks. -->

- (none yet)

## Log

<!-- Optional terse history: `[YYYY-MM-DD] #<id> DONE — <commit / result>` -->
