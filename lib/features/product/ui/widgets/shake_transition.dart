import 'package:flutter/material.dart';

class ShakeTransition extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final double offset;
  final Axis axis;

  const ShakeTransition({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 800),
    this.offset = 140.0,
    this.axis = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: duration,
      curve: Curves.decelerate,
      tween: Tween(begin: 1.0, end: 0.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: axis == Axis.horizontal
              ? Offset(value * offset, 0.0)
              : Offset(0.0, value * offset),
          child: child,
        );
      },
      child: child,
    );
  }
}
