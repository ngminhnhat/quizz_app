import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/main.dart';
import 'package:empty_proj/models/quizz_category.dart';
import 'package:empty_proj/view/ingame_page.dart';
import 'package:flutter/material.dart';

class GameOptionDialog extends StatefulWidget {
  const GameOptionDialog({Key? key}) : super(key: key);

  @override
  _GameOptionDialogState createState() => _GameOptionDialogState();
}

class _GameOptionDialogState extends State<GameOptionDialog> {
  late QuizzCategory? selectedCategory;
// Lay du lieu tu firebase
  List<QuizzCategory> quizzCategorys = <QuizzCategory>[
    const QuizzCategory(1, "Toán"),
    const QuizzCategory(2, 'Địa lí')
  ];
//
// Gan cung du lieu sau nay xu li
  late int selectedNumQuest;
  List<String> numOfQuestions = <String>['10', '20', '30', '40'];
  //
  // int? selectedTimer;
  // List<String> timers = <String>['10', '20', '30', '40', '50'];
//
  @override
  void initState() {
    selectedCategory = quizzCategorys[0];
    selectedNumQuest = int.parse(numOfQuestions[0]);
    //selectedTimer = int.parse(timers[0]);
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
            content: "Cấu hình trò chơi".toUpperCase(),
            fontsize: 20,
            fontfamily: "SVN-DeterminationSans",
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Chọn lĩnh vực"),
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
                Text("Chọn số lượng câu hỏi"),
                Container(
                  child: DropdownButton(
                    value: selectedNumQuest.toString(),
                    items: numOfQuestions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(value + ' ' + 'câu'),
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
          // Container(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text("Chọn thời gian"),
          //       Container(
          //         child: DropdownButton(
          //           value: selectedTimer.toString(),
          //           items: timers.map<DropdownMenuItem<String>>((String value) {
          //             return DropdownMenuItem(
          //               value: value,
          //               child: Text(value + ' ' + 'phút'),
          //             );
          //           }).toList(),
          //           onChanged: ((String? value) {
          //             setState(() {
          //               selectedTimer = int.parse(value ?? '0');
          //               print(selectedTimer);
          //             });
          //           }),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomBtn(
                  buttonImagePath: "assets/images/btn_blue.png",
                  text: "Bắt đầu".toUpperCase(),
                  paddings:
                      EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                  ontap: () {
                    player.stop();
                    player.play(AssetSource("audios/ingame_audio.mp3"));
                    player.setReleaseMode(ReleaseMode.loop);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => IngamePage(
                                  soCauHoi: selectedNumQuest,
                                  linhvcucid: selectedCategory!.id,
                                ))));
                  },
                ),
                CustomBtn(
                  buttonImagePath: "assets/images/btn_red.png",
                  text: "Huỷ bỏ".toUpperCase(),
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
