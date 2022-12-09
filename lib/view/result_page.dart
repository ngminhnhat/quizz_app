import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/game_option_dialog.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/data/game_logic.dart';
import 'package:empty_proj/models/ingame_answer.dart';
import 'package:empty_proj/models/question.dart';
import 'package:empty_proj/view/home_page.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage(
      {Key? key,
      required this.cauTraLoi,
      required this.cauHoi,
      required this.questionAnswer,
      required this.selectedCache})
      : super(key: key);

  final List<Question> cauHoi;
  final List<int> cauTraLoi;
  final List<int> selectedCache;
  final List<List<IngameAnswer>> questionAnswer;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late int score;
  late int numOfCorrect;
  late int streak;
  late double percent;
  @override
  void initState() {
    super.initState();
    score = GameLogic().scoreCalculator(widget.cauHoi, widget.cauTraLoi);
    numOfCorrect = GameLogic().correctAnswer(widget.cauHoi, widget.cauTraLoi);
    streak = GameLogic().correctStreak(widget.cauHoi, widget.cauTraLoi);
    percent = GameLogic().percent(widget.cauHoi, widget.cauTraLoi);
  }
//Đưa vào firebase

//

  List<IngameAnswer> getValue(int index) {
    List<IngameAnswer> temp = widget.questionAnswer[index];
    return temp;
  }

  Widget res(int i) {
    bool resA = false;
    bool resB = false;
    bool resC = false;
    bool resD = false;
    bool chooseA = false;
    bool chooseB = false;
    bool chooseC = false;
    bool chooseD = false;
    int key = -1;
    List<IngameAnswer> answers = getValue(i);

    for (var i = 0; i < answers.length; i++) {
      if (answers[i].key == widget.cauHoi[i].dapAnDung) {
        key = i;
        break;
      }
    }

    switch (key) {
      case 0:
        resA = true;
        break;
      case 1:
        resB = true;
        break;
      case 2:
        resC = true;
        break;
      case 3:
        resD = true;
        break;

      default:
    }
    switch (widget.selectedCache[i]) {
      case 0:
        chooseA = true;
        break;
      case 1:
        chooseB = true;
        break;
      case 2:
        chooseC = true;
        break;
      case 3:
        chooseD = true;
        break;

      default:
    }

    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.5)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Câu " + (i + 1).toString() + ":"),
        Text(widget.cauHoi[i].cauHoi),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: resA
                  ? Colors.green
                  : (chooseA ? Colors.red : Colors.black.withOpacity(0.5))),
          child: Text("A. " + answers[0].value),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: resB
                  ? Colors.green
                  : (chooseB ? Colors.red : Colors.black.withOpacity(0.5))),
          child: Text("B. " + answers[1].value),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: resC
                  ? Colors.green
                  : (chooseC ? Colors.red : Colors.black.withOpacity(0.5))),
          child: Text("C. " + answers[2].value),
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: resD
                  ? Colors.green
                  : (chooseD ? Colors.red : Colors.black.withOpacity(0.5))),
          child: Text("D. " + answers[3].value),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/detail_bg.png"),
                  fit: BoxFit.fitHeight),
            ),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 215, bottom: 55),
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.cauHoi.length,
                        itemBuilder: ((context, index) {
                          return res(index);
                        }),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    child: Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBtn(
                            buttonImagePath: "assets/images/btn_blue.png",
                            text: "Trò chơi mới".toUpperCase(),
                            paddings: EdgeInsets.only(
                                top: 15, bottom: 15, left: 40, right: 40),
                            ontap: (() {
                              showDialog(
                                  context: context,
                                  builder: ((context) => GameOptionDialog()));
                            }),
                          ),
                          CustomBtn(
                              buttonImagePath: "assets/images/btn_purple.png",
                              text: "Trở về trang chính".toUpperCase(),
                              paddings: EdgeInsets.only(
                                  top: 15, bottom: 15, left: 30, right: 30),
                              ontap: (() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => HomePage())));
                              })),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 30, left: 15, right: 15, bottom: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextStroke(
                            content: "Trò chơi kết thúc".toUpperCase(),
                            fontfamily: "SVN-DeterminationSans",
                            fontsize: 45,
                          ),
                          Text(
                            "Kết quả:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("Lĩnh vực:"),
                                Text("Số câu hỏi: " +
                                    widget.cauHoi.length.toString()),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text("Số câu trả lời đúng: $numOfCorrect"),
                                Text("Tỉ lệ trả lời đúng: $percent%"),
                              ],
                            ),
                          ),
                          Text(
                              "Số câu trả lời đúng liên tiếp cao nhất: $streak"),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Điểm số: ",
                                ),
                                TextStroke(
                                  content: score.toString().toUpperCase(),
                                  fontfamily: "SVN-DeterminationSans",
                                  fontsize: 30,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "Chi tiết câu hỏi:",
                            style: TextStyle(fontSize: 16),
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => HomePage())));
        return false;
      },
    );
  }
}
