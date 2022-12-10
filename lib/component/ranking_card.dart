import 'package:empty_proj/component/text_stroke.dart';
import 'package:empty_proj/view/user_detail_page.dart';
import 'package:flutter/material.dart';

class RankingCard extends StatelessWidget {
  const RankingCard(
      {Key? key,
      this.name = "",
      this.edgeInset = const EdgeInsets.only(left: 5),
      this.diem = 0})
      : super(key: key);

  final String name;
  final int diem;
  final EdgeInsets edgeInset;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UserDetailPage(
                    nickname: name,
                  )),
        );
      }),
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        padding:
            const EdgeInsets.only(top: 10, bottom: 13, left: 10, right: 10),
        height: 77,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/ranking_card.png'),
              fit: BoxFit.fill),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: edgeInset,
              child: Text(
                name,
                style: const TextStyle(fontSize: 16),
              ),
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
                    content: diem.toString(),
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
