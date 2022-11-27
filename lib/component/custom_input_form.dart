import 'package:flutter/material.dart';

typedef String? StringCallBack(String? arg);

class CustomInputForm extends StatelessWidget {
  const CustomInputForm(
      {Key? key,
      this.label = '',
      this.hint = '',
      this.textSecure = false,
      this.typeKeyboard = TextInputType.text,
      this.validate})
      : super(key: key);

  final String label;
  final String hint;
  final bool textSecure;
  final TextInputType typeKeyboard;
  final StringCallBack? validate;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Container(
            padding:
                EdgeInsets.only(left: 100, right: 100, top: 20, bottom: 30),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/txt_inp.png"),
                    fit: BoxFit.fill)),
            child: SizedBox(
              child: TextFormField(
                validator: validate,
                obscureText: textSecure,
                keyboardType: typeKeyboard,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: hint,
                  labelText: label,
                ),
              ),
            )),
      ]),
    );
  }
}
