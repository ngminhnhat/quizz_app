import 'package:flutter/material.dart';

class SlideFadeTransition extends StatefulWidget {
  SlideFadeTransition({
    Key? key,
    required this.aniDuration,
    required this.child,
    this.exit = false,
    required this.curveIn,
    required this.curveOut,
    this.dBeginOut = 1.0,
    this.dBeginIn = 0.0,
    this.dEndOut = 0.0,
    this.dEndIn = 1.0,
    required this.oBeginOut,
    required this.oBeginIn,
    required this.oEndOut,
    required this.oEndIn,
    required this.controller,
  }) : super(key: key);
  final Duration aniDuration;
  final Widget child;
  final Curve curveIn;
  final Curve curveOut;
  //
  final bool exit;
  //
  final Offset oBeginIn;
  final Offset oBeginOut;
  final Offset oEndIn;
  final Offset oEndOut;
  //
  final double dBeginIn;
  final double dBeginOut;
  final double dEndIn;
  final double dEndOut;
  AnimationController controller;

  @override
  _SlideFadeTransitionState createState() => _SlideFadeTransitionState();
}

class _SlideFadeTransitionState extends State<SlideFadeTransition> {
  late final Animation<Offset> _animationOffsetIn;
  late final Animation<Offset> _animationOffsetOut;
  late final Animation<double> _animationFadeIn;
  late final Animation<double> _animationFadeOut;

  @override
  void initState() {
    super.initState();
    //
    _animationOffsetIn = Tween<Offset>(
      begin: widget.oBeginIn,
      end: widget.oEndIn,
    ).animate(
        CurvedAnimation(parent: widget.controller, curve: widget.curveIn));
    //
    _animationOffsetOut = Tween<Offset>(
      begin: widget.oBeginOut,
      end: widget.oEndOut,
    ).animate(
        CurvedAnimation(parent: widget.controller, curve: widget.curveOut));
    //
    _animationFadeIn = Tween<double>(
      begin: widget.dBeginIn,
      end: widget.dEndIn,
    ).animate(widget.controller);
    _animationFadeOut = Tween<double>(
      begin: widget.dBeginOut,
      end: widget.dEndOut,
    ).animate(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget.exit ? _animationOffsetOut : _animationOffsetIn,
      child: FadeTransition(
        opacity: widget.exit ? _animationFadeOut : _animationFadeIn,
        child: widget.child,
      ),
    );
  }
}
