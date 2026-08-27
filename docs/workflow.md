# 🎯 Workflow conventions

## 💡 Convention

For every non-documentation task, invoke `update-flutter-dependencies` first.
Then complete the task, run the relevant available tests, and request explicit
confirmation before creating a commit. Documentation-only work may skip the
dependency check, but it still follows the applicable validation and commit
rules.

## 🏆 Benefits

- Detects dependency drift before implementation work begins.
- Ensures changes are validated before they are committed.
- Keeps commit authorization explicit and auditable.

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

## 🔗 Related agreements

- [Constitution](constitution.md) defines the non-negotiable checks.
- [Builds](builds.md) documents setup, validation, and run commands.
- [Commit conventions](commit-conventions.md) defines commit format.

Workflow kept explicit by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
