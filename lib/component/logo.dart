import 'package:empty_proj/component/text_stroke.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    this.logoPath = "assets/images/logo_bg.png",
    this.text = "",
    this.logoSize = 150,
    this.fontsize = 50,
  }) : super(key: key);

  final String logoPath;
  final String text;
  final double logoSize;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                height: logoSize,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      logoPath,
                    ),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: TextStroke(
                  content: text,
                  strokeColor: Colors.black,
                  fontsize: fontsize,
                  fontfamily: "SVN-DeterminationSans",
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 50,
                child: Image.asset(
                  "assets/images/align.png",
                  fit: BoxFit.fill,
                ),
              ),
            ],
          )
        ]));
  }
}
