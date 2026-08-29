import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dicee/app/dicee_app.dart';

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

      expect(find.text('One die'), findsOneWidget);
      expect(find.text('Two dice'), findsOneWidget);
      expect(find.text('Roll one die'), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('One die')), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('Two dice')), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('Roll one die')), findsOneWidget);

      await tester.tap(find.text('Two dice'));
      await tester.pumpAndSettle();

      expect(find.text('Roll two dice'), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('Roll two dice')), findsOneWidget);
    } finally {
      semantics.dispose();
    }
  });
}
