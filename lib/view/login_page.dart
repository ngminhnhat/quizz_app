import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/custom_input_form.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  AssetImage("assets/images/Static_Cinematic_bg_transend.png"),
              fit: BoxFit.cover),
        ),
        child: Center(
            child: ListView(
          children: [
            Column(children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(50),
                    child: Image.asset("assets/images/logo_bg.png"),
                  ),
                  TextStroke(
                    content: "Đăng nhập".toUpperCase(),
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
                      label: "Email",
                      typeKeyboard: TextInputType.emailAddress,
                    ),
                    CustomInputForm(
                      label: "Password",
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
                      text: "Đăng Nhập".toUpperCase(),
                      ontap: () {
                        print('xử lí đăng nhập');
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Bạn chưa có tài khoản? "),
                    InkWell(
                      child: const Text(
                        "Đăng ký ngay!",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        print("Xu li dang ky");
                      },
                    )
                  ],
                ),
              )
            ]),
          ],
        )),
      ),
    );
  }
}
