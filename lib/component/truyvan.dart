import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class cauhoi1 {
  getdata(String cauhoi) {
    return FirebaseFirestore.instance
        .collection('Cauhois')
        .where('linhvucid', isEqualTo: cauhoi)
        .get();
  }
}
