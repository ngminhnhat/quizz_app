import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flame/components.dart';
import 'package:intl/intl.dart';

class GameHistory {
  const GameHistory({
    required this.diem,
    required this.emailuser,
    required this.ngaychoi,
    required this.socauhoi,
    required this.socautraloidung,
    required this.thoigianconlai,
    required this.thoigiantraloi,
  });

  final int diem;
  final String emailuser;
  final String ngaychoi;
  final int socauhoi;
  final int socautraloidung;
  final int thoigiantraloi;
  final int thoigianconlai;

  static Future<List<GameHistory>> fetchAll() async {
    List<GameHistory> _gameHistory = [];
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection("history").get();
    if (query.docs.isNotEmpty) {
      for (var element in query.docs) {
        _gameHistory.add(
          GameHistory(
              diem: element['diem'],
              emailuser: element['emailuser'],
              ngaychoi: DateFormat('dd-MM-yyyy')
                  .format(element['ngaychoi'].toDate())
                  .toString(),
              socauhoi: element['socauhoi'],
              socautraloidung: element['socautraloidung'],
              thoigiantraloi: element['thoigiantraloi'],
              thoigianconlai: element['thoigianconlai']),
        );
      }
    }
    return _gameHistory;
  }

  static Future<List<GameHistory>> getByEmail(String email) async {
    List<GameHistory> _gameHistory = [];
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("history")
        .where('emailuser', isEqualTo: email)
        .get();
    if (query.docs.isNotEmpty) {
      for (var element in query.docs) {
        _gameHistory.add(
          GameHistory(
              diem: element['diem'],
              emailuser: element['emailuser'],
              ngaychoi: DateFormat('dd-MM-yyyy')
                  .format(element['ngaychoi'].toDate())
                  .toString(),
              socauhoi: element['socauhoi'],
              socautraloidung: element['socautraloidung'],
              thoigiantraloi: element['thoigiantraloi'],
              thoigianconlai: element['thoigianconlai']),
        );
      }
    }
    return _gameHistory;
  }
}
