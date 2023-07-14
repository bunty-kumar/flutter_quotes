import 'dart:async';
import 'package:flutter/material.dart';

enum Direction { up, down, left, right }

class ShowAnimation extends StatefulWidget {
  final Widget child;
  final int delay;
  final Direction direction;

  const ShowAnimation(
      {super.key,
      required this.child,
      required this.delay,
      required this.direction});

  @override
  _ShowAnimationState createState() => _ShowAnimationState();
}

class _ShowAnimationState extends State<ShowAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: getOffset(widget.direction), end: Offset.zero)
            .animate(curve);
    Timer(Duration(milliseconds: widget.delay), () {
      _animController.forward();
    });
  }

  Offset getOffset(Direction direction) {
    switch (direction) {
      case Direction.left:
        return const Offset(2, 0);
      case Direction.up:
        return const Offset(0.0, 0.35);
      case Direction.right:
        return const Offset(-2, 0);
      case Direction.down:
        return const Offset(0, -2);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animController,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
