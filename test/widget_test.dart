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
}
