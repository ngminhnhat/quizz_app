import 'package:empty_proj/component/logo.dart';
import 'package:empty_proj/component/ranking_card.dart';
import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({Key? key}) : super(key: key);

  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/ranking_bg.png'),
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
                        if (index < 3) {
                          int temp = index + 1;
                          return Stack(
                            children: <Widget>[
                              RankingCard(
                                name: "tên1",
                              ),
                              Transform.translate(
                                offset: const Offset(0, -15),
                                child: SizedBox(
                                  height: 80,
                                  child: Image.asset(
                                      "assets/images/icons/icon_top_$temp.png"),
                                ),
                              )
                            ],
                          );
                        }
                        return RankingCard(
                          name: "tên",
                        );
                      },
                    ),
                  ),
                ),
                Logo(
                  text: "Xếp hạng".toUpperCase(),
                  logoPath: "assets/images/ranking_logo.png",
                ),
              ],
            )),
      ),
    );
  }
}
