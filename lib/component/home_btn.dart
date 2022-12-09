import 'package:empty_proj/component/SlideFadeTransition.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:flutter/material.dart';

class HomeBtn extends StatefulWidget {
  const HomeBtn(
      {Key? key,
      required this.btnsize,
      required this.text,
      this.onPress,
      this.textSize = 12,
      required this.flip})
      : super(key: key);
  final double btnsize;
  final String text;
  final VoidCallback? onPress;
  final double textSize;
  final bool flip;

  @override
  _HomeBtnState createState() => _HomeBtnState();
}

class _HomeBtnState extends State<HomeBtn> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return SlideFadeTransition(
        child: Container(
          width: widget.btnsize,
          child: InkWell(
            onTap: widget.onPress,
            child: Column(
              children: [
                TextStroke(
                  content: widget.text,
                  strokesize: 2,
                  fontsize: widget.textSize,
                ),
                Transform.scale(
                  scaleX: widget.flip ? -1 : 1,
                  child: Image.asset(
                    "assets/images/home_btn.png",
                    fit: BoxFit.fitHeight,
                  ),
                )
              ],
            ),
          ),
        ),
        curveIn: Curves.ease,
        curveOut: Curves.ease,
        oBeginOut: Offset.zero,
        oBeginIn: const Offset(0, 1),
        oEndOut: Offset.zero,
        oEndIn: Offset.zero,
        controller: _controller);
  }
}
