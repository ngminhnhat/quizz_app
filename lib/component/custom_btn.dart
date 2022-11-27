import 'package:flutter/material.dart';

class CustomBtn extends StatefulWidget {
  const CustomBtn(
      {Key? key,
      this.ontap,
      required this.buttonImagePath,
      this.text = "",
      this.paddings = const EdgeInsets.all(10)})
      : super(key: key);

  final VoidCallback? ontap;
  final String buttonImagePath;
  final String text;
  final EdgeInsets paddings;

  @override
  _CustomBtnState createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Container(
        padding: widget.paddings,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(widget.buttonImagePath), fit: BoxFit.fill),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
