import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/logo.dart';
import 'package:empty_proj/main.dart';
import 'package:empty_proj/models/challenge.dart';
import 'package:empty_proj/models/challengeRequest.dart';
import 'package:empty_proj/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  List<ChallengeRequest> _challengeRequest = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: <Widget>[
        Column(
          children: [
            SizedBox(
              width: 100,
              height: 100,
            )
          ],
        ),
        Logo(
          logoSize: 55,
          text: "Thách đấu".toUpperCase(),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          padding: EdgeInsets.all(10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text('Yêu cầu thách đấu:'),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(border: Border.all()),
                      child: SingleChildScrollView(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('challengerequest')
                              .where('touseremail',
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.email)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              _challengeRequest = [];
                              final data = snapshot.data!.docs;
                              //
                              for (var row in data) {
                                final r = row.data() as Map<String, dynamic>;
                                ChallengeRequest temp = ChallengeRequest(
                                    challengeid: r['challengeid'],
                                    touseremail: r['touseremail']);
                                _challengeRequest.add(temp);
                              }
                            }
                            return ListView.builder(
                              itemCount: _challengeRequest.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: ((context, index) {
                                return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('challenge')
                                      .where('id',
                                          isEqualTo: _challengeRequest[index]
                                              .challengeid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    Challenge tempChallenge = Challenge(
                                        id: -1,
                                        linhvucid: -1,
                                        listquestion: '-1',
                                        makebyemail: 'makebyemail',
                                        numberofquestion: -1,
                                        playtime: -1);
                                    if (snapshot.hasData) {
                                      _challengeRequest = [];
                                      final data = snapshot.data!.docs;
                                      //
                                      for (var row in data) {
                                        final r =
                                            row.data() as Map<String, dynamic>;
                                        tempChallenge = Challenge(
                                            id: r['id'],
                                            linhvucid: r['linhvucid'],
                                            listquestion: r['listquestion'],
                                            makebyemail: r['makebyemail'],
                                            numberofquestion:
                                                r['numberofquestion'],
                                            playtime: r['playtime']);
                                      }
                                    }
                                    return StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('users')
                                          .where('Email',
                                              isEqualTo:
                                                  tempChallenge.makebyemail)
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        Challenge temp = Challenge(
                                            id: -1,
                                            linhvucid: -1,
                                            listquestion: '-1',
                                            makebyemail: 'makebyemail',
                                            numberofquestion: -1,
                                            playtime: -1);
                                        if (snapshot.hasData) {
                                          _challengeRequest = [];
                                          final data = snapshot.data!.docs;
                                          //
                                          for (var row in data) {
                                            final r = row.data()
                                                as Map<String, dynamic>;
                                            Player tempPlayer = Player(
                                                r['Email'],
                                                r['PassWord'],
                                                r['Nickname'],
                                                r['Coin'],
                                                r['Diamond'],
                                                DateFormat('dd-MM-yyyy')
                                                    .format(r['CreateDate']
                                                        .toDate())
                                                    .toString(),
                                                r['Energy']);
                                          }
                                        }
                                        return Text('data');
                                      },
                                    );
                                  },
                                );
                              }),
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
                ),
                Container(
                  margin: EdgeInsets.all(5),
                  alignment: AlignmentDirectional.center,
                  child: CustomBtn(
                      buttonImagePath: "assets/images/btn_purple.png",
                      text: "Tạo phòng thách đấu".toUpperCase(),
                      paddings: EdgeInsets.only(
                          top: 15, bottom: 15, left: 20, right: 20)),
                ),
              ]),
        )
      ]),
    );
  }
}
