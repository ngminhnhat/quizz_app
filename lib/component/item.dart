import 'package:empty_proj/component/custom_detail_dialog.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({Key? key, this.iconPath = "assets/images/icons/unknow_item.png"})
      : super(key: key);
  final String iconPath;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/icons/icon_1.png"),
          fit: BoxFit.fitWidth,
        ),
      ),
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: ((context) {
                return CustomDetailDialog();
              }));
        },
        child: Image.asset(
          iconPath,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
