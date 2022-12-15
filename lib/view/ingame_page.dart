import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/SlideFadeTransition.dart';
import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/custom_dialog.dart';
import 'package:empty_proj/component/selected_answer.dart';
import 'package:empty_proj/custome_effect/custom_sprite_animate.dart';
import 'package:empty_proj/main.dart';
import 'package:empty_proj/models/ingame_answer.dart';
import 'package:empty_proj/models/question.dart';
import 'package:empty_proj/models/quizz_category.dart';
import 'package:empty_proj/view/home_page.dart';
import 'package:empty_proj/view/result_page.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class IngamePage extends StatefulWidget {
  const IngamePage(
      {Key? key, this.soCauHoi = 0, required this.linhvuc, this.thoigian = 0})
      : super(key: key);

  final int soCauHoi;
  final QuizzCategory linhvuc;
  final int thoigian;

  @override
  _IngamePageState createState() => _IngamePageState();
}

class _IngamePageState extends State<IngamePage> with TickerProviderStateMixin {
  //Đưa dl firebase vào dsQuestion
  List<Question> dsQuestionAll = [];
  //dsChon chứa 1 list danh sách các phương án đã chọn cho 1 câu(1 chỉ số là 1 câu)
  //-1 == chưa chọn
  //0 == chọn A
  //1 == chọn B
  //2 == chọn C
  //3 == chọn C
  List<int> dsChon = [];
  List<Question> dsQuestion = [];
  //
  //////Không làm gì
  //Biến này chứa 4 đáp án ABCD để đảo nhau
  late List<IngameAnswer> answers;
  //Biến này chứa ds biến trên
  List<List<IngameAnswer>> _questionAnswer = [];
  List<int> _selectCache = [];
  //
  late int starttime = widget.thoigian * 60;
  late int current = starttime;
  late StreamSubscription<CountdownTimer> sub;
  //
  late final AnimationController _controller;
  late final AnimationController _controllerReplay;
  late final AnimationController _controllerReplayQ;
  late final AnimationController _controllerReplayA;
  late final AnimationController _controllerReplayB;
  late final AnimationController _controllerReplayC;
  late final AnimationController _controllerReplayD;
  late final AnimationController _controllerRepeat;
  late final Animation<Offset> _offsetAnimationUp;
  late final Animation<Offset> _offsetAnimationUpNext;
  late final Animation<Offset> _offsetAnimationDown;
  late final Animation<Offset> _offsetAnimationLeft;
  late final Animation<Offset> _offsetAnimationRight;
  late final Animation<double> _rotateAnimation;
  //
  int index = 0;
  bool selectA = false;
  bool selectB = false;
  bool selectC = false;
  bool selectD = false;
  bool next = false;
  bool nextQ = false;
  bool nextA = false;
  bool nextB = false;
  bool nextC = false;
  bool nextD = false;
  bool leftArrow = false;
  bool rightArrow = true;
  bool _visible = true;
  bool _enabled = true;
  //////

  List<IngameAnswer> getValue(int index) {
    List<IngameAnswer> temp = _questionAnswer[index];
    return temp;
  }

  void chooseCase(int chon) {
    switch (chon) {
      case 0:
        selectA = true;
        selectB = false;
        selectC = false;
        selectD = false;
        break;
      case 1:
        selectA = false;
        selectB = true;
        selectC = false;
        selectD = false;
        break;
      case 2:
        selectA = false;
        selectB = false;
        selectC = true;
        selectD = false;
        break;
      case 3:
        selectA = false;
        selectB = false;
        selectC = false;
        selectD = true;
        break;
      default:
        selectA = false;
        selectB = false;
        selectC = false;
        selectD = false;
    }
  }

  bool checkAnswer() {
    bool check = false;
    for (final item in dsChon) {
      if (item == -1) {
        check = true;
        break;
      }
    }
    return check;
  }

