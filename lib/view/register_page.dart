import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/custom_input_form.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/view/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  TextEditingController nickname = TextEditingController();
  TextEditingController txtemail = TextEditingController();
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
                        content: "Đăng Ký".toUpperCase(),
                        strokeColor: Colors.black,
                        fontsize: 50,
                        fontfamily: "SVN-DeterminationSans",
                      )
                    ],
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomInputForm(
                          controllers: nickname,
                          label: "Biệt danh",
                        ),
                        CustomInputForm(
                          controllers: txtemail,
                          label: "Email",
                          typeKeyboard: TextInputType.emailAddress,
                        ),
                        CustomInputForm(
                          controllers: txtpass,
                          label: "Mật khẩu",
                          textSecure: true,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Con cặt';
                            }
                            return null;
                          },
                        ),
                        CustomInputForm(
                          controllers: txtpass2,
                          label: "Xác nhận mật khẩu",
                          textSecure: true,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Tôi đồng ý với "),
                              InkWell(
                                child: const Text(
                                  "điều khoản dịch vụ và chính sách bảo mật.",
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      decoration: TextDecoration.underline),
                                ),
                                onTap: () {},
                              )
                            ],
                          ),
                        ),
                        CustomBtn(
                          buttonImagePath: "assets/images/btn_blue.png",
                          text: "Đăng ký ngay".toUpperCase(),
                          ontap: () async {
                            if (txtemail.text.isEmpty ||
                                txtpass.text.isEmpty ||
                                nickname.text.isEmpty ||
                                txtpass2.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Vui lòng nhập cho đầy đủ"),
                                ),
                              );
                            }
                            if (txtpass.text.length <= 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Vui lòng nhập PassWord trên 6 kí tự"),
                                ),
                              );
                            } else if (txtpass.text != txtpass2.text) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text("Vui lòng nhập trùng PassWord"),
                                ),
                              );
                            } else {
                              try {
                                UserCredential NewUser = await FirebaseAuth
                                    .instance
                                    .createUserWithEmailAndPassword(
                                        email: txtemail.text,
                                        password: txtpass.text);
                                User? user = NewUser.user;
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user?.uid)
                                    .set({
                                  "Coin": 0,
                                  "Diamond": 0,
                                  "Email": txtemail.text,
                                  "Energy": 100,
                                  "Nickname": nickname.text,
                                  "PassWord": txtpass.text,
                                  "CreateDate": DateTime.now(),
                                });
                                if (NewUser != null) {
                                  Navigator.pop(context, "Thành công");
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Tài khoản này không hợp lệ"),
                                    ),
                                  );
                                }
                              } catch (e) {
                                final snackBar = SnackBar(
                                    content: Text('Email đã tồn tại!'));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
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
