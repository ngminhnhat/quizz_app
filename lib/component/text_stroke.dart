import 'package:flutter/material.dart';

class TextStroke extends StatelessWidget {
  TextStroke({
    Key? key,
    this.fontfamily,
    required this.content,
    this.strokeColor = const Color.fromARGB(255, 0, 0, 0),
    this.fontColor = const Color.fromARGB(255, 255, 255, 255),
    this.fontsize = 12,
    this.strokesize = 3,
  }) : super(key: key);

  String? fontfamily;
  final String content;
  Color strokeColor;
  Color fontColor;
  double fontsize;
  double strokesize;

  @override
  Widget build(BuildContext context) {
    fontfamily ??= DefaultTextStyle.of(context).style.fontFamily;
    return Container(
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Text(
            content,
            style: TextStyle(
              fontFamily: fontfamily,
              fontSize: fontsize,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = strokesize
                ..color = strokeColor,
            ),
          ),
          // Solid text as fill.
          Text(
            content,
            style: TextStyle(
              fontFamily: fontfamily,
              fontSize: fontsize,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
