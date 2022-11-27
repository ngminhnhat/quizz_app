import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/custom_confirm_buy_dialog.dart';
import 'package:empty_proj/component/item.dart';
import 'package:flutter/material.dart';

class ItemShop extends StatefulWidget {
  const ItemShop(
      {Key? key,
      this.iconPath = "assets/images/icons/unknow_item.png",
      this.cost = const Text("NaN")})
      : super(key: key);

  final String iconPath;
  final Text cost;

  @override
  _ItemShopState createState() => _ItemShopState();
}

class _ItemShopState extends State<ItemShop> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        width: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Item(
              iconPath: widget.iconPath,
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: widget.cost,
                ),
                Container(
                  width: double.infinity,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/images/icons/coin.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            ),
            CustomBtn(
              paddings:
                  EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
              buttonImagePath: "assets/images/btn_amber.png",
              text: "mua".toUpperCase(),
              ontap: () {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return CustomConfirmBuyDialog();
                    }));
              },
            )
          ],
        ));
  }
}
