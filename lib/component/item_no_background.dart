import 'package:empty_proj/component/custom_detail_dialog.dart';
import 'package:flutter/material.dart';

class ItemNoBackground extends StatelessWidget {
  const ItemNoBackground(
      {Key? key, this.iconPath = "assets/images/icons/unknow_item.png"})
      : super(key: key);
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: ((context) {
                return CustomDetailDialog(
                  iconPath: iconPath,
                );
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
