import 'dart:math';

import 'package:dicee/widgets/animated_dice.dart';
import 'package:flutter/material.dart';

/* ---------------- UN DADO ---------------- */

class OneDicePage extends StatefulWidget {
  const OneDicePage({super.key});

  @override
  State<OneDicePage> createState() => _OneDicePageState();
}

class _OneDicePageState extends State<OneDicePage> {
  int dice = 1;

  void roll() {
    setState(() {
      dice = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxHeight < 560;
        final horizontalPadding = constraints.maxWidth < 360 ? 16.0 : 24.0;
        final diceSize = min(
          160.0,
          max(120.0, constraints.maxWidth * 0.55),
        );

        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isCompact ? 16 : 32,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: max(0.0, constraints.maxHeight - 32),
              ),
              child: Column(
                mainAxisAlignment: isCompact
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  Text(
                    'One die',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: isCompact ? 12 : 24),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.all(isCompact ? 12 : 20),
                      child: AnimatedDice(value: dice, size: diceSize),
                    ),
                  ),
                  SizedBox(height: isCompact ? 16 : 24),
                  Semantics(
                    label: 'Current result: $dice',
                    child: Text(
                      'Result: $dice',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: isCompact ? 16 : 32),
                  FilledButton.icon(
                    onPressed: roll,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Roll one die'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
