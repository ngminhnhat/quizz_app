import 'package:audioplayers/audioplayers.dart';
import 'package:empty_proj/main.dart';
import 'package:empty_proj/view/challenge/index.dart';
import 'package:flutter/material.dart';
import 'package:quiver/strings.dart';

class ChallengeLobby extends StatefulWidget {
  const ChallengeLobby({Key? key}) : super(key: key);

  @override
  _ChallengeLobbyState createState() => _ChallengeLobbyState();
}

class _ChallengeLobbyState extends State<ChallengeLobby> {
  int _selectedIndex = 0;
  List<Widget> _page = <Widget>[Index(), Text('2')];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Center(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/Static_Cinematic_bg_transend.png'),
                    fit: BoxFit.fitHeight),
              ),
              child: _page.elementAt(_selectedIndex),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.black.withOpacity(0.5),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.vpn_lock), label: "Thách đấu".toUpperCase()),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: "Lịch sử".toUpperCase()),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
        onWillPop: (() async {
          player.stop();
          player.play(AssetSource("audios/common_audio.mp3"));
          player.setReleaseMode(ReleaseMode.loop);
          return true;
        }));
  }
}
