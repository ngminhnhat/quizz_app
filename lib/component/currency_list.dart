import 'package:empty_proj/component/avatar_component.dart';
import 'package:empty_proj/component/currency_component.dart';
import 'package:flutter/material.dart';

class CurrencyList extends StatefulWidget {
  const CurrencyList({Key? key}) : super(key: key);

  @override
  _CurrencyListState createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AvatarComponent(),
          CurrencyComponent(
            iconPath: "assets/images/icons/coin.png",
          ),
          CurrencyComponent(
            iconPath: "assets/images/icons/gems.png",
          ),
        ],
      ),
    );
  }
}
