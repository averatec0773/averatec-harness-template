# Testing Conventions

## Philosophy

- Tests are first-class code. Treat them with the same standards as production code.
- A test that passes without actually verifying the behavior is worse than no test.
- Do not remove a failing test to make CI pass — fix the underlying issue.

## Test types

| Type | When to write | Location |
|------|--------------|----------|
| Unit | For pure functions and isolated logic | [e.g., `src/__tests__/`] |
| Integration | For code that touches a database, external API, or file system | [e.g., `tests/integration/`] |
| E2E | For critical user flows | [e.g., `tests/e2e/`] |

## Test runner

- Tool: [e.g., Jest, pytest, go test]
- Run all tests: `[COMMAND]`
- Run a single test: `[COMMAND]`
- Run tests in watch mode: `[COMMAND]`

## Rules

- **Test real behavior, not implementation.** Assert on outputs and side effects, not internal state.
- **No mocking databases in integration tests.** Tests must run against a real (local) database. See `memory/lessons.md` for why.
- **Each test is independent.** Tests must not rely on execution order or shared mutable state.
- **Tests must be deterministic.** Flaky tests are treated as bugs and fixed immediately.

## Naming tests

```
[UNIT] describe what the function does under what condition
  → "returns null when user is not found"
  → "throws an error when input is empty"

[INTEGRATION] describe the operation and expected outcome
  → "creates a user and persists it to the database"
```

## Coverage

- Minimum coverage threshold: [e.g., 80%] (enforced by CI)
- Coverage alone is not the goal — meaningful assertions are.

## What NOT to do

- Do not write tests that only assert the function was called (mock-only tests with no real assertion).
- Do not use `sleep` or time-based delays in tests — use proper async patterns.
- Do not commit tests with `skip`, `xit`, or `.only` unless accompanied by a tracking issue.
