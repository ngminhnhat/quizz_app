import 'package:empty_proj/component/SlideFadeTransition.dart';
import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/custom_dialog.dart';
import 'package:empty_proj/component/selected_answer.dart';
import 'package:empty_proj/models/question.dart';
import 'package:empty_proj/view/home_page.dart';
import 'package:flutter/material.dart';

class IngamePage extends StatefulWidget {
  const IngamePage({Key? key, this.soCauHoi = 0}) : super(key: key);

  final int soCauHoi;

  @override
  _IngamePageState createState() => _IngamePageState();
}

class _IngamePageState extends State<IngamePage> with TickerProviderStateMixin {
  //Code khai báo dữ liệu bỏ vào dưới đây
  List<Question> dsQuestion = [];
  //dsChon chứa 1 list danh sách các phương án đã chọn cho 1 câu(1 chỉ số là 1 câu)
  //-1 == chưa chọn
  //0 == chọn A
  //1 == chọn B
  //2 == chọn C
  //3 == chọn C
  List<int> dsChon = [];

  //
  late final AnimationController _controller;
  late final AnimationController _controllerReplay;
  late final AnimationController _controllerReplayQ;
  late final AnimationController _controllerReplayA;
  late final AnimationController _controllerReplayB;
  late final AnimationController _controllerReplayC;
  late final AnimationController _controllerReplayD;
  late final Animation<Offset> _offsetAnimationUp;
  late final Animation<Offset> _offsetAnimationUpNext;
  late final Animation<Offset> _offsetAnimationDown;
  late final Animation<Offset> _offsetAnimationLeft;
  late final Animation<Offset> _offsetAnimationRight;
  //
  int index = 0;
  bool selectA = false;
  bool selectB = false;
  bool selectC = false;
  bool selectD = false;
  bool next = false;
  bool leftArrow = false;
  bool rightArrow = true;

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
    //Code xử lí dữ liệu bỏ vào dưới đây
    for (var i = 0; i < widget.soCauHoi; i++) {
      Question quest = Question(
          i, i, "cauHoi$i", "dapAn1$i", "dapAn2$i", "dapAn3$i", "dapAn4$i", 1);
      dsQuestion.add(quest);
      dsChon.add(-1);
    }
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
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    //
    _controllerReplayA = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    //
    _controllerReplayB = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    //
    _controllerReplayC = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    //
    _controllerReplayD = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
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
    _controllerReplay.forward();
    _controller.forward();
  }

  @override
  void dispose() {
    _controllerReplay.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Center(
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.only(top: 25, bottom: 5, left: 16, right: 16),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/inamge_bg.png"),
                      fit: BoxFit.fitHeight)),
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
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
                        exit: next,
                        controller: _controllerReplay,
                        aniDuration: Duration(milliseconds: 500),
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
                                Text(
                                  dsQuestion[index].cauHoi,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ]),
                        ),
                      ),
                      SlideFadeTransition(
                        exit: next,
                        controller: _controllerReplay,
                        aniDuration: Duration(milliseconds: 500),
                        curveIn: Curves.ease,
                        curveOut: Curves.ease,
                        oBeginOut: Offset.zero,
                        oBeginIn: Offset(0, -1),
                        oEndOut: Offset(0, 1),
                        oEndIn: Offset.zero,
                        child: SelectedAnswer(
                          selected: selectA,
                          cauSo: "A",
                          cauTraLoi: dsQuestion[index].dapAn1,
                          ontap: () {
                            setState(() {
                              selectA = !selectA;
                              selectB = false;
                              selectC = false;
                              selectD = false;
                              dsChon[index] = 0;
                            });
                          },
                        ),
                      ),
                      SlideFadeTransition(
                        exit: next,
                        controller: _controllerReplay,
                        aniDuration: Duration(milliseconds: 500),
                        curveIn: Curves.ease,
                        curveOut: Curves.ease,
                        oBeginOut: Offset.zero,
                        oBeginIn: Offset(0, -1),
                        oEndOut: Offset(0, 1),
                        oEndIn: Offset.zero,
                        child: SelectedAnswer(
                          selected: selectB,
                          cauSo: "B",
                          cauTraLoi: dsQuestion[index].dapAn2,
                          ontap: (() {
                            setState(() {
                              selectA = false;
                              selectB = !selectB;
                              selectC = false;
                              selectD = false;
                              dsChon[index] = 1;
                            });
                          }),
                        ),
                      ),
                      SlideFadeTransition(
                        exit: next,
                        controller: _controllerReplay,
                        aniDuration: Duration(milliseconds: 500),
                        curveIn: Curves.ease,
                        curveOut: Curves.ease,
                        oBeginOut: Offset.zero,
                        oBeginIn: Offset(0, -1),
                        oEndOut: Offset(0, 1),
                        oEndIn: Offset.zero,
                        child: SelectedAnswer(
                          selected: selectC,
                          cauSo: "C",
                          cauTraLoi: dsQuestion[index].dapAn3,
                          ontap: () {
                            setState(() {
                              selectA = false;
                              selectB = false;
                              selectC = !selectC;
                              selectD = false;
                              dsChon[index] = 2;
                            });
                          },
                        ),
                      ),
                      SlideFadeTransition(
                        exit: next,
                        controller: _controllerReplay,
                        aniDuration: Duration(milliseconds: 500),
                        curveIn: Curves.ease,
                        curveOut: Curves.ease,
                        oBeginOut: Offset.zero,
                        oBeginIn: Offset(0, -1),
                        oEndOut: Offset(0, 1),
                        oEndIn: Offset.zero,
                        child: SelectedAnswer(
                          selected: selectD,
                          cauSo: "D",
                          cauTraLoi: dsQuestion[index].dapAn4,
                          ontap: () {
                            setState(() {
                              selectA = false;
                              selectB = false;
                              selectC = false;
                              selectD = !selectD;
                              dsChon[index] = 3;
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
                                  onTap: () {
                                    print(index);
                                    if (index > 0) {
                                      setState(() {
                                        next = true;
                                        _controllerReplay.reset();
                                        _controllerReplay.forward();
                                        chooseCase(dsChon[index]);
                                        rightArrow = true;
                                      });
                                      Future.delayed(
                                          Duration(milliseconds: 500), (() {
                                        setState(() {
                                          index--;
                                          chooseCase(dsChon[index]);
                                          next = false;
                                          _controllerReplay.reset();
                                          _controllerReplay.forward();
                                        });
                                      }));
                                    }
                                    if (index == 0) {
                                      setState(() {
                                        leftArrow = false;
                                      });
                                    }
                                  },
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
                                  onTap: () {
                                    if (index < dsQuestion.length - 1) {
                                      setState(() {
                                        next = true;
                                        _controllerReplay.reset();
                                        _controllerReplay.forward();
                                        leftArrow = true;
                                        Future.delayed(
                                            Duration(milliseconds: 500), (() {
                                          setState(() {
                                            index += 1;
                                            chooseCase(dsChon[index]);
                                            next = false;
                                            _controllerReplay.reset();
                                            _controllerReplay.forward();
                                          });
                                        }));
                                      });
                                    }
                                    if (index == dsQuestion.length - 1) {
                                      setState(() {
                                        rightArrow = false;
                                      });
                                    }
                                  },
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
                      Navigator.of(context).pop(true);
                    },
                  )));
        }));
  }
}
