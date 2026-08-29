# 🎯 Workflow conventions

## 💡 Convention

For every non-documentation task, invoke `update-flutter-dependencies` first.
Then complete the task, run the relevant available tests, and request explicit
confirmation before creating a commit. Documentation-only work may skip the
dependency check, but it still follows the applicable validation and commit
rules.

Every change that modifies application code must also include a focused,
educational note under [`docs/updates/`](updates/README.md). The note must
explain the theory and practical effect of the change, compare new declarations
or APIs with the previous approach, record dependency implications, and list
the tests and validation performed.

## 🏆 Benefits

- Detects dependency drift before implementation work begins.
- Ensures changes are validated before they are committed.
- Keeps commit authorization explicit and auditable.
- Preserves the reasoning and learning context for every code change.

## 👀 Examples

### ✅ Good: Follow the task sequence

```text
dependency check → implementation → relevant tests → confirmation → commit
```

### ❌ Bad: Commit before validation or confirmation

Do not create a commit immediately after editing, and do not treat an
inspection-only dependency check as permission to upgrade packages.

## 🧐 Real world examples

- `flutter pub outdated` performs the read-only dependency inspection.
- `flutter analyze` and `flutter test` validate Dicee+ changes.
- [Commit conventions](commit-conventions.md) defines the resulting message.
- [`docs/updates/`](updates/README.md) records the educational explanation for code changes.

## 🔗 Related agreements

- [Constitution](constitution.md) defines the non-negotiable checks.
- [Builds](builds.md) documents setup, validation, and run commands.
- [Commit conventions](commit-conventions.md) defines commit format.

Workflow kept explicit by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
