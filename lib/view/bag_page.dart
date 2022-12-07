import 'package:empty_proj/component/item_bag.dart';
import 'package:empty_proj/component/logo.dart';
import 'package:flutter/material.dart';

class BagPage extends StatefulWidget {
  const BagPage({Key? key}) : super(key: key);

  @override
  _BagPageState createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bag_bg.png"),
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
                      ),
                      itemBuilder: (context, index) {
                        return ItemBag();
                      },
                    ),
                  ],
                ),
              ),
              Logo(
                text: "Túi đồ".toUpperCase(),
                logoPath: "assets/images/bag_logo.png",
              ),
            ],
          )),
    );
  }
}
