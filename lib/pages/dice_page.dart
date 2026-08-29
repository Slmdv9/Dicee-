import 'dart:math';

import 'package:dicee/widgets/animated_dice.dart';
import 'package:flutter/material.dart';

/* ---------------- DOS DADOS ---------------- */

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int left = 1;
  int right = 1;

  void roll() {
    setState(() {
      left = Random().nextInt(6) + 1;
      right = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxHeight < 560;
        final horizontalPadding = constraints.maxWidth < 360 ? 16.0 : 24.0;
        final cardPadding = isCompact ? 12.0 : 20.0;
        final diceSize = min(
          120.0,
          max(
            88.0,
            (constraints.maxWidth - (horizontalPadding * 2) -
                    (cardPadding * 2) -
                    12) /
                2,
          ),
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
                    'Two dice',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: isCompact ? 12 : 24),
                  Card(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.all(cardPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: _dieResult(
                              context,
                              label: 'Left result: $left',
                              value: left,
                              size: diceSize,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _dieResult(
                              context,
                              label: 'Right result: $right',
                              value: right,
                              size: diceSize,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: isCompact ? 16 : 32),
                  FilledButton.icon(
                    onPressed: roll,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Roll two dice'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.2,
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

  Widget _dieResult(
    BuildContext context, {
    required String label,
    required int value,
    required double size,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedDice(value: value, size: size),
        const SizedBox(height: 8),
        Semantics(
          label: label,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
