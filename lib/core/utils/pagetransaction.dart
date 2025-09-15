import 'package:flutter/material.dart';
import 'package:get/get.dart';


enum SlideDirection { leftToRight, rightToLeft }

class SlidePageTransition extends CustomTransition {
  final SlideDirection direction;

  SlidePageTransition(this.direction);

  @override
  Widget buildTransition(
    BuildContext context,
    Curve? curve,
    Alignment? alignment,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: curve ?? Curves.easeInOut,
    );

    Offset beginOffset;
    switch (direction) {
      case SlideDirection.leftToRight:
        beginOffset = const Offset(-1, 0); // left se enter
        break;
      case SlideDirection.rightToLeft:
        beginOffset = const Offset(1, 0); // right se enter
        break;
    }

    return SlideTransition(
      position: Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).animate(curved),
      child: child,
    );
  }
}
