import 'package:empty_proj/component/custom_btn.dart';
import 'package:flutter/material.dart';

class CustomConfirmBuyDialog extends StatelessWidget {
  const CustomConfirmBuyDialog({Key? key}) : super(key: key);

  dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/dialog_bg.png"),
            fit: BoxFit.fitWidth),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Row(
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
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "Day la mo ta cua cai item cu loz dit con me bay gio lam sao khi nhan vo cai nut no hien cai nay len day cc",
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
            )
          ],
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
