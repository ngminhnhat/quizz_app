import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/custom_input_form.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/main.dart';
import 'package:empty_proj/models/user.dart';
import 'package:empty_proj/view/auth_user_page.dart';
import 'package:empty_proj/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Resetpassword extends StatelessWidget {
  Resetpassword({Key? key}) : super(key: key);
  TextEditingController txtpass3 = TextEditingController();
  TextEditingController txtpass = TextEditingController();
  TextEditingController txtpass2 = TextEditingController();
  final _user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  late Player _player;

  void getUser() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      _player = Player(
          querySnapshot.docs[0]['Email'],
          querySnapshot.docs[0]['PassWord'],
          querySnapshot.docs[0]['Nickname'],
          querySnapshot.docs[0]['Coin'],
          querySnapshot.docs[0]['Diamond'],
          DateFormat('dd-MM-yyyy')
              .format(querySnapshot.docs[0]['CreateDate'].toDate())
              .toString(),
          querySnapshot.docs[0]['Energy']);
    }
  }

  void updateUser() async {
    try {
      final user = await FirebaseFirestore.instance
          .collection('users')
          .where('Email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .limit(1)
          .get()
          .then((QuerySnapshot snapshot) {
        //Here we get the document reference and return to the post variable.
        return snapshot.docs[0].reference;
      });

      var batch = FirebaseFirestore.instance.batch();
      //Updates the field value, using post as document reference
      batch.update(user, {'PassWord': txtpass2.text});
      batch.commit();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/images/Static_Cinematic_bg_transend.png"),
                fit: BoxFit.fitHeight),
          ),
          child: Center(
            child: ListView(
              children: [
                Column(children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 50, right: 50, top: 50, bottom: 10),
                        child: Image.asset("assets/images/logo_bg.png"),
                      ),
                      TextStroke(
                        content: "Đổi password".toUpperCase(),
                        strokeColor: Colors.black,
                        fontsize: 40,
                        fontfamily: "SVN-DeterminationSans",
                      )
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomInputForm(
                          controllers: txtpass2,
                          label: "Nhập mật khẩu mới",
                          typeKeyboard: TextInputType.emailAddress,
                        ),
                        CustomInputForm(
                          controllers: txtpass3,
                          label: "Nhập lại mật khẩu",
                          textSecure: true,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Con cặt';
                            }
                            return null;
                          },
                        ),
                        CustomBtn(
                          buttonImagePath: "assets/images/btn_blue.png",
                          text: "Đổi mật khẩu".toUpperCase(),
                          ontap: () async {
                            if (txtpass2.text.isEmpty ||
                                txtpass3.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Vui lòng nhập cho đầy đủ"),
                                ),
                              );
                            } else if (txtpass2.text.length <= 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Vui lòng nhập trên 6 kí tự"),
                                ),
                              );
                            } else if (txtpass2.text != txtpass3.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Vui lòng nhập trùng password"),
                                ),
                              );
                            } else {
                              final FirebaseAuth firebaseAuth =
                                  FirebaseAuth.instance;
                              User? currentUser = firebaseAuth.currentUser;
                              var credential = EmailAuthProvider.credential(
                                  email: _player.email,
                                  password: _player.password);
                              await currentUser!
                                  .reauthenticateWithCredential(credential);
                              await currentUser
                                  .updatePassword(txtpass2.text)
                                  .then((e) {
                                Navigator.pop(context);
                              }).catchError((err) {});
                              updateUser();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => AuthUserPage())));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Đổi mật khẩu thành công"),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          )),
    );
  }
}
