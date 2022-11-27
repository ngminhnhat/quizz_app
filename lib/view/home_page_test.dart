import 'package:empty_proj/cookbook/expandable_FAB/action_button.dart';
import 'package:empty_proj/cookbook/expandable_FAB/expandable_fab.dart';
import 'package:flutter/material.dart';

class HomePage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState2();
  }
}

class HomePageState2 extends State<HomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 46, 66, 90),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(80, 40),
                bottomRight: Radius.elliptical(80, 40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(4, 8),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  color: Colors.amber,
                  margin: EdgeInsets.only(left: 50),
                  child: IconButton(
                    onPressed: (() {}),
                    icon: Icon(
                      Icons.access_alarm,
                      size: 50,
                    ),
                    iconSize: 50,
                  ),
                ),
                Container(
                  color: Colors.amber,
                  child: Text(
                    'data',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                Container(
                  color: Colors.amber,
                  margin: EdgeInsets.only(right: 50),
                  child: IconButton(
                    onPressed: (() {}),
                    icon: Icon(
                      Icons.abc,
                      size: 50,
                    ),
                    iconSize: 50,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'adsa',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: ExpandableFab(
        icon: Icon(Icons.compass_calibration),
        distance: 120.0,
        backgroundColor: Theme.of(context).primaryColor,
        alignment: Alignment.bottomCenter,
        children: [
          ActionButton(
            onPressed: () {},
            icon: const Icon(Icons.format_size),
            desscription: 'Chơi mới',
          ),
          ActionButton(
            onPressed: () {},
            icon: const Icon(Icons.insert_photo),
            desscription: 'Chơi mới',
          ),
          ActionButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam),
            desscription: 'Chơi mới',
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.large(
      //   onPressed: () {
      //     // Add your onPressed code here!
      //   },
      //   backgroundColor: Colors.green,
      //   child: Container(
      //     color: Colors.amber,
      //     width: 20,
      //     height: 20,
      //   ),
      // ),
    );
  }
}
