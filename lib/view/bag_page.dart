import 'package:empty_proj/component/item_bag.dart';
import 'package:empty_proj/component/logo.dart';
import 'package:empty_proj/view/login_page.dart';
import 'package:empty_proj/view/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 185),
                child: (FirebaseAuth.instance.currentUser != null)
                    ? ListView(
                        children: <Widget>[
                          GridView.builder(
                            itemCount: 15,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              return ItemBag();
                            },
                          ),
                        ],
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 150, left: 20, right: 20),
                        child: FittedBox(
                          child: Row(
                            children: [
                              Text('Vui lòng '),
                              TextButton(
                                  onPressed: (() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                LoginPage())));
                                  }),
                                  child: Text(
                                    'đăng nhập',
                                    style: TextStyle(color: Colors.blue),
                                  )),
                              Text(" hoặc "),
                              TextButton(
                                  onPressed: (() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                RegisterPage())));
                                  }),
                                  child: Text(
                                    'đăng ký',
                                    style: TextStyle(color: Colors.blue),
                                  )),
                              Text(" để sử dụng chức năng này!"),
                            ],
                          ),
                        ),
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
