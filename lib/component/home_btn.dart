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

class _HomeBtnState extends State<HomeBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
