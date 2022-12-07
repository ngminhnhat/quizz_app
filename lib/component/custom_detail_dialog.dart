import 'package:empty_proj/component/custom_btn.dart';
import 'package:flutter/material.dart';

class CustomDetailDialog extends StatelessWidget {
  const CustomDetailDialog(
      {Key? key,
      this.iconPath = "assets/images/icons/unknow_item.png",
      this.amount = "NaN"})
      : super(key: key);

  final String iconPath;
  final String amount;

  dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
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
        children: [
          FittedBox(
            fit: BoxFit.fill,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/icons/icon_1.png"),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(
                        iconPath,
                        fit: BoxFit.fitWidth,
                      ),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 270,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Teen vat pham",
                        style: TextStyle(fontSize: 25),
                      ),
                      Container(
                        width: 250,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Image.asset(
                          "assets/images/align.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "Day la mo ta cua cai item cu loz",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.red),
            child: IconButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              icon: Icon(Icons.close),
            ),
          ),
        ],
      ),
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