  @override
  void initState() {
    super.initState();
    //
    getQuestionData();
    //
    for (var i = 0; i < widget.soCauHoi; i++) {
      dsQuestionAll.add(const Question(
          0,
          0,
          "Đang tải câu hỏi...",
          "Đang tải đáp án...",
          "Đang tải đáp án...",
          "Đang tải đáp án...",
          "Đang tải đáp án...",
          0));
    }
    for (var i = 0; i < widget.soCauHoi; i++) {
      dsQuestion.add(dsQuestionAll[i]);
      dsChon.add(-1);
      _selectCache.add(-1);
    }
    //----------------
    for (var i = 0; i < dsQuestion.length; i++) {
      answers = [];
      answers.add(IngameAnswer(key: 0, value: dsQuestion[i].dapAn1));
      answers.add(IngameAnswer(key: 1, value: dsQuestion[i].dapAn2));
      answers.add(IngameAnswer(key: 2, value: dsQuestion[i].dapAn3));
      answers.add(IngameAnswer(key: 3, value: dsQuestion[i].dapAn4));
      answers.shuffle();
      _questionAnswer.add(answers);
    }
    //
    //
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    //
    _controllerReplay = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    //
    _controllerReplayQ = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    //
    _controllerReplayA = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    //
    _controllerReplayB = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    //
    _controllerReplayC = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    //
    _controllerReplayD = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    //
    _controllerRepeat = AnimationController(
      duration: const Duration(minutes: 5),
      vsync: this,
    )..repeat();
    //
    _offsetAnimationUp = Tween<Offset>(
      begin: const Offset(0, -1.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controllerReplay, curve: Curves.ease));
    //
    _offsetAnimationUpNext = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1.5),
    ).animate(CurvedAnimation(parent: _controllerReplay, curve: Curves.ease));
    //
    _offsetAnimationDown = Tween<Offset>(
      begin: const Offset(0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    //
    _offsetAnimationLeft = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    //
    _offsetAnimationRight = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    //
    _rotateAnimation =
        Tween<double>(begin: 0, end: 360).animate(_controllerRepeat);
    //

    _controllerReplay.forward();
    _controller.forward();
    Future.delayed(
      const Duration(milliseconds: 400),
      () {
        _controllerReplayQ.forward();
        setState(() {
          _visible = false;
        });
      },
    );
    Future.delayed(
      const Duration(milliseconds: 450),
      () {
        _controllerReplayA.forward();
      },
    );
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        _controllerReplayB.forward();
      },
    );
    Future.delayed(
      const Duration(milliseconds: 550),
      () {
        _controllerReplayC.forward();
      },
    );
    Future.delayed(
      const Duration(milliseconds: 600),
      () {
        _controllerReplayD.forward();
      },
    );
  }

  @override
  void dispose() {
    _controllerRepeat.dispose();
    _controllerReplay.dispose();
    _controllerReplayQ.dispose();
    _controllerReplayA.dispose();
    _controllerReplayB.dispose();
    _controllerReplayC.dispose();
    _controllerReplayD.dispose();
    _controller.dispose();
    super.dispose();
  }

  void getQuestionData() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("Cauhois")
        .where("linhvucid", isEqualTo: widget.linhvuc.id)
        .get();
    dsQuestionAll = [];
    dsQuestion = [];
    _selectCache = [];
    dsChon = [];
    _questionAnswer = [];
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
          dsQuestionAll.add(temp);
        });
        dsQuestionAll.shuffle();
        //Code xử lí dữ liệu bỏ vào dưới đây
        for (var i = 0; i < widget.soCauHoi; i++) {
          dsQuestion.add(dsQuestionAll[Random().nextInt(dsQuestionAll.length)]);
          dsChon.add(-1);
          _selectCache.add(-1);
        }
        dsQuestion.shuffle();
        //----------------
        for (var i = 0; i < dsQuestion.length; i++) {
          answers = [];
          answers.add(IngameAnswer(key: 0, value: dsQuestion[i].dapAn1));
          answers.add(IngameAnswer(key: 1, value: dsQuestion[i].dapAn2));
          answers.add(IngameAnswer(key: 2, value: dsQuestion[i].dapAn3));
          answers.add(IngameAnswer(key: 3, value: dsQuestion[i].dapAn4));
          answers.shuffle();
          _questionAnswer.add(answers);
          print(dsQuestion[i].cauHoi +
              " " +
              dsQuestion[i].dapAn1 +
              " " +
              dsQuestion[i].dapAn2 +
              " " +
              dsQuestion[i].dapAn3 +
              " " +
              dsQuestion[i].dapAn4 +
              " " +
              dsQuestion[i].dapAnDung.toString());
        }
      });
    }
    startTimer();
  }

  void startTimer() {
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: starttime),
      new Duration(seconds: 1),
    );

    sub = countDownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        current = starttime - duration.elapsed.inSeconds;
      });
    });

    sub.onDone(() {
      sub.cancel();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => ResultPage(
                    cauTraLoi: dsChon,
                    cauHoi: dsQuestion,
                    questionAnswer: _questionAnswer,
                    selectedCache: _selectCache,
                    thoigian: widget.thoigian,
                    thoigianconlai: current,
                    linhvuc: widget.linhvuc,
                  ))));
    });
  }

  @override
  Widget build(BuildContext context) {
    AudioPlayer _player = AudioPlayer();

    return WillPopScope(
        child: Scaffold(
          body: Center(
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.only(top: 25, bottom: 5, left: 16, right: 16),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: _visible
                          ? AssetImage("assets/images/inamge_bg2.png")
                          : AssetImage("assets/images/inamge_bg.png"),
                      fit: BoxFit.fitHeight)),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Visibility(
                    visible: _visible,
                    child: Positioned.fill(
                      top: -100,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 150,
                                height: double.infinity,
                                child: GameWidget(
                                    game: CustomSpriteAnimate(
                                  spritePath: "sprites/lig_ty_009.png",
                                  column: 5,
                                  row: 2,
                                  steptime: 0.05,
                                  sizes: Vector2(150, 700),
                                )),
                              ),
                              Container(
                                width: 150,
                                height: double.infinity,
                                child: GameWidget(
                                    game: CustomSpriteAnimate(
                                  spritePath: "sprites/lig_ty_009.png",
                                  column: 5,
                                  row: 2,
                                  steptime: 0.05,
                                  sizes: Vector2(150, 700),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _visible,
                    child: Positioned.fill(
                      top: -50,
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 150,
                                  height: double.infinity,
                                  child: GameWidget(
                                      game: CustomSpriteAnimate(
                                    spritePath:
                                        "sprites/Fx_Lightning01_Sylvie_Alpha_W.png",
                                    column: 4,
                                    row: 1,
                                    steptime: 0.05,
                                    sizes: Vector2(150, 600),
                                  )),
                                ),
                                Container(
                                  width: 150,
                                  height: double.infinity,
                                  child: GameWidget(
                                      game: CustomSpriteAnimate(
                                    spritePath:
                                        "sprites/Fx_Lightning01_W_01.png",
                                    column: 4,
                                    row: 1,
                                    steptime: 0.05,
                                    sizes: Vector2(150, 600),
                                  )),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  RotationTransition(
                    turns: _rotateAnimation,
                    child: Container(
                        width: 600,
                        child: Image.asset(
                          "assets/images/sprites/Fx_WaterWave01.png",
                          fit: BoxFit.fitWidth,
                        )),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SlideTransition(
                          position: next
                              ? _offsetAnimationUpNext
                              : _offsetAnimationUp,
                          child: Container(
                            child: Image.asset(
                              "assets/images/ingame_up.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SlideTransition(
                          position: _offsetAnimationDown,
                          child: Container(
                            child: Image.asset(
                              "assets/images/ingame_down.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ]),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SlideFadeTransition(
                        exit: nextQ,
                        controller: _controllerReplayQ,
                        curveIn: Curves.ease,
                        curveOut: Curves.ease,
                        oBeginOut: Offset.zero,
                        oBeginIn: Offset(0, -1),
                        oEndOut: Offset(0, 1),
                        oEndIn: Offset.zero,
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 30),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20))),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Câu ' + (index + 1).toString() + ":",
                                  style: TextStyle(fontSize: 20),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    dsQuestion[index].cauHoi,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                      SlideFadeTransition(
                        exit: nextA,
                        controller: _controllerReplayA,
                        curveIn: Curves.ease,
                        curveOut: Curves.ease,
                        oBeginOut: Offset.zero,
                        oBeginIn: Offset(0, -1),
                        oEndOut: Offset(0, 1),
                        oEndIn: Offset.zero,
                        child: SelectedAnswer(
                          selected: selectA,
                          cauSo: "A",
                          cauTraLoi: getValue(index)[0].value,
                          ontap: () {
                            setState(() {
                              selectA = !selectA;
                              selectB = false;
                              selectC = false;
                              selectD = false;
                              dsChon[index] = getValue(index)[0].key;
                              _selectCache[index] = 0;
                            });
                          },
                        ),
                      ),
                      SlideFadeTransition(
                        exit: nextB,
                        controller: _controllerReplayB,
                        curveIn: Curves.ease,
                        curveOut: Curves.ease,
                        oBeginOut: Offset.zero,
                        oBeginIn: Offset(0, -1),
                        oEndOut: Offset(0, 1),
                        oEndIn: Offset.zero,
                        child: SelectedAnswer(
                          selected: selectB,
                          cauSo: "B",
                          cauTraLoi: getValue(index)[1].value,
                          ontap: (() {
                            setState(() {
                              selectA = false;
                              selectB = !selectB;
                              selectC = false;
                              selectD = false;
                              dsChon[index] = getValue(index)[1].key;
                              _selectCache[index] = 1;
                            });
                          }),
                        ),
                      ),
                      SlideFadeTransition(
                        exit: nextC,
                        controller: _controllerReplayC,
                        curveIn: Curves.ease,
                        curveOut: Curves.ease,
                        oBeginOut: Offset.zero,
                        oBeginIn: Offset(0, -1),
                        oEndOut: Offset(0, 1),
                        oEndIn: Offset.zero,
                        child: SelectedAnswer(
                          selected: selectC,
                          cauSo: "C",
                          cauTraLoi: getValue(index)[2].value,
                          ontap: () {
                            setState(() {
                              selectA = false;
                              selectB = false;
                              selectC = !selectC;
                              selectD = false;
                              dsChon[index] = getValue(index)[2].key;
                              _selectCache[index] = 2;
                            });
                          },
                        ),
                      ),
                      SlideFadeTransition(
                        exit: nextD,
                        controller: _controllerReplayD,
                        curveIn: Curves.ease,
                        curveOut: Curves.ease,
                        oBeginOut: Offset.zero,
                        oBeginIn: Offset(0, -1),
                        oEndOut: Offset(0, 1),
                        oEndIn: Offset.zero,
                        child: SelectedAnswer(
                          selected: selectD,
                          cauSo: "D",
                          cauTraLoi: getValue(index)[3].value,
                          ontap: () {
                            setState(() {
                              selectA = false;
                              selectB = false;
                              selectC = false;
                              selectD = !selectD;
                              dsChon[index] = getValue(index)[3].key;
                              _selectCache[index] = 3;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 50, right: 50),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                ((current / 60).toInt()).toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                ':',
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                ((current % 60).toInt()).toString(),
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/alert.png"),
                                  fit: BoxFit.fitWidth)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SlideTransition(
                                position: _offsetAnimationLeft,
                                child: InkWell(
                                  onTap: _enabled
                                      ? () {
                                          if (index > 0) {
                                            index--;
                                            setState(() {
                                              _enabled = false;
                                              nextQ = true;
                                              _controllerReplayQ.reset();
                                              _controllerReplayQ.forward();
                                              _visible = true;
                                              _player.play(
                                                  AssetSource(
                                                      "audios/active.mp3"),
                                                  mode: PlayerMode.lowLatency);
                                            });
                                            Future.delayed(
                                                Duration(milliseconds: 50),
                                                (() {
                                              setState(() {
                                                nextA = true;
                                                _controllerReplayA.reset();
                                                _controllerReplayA.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 100),
                                                (() {
                                              setState(() {
                                                nextB = true;
                                                _controllerReplayB.reset();
                                                _controllerReplayB.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 150),
                                                (() {
                                              setState(() {
                                                nextC = true;
                                                _controllerReplayC.reset();
                                                _controllerReplayC.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 200),
                                                (() {
                                              setState(() {
                                                nextD = true;
                                                _controllerReplayD.reset();
                                                _controllerReplayD.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 500),
                                                (() {
                                              setState(() {
                                                next = true;
                                                _controllerReplay.reset();
                                                _controllerReplay.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 1000),
                                                (() {
                                              setState(() {
                                                chooseCase(_selectCache[index]);
                                                next = false;
                                                _controllerReplay.reset();
                                                _controllerReplay.forward();
                                                if (index == 0) {
                                                  setState(() {
                                                    leftArrow = false;
                                                  });
                                                }
                                                rightArrow = true;
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 1400),
                                                (() {
                                              setState(() {
                                                nextQ = false;
                                                _controllerReplayQ.reset();
                                                _controllerReplayQ.forward();
                                                _visible = false;
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 1450),
                                                (() {
                                              setState(() {
                                                nextA = false;
                                                _controllerReplayA.reset();
                                                _controllerReplayA.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 1500),
                                                (() {
                                              setState(() {
                                                nextB = false;
                                                _controllerReplayB.reset();
                                                _controllerReplayB.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 1550),
                                                (() {
                                              setState(() {
                                                nextC = false;
                                                _controllerReplayC.reset();
                                                _controllerReplayC.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 1600),
                                                (() {
                                              setState(() {
                                                _enabled = true;
                                                nextD = false;
                                                _controllerReplayD.reset();
                                                _controllerReplayD.forward();
                                              });
                                            }));
                                          }
                                          print(index);
                                        }
                                      : null,
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        leftArrow
                                            ? Colors.transparent
                                            : Colors.grey,
                                        BlendMode.srcATop),
                                    child: Transform.scale(
                                      scaleX: -1,
                                      child: Image.asset(
                                          "assets/images/ingame_arrow.png"),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 50, right: 50),
                                child: Text(
                                  (index + 1).toString() +
                                      " / " +
                                      dsQuestion.length.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              SlideTransition(
                                position: _offsetAnimationRight,
                                child: InkWell(
                                  onTap: _enabled
                                      ? () {
                                          if (index < dsQuestion.length - 1) {
                                            _player.play(
                                                AssetSource(
                                                    "audios/active.mp3"),
                                                mode: PlayerMode.lowLatency);
                                            setState(() {
                                              _enabled = false;
                                              index += 1;
                                              nextQ = true;
                                              _controllerReplayQ.reset();
                                              _controllerReplayQ.forward();
                                              _visible = true;
                                            });
                                            Future.delayed(
                                                Duration(milliseconds: 50),
                                                (() {
                                              setState(() {
                                                nextA = true;
                                                _controllerReplayA.reset();
                                                _controllerReplayA.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 100),
                                                (() {
                                              setState(() {
                                                nextB = true;
                                                _controllerReplayB.reset();
                                                _controllerReplayB.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 150),
                                                (() {
                                              setState(() {
                                                nextC = true;
                                                _controllerReplayC.reset();
                                                _controllerReplayC.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 200),
                                                (() {
                                              setState(() {
                                                nextD = true;
                                                _controllerReplayD.reset();
                                                _controllerReplayD.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 500),
                                                (() {
                                              setState(() {
                                                next = true;
                                                _controllerReplay.reset();
                                                _controllerReplay.forward();
                                              });
                                            }));
                                            leftArrow = true;
                                            Future.delayed(
                                                Duration(milliseconds: 1000),
                                                (() {
                                              setState(() {
                                                chooseCase(_selectCache[index]);
                                                next = false;
                                                _controllerReplay.reset();
                                                _controllerReplay.forward();
                                                if (index ==
                                                    dsQuestion.length - 1) {
                                                  setState(() {
                                                    rightArrow = false;
                                                  });
                                                }
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 1400),
                                                (() {
                                              setState(() {
                                                nextQ = false;
                                                _controllerReplayQ.reset();
                                                _controllerReplayQ.forward();
                                                _visible = false;
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 1450),
                                                (() {
                                              setState(() {
                                                nextA = false;
                                                _controllerReplayA.reset();
                                                _controllerReplayA.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 1500),
                                                (() {
                                              setState(() {
                                                nextB = false;
                                                _controllerReplayB.reset();
                                                _controllerReplayB.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 1550),
                                                (() {
                                              setState(() {
                                                nextC = false;
                                                _controllerReplayC.reset();
                                                _controllerReplayC.forward();
                                              });
                                            }));
                                            Future.delayed(
                                                Duration(milliseconds: 1600),
                                                (() {
                                              setState(() {
                                                nextD = false;
                                                _enabled = true;
                                                _controllerReplayD.reset();
                                                _controllerReplayD.forward();
                                              });
                                            }));
                                          }
                                        }
                                      : null,
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        rightArrow
                                            ? Colors.transparent
                                            : Colors.grey,
                                        BlendMode.srcATop),
                                    child: Transform.scale(
                                      scaleX: 1,
                                      child: Image.asset(
                                          "assets/images/ingame_arrow.png"),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomBtn(
                                buttonImagePath: "assets/images/btn_red.png",
                                text: "Thoát".toUpperCase(),
                                paddings: EdgeInsets.only(
                                    top: 15, bottom: 15, left: 25, right: 25),
                                ontap: () {
                                  showDialog(
                                      context: context,
                                      builder: ((context) => CustomDialog(
                                            title: "Cảnh báo".toUpperCase(),
                                            content:
                                                "Bạn chắc chắn muốn thoát khỏi trò chơi? \nTiến trình chơi của bạn sẽ không được lưu",
                                            onTapCancel: (() {
                                              Navigator.pop(context);
                                            }),
                                            onTapConfirm: () {
                                              sub.cancel();
                                              player.stop();
                                              player.play(AssetSource(
                                                  "audios/common_audio.mp3"));
                                              player.setReleaseMode(
                                                  ReleaseMode.loop);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          HomePage())));
                                            },
                                          )));
                                },
                              ),
                              CustomBtn(
                                buttonImagePath: "assets/images/btn_amber.png",
                                text: "Hoàn tất".toUpperCase(),
                                paddings: EdgeInsets.all(15),
                                ontap: () {
                                  if (checkAnswer()) {
                                    showDialog(
                                        context: context,
                                        builder: ((context) => CustomDialog(
                                              title: "Cảnh báo".toUpperCase(),
                                              content:
                                                  "Vẫn còn câu hỏi chưa chọn đáp án, Bạn vẫn chắc chán muốn hoàn tất trò chơi?",
                                              onTapCancel: (() {
                                                Navigator.pop(context);
                                              }),
                                              onTapConfirm: (() {
                                                sub.cancel();
                                                player.stop();
                                                player.play(AssetSource(
                                                    "audios/common_audio.mp3"));
                                                player.setReleaseMode(
                                                    ReleaseMode.loop);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) =>
                                                          ResultPage(
                                                            cauTraLoi: dsChon,
                                                            cauHoi: dsQuestion,
                                                            questionAnswer:
                                                                _questionAnswer,
                                                            selectedCache:
                                                                _selectCache,
                                                            thoigian:
                                                                widget.thoigian,
                                                            thoigianconlai:
                                                                current,
                                                            linhvuc:
                                                                widget.linhvuc,
                                                          ))),
                                                );
                                              }),
                                            )));
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) => CustomDialog(
                                        title: "Hoàn tất".toUpperCase(),
                                        content:
                                            "Bạn chắc chắn muốn hoàn tất trò chơi?",
                                        onTapCancel: (() {
                                          Navigator.pop(context);
                                        }),
                                        onTapConfirm: () {
                                          sub.cancel();
                                          player.stop();
                                          player.play(AssetSource(
                                              "audios/common_audio.mp3"));
                                          player
                                              .setReleaseMode(ReleaseMode.loop);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    ResultPage(
                                                      cauTraLoi: dsChon,
                                                      cauHoi: dsQuestion,
                                                      questionAnswer:
                                                          _questionAnswer,
                                                      selectedCache:
                                                          _selectCache,
                                                      thoigian: widget.thoigian,
                                                      thoigianconlai: current,
                                                      linhvuc: widget.linhvuc,
                                                    ))),
                                          );
                                        },
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: (() async {
          return await showDialog(
              context: context,
              builder: ((context) => CustomDialog(
                    title: "Cảnh báo".toUpperCase(),
                    content:
                        "Bạn chắc chắn muốn thoát khỏi trò chơi? \nTiến trình chơi của bạn sẽ không được lưu",
                    onTapCancel: () {
                      Navigator.of(context).pop(false);
                    },
                    onTapConfirm: () {
                      sub.cancel();
                      player.stop();
                      player.play(AssetSource("audios/common_audio.mp3"));
                      player.setReleaseMode(ReleaseMode.loop);
                      Navigator.of(context).pop(true);
                    },
                  )));
        }));
  }
}
