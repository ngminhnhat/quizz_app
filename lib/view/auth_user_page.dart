import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/logo.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/models/question.dart';
import 'package:empty_proj/view/home_page.dart';
import 'package:empty_proj/view/resetPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AuthUserPage extends StatefulWidget {
  const AuthUserPage(
      {Key? key,
      this.nickname = "",
      this.created_at = "",
      this.hightest_score = "",
      this.game_played = ""})
      : super(key: key);

  final String nickname;
  final String created_at;
  final String hightest_score;
  final String game_played;

  @override
  _AuthUserPageState createState() => _AuthUserPageState();
}

class _AuthUserPageState extends State<AuthUserPage> {
  //

  //
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _user = FirebaseAuth.instance.currentUser;
  String _uid = "";
  String _name = "";
  Timestamp stamp = Timestamp.now();
  final _now = DateFormat.yMMMMd().format(DateTime.now()).toString();

  @override
  void initState() {
    super.initState();
    getQuestionData();
    getdata();
  }

  void getQuestionData() async {
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection("Cauhois").get();
    if (query.docs.isNotEmpty) {
      setState(() {
        query.docs.forEach((element) {
          Question temp = Question(
              element['id'],
              element['linhvucid'],
              element['cauhoi'],
              element['dapan1'],
              element['dapan2'],
              element['dapan3'],
              element['dapan4'],
              element['dapandung']);
          print(temp.cauHoi);
          //dsQuestionAll.add(temp);
        });
      }); // trong fire base a
      //có 1(hay nhiều câu ko có dòng dap án dung)
      //má tuấn ẩu r đó
      //100 câu dò oải
    }
  }
  //lz má căng z ta
  //camwg vc a

  void getdata() async {
    User user = _auth.currentUser!;
    _uid = user.uid;
    final DocumentSnapshot userdoc =
        await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      // print('email ${user.email}');
      _name = userdoc.get('Nickname');
    });
    // _date = userdoc.get('CreateDate');
    print("name nay ban ${_now}");
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
                text: "Thông tin người chơi".toUpperCase(),
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
                      content: "Ngày tạo:",
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
                      content: "Số lượt chơi:",
                      fontsize: 20,
                      strokesize: 2,
                    ),
                    TextStroke(
                      content: widget.game_played,
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
                      content: "Điểm cao nhất:",
                      fontsize: 20,
                      strokesize: 2,
                    ),
                    TextStroke(
                      content: widget.hightest_score,
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
                    CustomBtn(
                      buttonImagePath: "assets/images/btn_blue.png",
                      text: "Thay đổi thông tin".toUpperCase(),
                      paddings: EdgeInsets.all(20),
                    ),
                    CustomBtn(
                      buttonImagePath: "assets/images/btn_purple.png",
                      text: "Thay đổi mật khẩu".toUpperCase(),
                      paddings: EdgeInsets.all(20),
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Resetpassword()));
                      },
                    )
                  ],
                ),
              ),
              CustomBtn(
                buttonImagePath: "assets/images/btn_red.png",
                text: "Đăng xuất".toUpperCase(),
                paddings: EdgeInsets.all(15),
                ontap: (() async {
                  FirebaseAuth.instance.signOut();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đăng xuất thành công.')));
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
