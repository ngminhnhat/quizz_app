import 'package:empty_proj/view/auth_user_page.dart';
import 'package:empty_proj/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AvatarComponent extends StatelessWidget {
  const AvatarComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 30),
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.black.withAlpha(128)),
      child: IconButton(
        onPressed: () {
          if (FirebaseAuth.instance.currentUser == null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AuthUserPage()),
            );
          }
        },
        icon: Icon(Icons.person),
        iconSize: 40,
      ),
    );
  }
}
