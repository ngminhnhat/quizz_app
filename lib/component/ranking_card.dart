import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/models/game_history.dart';
import 'package:empty_proj/models/user.dart';
import 'package:empty_proj/view/user_detail_page.dart';
import 'package:flutter/material.dart';

class RankingCard extends StatelessWidget {
  RankingCard(
      {Key? key,
      this.edgeInset = const EdgeInsets.only(left: 5),
      required this.gameHistory,
      required this.user})
      : super(key: key);

  final EdgeInsets edgeInset;
  final User user;
  final GameHistory gameHistory;

  int a = 0;

  void count() async {
    List<GameHistory> list = await GameHistory.getByEmail(user.email);
    a = list.length;
  }

  @override
  Widget build(BuildContext context) {
    count();
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserDetailPage(
                    user: user,
                    gameHistory: gameHistory,
                    gameplayed: a,
                  )),
        );
      }),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        padding:
            const EdgeInsets.only(top: 10, bottom: 13, left: 10, right: 10),
        height: 77,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/ranking_card.png'),
              fit: BoxFit.fill),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: edgeInset,
              child: Text(
                user.nickname,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "Điểm số: ",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  TextStroke(
                    content: gameHistory.diem.toString(),
                    fontsize: 35,
                    fontfamily: "SVN-DeterminationSans",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
