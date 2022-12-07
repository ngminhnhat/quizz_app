import 'package:empty_proj/component/custom_btn.dart';
import 'package:flutter/material.dart';

class CustomConfirmBuyDialog extends StatefulWidget {
  CustomConfirmBuyDialog({Key? key, this.amount = 1}) : super(key: key);

  int amount;

  @override
  _CustomConfirmBuyDialogState createState() => _CustomConfirmBuyDialogState();
}

class _CustomConfirmBuyDialogState extends State<CustomConfirmBuyDialog> {
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
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        FittedBox(
          fit: BoxFit.fitWidth,
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
                child: Image.asset(
                  "assets/images/icons/unknow_item.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: 270,
                child: Container(
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
                      Text(
                        "Day la mo ta cua cai item cu loz djgfdsjfgdsjfgdsjfgdsfgdsjfgdsjdgfsjdhgdsjfsgdfjdsgfjdsgfjsdgfjsfgsjfgsdsfsdfjdsjfgsdjfdgdsjgfjdsfgjdsfgdsjfgdsjfsgjfsgjfsgjfsgjfdsgjfgsjgfyfgsjg",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.black.withAlpha(128),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: (() {
                    setState(() {
                      if (widget.amount > 1) {
                        widget.amount--;
                      }
                    });
                  }),
                  icon: Icon(Icons.remove)),
              Text(
                widget.amount.toString(),
                style: TextStyle(fontSize: 16),
              ),
              IconButton(
                  onPressed: (() {
                    setState(() {
                      widget.amount++;
                    });
                  }),
                  icon: Icon(Icons.add))
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "Bạn có chắc muốn mua vật phẩm này?",
            style: TextStyle(fontSize: 12),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomBtn(
              buttonImagePath: "assets/images/btn_blue.png",
              paddings:
                  EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
              text: "Mua".toUpperCase(),
            ),
            CustomBtn(
              buttonImagePath: "assets/images/btn_red.png",
              paddings:
                  EdgeInsets.only(top: 10, bottom: 10, left: 45, right: 45),
              text: "Huỷ bỏ".toUpperCase(),
              ontap: () {
                Navigator.pop(context);
              },
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
