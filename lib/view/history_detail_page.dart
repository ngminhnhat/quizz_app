import 'package:empty_proj/component/logo.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/custome_effect/custom_sprite_animate.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class HistoryDetailPage extends StatelessWidget {
  const HistoryDetailPage({Key? key, this.name = ""}) : super(key: key);

  final String name;

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
          child: Column(children: [
            Logo(
              text: "Thông tin trận đấu".toUpperCase(),
              fontsize: 30,
              logoSize: 80,
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextStroke(
                    content: "Trận đấu số:",
                    strokesize: 2,
                    fontsize: 20,
                  ),
                  TextStroke(
                    content: name,
                    fontsize: 35,
                    fontfamily: "SVN-DeterminationSans",
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextStroke(
                    content: "Ngày chơi:",
                    strokesize: 2,
                    fontsize: 20,
                  ),
                  TextStroke(
                    content: name,
                    fontsize: 35,
                    fontfamily: "SVN-DeterminationSans",
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextStroke(
                    content: "Số câu hỏi:",
                    strokesize: 2,
                    fontsize: 20,
                  ),
                  TextStroke(
                    content: name,
                    fontsize: 35,
                    fontfamily: "SVN-DeterminationSans",
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextStroke(
                    content: "Số câu trả lời đúng:",
                    strokesize: 2,
                    fontsize: 20,
                  ),
                  TextStroke(
                    content: name,
                    fontsize: 35,
                    fontfamily: "SVN-DeterminationSans",
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextStroke(
                    content: "Thời gian hoàn thành:",
                    strokesize: 2,
                    fontsize: 20,
                  ),
                  TextStroke(
                    content: name,
                    fontsize: 35,
                    fontfamily: "SVN-DeterminationSans",
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
