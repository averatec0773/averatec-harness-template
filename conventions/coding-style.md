# Coding Style

## General

- Write code for the next developer to read, not for the machine.
- Minimum complexity for the current task. Do not build for hypothetical future requirements.
- Prefer editing existing files over creating new ones.
- Three similar lines of code is better than a premature abstraction.

## File Organization

- [Describe how files and modules should be organized in this project]
- [e.g., Feature folders vs. type folders]

## Formatting

- [Formatter and version: e.g., Prettier 3.x, Black 24.x]
- [Tab width, quote style, line length, etc.]
- Formatting is enforced by CI. Run `[FORMAT COMMAND]` before committing.

## Language-specific rules

### [Primary language]

- [Rule 1]
- [Rule 2]

## What NOT to do

- Do not add comments explaining what code does — write self-documenting code instead.
- Do not add error handling for scenarios that cannot happen.
- Do not add docstrings or type annotations to code you did not write.
- Do not introduce abstractions for one-time use.

## Linting

- Linter: [e.g., ESLint, Ruff]
- Config file: [e.g., .eslintrc.json]
- Run: `[LINT COMMAND]`
- CI will fail on lint errors. Fix them before committing.
