import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/custom_dialog.dart';
import 'package:empty_proj/component/logo.dart';
import 'package:empty_proj/component/ranking_card.dart';
import 'package:empty_proj/models/game_history.dart';
import 'package:empty_proj/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  List<GameHistory> _gameHistory = [];
  List<Player> _user = [];
  List<GameHistory> _userHighestHistory = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/ranking_bg.png'),
                  fit: BoxFit.fitHeight),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 185),
                  child: SingleChildScrollView(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('history')
                          .orderBy('diem', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          _userHighestHistory = [];
                          final data = snapshot.data!.docs;
                          //
                          for (var row in data) {
                            final r = row.data() as Map<String, dynamic>;
                            GameHistory temp = GameHistory(
                                diem: r['diem'],
                                emailuser: r['emailuser'],
                                ngaychoi: DateFormat('dd-MM-yyyy')
                                    .format(r['ngaychoi'].toDate())
                                    .toString(),
                                socauhoi: r['socauhoi'],
                                socautraloidung: r['socautraloidung'],
                                thoigiantraloi: r['thoigiantraloi'],
                                thoigianconlai: r['thoigianconlai']);
                            _gameHistory.add(temp);
                          }
                        }
                        for (var i = 0; i < _gameHistory.length; i++) {
                          bool duplicate = false;
                          GameHistory temp = _gameHistory[i];
                          for (var j = 0; j < _userHighestHistory.length; j++) {
                            if (_userHighestHistory[j].emailuser ==
                                temp.emailuser) {
                              duplicate = true;
                              break;
                            }
                          }
                          if (!duplicate) {
                            _userHighestHistory.add(temp);
                            _user.add(Player("Loading////", "Loading////",
                                "Loading////", 0, 0, "Loading////", 0));
                          }
                        }
                        return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .snapshots(),
                          builder: ((context, snapshot) {
                            if (snapshot.hasError) {
                              return CustomDialog(
                                content:
                                    "Có lỗi xảy ra, vui lòng kiểm tra kết nối!",
                              );
                            }

                            if (snapshot.hasData) {
                              _user = [];
                              final data = snapshot.data!.docs;
                              for (var i = 0;
                                  i < _userHighestHistory.length;
                                  i++) {
                                for (var element in data) {
                                  final r =
                                      element.data() as Map<String, dynamic>;
                                  Player temp = Player(
                                      r['Email'],
                                      r['PassWord'],
                                      r['Nickname'],
                                      r['Coin'],
                                      r['Diamond'],
                                      DateFormat('dd-MM-yyyy')
                                          .format(r['CreateDate'].toDate())
                                          .toString(),
                                      r['Energy']);
                                  if (temp.email ==
                                      _userHighestHistory[i].emailuser) {
                                    _user.add(temp);
                                    break;
                                  }
                                }
                              }
                            }
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _userHighestHistory.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                if (index < 3) {
                                  int temp = index + 1;
                                  return Stack(
                                    children: <Widget>[
                                      RankingCard(
                                        user: _user[index],
                                        gameHistory: _userHighestHistory[index],
                                        edgeInset: EdgeInsets.only(left: 50),
                                      ),
                                      Transform.translate(
                                        offset: const Offset(0, -15),
                                        child: SizedBox(
                                          height: 80,
                                          child: Image.asset(
                                              "assets/images/icons/icon_top_$temp.png"),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                return RankingCard(
                                  user: _user[index],
                                  gameHistory: _userHighestHistory[index],
                                );
                              },
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ),
                Logo(
                  text: "Xếp hạng".toUpperCase(),
                  logoPath: "assets/images/ranking_logo.png",
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
