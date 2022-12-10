import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/logo.dart';
import 'package:empty_proj/component/ranking_card.dart';
import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  List<String> ls = [];
  List<int> ls1 = []; //đã khai bao o day r //e queoa duoi n x
//đã khai bao o day r //e queoa duoi n x
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
                          final data = snapshot.data!.docs;

                          for (var row in data) {
                            final r = row.data() as Map<String, dynamic>;
                            ls.add(r['emailuser']);
                            ls1.add(r['diem']);
                          }
                        }
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ls.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            if (index < 3) {
                              int temp = index + 1;
                              return Stack(
                                children: <Widget>[
                                  RankingCard(
                                      name: ls[index],
                                      edgeInset: EdgeInsets.only(left: 50),
                                      diem: ls1[index]),
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
                              name: ls[index],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Logo(
                  text: "Xếp hạng".toUpperCase(),
                  logoPath: "assets/images/ranking_logo.png",
                ),
              ],
            )),
      ),
    );
  }
}
