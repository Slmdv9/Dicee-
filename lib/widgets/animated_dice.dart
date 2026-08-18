import 'package:flutter/material.dart';

class AnimatedDice extends StatelessWidget {
  final int value;
  final double size;

  const AnimatedDice({
    super.key,
    required this.value,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    final imagePath = isLight
        ? 'images/dice${value}_light.png' // Imagen con puntos verdes
        : 'images/dice$value.png'; // Imagen original con puntos blancos

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return ScaleTransition(scale: animation, child: child);
      },
      child: Image.asset(
        imagePath,
        key: ValueKey(imagePath),
        height: size,
      ),
    );
  }
}
