import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/logo.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/models/game_history.dart';
import 'package:empty_proj/models/question.dart';
import 'package:empty_proj/view/home_page.dart';
import 'package:empty_proj/view/resetPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AuthUserPage extends StatefulWidget {
  const AuthUserPage({Key? key}) : super(key: key);

  @override
  _AuthUserPageState createState() => _AuthUserPageState();
}

class _AuthUserPageState extends State<AuthUserPage> {
  //
  int hightest_score = 0;
  int game_played = 0;
  //
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _user = FirebaseAuth.instance.currentUser;
  String _uid = "";
  String _name = "";
  String _email = "";
  Timestamp stamp = Timestamp.now();
  String _now = DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();
  List<GameHistory> _gameHistory = [];
  @override
  void initState() {
    super.initState();
    getdata();
    getHistory();
  }

  void getHistory() async {
    String? temp = FirebaseAuth.instance.currentUser!.email;
    final data = await GameHistory.getByEmail(temp!);

    setState(() {
      _gameHistory = data;
      for (var element in _gameHistory) {
        if (element.diem > hightest_score) {
          hightest_score = element.diem;
        }
      }
      game_played = _gameHistory.length;
    });
  }

  void getdata() async {
    User user = _auth.currentUser!;
    _uid = user.uid;
    final DocumentSnapshot userdoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      // print('email ${user.email}');
      _name = userdoc.get('Nickname');
      _email = userdoc.get('Email');
      _now = DateFormat('dd-MM-yyyy')
          .format(userdoc.get('CreateDate').toDate())
          .toString();
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/images/Static_Cinematic_bg_transend.png'),
                fit: BoxFit.fitHeight),
          ),
          child: Column(
            children: [
              Logo(
                text: "Th??ng tin ng?????i ch??i".toUpperCase(),
                fontsize: 35,
                logoSize: 90,
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextStroke(
                      content: "Nickname:",
                      fontsize: 20,
                      strokesize: 2,
                    ),
                    TextStroke(
                      content: _name,
                      fontsize: 20,
                      fontfamily: "SVN-DeterminationSans",
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextStroke(
                      content: "Email:",
                      fontsize: 20,
                      strokesize: 2,
                    ),
                    TextStroke(
                      content: _email,
                      fontsize: 20,
                      fontfamily: "SVN-DeterminationSans",
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextStroke(
                      content: "Ng??y t???o:",
                      fontsize: 20,
                      strokesize: 2,
                    ),
                    TextStroke(
                      content: _now,
                      fontsize: 20,
                      fontfamily: "SVN-DeterminationSans",
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextStroke(
                      content: "S??? l?????t ch??i:",
                      fontsize: 20,
                      strokesize: 2,
                    ),
                    TextStroke(
                      content: game_played.toString(),
                      fontsize: 35,
                      fontfamily: "SVN-DeterminationSans",
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 50, right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextStroke(
                      content: "??i???m cao nh???t:",
                      fontsize: 20,
                      strokesize: 2,
                    ),
                    TextStroke(
                      content: hightest_score.toString(),
                      fontsize: 35,
                      fontfamily: "SVN-DeterminationSans",
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: CustomBtn(
                        buttonImagePath: "assets/images/btn_blue.png",
                        text: "Thay ?????i th??ng tin".toUpperCase(),
                        paddings: EdgeInsets.all(20),
                      ),
                    ),
                    Flexible(
                        child: CustomBtn(
                      buttonImagePath: "assets/images/btn_purple.png",
                      text: "Thay ?????i m???t kh???u".toUpperCase(),
                      paddings: EdgeInsets.all(20),
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Resetpassword()));
                      },
                    ))
                  ],
                ),
              ),
              CustomBtn(
                buttonImagePath: "assets/images/btn_red.png",
                text: "????ng xu???t".toUpperCase(),
                paddings: EdgeInsets.all(15),
                ontap: (() async {
                  FirebaseAuth.instance.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('????ng xu???t th??nh c??ng.')));
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => HomePage())));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
