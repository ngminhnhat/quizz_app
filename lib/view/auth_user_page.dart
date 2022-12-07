import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/logo.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                  children: [
                    TextStroke(
                      content: "Nickname:",
                      fontsize: 20,
                      strokesize: 2,
                    ),
                    TextStroke(
                      content: widget.nickname,
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
                      content: "Ngày tạo:",
                      fontsize: 20,
                      strokesize: 2,
                    ),
                    TextStroke(
                      content: widget.created_at,
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
