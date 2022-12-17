import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flame/components.dart';
import 'package:intl/intl.dart';

class Player {
  const Player(
    this.email,
    this.password,
    this.nickname,
    this.coin,
    this.diamond,
    this.createdate,
    this.energy,
  );

  final String email;
  final String password;
  final String nickname;
  final int coin;
  final int diamond;
  final int energy;
  final String createdate;

  static Future<Player> getUserByEmail(String email) async {
    Player _user = Player("email", 'password', 'nickname', 0, 0,
        DateFormat.yMMMMd().format(DateTime.now()).toString(), 0);
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: email)
        .limit(1)
        .get();
    if (query.docs.isNotEmpty) {
      _user = Player(
          query.docs[0]['Email'],
          query.docs[0]['PassWord'],
          query.docs[0]['Nickname'],
          query.docs[0]['Coin'],
          query.docs[0]['Diamond'],
          DateFormat.yMMMMd()
              .format(query.docs[0]['CreateDate'].toDate())
              .toString(),
          query.docs[0]['Energy']);
    }
    return _user;
  }

  static Future<List<Player>> fetchAll() async {
    List<Player> _user = [];
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection("users").get();
    if (query.docs.isNotEmpty) {
      for (var element in query.docs) {
        _user.add(Player(
            element['Email'],
            element['PassWord'],
            element['Nickname'],
            element['Coin'],
            element['Diamond'],
            DateFormat.yMMMMd()
                .format(element['CreateDate'].toDate())
                .toString(),
            element['Energy']));
      }
    }
    return _user;
  }
}
