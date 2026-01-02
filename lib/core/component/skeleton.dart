import 'package:flutter/material.dart';



class Skeleton extends StatelessWidget {
  const Skeleton({super.key, this.height, this.width, this.layer = 1});

  final double? height, width;
  final int layer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(15 / 2),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04 * layer),
          borderRadius:
              const BorderRadius.all(Radius.circular(15))),
    );
  }
}

class CircleSkeleton extends StatelessWidget {
  const CircleSkeleton({super.key, this.size = 24});

  final double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      // padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
    );
  }
}