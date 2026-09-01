# 🎯 T10: roll action blocking and recovery

## 💡 Convention

The existing local `_RollPhase` already provides two layers of protection while
a die is rolling. The `FilledButton` receives `onPressed: null` for the visible
disabled state, and `roll()` returns immediately when its phase is `rolling`.
The delayed completion remains attached to the state object, so an ordinary
widget rebuild preserves the pending result and restores the action after the
shared 800 ms duration.

Previously, this behaviour was implemented but did not cover a repeated tap or
a rebuild in one focused test. The new widget test starts a one-die roll, tries
the disabled action again, rebuilds `DiceeApp` halfway through, and verifies
that the original result completes and re-enables the button. No production
API, package, or SDK change is necessary.

## 🏆 Benefits

- Prevents accidental extra rolls through UI and state-level guards.
- Keeps the active roll valid when the widget tree rebuilds.
- Documents recovery without duplicating state-management logic.

## 👀 Examples

### ✅ Good: guard both the control and the action

Disable the button during `rolling` and keep the early return in `roll()` as a
second defence against duplicate invocation.

### ❌ Bad: rely only on the disabled button

Do not remove the phase guard; a programmatic or delayed invocation could then
start another roll while the first result is still pending.

## 🧐 Real world examples

- [`OneDicePage`](../../lib/pages/one_dice.dart) owns the phase and result.
- [`widget_test.dart`](../../test/widget_test.dart) rebuilds during a roll.
- Validation uses `flutter analyze`, `flutter test`, and hot reload.

## 🔗 Related agreements

- [T10 specification](../../specs/001-dicee/spec.md) covers RF-3.
- [Testing](../testing.md) requires stable interaction assertions.
- [Architecture](../architecture.md) keeps mode state local.

One roll, one result, by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
