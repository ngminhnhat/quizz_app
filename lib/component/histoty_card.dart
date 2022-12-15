import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/models/game_history.dart';
import 'package:empty_proj/view/history_detail_page.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class HistotyCard extends StatelessWidget {
  const HistotyCard(
      {Key? key, this.name = "", this.score = 0, required this.gameHistory})
      : super(key: key);

  final String name;
  final int score;
  final GameHistory gameHistory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HistoryDetailPage(
                    gameHistory: gameHistory,
                  )),
        );
      }),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        padding:
            const EdgeInsets.only(top: 10, bottom: 13, left: 10, right: 10),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/history_card_bg.png'),
              fit: BoxFit.fill),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                name,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "Điểm số: ",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  TextStroke(
                    content: score.toString(),
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
