import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/custom_dialog.dart';
import 'package:empty_proj/models/game_history.dart';
import 'package:empty_proj/models/user.dart';
import 'package:empty_proj/view/user_detail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserCard extends StatelessWidget {
  const UserCard({Key? key, required this.user, this.state = 0})
      : super(key: key);

  final Player user;
  final int state;

  void deleteFriendRequest() async {
    try {
      final friendRequest = await FirebaseFirestore.instance
          .collection('friendrequest')
          .where('emailuser', isEqualTo: user.email)
          .limit(1)
          .get()
          .then((QuerySnapshot snapshot) {
        //Here we get the document reference and return to the post variable.
        return snapshot.docs[0].reference;
      });

      var batch = FirebaseFirestore.instance.batch();
      //Updates the field value, using post as document reference
      batch.delete(friendRequest);
      batch.commit();
    } catch (e) {
      print(e);
    }
  }

  void acceptRequest(BuildContext context) {
    existed(context);
    deleteFriendRequest();
  }

  void deleteFriend() async {
    try {
      final friend = await FirebaseFirestore.instance
          .collection('friend')
          .where('emailfriend', isEqualTo: user.email)
          .limit(1)
          .get()
          .then((QuerySnapshot snapshot) {
        //Here we get the document reference and return to the post variable.
        return snapshot.docs[0].reference;
      });

      var batch = FirebaseFirestore.instance.batch();
      //Updates the field value, using post as document reference
      batch.delete(friend);
      batch.commit();
    } catch (e) {
      print(e);
    }
  }

  void existed(BuildContext context) async {
    print(user.email);
    bool exist = false;
    bool otherExit = false;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('friend')
        .where('emailuser', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      for (var element in querySnapshot.docs) {
        if (element['emailfriend'] == user.email) {
          exist = true;
          break;
        }
      }
    }
    if (exist) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ng?????i ch??i n??y ???? th??m v??o d.s??ch b???n b??!')));
      print("friendrequest friend not added");
    } else {
      FirebaseFirestore.instance.collection('friend').add({
        "emailuser": FirebaseAuth.instance.currentUser!.email,
        "emailfriend": user.email,
      });
      QuerySnapshot _queryRequest = await FirebaseFirestore.instance
          .collection('friend')
          .where('emailuser', isEqualTo: user.email)
          .get();
      if (_queryRequest.docs.isNotEmpty) {
        for (var element in _queryRequest.docs) {
          if (element['emailfriend'] ==
              FirebaseAuth.instance.currentUser!.email) {
            otherExit = true;
            break;
          }
        }
      }
      if (!otherExit) {
        FirebaseFirestore.instance.collection('friendrequest').add({
          "emailuser": FirebaseAuth.instance.currentUser!.email,
          "emailrequest": user.email,
        });
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Th??m b???n th??nh c??ng!')));
      print("friendrequest friend added");
    }
  }

  Widget switchWidget(BuildContext context) {
    switch (state) {
      case 1:
        return Container(
          alignment: AlignmentDirectional.bottomEnd,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 45,
                height: 45,
                margin: EdgeInsets.only(left: 2.5, right: 2.5),
                decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                    onPressed: (() {
                      acceptRequest(context);
                    }),
                    icon: Icon(Icons.check)),
              ),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                    onPressed: (() {
                      showDialog(
                          context: context,
                          builder: ((context) => CustomDialog(
                                title: "C???nh b??o".toUpperCase(),
                                content:
                                    "B???n ch???c ch???c mu???n t??? ch???i l???i m???i k???t b???n n??y?",
                                onTapConfirm: () {
                                  deleteFriendRequest();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Y??u c???u ???? ???????c xo??!')));
                                },
                                onTapCancel: () {
                                  Navigator.pop(context);
                                },
                              )));
                    }),
                    icon: Icon(Icons.close)),
              ),
            ],
          ),
        );
      case 2:
        return Container(
          alignment: AlignmentDirectional.bottomEnd,
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
                onPressed: (() {
                  existed(context);
                }),
                icon: Icon(Icons.add)),
          ),
        );
      default:
        return Container(
          alignment: AlignmentDirectional.bottomEnd,
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10)),
            child: IconButton(
                onPressed: (() {
                  showDialog(
                      context: context,
                      builder: ((context) => CustomDialog(
                            title: "C???nh b??o".toUpperCase(),
                            content:
                                "B???n ch???c ch???c mu???n xo?? ng?????i ch??i n??y kh???i danh s??ch b???n b???",
                            onTapConfirm: () {
                              deleteFriend();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Xo?? b???n th??nh c??ng!')));
                            },
                            onTapCancel: () {
                              Navigator.pop(context);
                            },
                          )));
                }),
                icon: Icon(Icons.close)),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() async {
        int _gameplayed = 0;
        GameHistory gameHistory = GameHistory(
            diem: 0,
            emailuser: 'emailuser',
            ngaychoi: "0",
            socauhoi: 0,
            socautraloidung: 0,
            thoigianconlai: 0,
            thoigiantraloi: 0);
        QuerySnapshot query = await FirebaseFirestore.instance
            .collection('history')
            .where('emailuser', isEqualTo: user.email)
            .orderBy('diem', descending: true)
            .get();
        if (query.docs.isNotEmpty) {
          _gameplayed = query.docs.length;
          gameHistory = GameHistory(
              diem: query.docs[0]['diem'],
              emailuser: query.docs[0]['emailuser'],
              ngaychoi: DateFormat('dd-MM-yyyy')
                  .format(query.docs[0]['ngaychoi'].toDate())
                  .toString(),
              socauhoi: query.docs[0]['socauhoi'],
              socautraloidung: query.docs[0]['socautraloidung'],
              thoigianconlai: query.docs[0]['thoigianconlai'],
              thoigiantraloi: query.docs[0]['thoigiantraloi']);
        }
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => UserDetailPage(
                      user: user,
                      gameHistory: gameHistory,
                      gameplayed: _gameplayed,
                    ))));
      }),
      child: Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 15),
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
          height: 77,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/friend_card.png'),
                fit: BoxFit.fill),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(user.nickname),
              switchWidget(context),
            ],
          )),
    );
  }
}
