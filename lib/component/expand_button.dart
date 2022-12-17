import 'package:empty_proj/view/friend_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpandButton extends StatefulWidget {
  const ExpandButton({Key? key, this.onTapExpand, this.flip = 1})
      : super(key: key);

  final VoidCallback? onTapExpand;
  final double flip;

  @override
  _ExpandButtonState createState() => _ExpandButtonState();
}

class _ExpandButtonState extends State<ExpandButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 30),
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(50), bottomRight: Radius.circular(50))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => FriendListPage())));
              }),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person, size: 40),
                    Text(
                      'Bạn bè'.toUpperCase(),
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              )),
          InkWell(
              onTap: (() {
                print('object');
              }),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_month, size: 40),
                    Text(
                      'Điểm danh'.toUpperCase(),
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              )),
          InkWell(
              onTap: (() {
                print('object');
              }),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.request_page, size: 40),
                    Text(
                      'Nhiệm vụ'.toUpperCase(),
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              )),
          Container(
            width: 70,
            height: 70,
            margin: EdgeInsets.only(left: 15),
            padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
            child: InkWell(
              onTap: widget.onTapExpand,
              child: Transform.scale(
                scaleX: widget.flip,
                child: Image.asset("assets/images/icons/arrow.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
