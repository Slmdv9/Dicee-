# 🎯 Testing conventions

## 💡 Convention

Choose the smallest test level that verifies the behavior. Unit tests isolate
logic, widget tests verify visible UI and interactions, and integration tests
cover complete flows requiring multiple screens or platform services. Every
behavior change must include or update a relevant test, and every change must
pass `flutter analyze` and `flutter test`.

## 🏆 Benefits

- Keeps feedback fast by avoiding unnecessary end-to-end coverage.
- Verifies user-visible behavior without coupling tests to implementation details.
- Prevents false failures caused by uncontrolled randomness.

## 👀 Examples

### ✅ Good: Assert stable visible behavior

```dart
testWidgets('displays the dice modes', (tester) async {
  await tester.pumpWidget(const DiceeApp());

  expect(find.text('Dicee+'), findsOneWidget);
  expect(find.byIcon(Icons.casino_outlined), findsOneWidget);
  expect(find.byIcon(Icons.casino), findsOneWidget);
});
```

### ❌ Bad: Assert an uncontrolled random roll

```dart
await tester.tap(find.byIcon(Icons.refresh));
expect(find.image(const AssetImage('images/dice6.png')), findsOneWidget);
```

Use controlled randomness or assert stable UI state instead.

## 🧐 Real world examples

- [`test/widget_test.dart`](../test/widget_test.dart) covers the Dicee+ widget surface.
- [`lib/pages/`](../lib/pages/) contains behavior requiring widget coverage.

## 🔗 Related agreements

- [Builds](builds.md) lists the quality-check commands.
- [Constitution](constitution.md) makes testing non-negotiable.
- [Architecture](architecture.md) defines state ownership and boundaries.

Tests that users can trust, by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
