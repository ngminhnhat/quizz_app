import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/custom_input_form.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Resetpassword extends StatelessWidget {
  Resetpassword({Key? key}) : super(key: key);
  TextEditingController txtpass3 = TextEditingController();
  TextEditingController txtpass = TextEditingController();
  TextEditingController txtpass2 = TextEditingController();
  final _user = FirebaseAuth.instance.currentUser;
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                              currentUser
                                  ?.updatePassword(txtpass2.text)
                                  .then((e) {
                                Navigator.pop(context);
                              }).catchError((err) {});
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
