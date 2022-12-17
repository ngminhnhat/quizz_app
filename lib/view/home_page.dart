import 'package:empty_proj/component/currency_list.dart';
import 'package:empty_proj/component/expand_button.dart';
import 'package:empty_proj/component/game_option_dialog.dart';
import 'package:empty_proj/component/home_btn.dart';
import 'package:empty_proj/custome_effect/custom_sprite_animate.dart';
import 'package:empty_proj/main.dart';
import 'package:empty_proj/view/bag_page.dart';
import 'package:empty_proj/view/history_page.dart';
import 'package:empty_proj/view/login_page.dart';
import 'package:empty_proj/view/ranking_page.dart';
import 'package:empty_proj/view/shop_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  // ADD THIS AppLifecycleState VARIABLE
  late AppLifecycleState appLifecycle;

  bool expand = false;
  double _flip = 1;

  // ADD THIS FUNCTION WITH A AppLifecycleState PARAMETER
  didChangeAppLifecycleState(AppLifecycleState state) {
    appLifecycle = state;
    setState(() {});

    if (state == AppLifecycleState.paused) {
      // IF YOUT APP IS IN BACKGROUND...
      // YOU CAN ADDED THE ACTION HERE
      player.pause();
      print('My app is in background');
    }
    if (state == AppLifecycleState.resumed) {
      // IF YOUT APP IS IN BACKGROUND...
      // YOU CAN ADDED THE ACTION HERE
      player.resume();
      print('My app is in resumed');
    }
  }

  late DateTime currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nhấn một lần nữa để thoát")));
      return Future.value(false);
    }
    SystemNavigator.pop();
    return Future.value(true);
  }

  void scroll() {
    setState(() {
      expand = !expand;
      if (expand) {
        _flip = -1;
      } else {
        _flip = 1;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
    WidgetsBinding.instance.removeObserver(this);
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Center(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
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
                            MaterialPageRoute(
                                builder: (context) => const BagPage()),
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
                            MaterialPageRoute(
                                builder: (context) => const ShopPage()),
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
              Positioned(
                bottom: 100,
                child: Transform.translate(
                  offset: Offset(80, 0),
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/play_btn_bg.png'))),
                    child: IconButton(
                      onPressed: (() {
                        if (FirebaseAuth.instance.currentUser != null) {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return GameOptionDialog(
                                  title: "Thách đấu nhiều người",
                                  multi: true,
                                );
                              }));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Vui lòng đăng nhập hoặc đăng ký để sử dụng chức năng này!")));
                        }
                      }),
                      icon: Icon(Icons.vpn_lock),
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                  left: expand ? 0 : -230,
                  child: ExpandButton(
                    onTapExpand: () {
                      scroll();
                      print(_flip);
                    },
                    flip: _flip,
                  ),
                  duration: Duration(milliseconds: 250)),
              AnimatedPositioned(
                  left: expand ? 0 : -230,
                  child: Visibility(
                    visible: (FirebaseAuth.instance.currentUser == null),
                    child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          Container(
                            width: 225,
                            height: 80,
                            child: Image.asset(
                              "assets/images/auth_lock.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => LoginPage())));
                            },
                            child: Text('Yêu cầu đăng nhập'.toUpperCase()),
                          )
                        ]),
                  ),
                  duration: Duration(milliseconds: 250))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.large(
          onPressed: (() {
            showDialog(
                context: context,
                builder: ((context) {
                  return GameOptionDialog(
                    title: "Cấu hình trò chơi",
                  );
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
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
      onWillPop: onWillPop,
    );
  }
}
