import 'package:empty_proj/component/custom_confirm_buy_dialog.dart';
import 'package:empty_proj/view/home_page.dart';
import 'package:empty_proj/view/shop_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const QuizzApp());
}

class QuizzApp extends StatelessWidget {
  const QuizzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Đố Vui',
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.amber.shade900,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage());
  }
}
