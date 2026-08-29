import 'package:flutter/material.dart';

class AnimatedDice extends StatelessWidget {
  final int value;
  final double size;
  final bool isRolling;

  const AnimatedDice({
    super.key,
    required this.value,
    this.size = 120,
    this.isRolling = false,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    final imagePath = isLight
        ? 'images/dice${value}_light.png' // Imagen con puntos verdes
        : 'images/dice$value.png'; // Imagen original con puntos blancos

    final colorScheme = Theme.of(context).colorScheme;
    final borderColor = isRolling
        ? colorScheme.primary
        : colorScheme.outlineVariant;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: borderColor,
          width: isRolling ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(
              alpha: isRolling ? 0.24 : 0.14,
            ),
            blurRadius: isRolling ? 18 : 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Image.asset(
          imagePath,
          key: ValueKey(imagePath),
          height: size,
        ),
      ),
    );
  }
}
