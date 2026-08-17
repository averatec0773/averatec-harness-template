# [PROJECT_NAME] Autonomous Loop Prompt

Launch from the repo root in a fresh session with:

```
/loop Read loop/PROMPT.md and execute exactly one iteration as it specifies: usage-budget protocol first, then one task chunk, fully autonomous — never ask the user anything. This line is the canonical loop input; repeat it verbatim in every ScheduleWakeup/CronCreate.
```

That single-line input is the CANONICAL LOOP INPUT. Whenever this protocol says
"the FULL original /loop input, verbatim", it means exactly that line.

<!-- WHY THIS SHAPE: the wake-up chain only ever carries the fixed line above, so
     everything below can be hot-edited between iterations without breaking the
     loop. NEVER change the canonical line while a loop is running. If the user
     asked for an ATTENDED loop instead, replace "fully autonomous — never ask
     the user anything" with "attended — park DECISION-GATED items and ask"
     in the canonical line BEFORE launching. Unattended is the default. -->

---

## PART 1 — USAGE-BUDGET PROTOCOL — execute FIRST in every loop iteration, before any task work

STEP 1 — READ USAGE
Run: bash scripts/check-usage.sh
Parse the single-line JSON it prints.

STEP 2 — CLASSIFY the iteration mode, branching on the "source" field:

  A. source is "statusline" or "oauth_endpoint" (official percentages):
     - five_hour_pct < 70            -> WORK mode: run one full task chunk.
     - 70 <= five_hour_pct < 90      -> REDUCED mode: run one minimal task chunk
                                        (at most half the size of a normal chunk).
     - five_hour_pct >= 90           -> PARK mode (STEP 3).
     - Overlay rule: if seven_day_pct >= 90, never exceed REDUCED mode regardless
       of the 5-hour value, and add "WEEKLY LIMIT CRITICAL" to the report line.
     - RESET_TIME = five_hour_resets_at.

  B. source is "local_estimate" or "ccusage_estimate" (offline estimate, no official pct):
     - TOKEN_BUDGET = 30000000  (initial guess; recalibrate from
       ~/.claude/usage-log.jsonl after the first real limit hit: use 85% of the
       block_total_tokens recorded at that moment).
     - pct_est = block_total_tokens / TOKEN_BUDGET * 100.
     - Apply the same thresholds as branch A using pct_est.
     - RESET_TIME = block_end_time.

  C. source is "none", or the script errors:
     - Treat as PARK mode with RESET_TIME = now + 1 hour (fail-safe).
     - If this branch is hit on 3 consecutive iterations, send a PushNotification
       describing the failure, then stop the loop (do NOT schedule anything).

STEP 3 — PARK mode (usage >= 90%): sleep until the next 5-hour window
  Do NO task work in this iteration. Then:
  1. WAKE_AT = RESET_TIME + 5 minutes (RESET_TIME is UTC ISO; convert to local
     time with `date` in Bash and double-check the arithmetic).
  2. PREFERRED — one-shot resume via cron:
     Call CronCreate with:
       - cron: the exact local-time expression for WAKE_AT
         (minute hour day-of-month month *),
       - prompt: the FULL original /loop input, verbatim,
       - recurring: false.
     Confirm the job was created (note its ID in STATE), then END the
     turn WITHOUT calling ScheduleWakeup. The cron firing re-enters the loop
     exactly when the new window opens; parking consumes zero tokens.
  3. FALLBACK — only if CronCreate fails or is unavailable:
     Call ScheduleWakeup with
       delaySeconds = min(3600, seconds until WAKE_AT),
       prompt = the FULL original /loop input, verbatim.
     Each heartbeat wake-up repeats STEP 1-3 only, until usage drops below 90.
  A parked or heartbeat turn may ONLY: run the check script, append one status
  line to STATE, and schedule the resume. No other tool calls.

STEP 4 — HARD RULES (apply to every iteration)
  - Never work past 90%. The remaining margin exists so that the loop's own
    scheduling turns always have quota to execute; if usage ever truly reaches
    100%, the wake-up turn itself will fail and the loop dies unrecoverably.
  - The FIRST line of every iteration summary must be:
    [usage] source=<...> five_hour=<pct>% mode=<WORK|REDUCED|PARK> next_reset=<ts>
  - In WORK or REDUCED mode, after finishing the task chunk, end the turn with
    ScheduleWakeup (prompt = the FULL original /loop input, verbatim;
    delaySeconds per PART 2 §Pacing).
  - If task work fails mid-iteration with a rate-limit-shaped error
    ("limit reached", 429, "resets at ..."), abort the chunk immediately and
    switch to PARK mode handling in the same turn — schedule the resume while
    the turn can still execute tools.
  - One iteration = one chunk. Never loop task work inside a single turn to
    "make the most" of remaining quota; pacing lives at the iteration level.

