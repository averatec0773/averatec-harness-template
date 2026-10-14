# Agent brief

Paste into every subagent prompt, then add the task.

```
Project <FILL: absolute repo path>. Read CLAUDE.md and memory/rules.md first.
- No commits. Edit only the files of this task; shared files only with the Edit tool and small unique replacements.
- Stop only processes you started. If a step will take more than 10 minutes, report first.
- Write progress notes as you go to <FILL: progress file path> (what is done, what is next) so the task can resume
  after an interruption.
- Return: outcome first, files changed, commands run with results, open points.
```

Sizing: one agent = one clear output (one change, one review, one research question), about 30 minutes of work.
