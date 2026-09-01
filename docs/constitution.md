# 🎯 Dicee+ Constitution

## 💡 Convention

These principles are non-negotiable and must be verifiable in the repository:

1. Keep the stack minimal: use Flutter and existing project dependencies.
2. Add a dependency only when the current stack cannot satisfy the requirement.
3. Every specification must map to identifiable code and observable behavior.
4. Code is incomplete when its specified behavior lacks implementation or tests.
5. Keep specifications, code, and tests consistent after every change.
6. Extend existing documentation before creating parallel guidance.
7. Follow the structure, language, and terminology already used in project docs.
8. Every behavior change must include or update a relevant test.
9. Every change must pass `flutter analyze` and `flutter test`.
10. Tests must assert stable behavior, never uncontrolled random outcomes.
11. Add integration tests only when unit or widget tests cannot verify the flow.

## 🏆 Benefits

- Limits unnecessary technology and maintenance cost.
- Keeps requirements traceable to implementation and verification.
- Makes documentation and quality expectations reviewable.

## 👀 Examples

### ✅ Good: Add a focused widget test for a visible behavior

Update the relevant specification, implementation, and test together, then run
`flutter analyze` and `flutter test`.

### ❌ Bad: Add an unverified abstraction or dependency

Do not introduce a package, undocumented behavior, or flaky random assertion
when the existing Flutter stack can satisfy the requirement.

## 🧐 Real world examples

- [`lib/`](../lib/) contains the implementation covered by the project docs.
- [`test/`](../test/) contains the current widget tests.
- [`pubspec.yaml`](../pubspec.yaml) defines the intentionally small dependency set.

## 🔗 Related agreements

- [Architecture](architecture.md) defines module and state ownership.
- [Testing](testing.md) defines stable test behavior and required commands.
- [Documentation conventions](documentation-conventions.md) defines doc structure.

Principles made practical by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
