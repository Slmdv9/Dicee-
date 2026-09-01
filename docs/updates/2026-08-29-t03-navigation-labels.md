# 🎯 T3: descriptive navigation and roll actions

## 💡 Convention

User-facing controls must communicate their purpose through visible text and
semantics, not icons alone. The change keeps the existing `TabBar` and local
page state while making each mode and roll action explicit.

## 🏆 Benefits

- Users can identify a mode without interpreting an icon.
- Screen readers receive meaningful names for tabs and actions.
- The existing navigation and behavior remain stable while discoverability improves.

## 👀 Examples

### ✅ Good: pair icons with purpose-driven labels

The navigation now names the modes `One die` and `Two dice`. Each action names
its target as `Roll one die` or `Roll two dice`, so the visible and semantic
interfaces describe the same behavior.

### ❌ Bad: expose an icon or an empty action label

An unlabeled refresh icon forces users to infer the action and gives assistive
technology insufficient context.

## 🧐 Real world examples

- [`lib/pages/home_page.dart`](../../lib/pages/home_page.dart) provides named tabs.
- [`lib/pages/one_dice.dart`](../../lib/pages/one_dice.dart) labels the one-die action.
- [`lib/pages/dice_page.dart`](../../lib/pages/dice_page.dart) labels the two-dice action.
- [`test/widget_test.dart`](../../test/widget_test.dart) verifies visible and semantic labels.

## 🔗 Related agreements

- [T3 specification](../../specs/001-dicee/spec.md) defines RF-1, RF-4, and RF-6.
- [Testing conventions](../testing.md) requires stable, behavior-focused tests.
- [Workflow](../workflow.md) requires this learning note before code changes.

Navigation made easier to understand by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
