import 'package:empty_proj/component/histoty_card.dart';
import 'package:empty_proj/component/logo.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/history_bg.png'),
                  fit: BoxFit.fitHeight),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 185),
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 30,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        int temp = index + 1;
                        return HistotyCard(
                          name: "Trận đấu số $temp",
                        );
                      },
                    ),
                  ),
                ),
                Logo(
                  text: "Lịch sử trò chơi".toUpperCase(),
                  logoPath: "assets/images/history_logo.png",
                  fontsize: 40,
                ),
              ],
            )),
      ),
    );
  }
}
