import 'package:empty_proj/component/custom_btn.dart';
import 'package:empty_proj/component/custom_input_form.dart';
import 'package:empty_proj/component/text_stroke.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

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
                          label: "Biệt danh",
                        ),
                        CustomInputForm(
                          label: "Email",
                          typeKeyboard: TextInputType.emailAddress,
                        ),
                        CustomInputForm(
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
                          label: "Xác nhận mật khẩu",
                          textSecure: true,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Con cặt';
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
                                onTap: () {
                                  print("Xu li dang ky");
                                },
                              )
                            ],
                          ),
                        ),
                        CustomBtn(
                          buttonImagePath: "assets/images/btn_blue.png",
                          text: "Đăng ký ngay".toUpperCase(),
                          ontap: () {
                            print('xử lí đang kí');
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
