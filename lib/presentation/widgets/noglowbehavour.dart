
import 'package:flutter/material.dart';

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    // 👇 Yaha direct child return karne se
    // glow + stretch dono disable ho jaayenge
    return child;
  }
}
