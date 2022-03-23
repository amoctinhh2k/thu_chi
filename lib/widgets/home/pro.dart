import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app_home_screen.dart';




final CatmullRomSpline path = CatmullRomSpline(
  const <Offset>[
    Offset(0.05, 0.75),
    Offset(0.18, 0.23),
    Offset(0.32, 0.04),
    Offset(0.73, 0.5),
    Offset(0.42, 0.74),
    Offset(0.73, 0.01),
    Offset(0.93, 0.93),
    Offset(0.05, 0.75),
  ],
  startHandle: const Offset(0.93, 0.93),
  endHandle: const Offset(0.18, 0.23),
);

class FollowCurve2D extends StatefulWidget {
  const FollowCurve2D({
    Key? key,
    required this.path,
    this.curve = Curves.easeInOut,
    required this.child,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  final Curve2D path;
  final Curve curve;
  final Duration duration;
  final Widget child;

  @override
  State<FollowCurve2D> createState() => _FollowCurve2DState();
}

class _FollowCurve2DState extends State<FollowCurve2D>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: widget.duration, vsync: this);
    animation = CurvedAnimation(parent: controller, curve: widget.curve);
    controller.repeat();
    controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scale the path values to match the -1.0 to 1.0 domain of the Alignment widget.
    final Offset position =
        widget.path.transform(animation.value) * 2.0 - const Offset(1.0, 1.0);
    return Align(
      alignment: Alignment(position.dx, position.dy),
      child: widget.child,
    );
  }
}