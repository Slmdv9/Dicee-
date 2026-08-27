# Testing

## Description

Automated tests help Dicee+ keep its dice modes working while changes are made.
This guide follows Flutter's [testing overview](https://docs.flutter.dev/testing/overview).
Run the current test suite with `flutter test`; run `flutter analyze` alongside
it before submitting a change.

## Test types

- **Unit tests** verify one function, method, or class in isolation. Use them
  for logic that can run without rendering a widget.
- **Widget tests** verify a widget's visible UI and interactions in Flutter's
  test environment. This project currently uses them in `test/`.
- **Integration tests** verify an end-to-end user flow on a device or emulator.
  Add them in `integration_test/` when a change depends on multiple screens or
  platform services.

Prefer fast unit and widget tests for focused behaviour. Add integration tests
for important complete flows rather than duplicating every widget assertion.

## Examples

### Do

Test what a user can see or do, with a focused name and explicit expectations:

```dart
testWidgets('displays the dice modes', (tester) async {
  await tester.pumpWidget(const DiceeApp());

  expect(find.text('Dicee+'), findsOneWidget);
  expect(find.byIcon(Icons.casino_outlined), findsOneWidget);
  expect(find.byIcon(Icons.casino), findsOneWidget);
});
```

Keep the test level aligned with the behaviour. For example, test a pure
roll-value helper with a unit test instead of building the whole application.

### Do not

Do not make a widget test depend on an exact random roll result:

```dart
await tester.tap(find.byIcon(Icons.refresh));
expect(find.image(const AssetImage('images/dice6.png')), findsOneWidget);
```

The roll value is random, so this assertion is flaky. Test stable UI state or
inject controllable randomness before asserting a particular value.
