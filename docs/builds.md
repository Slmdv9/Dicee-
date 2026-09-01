# 🎯 Build and local development conventions

## 💡 Convention

Use a Flutter SDK compatible with `pubspec.yaml`, verify platform tooling with
`flutter doctor`, and run only commands supported by the installed toolchain.
Install dependencies with `flutter pub get`; run quality checks before sharing
changes; select an explicit device when the default is ambiguous.

## 🏆 Benefits

- Makes local setup repeatable across supported platforms.
- Detects toolchain problems before platform builds.
- Keeps generated artifacts and device selection intentional.

## 👀 Examples

### ✅ Good: Validate and target a device

```bash
flutter doctor
flutter pub get
flutter analyze
flutter test
flutter devices
flutter run -d chrome
```

### ❌ Bad: Assume every platform is available

Do not run `flutter build ios` or `flutter build windows` without the required
Xcode or Windows toolchain; use only supported platform commands.

## 🧐 Real world examples

- `flutter analyze` applies [`analysis_options.yaml`](../analysis_options.yaml).
- `flutter test` runs the widget tests in [`test/`](../test/).
- Supported build commands include APK, iOS, web, macOS, Windows, and Linux targets.

## 🔗 Related agreements

- [Testing](testing.md) defines the required analysis and test checks.
- [Workflow](workflow.md) defines the order of work before a commit.
- [Constitution](constitution.md) makes passing checks non-negotiable.

Build guidance supported by 🐢 💨 (Turbotuga™, [Codely](https://codely.com)’s mascot)
