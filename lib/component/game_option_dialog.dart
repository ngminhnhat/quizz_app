import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/main.dart';
import 'package:empty_proj/models/quizz_category.dart';
import 'package:empty_proj/view/ingame_page.dart';
import 'package:empty_proj/view/multi_lobby.dart';
import 'package:flutter/material.dart';

class GameOptionDialog extends StatefulWidget {
  const GameOptionDialog({Key? key, this.title = "", this.multi = false})
      : super(key: key);

  final String title;
  final bool multi;

  @override
  _GameOptionDialogState createState() => _GameOptionDialogState();
}

class _GameOptionDialogState extends State<GameOptionDialog> {
  late QuizzCategory? selectedCategory;
// Lay du lieu tu firebase
  List<QuizzCategory> quizzCategorys = <QuizzCategory>[
    const QuizzCategory(0, "Loading.."),
  ];
//
// Gan cung du lieu sau nay xu li
  late int selectedNumQuest;
  List<String> numOfQuestions = <String>['10', '20', '30', '40'];
  //
  int? selectedTimer;
  List<String> timers = <String>['1', '10', '20', '30', '40', '50'];
//
  void getCategory() async {
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection('linhvucs').get();
    if (query.docs.isNotEmpty) {
      quizzCategorys = [];
      for (var element in query.docs) {
        quizzCategorys.add(QuizzCategory(element['id'], element['name']));
      }
      selectedCategory = quizzCategorys[0];
    }
    setState(() {});
  }

//
  @override
  void initState() {
    selectedCategory = quizzCategorys[0];
    selectedNumQuest = int.parse(numOfQuestions[0]);
    selectedTimer = int.parse(timers[0]);
    getCategory();
  }

  dialogContent(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      padding: const EdgeInsets.only(left: 70, right: 70, top: 30, bottom: 10),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/option_dialog.png"),
            fit: BoxFit.fitWidth),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextStroke(
            content: widget.title.toUpperCase(),
            fontsize: 20,
            fontfamily: "SVN-DeterminationSans",
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Ch???n l??nh v???c"),
                DropdownButton<QuizzCategory>(
                  value: selectedCategory,
                  items: quizzCategorys.map<DropdownMenuItem<QuizzCategory>>(
                      (QuizzCategory value) {
                    return DropdownMenuItem<QuizzCategory>(
                      value: value,
                      child: Text(value.name + ' ' + value.id.toString()),
                    );
                  }).toList(),
                  onChanged: ((QuizzCategory? value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Ch???n s??? l?????ng c??u h???i"),
                Container(
                  child: DropdownButton(
                    value: selectedNumQuest.toString(),
                    items: numOfQuestions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value + ' ' + 'c??u'),
                      );
                    }).toList(),
                    onChanged: ((String? value) {
                      setState(() {
                        selectedNumQuest = int.parse(value ?? '0');
                      });
                      print(selectedNumQuest);
                    }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Ch???n th???i gian"),
                Container(
                  child: DropdownButton(
                    value: selectedTimer.toString(),
                    items: timers.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value + ' ' + 'ph??t'),
                      );
                    }).toList(),
                    onChanged: ((String? value) {
                      setState(() {
                        selectedTimer = int.parse(value ?? '0');
                        print(selectedTimer);
                      });
                    }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBtn(
                  buttonImagePath: "assets/images/btn_blue.png",
                  text: "B???t ?????u".toUpperCase(),
                  paddings:
                      EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                  ontap: () {
                    player.stop();
                    player.play(AssetSource("audios/ingame_audio.mp3"));
                    player.setReleaseMode(ReleaseMode.loop);
                    Navigator.pop(context);
                    widget.multi
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => MultiLobby(
                                      soCauHoi: selectedNumQuest,
                                      linhvuc: selectedCategory!,
                                      thoigian: selectedTimer!,
                                    ))))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => IngamePage(
                                      soCauHoi: selectedNumQuest,
                                      linhvuc: selectedCategory!,
                                      thoigian: selectedTimer!,
                                    ))));
                  },
                ),
                CustomBtn(
                  buttonImagePath: "assets/images/btn_red.png",
                  text: "Hu??? b???".toUpperCase(),
                  paddings:
                      EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                  ontap: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      elevation: 0.0,
      insetPadding: EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}
