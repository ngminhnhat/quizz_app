import 'dart:math';

import 'package:empty_proj/component/logo.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/models/game_history.dart';
import 'package:empty_proj/models/user.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserDetailPage extends StatelessWidget {
  UserDetailPage(
      {Key? key,
      required this.user,
      required this.gameHistory,
      this.gameplayed = 0})
      : super(key: key);

  final User user;
  final GameHistory gameHistory;
  int gameplayed;

  void count() async {
    List<GameHistory> list = await GameHistory.fetchAll();
    gameplayed = list.length;
  }

  @override
  Widget build(BuildContext context) {
    count();
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
                    EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextStroke(
                      content: "Nickname:",
                      fontsize: 15,
                      strokesize: 2,
                    ),
                    TextStroke(
                      content: user.nickname,
                      fontsize: 20,
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
                    TextStroke(
                      content: "Ngày tạo:",
                      fontsize: 15,
                      strokesize: 2,
                    ),
                    TextStroke(
                      content: user.createdate,
                      fontsize: 20,
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
                    TextStroke(
                      content: "Số lượt chơi:",
                      fontsize: 15,
                      strokesize: 2,
                    ),
                    TextStroke(
                      content: gameplayed.toString(),
                      fontsize: 20,
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
                    TextStroke(
                      content: "Điểm cao nhất:",
                      fontsize: 15,
                      strokesize: 2,
                    ),
                    TextStroke(
                      content: gameHistory.diem.toString(),
                      fontsize: 20,
                      fontfamily: "SVN-DeterminationSans",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
