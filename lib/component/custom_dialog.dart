import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  CustomDialog(
      {Key? key,
      this.onTapCancel,
      this.onTapConfirm,
      this.title = "",
      this.content = ""})
      : super(key: key);

  final VoidCallback? onTapConfirm;
  final VoidCallback? onTapCancel;
  final String title;
  final String content;

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/dialog_bg.png"), fit: BoxFit.fill),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                Icons.error_outline,
                size: 70,
              ),
            ),
            Container(
                alignment: Alignment.center,
                child: TextStroke(
                  content: widget.title,
                  fontsize: 30,
                  fontfamily: "SVN-DeterminationSans",
                )),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(10),
              child: Text(
                widget.content,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomBtn(
                  buttonImagePath: "assets/images/btn_red.png",
                  paddings:
                      EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                  text: "Đồng ý".toUpperCase(),
                  ontap: widget.onTapConfirm,
                ),
                CustomBtn(
                  buttonImagePath: "assets/images/btn_blue.png",
                  paddings:
                      EdgeInsets.only(top: 10, bottom: 10, left: 45, right: 45),
                  text: "Huỷ bỏ".toUpperCase(),
                  ontap: widget.onTapCancel,
                )
              ],
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
