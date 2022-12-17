import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/user_card.dart';
import 'package:empty_proj/models/friend_data.dart';
import 'package:empty_proj/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListFriend extends StatefulWidget {
  const ListFriend({Key? key}) : super(key: key);

  @override
  _ListFriendState createState() => _ListFriendState();
}

class _ListFriendState extends State<ListFriend> {
  List<Player> _list = [];
  List<FriendData> _data = [];
  bool executing = true;

  void getData() async {
    QuerySnapshot _getFriend = await FirebaseFirestore.instance
        .collection('friend')
        .where('emailuser', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    if (_getFriend.docs.isNotEmpty) {
      List<FriendData> _friends = [];
      for (var r in _getFriend.docs) {
        _friends.add(FriendData(
            emailuser: r['emailuser'], emailfriend: r['emailfriend']));
      }
      for (var element in _friends) {
        QuerySnapshot _getUser = await FirebaseFirestore.instance
            .collection('users')
            .where('Email', isEqualTo: element.emailfriend)
            .get();
        if (_getUser.docs.isNotEmpty) {
          for (var r in _getUser.docs) {
            _list.add(Player(
                r['Email'],
                r['PassWord'],
                r['Nickname'],
                r['Coin'],
                r['Diamond'],
                DateFormat('dd-MM-yyyy')
                    .format(r['CreateDate'].toDate())
                    .toString(),
                r['Energy']));
          }
          if (mounted) {
            setState(() {});
          }
        }
      }
    }
  }

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
                  .collection('friend')
                  .where('emailuser',
                      isEqualTo: FirebaseAuth.instance.currentUser!.email)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _data = [];
                  final data = snapshot.data!.docs;
                  //
                  for (var row in data) {
                    final r = row.data() as Map<String, dynamic>;
                    _data.add(FriendData(
                        emailuser: r['emailuser'],
                        emailfriend: r['emailfriend']));
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
                            if (request.emailfriend == _temp.email) {
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
