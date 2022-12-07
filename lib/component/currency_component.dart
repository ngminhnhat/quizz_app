import 'package:empty_proj/component/item_no_background.dart';
import 'package:flutter/material.dart';

class CurrencyComponent extends StatefulWidget {
  const CurrencyComponent(
      {Key? key, this.iconPath = "assets/images/icons/unknow_item.png"})
      : super(key: key);

  final String iconPath;

  @override
  _CurrencyComponentState createState() => _CurrencyComponentState();
}

class _CurrencyComponentState extends State<CurrencyComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: <Widget>[
          Container(
              alignment: Alignment.centerRight,
              height: 25,
              decoration: BoxDecoration(
                  color: Colors.black.withAlpha(128),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(right: 5, left: 50, top: 5, bottom: 5),
                    child: Text(
                      '99999999',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('Xu li them tien');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Text(
                        '+',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              )),
          Container(
            height: 40,
            child: Stack(children: <Widget>[
              Container(),
              ItemNoBackground(
                iconPath: widget.iconPath,
              )
            ]),
          )
        ],
      ),
    );
  }
}
