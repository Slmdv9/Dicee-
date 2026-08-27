# Dicee+ Constitution
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
