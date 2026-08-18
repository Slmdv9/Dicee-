# Builds and local development

## Prerequisites

- Install a Flutter SDK compatible with the Dart constraint in `pubspec.yaml`.
- Run `flutter doctor` to verify the toolchain for the platforms you intend to use.
- Install the platform-specific tooling when building for Android, iOS, macOS, Windows, or Linux.

## Install dependencies

```bash
flutter pub get
```

Run this after cloning the repository or changing `pubspec.yaml`.

## Quality checks

```bash
flutter analyze
flutter test
```

`flutter analyze` applies the lint configuration in `analysis_options.yaml`. `flutter test` runs the widget tests in `test/`.

## Run locally

List available devices:

```bash
flutter devices
```

Run on the selected default device:

```bash
flutter run
```

Target a specific device when needed:

```bash
flutter run -d <device-id>
```

## Build artifacts

```bash
flutter build apk
flutter build appbundle
flutter build ios
flutter build web
flutter build macos
flutter build windows
flutter build linux
```

Run only the platform commands that your local toolchain supports. iOS and macOS builds require macOS and Xcode; Android builds require the Android SDK; Windows and Linux builds require their respective desktop toolchains.
