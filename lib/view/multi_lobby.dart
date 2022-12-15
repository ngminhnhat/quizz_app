import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/models/quizz_category.dart';
import 'package:flutter/material.dart';

class MultiLobby extends StatefulWidget {
  const MultiLobby(
      {Key? key, this.soCauHoi = 0, required this.linhvuc, this.thoigian = 0})
      : super(key: key);

  final int soCauHoi;
  final QuizzCategory linhvuc;
  final int thoigian;

  @override
  _MultiLobbyState createState() => _MultiLobbyState();
}

class _MultiLobbyState extends State<MultiLobby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/images/Static_Cinematic_bg_transend.png"),
                  fit: BoxFit.fitHeight)),
          child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(
                      width: 100,
                      height: 100,
                    )
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 25, left: 15, right: 15),
                    child: Column(
                      children: [
                        Icon(
                          Icons.vpn_lock_outlined,
                          size: 100,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text("Lĩnh vực: " + widget.linhvuc.name),
                              Text("Số câu hỏi: " + widget.soCauHoi.toString()),
                            ],
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  top: 50,
                  child: TextStroke(
                    content: "Thách đấu".toUpperCase(),
                    fontfamily: "SVN-DeterminationSans",
                    fontsize: 40,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
