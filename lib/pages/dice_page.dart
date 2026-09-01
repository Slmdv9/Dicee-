import 'dart:math';

import 'package:dicee/widgets/animated_dice.dart';
import 'package:flutter/material.dart';

/* ---------------- DOS DADOS ---------------- */

enum _RollPhase { available, rolling, result }

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int left = 1;
  int right = 1;
  int _pendingLeft = 1;
  int _pendingRight = 1;
  _RollPhase _rollPhase = _RollPhase.available;

  void roll() {
    if (_rollPhase == _RollPhase.rolling) return;

    final nextLeft = Random().nextInt(6) + 1;
    final nextRight = Random().nextInt(6) + 1;
    final rollDuration = MediaQuery.disableAnimationsOf(context)
        ? AnimatedDice.reducedMotionDuration
        : AnimatedDice.rollDuration;
    setState(() {
      _pendingLeft = nextLeft;
      _pendingRight = nextRight;
      _rollPhase = _RollPhase.rolling;
    });

    Future<void>.delayed(rollDuration, () {
      if (!mounted) return;
      setState(() {
        left = _pendingLeft;
        right = _pendingRight;
        _rollPhase = _RollPhase.result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isCompact = constraints.maxHeight < 560;
        final reduceMotion = MediaQuery.disableAnimationsOf(context);
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
                              isRolling: _rollPhase == _RollPhase.rolling,
                              reduceMotion: reduceMotion,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _dieResult(
                              context,
                              label: 'Right result: $right',
                              value: right,
                              size: diceSize,
                              isRolling: _rollPhase == _RollPhase.rolling,
                              reduceMotion: reduceMotion,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: isCompact ? 16 : 32),
                  FilledButton.icon(
                    onPressed: _rollPhase == _RollPhase.rolling ? null : roll,
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
    required bool isRolling,
    required bool reduceMotion,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedDice(
          value: value,
          size: size,
          isRolling: isRolling,
          reduceMotion: reduceMotion,
        ),
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
