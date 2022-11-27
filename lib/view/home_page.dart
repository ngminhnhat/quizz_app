import 'package:empty_proj/component/home_btn.dart';
import 'package:empty_proj/component/selected_box.dart';
import 'package:empty_proj/custome_effect/custom_sprite_animate.dart';
import 'package:empty_proj/view/shop_page.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/main_bg.png'),
                  fit: BoxFit.fitHeight),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100, left: 110),
                  child: HomeBtn(
                    btnsize: 130,
                    text: "Xếp hạng".toUpperCase(),
                    textSize: 17,
                    flip: false,
                    onPress: () {
                      print('Xu li cua hang');
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 200, top: 0),
                  child: HomeBtn(
                    btnsize: 180,
                    text: "Túi đồ".toUpperCase(),
                    textSize: 18,
                    flip: false,
                    onPress: () {
                      print('cua hang');
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 250, top: 70),
                  child: HomeBtn(
                    btnsize: 150,
                    text: "Cửa hàng".toUpperCase(),
                    textSize: 18,
                    flip: true,
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShopPage()),
                      );
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 180, top: 50),
                  child: HomeBtn(
                    btnsize: 200,
                    text: "Lịch sử trận đấu".toUpperCase(),
                    textSize: 19,
                    flip: false,
                    onPress: () {
                      print('lich su tran dau');
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 50, top: 70),
                  child: HomeBtn(
                    btnsize: 250,
                    text: "Thông tin tài khoản".toUpperCase(),
                    textSize: 20,
                    flip: false,
                    onPress: () {
                      print('lich su tran dau');
                    },
                  ),
                )
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton.large(
          onPressed: (() {
            print("choi ngay");
          }),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Icon(Icons.gamepad, size: 40),
              Transform.translate(
                  offset: Offset(-54.0, -54.0),
                  child: GameWidget(
                      game: CustomSpriteAnimate(
                    spritePath: "sprites/Fire_mu_fire_27_Bs.png",
                    column: 5,
                    row: 5,
                    steptime: 0.05,
                    sizes: Vector2(180, 180),
                  ))),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
