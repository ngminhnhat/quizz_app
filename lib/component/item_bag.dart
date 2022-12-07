import 'package:empty_proj/component/item.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:flutter/material.dart';

class ItemBag extends StatefulWidget {
  const ItemBag(
      {Key? key,
      this.iconPath = "assets/images/icons/unknow_item.png",
      this.amount = "NaN"})
      : super(key: key);

  final String iconPath;
  final String amount;

  @override
  _ItemBagState createState() => _ItemBagState();
}

class _ItemBagState extends State<ItemBag> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(15),
        width: 100,
        child: Stack(
          children: <Widget>[
            Item(
              iconPath: widget.iconPath,
            ),
            Container(
              padding: EdgeInsets.all(5),
              width: double.infinity,
              alignment: Alignment.bottomRight,
              child: TextStroke(
                content: widget.amount,
                fontsize: 20,
              ),
            ),
          ],
        ));
  }
}
