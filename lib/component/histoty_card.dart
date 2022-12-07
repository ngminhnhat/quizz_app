import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/view/history_detail_page.dart';
import 'package:flutter/material.dart';

class HistotyCard extends StatelessWidget {
  const HistotyCard({Key? key, this.name = ""}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HistoryDetailPage()),
        );
      }),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        padding:
            const EdgeInsets.only(top: 10, bottom: 13, left: 10, right: 10),
        height: 77,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/history_card_bg.png'),
              fit: BoxFit.fill),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    name,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      "Điểm số: ",
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  TextStroke(
                    content: "1245",
                    fontsize: 35,
                    fontfamily: "SVN-DeterminationSans",
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
