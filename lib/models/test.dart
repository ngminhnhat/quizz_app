import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class _Query {
  getdata(String cauhoi) {
    return FirebaseFirestore.instance
        .collection('Cauhois')
        .where('linhvucid', isEqualTo: cauhoi)
        .get();
  }
}
