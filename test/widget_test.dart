import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dicee/app/dicee_app.dart';
import 'package:dicee/pages/dice_page.dart';
import 'package:dicee/pages/one_dice.dart';
import 'package:dicee/widgets/animated_dice.dart';

void main() {
  testWidgets('displays the dice modes', (WidgetTester tester) async {
    await tester.pumpWidget(const DiceeApp());

    expect(find.text('Dicee+'), findsOneWidget);
    expect(find.byIcon(Icons.casino_outlined), findsOneWidget);
    expect(find.byIcon(Icons.casino), findsOneWidget);
    expect(find.byIcon(Icons.refresh), findsOneWidget);
  });

  testWidgets('defines shared light and dark Material 3 hierarchy',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DiceeApp());

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    final themes = [app.theme!, app.darkTheme!];

    for (final theme in themes) {
      expect(theme.useMaterial3, isTrue);
      expect(theme.scaffoldBackgroundColor,
          theme.colorScheme.surfaceContainerLowest);
      expect(theme.filledButtonTheme.style, isNotNull);
      expect(theme.filledButtonTheme.style!.foregroundColor, isNotNull);
      expect(theme.filledButtonTheme.style!.backgroundColor, isNotNull);
      expect(
        theme.filledButtonTheme.style!.backgroundColor!
            .resolve({WidgetState.disabled}),
        isNotNull,
      );
      expect(theme.tabBarTheme.labelColor, theme.colorScheme.primary);
      expect(theme.tabBarTheme.unselectedLabelColor,
          theme.colorScheme.onSurfaceVariant);
      expect(theme.tabBarTheme.indicatorColor, theme.colorScheme.primary);
    }
  });

  testWidgets('labels dice modes and roll actions',
      (WidgetTester tester) async {
    final semantics = tester.ensureSemantics();
    try {
      await tester.pumpWidget(const DiceeApp());

    expect(
      find.descendant(
        of: find.byType(TabBar),
        matching: find.text('One die'),
      ),
      findsOneWidget,
    );
    expect(
      find.descendant(
        of: find.byType(TabBar),
        matching: find.text('Two dice'),
      ),
      findsOneWidget,
    );
      expect(find.text('Roll one die'), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('One die')), findsAtLeastNWidgets(1));
      expect(find.bySemanticsLabel(RegExp('Two dice')), findsAtLeastNWidgets(1));
      expect(find.bySemanticsLabel(RegExp('Roll one die')), findsAtLeastNWidgets(1));

      await tester.tap(find.text('Two dice'));
      await tester.pumpAndSettle();

      expect(find.text('Roll two dice'), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('Roll two dice')), findsAtLeastNWidgets(1));
    } finally {
      semantics.dispose();
    }
  });

  testWidgets('composes one-die mode around its result',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DiceeApp());

    expect(find.text('One die'), findsNWidgets(2));
    expect(find.text('Result: 1'), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.text('Roll one die'), findsOneWidget);
  });

  testWidgets('keeps one-die composition usable in compact space',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(640, 960);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const DiceeApp());

    expect(find.text('Result: 1'), findsOneWidget);
    expect(find.text('Roll one die'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('composes two-dice mode with distinct results',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DiceeApp());

    await tester.tap(find.text('Two dice'));
    await tester.pumpAndSettle();

    expect(find.text('Two dice'), findsNWidgets(2));
    expect(find.text('Left result: 1'), findsOneWidget);
    expect(find.text('Right result: 1'), findsOneWidget);
    expect(find.byType(Card), findsOneWidget);
    expect(find.text('Roll two dice'), findsOneWidget);
  });

  testWidgets('keeps two-dice composition usable in compact space',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(640, 960);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const DiceeApp());
    await tester.tap(find.text('Two dice'));
    await tester.pumpAndSettle();

    expect(find.text('Left result: 1'), findsOneWidget);
    expect(find.text('Right result: 1'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('preserves themed die assets inside a depth surface',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
        home: const AnimatedDice(value: 4),
      ),
    );

    final lightImage = tester.widget<Image>(find.byType(Image));
    expect((lightImage.image as AssetImage).assetName,
        'images/dice4_light.png');
    expect(find.byType(AnimatedContainer), findsOneWidget);

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
        home: const AnimatedDice(value: 4),
      ),
    );
    await tester.pumpAndSettle();

    final darkImage = tester.widget<Image>(find.byType(Image));
    expect((darkImage.image as AssetImage).assetName, 'images/dice4.png');
  });

  testWidgets('exposes a distinct occupied presentation state',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: true),
        home: const AnimatedDice(value: 2, isRolling: true),
      ),
    );

    final surface = tester.widget<AnimatedContainer>(
      find.byType(AnimatedContainer),
    );
    final decoration = surface.decoration! as BoxDecoration;
    final theme = Theme.of(tester.element(find.byType(AnimatedDice)));

    expect(decoration.border!.top.color, theme.colorScheme.primary);
    expect(decoration.border!.top.width, 2);
    expect(decoration.boxShadow, isNotEmpty);
  });

  testWidgets('spins one die for 800 milliseconds before stabilising',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DiceeApp());

    await tester.tap(find.text('Roll one die'));
    await tester.pump();

    final oneDieButton = find.byWidgetPredicate(
      (widget) => widget is ButtonStyleButton,
    );
    final oneDieRotation = find.byType(RotationTransition).first;
    expect(tester.widget<ButtonStyleButton>(oneDieButton).onPressed, isNull);
    expect(tester.widget<AnimatedDice>(find.byType(AnimatedDice)).isRolling,
        isTrue);
    expect(
      tester.widget<RotationTransition>(oneDieRotation).turns.value,
      0,
    );

    await tester.pump(const Duration(milliseconds: 400));

    expect(tester.widget<AnimatedDice>(find.byType(AnimatedDice)).isRolling,
        isTrue);
    expect(
      tester.widget<RotationTransition>(oneDieRotation).turns.value,
      greaterThan(0),
    );

    await tester.pump(const Duration(milliseconds: 400));

    expect(tester.widget<ButtonStyleButton>(oneDieButton).onPressed,
        isNotNull);
    expect(tester.widget<AnimatedDice>(find.byType(AnimatedDice)).isRolling,
        isFalse);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && RegExp(r'Result: [1-6]').hasMatch(
              widget.data ?? '',
            ),
      ),
      findsOneWidget,
    );
  });

  testWidgets('ignores repeated one-die rolls and recovers after rebuild',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DiceeApp());

    final oneDieButton = find.byWidgetPredicate(
      (widget) => widget is ButtonStyleButton,
    );
    await tester.tap(find.text('Roll one die'));
    await tester.pump();

    expect(tester.widget<ButtonStyleButton>(oneDieButton).onPressed, isNull);

    await tester.tap(find.text('Roll one die'));
    await tester.pump(const Duration(milliseconds: 400));

    expect(tester.widget<AnimatedDice>(find.byType(AnimatedDice)).isRolling,
        isTrue);

    await tester.pumpWidget(const DiceeApp());
    await tester.pump(const Duration(milliseconds: 400));

    expect(tester.widget<ButtonStyleButton>(oneDieButton).onPressed,
        isNotNull);
    expect(tester.widget<AnimatedDice>(find.byType(AnimatedDice)).isRolling,
        isFalse);
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && RegExp(r'Result: [1-6]').hasMatch(
              widget.data ?? '',
            ),
      ),
      findsOneWidget,
    );
  });

  testWidgets('uses a reduced transition when animations are disabled',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: const MaterialApp(home: OneDicePage()),
      ),
    );

    await tester.tap(find.text('Roll one die'));
    await tester.pump();

    final oneDieButton = find.byWidgetPredicate(
      (widget) => widget is ButtonStyleButton,
    );
    final rotation = find.byType(RotationTransition);
    expect(tester.widget<ButtonStyleButton>(oneDieButton).onPressed, isNull);

    await tester.pump(const Duration(milliseconds: 75));

    final turns = tester.widget<RotationTransition>(rotation).turns.value;
    expect(turns, greaterThan(0));
    expect(turns, lessThan(0.1));

    await tester.pump(const Duration(milliseconds: 75));

    expect(tester.widget<ButtonStyleButton>(oneDieButton).onPressed,
        isNotNull);
    expect(tester.widget<AnimatedDice>(find.byType(AnimatedDice)).isRolling,
        isFalse);
  });

  testWidgets('uses a reduced transition for both dice',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(disableAnimations: true),
        child: const MaterialApp(home: DicePage()),
      ),
    );

    await tester.tap(find.text('Roll two dice'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 75));

    final rotations = find.descendant(
      of: find.byType(AnimatedDice),
      matching: find.byType(RotationTransition),
    );
    expect(rotations, findsNWidgets(2));
    expect(
      tester.widgetList<RotationTransition>(rotations).every(
            (rotation) =>
                rotation.turns.value > 0 && rotation.turns.value < 0.1,
          ),
      isTrue,
    );

    await tester.pump(const Duration(milliseconds: 75));

    expect(
      tester.widgetList<AnimatedDice>(find.byType(AnimatedDice)).every(
            (die) => !die.isRolling,
          ),
      isTrue,
    );
  });

  testWidgets('spins two dice together for 800 milliseconds before stabilising',
      (WidgetTester tester) async {
    await tester.pumpWidget(const DiceeApp());
    await tester.tap(find.text('Two dice'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Roll two dice'));
    await tester.pump();

    final twoDiceButton = find.byWidgetPredicate(
      (widget) => widget is ButtonStyleButton,
    );
    final twoDiceRotations = find.descendant(
      of: find.byType(AnimatedDice),
      matching: find.byType(RotationTransition),
    );
    expect(tester.widget<ButtonStyleButton>(twoDiceButton).onPressed, isNull);
    expect(find.byType(AnimatedDice), findsNWidgets(2));
    expect(twoDiceRotations, findsNWidgets(2));
    expect(
      tester.widgetList<AnimatedDice>(find.byType(AnimatedDice)).every(
            (die) => die.isRolling,
          ),
      isTrue,
    );
    expect(
      tester.widgetList<RotationTransition>(twoDiceRotations).every(
            (rotation) => rotation.turns.value == 0,
          ),
      isTrue,
    );

    await tester.pump(const Duration(milliseconds: 400));

    expect(
      tester.widgetList<AnimatedDice>(find.byType(AnimatedDice)).every(
            (die) => die.isRolling,
          ),
      isTrue,
    );
    expect(
      tester.widgetList<RotationTransition>(twoDiceRotations).every(
            (rotation) => rotation.turns.value > 0,
          ),
      isTrue,
    );

    await tester.pump(const Duration(milliseconds: 400));

    expect(
      tester.widgetList<AnimatedDice>(find.byType(AnimatedDice)).every(
            (die) => !die.isRolling,
          ),
      isTrue,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && RegExp(r'Left result: [1-6]').hasMatch(
              widget.data ?? '',
            ),
      ),
      findsOneWidget,
    );
    expect(
      find.byWidgetPredicate(
        (widget) => widget is Text && RegExp(r'Right result: [1-6]').hasMatch(
              widget.data ?? '',
            ),
      ),
      findsOneWidget,
    );
  });
}
