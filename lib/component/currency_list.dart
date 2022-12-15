import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/avatar_component.dart';
import 'package:empty_proj/component/currency_component.dart';
import 'package:empty_proj/models/user.dart' as user;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class CurrencyList extends StatefulWidget {
  const CurrencyList({Key? key}) : super(key: key);

  @override
  _CurrencyListState createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  int coin = 0;
  int diamond = 0;
  void getCurrency() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    if (query.docs.isNotEmpty) {
      coin = query.docs[0]['Coin'];
      diamond = query.docs[0]['Diamond'];
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      getCurrency();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AvatarComponent(),
          CurrencyComponent(
            iconPath: "assets/images/icons/coin.png",
            soluong: coin,
          ),
          CurrencyComponent(
            iconPath: "assets/images/icons/gems.png",
            soluong: diamond,
          ),
        ],
      ),
    );
  }
}
