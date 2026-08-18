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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedDice(value: dice, size: 160),
        const SizedBox(height: 40),
        FilledButton.icon(
          onPressed: roll,
          icon: const Icon(Icons.refresh),
          label: const Text(''),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          ),
        )
      ],
    );
  }
}