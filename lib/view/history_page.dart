import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/histoty_card.dart';
import 'package:empty_proj/component/logo.dart';
import 'package:empty_proj/models/game_history.dart';
import 'package:empty_proj/view/login_page.dart';
import 'package:empty_proj/view/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<GameHistory> _list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/history_bg.png'),
                  fit: BoxFit.fitHeight),
            ),
            child: Stack(
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
                    margin: EdgeInsets.only(top: 185, left: 1, right: 1),
                    child: (FirebaseAuth.instance.currentUser != null)
                        ? SingleChildScrollView(
                            child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('history')
                                .where('emailuser',
                                    isEqualTo: FirebaseAuth
                                        .instance.currentUser!.email)
                                .where('ischallenge', isEqualTo: 0)
                                .orderBy('ngaychoi', descending: true)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final data = snapshot.data!.docs;

                                for (var row in data) {
                                  final r = row.data() as Map<String, dynamic>;
                                  _list.add(GameHistory(
                                      diem: r['diem'],
                                      emailuser: r['emailuser'],
                                      ngaychoi: DateFormat('dd-MM-yyyy')
                                          .format(r['ngaychoi'].toDate())
                                          .toString(),
                                      socauhoi: r['socauhoi'],
                                      socautraloidung: r['socautraloidung'],
                                      thoigiantraloi: r['thoigiantraloi'],
                                      thoigianconlai: r['thoigianconlai']));
                                }
                              }
                              return (_list.length != 0)
                                  ? ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _list.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        int temp = index + 1;
                                        return HistotyCard(
                                          name:
                                              "Tr???n ?????u ng??y ${_list[index].ngaychoi}",
                                          score: _list[index].diem,
                                          gameHistory: _list[index],
                                        );
                                      },
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(
                                          top: 150, left: 20, right: 20),
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                            Text(
                                                'B???n ch??a c?? l???ch s??? ch??i, vui l??ng '),
                                            TextButton(
                                                onPressed: (() {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: ((context) =>
                                                              LoginPage())));
                                                }),
                                                child: Text(
                                                  'ch??i game',
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                )),
                                            Text(" ????? l??u l???ch s???!"),
                                          ],
                                        ),
                                      ),
                                    );
                            },
                          ))
                        : Container(
                            margin:
                                EdgeInsets.only(top: 150, left: 20, right: 20),
                            child: FittedBox(
                              child: Row(
                                children: [
                                  Text('Vui l??ng '),
                                  TextButton(
                                      onPressed: (() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    LoginPage())));
                                      }),
                                      child: Text(
                                        '????ng nh???p',
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                  Text(" ho???c "),
                                  TextButton(
                                      onPressed: (() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    RegisterPage())));
                                      }),
                                      child: Text(
                                        '????ng k??',
                                        style: TextStyle(color: Colors.blue),
                                      )),
                                  Text(" ????? s??? d???ng ch???c n??ng n??y!"),
                                ],
                              ),
                            ),
                          )),
                Logo(
                  text: "L???ch s??? tr?? ch??i".toUpperCase(),
                  logoPath: "assets/images/history_logo.png",
                  fontsize: 40,
                ),
              ],
            )),
      ),
    );
  }
}
