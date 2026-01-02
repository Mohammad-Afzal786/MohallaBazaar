import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/custom_transition.dart';

class NoReverseTransition extends CustomTransition {
  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0), // right to left
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Duration get reverseTransitionDuration => Duration.zero; // ✅ back pe no animation
}
