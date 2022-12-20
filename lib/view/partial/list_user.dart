import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/custom_alert.dart';
import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/logo.dart';
import 'package:empty_proj/component/user_card.dart';
import 'package:empty_proj/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListUser extends StatefulWidget {
  const ListUser({Key? key}) : super(key: key);

  @override
  _ListUserState createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  List<Player> _list = [];
  TextEditingController _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    QuerySnapshot _query;
    if (_search.text.isNotEmpty) {
      _query = await FirebaseFirestore.instance
          .collection('users')
          .where('Email',
              isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
          .where('Nickname', isEqualTo: _search.text)
          .get();
    } else {
      _query = await FirebaseFirestore.instance
          .collection('users')
          .where('Email',
              isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get();
    }
    if (_query.docs.isNotEmpty) {
      _list = [];
      for (var r in _query.docs) {
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
        print(r['Email']);
        print(r['Nickname']);
      }
      if (mounted) {
        setState(() {});
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
          Logo(
            text: "Tìm bạn".toUpperCase(),
            fontsize: 45,
          ),
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 180),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: _search,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nickname',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: CustomBtn(
                    buttonImagePath: "assets/images/btn_blue.png",
                    text: "Tìm kiếm".toUpperCase(),
                    paddings: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    ontap: () {
                      print(_search.text);
                      getData();
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 250, left: 1, right: 1),
            child: SingleChildScrollView(
                child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _list.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                int temp = index + 1;
                return UserCard(
                  user: _list[index],
                  state: 2,
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}
