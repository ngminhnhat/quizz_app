import 'package:empty_proj/component/item_shop.dart';
import 'package:empty_proj/component/logo.dart';
import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/Static_ActCenter_shop.png"),
                  fit: BoxFit.fitHeight)),
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 185),
                child: ListView(
                  children: <Widget>[
                    GridView.builder(
                      itemCount: 15,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height),
                      ),
                      itemBuilder: (context, index) {
                        return ItemShop();
                      },
                    ),
                  ],
                ),
              ),
              Logo(
                text: "Cửa hàng".toUpperCase(),
                logoPath: "assets/images/shop_logo.png",
              ),
            ],
          )),
    );
  }
}
