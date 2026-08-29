import 'dart:math';

import 'package:dicee/widgets/animated_dice.dart';
import 'package:flutter/material.dart';

/* ---------------- UN DADO ---------------- */

enum _RollPhase { available, rolling, result }

class OneDicePage extends StatefulWidget {
  const OneDicePage({super.key});

  @override
  State<OneDicePage> createState() => _OneDicePageState();
}

class _OneDicePageState extends State<OneDicePage> {
  int dice = 1;
  int _pendingDice = 1;
  _RollPhase _rollPhase = _RollPhase.available;

  void roll() {
    if (_rollPhase == _RollPhase.rolling) return;

    final nextDice = Random().nextInt(6) + 1;
    setState(() {
      _pendingDice = nextDice;
      _rollPhase = _RollPhase.rolling;
    });

    Future<void>.delayed(const Duration(milliseconds: 50), () {
      if (!mounted) return;
      setState(() {
        dice = _pendingDice;
        _rollPhase = _RollPhase.result;
      });
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
                      child: AnimatedDice(
                        value: dice,
                        size: diceSize,
                        isRolling: _rollPhase == _RollPhase.rolling,
                      ),
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
                    onPressed: _rollPhase == _RollPhase.rolling ? null : roll,
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
