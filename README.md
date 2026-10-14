# [PROJECT_NAME]

<!-- Replace this line with a one-sentence description of the project. -->

---

> **Note for template users:** The "About this template" section below is part of the template and should be removed once you've adapted this repo for a real project. Replace it — and this note — with content about your project.

---

## About this template

`averatec-harness-template` is a starting point for building a project harness: a structured repository that gives AI developers the context they need to operate consistently and safely within a codebase.

> **Multi-agent: Claude Code + Codex.** Both agents read one shared spec — `AGENTS.md` is a symlink to `CLAUDE.md`. Claude Code auto-loads skills in `.claude/skills/` (triggered by each skill's `description`) and reads `CLAUDE.md` at session start; Codex reads `AGENTS.md` plus `.codex/` (config + hooks). Edit `CLAUDE.md` only — `AGENTS.md` follows automatically.

### What is a harness?

A harness encodes how a project works — its architecture, conventions, and operational procedures — so an AI developer doesn't have to figure it out from scratch every session. Rather than relying on improvisation, the harness makes the right action easy and the wrong action obvious to avoid.

The core idea comes from how safety harnesses work physically: they don't restrict movement, they channel it. A well-written harness makes an AI developer more capable and less likely to cause unintended side effects.

### What's in this template

```
CLAUDE.md                      ← Entry point, auto-read by Claude Code
AGENTS.md                      ← Symlink to CLAUDE.md (read by Codex)
README.md                      ← This file
CHANGELOG.md                   ← Project change history
ROADMAP.md                     ← Versioned plan of open work
.env.example                   ← Environment variable template

.claude/
  settings.json                ← Shared permissions, attribution off, auto memory off, SessionStart hooks
  settings.local.json.example  ← Personal-override template (copied on first session)
  scripts/
    precheck.sh                ← One command for the pre-commit checks (ALL PASS / FAILED)
  skills/                      ← Auto-loaded by Claude Code
    git/                       ← Commit risk classification + pre-commit checklist
    harness/                   ← CHANGELOG / ROADMAP / conventions sync, status board, memory, skills
      references/agent-brief.md ← Standard block pasted into every subagent prompt

.codex/
  config.toml                  ← Codex agent config
  hooks.json                   ← Mirrors the Claude SessionStart hook

conventions/
  architecture.md              ← Directory map, layering rules, what NOT to change

changelog/
  README.md                    ← Archive index for older CHANGELOG series

memory/
  rules.md                     ← Standing rules the owner approved
  notes.md                     ← Cross-cutting gotchas

docs/                          ← Default home for agent-written docs; group by kind in subfolders
  README.md                    ← The docs organizing convention
  status.md                    ← Board of open work across sessions (rows, not a log)

modules/                       ← Template only: optional parts, copied in during setup, then deleted
  README.md                    ← Module list
  ui/                          ← conventions/style.md for projects with a UI
```

### How to use this template

1. Create a new repo from this template. (If you `cp` it rather than using GitHub's "Use this template", copy with symlink preservation — `cp -a` — so `AGENTS.md → CLAUDE.md` survives. Git needs `core.symlinks=true`; Windows needs Developer Mode.)
2. Have the AI inspect the real project, pick the modules it needs from `modules/` (copy them onto the root, then delete `modules/`), and classify each remaining file as **Keep**, **Adapt**, or **Delete**. Delete irrelevant stubs; don't invent a use for them.
3. Replace `[placeholder]` and `FILL` fields only in retained files. Update retained skills with the project's real workflow; after a deletion or rename, repair the Component Map, Index, README tree, hooks, scripts, and links.
4. Remove the one-time setup sections and replace this "About this template" section with the project's own documentation.
5. At the start of each AI session, point the AI developer to `CLAUDE.md` (Claude Code) or `AGENTS.md` (Codex).

### Inspiration and references

- [Harness Engineering](https://openai.com/index/harness-engineering/)
- [Harness Design for Long-Running Apps](https://www.anthropic.com/engineering/harness-design-long-running-apps)
- [Effective Harnesses for Long-Running Agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