## PART 2 — TASK PROTOCOL (WORK / REDUCED modes)

### Mission

<FILL — one paragraph: what the loop is building, where the spec lives
(e.g. docs/design/), and the end state. State explicitly whether the loop runs
until the backlog is empty or until the user stops it.>

### Iteration procedure

1. `git fetch && git status` — if the tree is dirty from an interrupted
   iteration, finish or revert that work FIRST (check the DOING row in STATE).
2. <FILL — CI check if the project has CI, e.g. `gh run list --limit 1`;
   if red, fixing CI is automatically this iteration's chunk. Delete if no CI.>
3. Read `loop/STATE.md`. Pick the top TODO item (REDUCED mode: only items with
   effort S, or a partial step of a larger item).
4. Mark it DOING. Implement it following the acceptance criteria in its row.
5. Verify (see §Verification). A chunk is DONE only when all gates pass.
6. Update STATE: row status, Decisions Log if any decision was made,
   one-line Log entry starting with the [usage] line.
7. <FILL — commit policy. If the user pre-authorized loop commits, state it
   explicitly here, e.g.: "Commit (`[loop]` prefix, imperative message) and
   push. The user has pre-authorized loop commits — this overrides the 'never
   commit unless asked' rule for loop iterations only. Never force-push.
   Never --no-verify." Otherwise: "Leave changes uncommitted; note the
   stopping point in STATE.">
8. End the turn with ScheduleWakeup per §Pacing.

### No-human-in-the-loop rules (unattended default — override harness decision-gating)

- NEVER call AskUserQuestion, EnterPlanMode, or anything that waits for the
  user. Never end a turn with a question.
- When a decision is needed, decide autonomously: prefer the option with the
  best confidence × reversal-cost profile (a cheap-to-change option beats a
  marginally better expensive one). Record every non-obvious decision in the
  STATE "Decisions Log" with one line of rationale; tag [REVIEW] if the user
  should look at it later. Then keep moving.
- Design/content gaps: use clearly-marked placeholder values that are
  data-driven (in data files or named constants) so replacing them is cheap.
- If an item genuinely cannot proceed (missing credential, broken toolchain),
  mark it BLOCKED with a note and take the next item. If 3 consecutive items
  block, send ONE PushNotification summarizing the blockage, then continue
  with whatever remains workable (quality passes if nothing else).

### Verification

Every chunk must pass before it counts as DONE:

- <FILL — build/import gate, e.g. `make build` exit 0.>
- <FILL — test gate, e.g. `make test` exit 0. Every new pure-logic system
  ships with tests in the same chunk.>
- <FILL — lint/format gate.>
- <FILL — behavior verification: how to actually observe the change working
  (screenshot pipeline, headless run, input simulation, curl against a dev
  server...). Name the concrete command(s).>
- Never claim a chunk done from code inspection alone. Evidence first.

### Pacing (ScheduleWakeup delaySeconds)

- WORK mode: 60 (continue nearly immediately; prompt cache stays warm).
- REDUCED mode: 1800 (stretch the remaining window).
- reason field: name the next backlog item.

### Backlog maintenance

- When fewer than 3 TODO items remain, refill STATE from `ROADMAP.md`
  (decompose the next version into chunk-sized rows with acceptance criteria)
  and prune ROADMAP accordingly in the same commit.
- <FILL — what to do when the roadmap is exhausted: quality passes, coverage,
  content breadth, balance tuning, CHANGELOG version cuts...>

### Hard safety rails

- Work ONLY inside <FILL — absolute repo path>.
- Never modify memory/rules.md, .claude/, loop/PROMPT.md, or CLAUDE.md except
  the specific harness-sync edits the harness skill prescribes.
- <FILL — project-specific never-touch list (design docs, generated dirs...).>
- Respect all Core Rules in CLAUDE.md except where this file explicitly
  overrides (commit authorization, no decision-gating).
