import 'package:empty_proj/component/currency_list.dart';
import 'package:empty_proj/component/game_option_dialog.dart';
import 'package:empty_proj/component/home_btn.dart';
import 'package:empty_proj/custome_effect/custom_sprite_animate.dart';
import 'package:empty_proj/view/bag_page.dart';
import 'package:empty_proj/view/history_page.dart';
import 'package:empty_proj/view/ranking_page.dart';
import 'package:empty_proj/view/shop_page.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 625),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.0, end: 1.0).animate(animation);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/main_bg.png'),
                fit: BoxFit.fitHeight),
          ),
          child: Column(
            children: [
              CurrencyList(),
              Container(
                margin: const EdgeInsets.only(top: 50, left: 150),
                child: HomeBtn(
                  btnsize: 130,
                  text: "Xếp hạng".toUpperCase(),
                  textSize: 17,
                  flip: false,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RankingPage()),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 200, top: 0),
                child: HomeBtn(
                  btnsize: 180,
                  text: "Túi đồ".toUpperCase(),
                  textSize: 18,
                  flip: false,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BagPage()),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 250, top: 30),
                child: HomeBtn(
                  btnsize: 150,
                  text: "Cửa hàng".toUpperCase(),
                  textSize: 18,
                  flip: true,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ShopPage()),
                    );
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 180, top: 50),
                child: HomeBtn(
                  btnsize: 200,
                  text: "Lịch sử trận đấu".toUpperCase(),
                  textSize: 19,
                  flip: false,
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
          onPressed: (() {
            showDialog(
                context: context,
                builder: ((context) {
                  return GameOptionDialog();
                }));
          }),
          backgroundColor: Colors.transparent,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                child: Image.asset('assets/images/play_btn_bg.png'),
              ),
              FadeTransition(
                opacity: _fadeInFadeOut,
                child: Container(
                  child: Image.asset('assets/images/play_btn_bg2.png'),
                ),
              ),
              Icon(Icons.gamepad, color: Colors.white),
              Transform.translate(
                  offset: const Offset(-54.0, -54.0),
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