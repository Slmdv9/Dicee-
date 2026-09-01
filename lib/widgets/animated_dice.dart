import 'package:flutter/material.dart';

class AnimatedDice extends StatefulWidget {
  static const rollDuration = Duration(milliseconds: 800);
  static const reducedMotionDuration = Duration(milliseconds: 150);

  final int value;
  final double size;
  final bool isRolling;
  final bool reduceMotion;

  const AnimatedDice({
    super.key,
    required this.value,
    this.size = 120,
    this.isRolling = false,
    this.reduceMotion = false,
  });

  @override
  State<AnimatedDice> createState() => _AnimatedDiceState();
}

class _AnimatedDiceState extends State<AnimatedDice>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: AnimatedDice.rollDuration,
    );
    if (widget.isRolling) _startRotation();
  }

  @override
  void didUpdateWidget(covariant AnimatedDice oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isRolling && !oldWidget.isRolling) {
      _startRotation();
    } else if (!widget.isRolling && oldWidget.isRolling) {
      _rotationController.reset();
    }
  }

  void _startRotation() {
    _rotationController.duration = widget.reduceMotion
        ? AnimatedDice.reducedMotionDuration
        : AnimatedDice.rollDuration;
    _rotationController.forward(from: 0);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    final imagePath = isLight
        ? 'images/dice${widget.value}_light.png'
        : 'images/dice${widget.value}.png';

    final colorScheme = Theme.of(context).colorScheme;
    final borderColor =
        widget.isRolling ? colorScheme.primary : colorScheme.outlineVariant;

    return RotationTransition(
      turns: Tween<double>(
        begin: 0,
        end: widget.reduceMotion ? 0.05 : 1,
      ).animate(_rotationController),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: borderColor,
            width: widget.isRolling ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(
                alpha: widget.isRolling ? 0.24 : 0.14,
              ),
              blurRadius: widget.isRolling ? 18 : 10,
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
            height: widget.size,
          ),
        ),
      ),
    );
  }
}
