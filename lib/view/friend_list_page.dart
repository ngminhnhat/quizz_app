import 'package:empty_proj/view/partial/list_friend.dart';
import 'package:empty_proj/view/partial/list_friend_request.dart';
import 'package:empty_proj/view/partial/list_user.dart';
import 'package:flutter/material.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({Key? key}) : super(key: key);

  @override
  _FriendListPageState createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  int _selectedIndex = 0;
  List<Widget> _page = <Widget>[ListFriend(), ListFriendRequest(), ListUser()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              icon: Icon(Icons.supervisor_account_sharp),
              label: "Danh sách bạn".toUpperCase()),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add),
              label: "Lời mời kết bạn".toUpperCase()),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_search), label: "tìm bạn".toUpperCase())
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
