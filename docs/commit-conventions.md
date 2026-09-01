# 🎯 Commit conventions

## 💡 Convention

Write every commit in English using Conventional Commits:

```text
type(scope): short imperative description
```

Use a concise lowercase scope when useful. Add `!` and a `BREAKING CHANGE:`
footer for breaking changes. Allowed types are `feat`, `fix`, `docs`, `style`,
`refactor`, `perf`, `test`, `build`, `ci`, `chore`, and `revert`.

## 🏆 Benefits

- Makes history searchable and release tooling compatible.
- Communicates intent without opening the full diff.
- Separates behavior, documentation, testing, and dependency changes.

## 👀 Examples

### ✅ Good: Describe one capability

```text
build(deps): update vm_service lockfile
docs: define project constitution
```

### ❌ Bad: Use vague or non-imperative messages

```text
updated stuff
```

This hides the affected area and makes the change difficult to classify.

## 🧐 Real world examples

- `build: update Flutter linting and widget test`
- `docs: document testing and task workflow`
- `build(deps): update vm_service lockfile`

## 🔗 Related agreements

- [Workflow](workflow.md) requires explicit confirmation before committing.
- [Constitution](constitution.md) requires consistent spec, code, and tests.

Commit history kept clear by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
