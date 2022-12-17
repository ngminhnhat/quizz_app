import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/user_card.dart';
import 'package:empty_proj/models/request_data.dart';
import 'package:empty_proj/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListFriendRequest extends StatefulWidget {
  const ListFriendRequest({Key? key}) : super(key: key);

  @override
  _ListFriendRequestState createState() => _ListFriendRequestState();
}

class _ListFriendRequestState extends State<ListFriendRequest> {
  List<Player> _list = [];
  List<RequestData> _data = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Column(children: [
            SizedBox(
              width: 100,
              height: 100,
            )
          ]),
          Container(
            margin: EdgeInsets.only(top: 125, left: 1, right: 1),
            child: SingleChildScrollView(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('friendrequest')
                  .where('emailrequest',
                      isEqualTo: FirebaseAuth.instance.currentUser!.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _data = [];
                  final data = snapshot.data!.docs;
                  //
                  for (var row in data) {
                    final r = row.data() as Map<String, dynamic>;
                    _data.add(RequestData(
                        emailuser: r['emailuser'],
                        emailrequest: r['emailrequest']));
                  }
                }
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        _list = [];
                        final data = snapshot.data!.docs;
                        for (var request in _data) {
                          for (var element in data) {
                            final r = element.data() as Map<String, dynamic>;
                            Player _temp = Player(
                                r['Email'],
                                r['PassWord'],
                                r['Nickname'],
                                r['Coin'],
                                r['Diamond'],
                                DateFormat('dd-MM-yyyy')
                                    .format(r['CreateDate'].toDate())
                                    .toString(),
                                r['Energy']);
                            if (request.emailuser == _temp.email) {
                              _list.add(_temp);
                              break;
                            }
                          }
                        }
                      }
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _list.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          int temp = index + 1;
                          return UserCard(
                            user: _list[index],
                            state: 1,
                          );
                        },
                      );
                    }));
              },
            )),
          ),
        ],
      ),
    );
  }
}
