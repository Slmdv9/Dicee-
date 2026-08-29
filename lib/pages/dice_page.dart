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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedDice(value: left),
            const SizedBox(width: 20),
            AnimatedDice(value: right),
          ],
        ),
        const SizedBox(height: 40),
        FilledButton.icon(
          onPressed: roll,
          icon: const Icon(Icons.refresh),
          label: const Text('Roll two dice'),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            textStyle: const TextStyle(
              fontSize: 16,
              letterSpacing: 1.2,
            ),
          ),
        )
      ],
    );
  }
}
