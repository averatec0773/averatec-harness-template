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
- DECISION-GATED items are NOT implemented. Write a short proposal under "Needs decision"
  and ask the user; wait for an answer before touching them.
- Know when to stop: when every row is DONE / BLOCKED / DECISION-GATED, report and end the loop.
-->

MODE: <FILL — optional phase flag, e.g. AUDIT | EXECUTE. Delete this line if the loop has no phases.>

Legend — status: `TODO` | `DOING` | `DONE` | `BLOCKED` | `DECISION-GATED`
Value / Effort / Risk: `H` | `M` | `L`

---

## Backlog

| id | item | V | E | R | status |
|----|------|---|---|---|--------|
| 1  | FILL: one concrete, independently-shippable task | M | L | L | TODO |
| 2  | FILL | M | M | L | TODO |

## Needs decision

<!-- DECISION-GATED items live here as short proposals: one paragraph of context +
     an option list. Do NOT implement until the user picks. -->

- (none yet)

## Log

<!-- Optional terse history: `[YYYY-MM-DD] #<id> DONE — <commit / result>` -->
