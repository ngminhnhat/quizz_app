import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/game_option_dialog.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/data/game_logic.dart';
import 'package:empty_proj/models/ingame_answer.dart';
import 'package:empty_proj/models/question.dart';
import 'package:empty_proj/models/quizz_category.dart';
import 'package:empty_proj/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({
    Key? key,
    required this.cauTraLoi,
    required this.cauHoi,
    required this.questionAnswer,
    required this.selectedCache,
    required this.thoigian,
    required this.thoigianconlai,
    required this.linhvuc,
  }) : super(key: key);

  final List<Question> cauHoi;
  final List<int> cauTraLoi;
  final List<int> selectedCache;
  final List<List<IngameAnswer>> questionAnswer;
  final int thoigian;
  final int thoigianconlai;
  final QuizzCategory linhvuc;

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final _user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;
  String _uid = "";
  String _email = "";
  late int score;
  late int numOfCorrect;
  late int streak;
  late double percent;

  void updateUser() async {
    try {
      final user = await FirebaseFirestore.instance
          .collection('users')
          .where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .limit(1)
          .get()
          .then((QuerySnapshot snapshot) {
        //Here we get the document reference and return to the post variable.
        return snapshot.docs[0].reference;
      });

      var batch = FirebaseFirestore.instance.batch();
      //Updates the field value, using post as document reference
      batch.update(user, {'Coin': FieldValue.increment(score)});
      batch.commit();
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    score = GameLogic().scoreCalculator(widget.cauHoi, widget.cauTraLoi,
        widget.thoigian, widget.thoigianconlai);
    numOfCorrect = GameLogic().correctAnswer(widget.cauHoi, widget.cauTraLoi);
    streak = GameLogic().correctStreak(widget.cauHoi, widget.cauTraLoi);
    percent = GameLogic().percent(widget.cauHoi, widget.cauTraLoi);
    if (_user != null) {
      User user = _auth.currentUser!;
      FirebaseFirestore.instance.collection('history').add({
        "emailuser": user.email,
        "socauhoi": widget.cauHoi.length,
        "socautraloidung": numOfCorrect,
        "thoigiantraloi": widget.thoigian * 60,
        "thoigianconlai": widget.thoigianconlai,
        "diem": score,
        "ngaychoi": DateTime.now(),
      });
      updateUser();
    }
  }

  List<IngameAnswer> getValue(int index) {
    List<IngameAnswer> temp = widget.questionAnswer[index];
    return temp;
  }

  Widget res(int index) {
    bool resA = false;
    bool resB = false;
    bool resC = false;
    bool resD = false;
    bool chooseA = false;
    bool chooseB = false;
    bool chooseC = false;
    bool chooseD = false;
    int key = -1;
    List<IngameAnswer> answers = getValue(index);
    print("start debug");
    print(widget.cauHoi[index].cauHoi +
        " " +
        widget.cauHoi[index].dapAn1 +
        " " +
        widget.cauHoi[index].dapAn2 +
        " " +
        widget.cauHoi[index].dapAn3 +
        " " +
        widget.cauHoi[index].dapAn4 +
        " " +
        widget.cauHoi[index].dapAnDung.toString());
    print("key answer");
    for (var i = 0; i < answers.length; i++) {
      print(answers[i].key.compareTo(widget.cauHoi[index].dapAnDung));
      if (answers[i].key == widget.cauHoi[index].dapAnDung) {
        key = i;
        print("true");
        break;
      }
    }
    print("key $index");
    print(key);
    print("end of debug");

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
    switch (widget.selectedCache[index]) {
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
        Text("Câu " + (index + 1).toString() + ":"),
        Text(widget.cauHoi[index].cauHoi),
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
                    margin: EdgeInsets.only(top: 250, bottom: 55),
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
                    child: FittedBox(
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
                                Text("Lĩnh vực: " + widget.linhvuc.name),
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
                                Text("Th.gian trả lời: ${widget.thoigian}phút"),
                                Text(
                                    "Th.gian còn lại: ${(widget.thoigianconlai / 60).toInt()}phút${(widget.thoigianconlai % 60).toInt()}giây"),
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
                          Visibility(
                            visible:
                                (FirebaseAuth.instance.currentUser != null),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Tiền thưởng: ",
                                  ),
                                  TextStroke(
                                    content: score.toString().toUpperCase(),
                                    fontfamily: "SVN-DeterminationSans",
                                    fontsize: 20,
                                  ),
                                ],
                              ),
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
