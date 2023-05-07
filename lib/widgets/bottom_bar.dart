import 'package:flutter/material.dart';
import 'package:goforcate_app/pages/goforcate/goforcate_page.dart';
import 'package:goforcate_app/pages/group/group_page.dart';
import 'package:goforcate_app/pages/home/home_page.dart';
import 'package:goforcate_app/pages/search/search_page.dart';
import 'package:goforcate_app/pages/user/user_page.dart';

//stful快速生成StatefulWidget
class BottomBar extends StatefulWidget {
  late int index;

  BottomBar({Key? key, required this.index}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  List pages = [
    HomePage(),
    SearchPage(),
    GoForCatePage(),
    GroupPage(),
    UserPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      widget.index = index;
      print("Tapped index is " + widget.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[widget.index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.index,
        onTap: _onItemTapped,
        elevation: 10,
        iconSize: 30,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Colors.yellow,
        unselectedItemColor: Colors.purple,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/Goforcate.png',
                width: 56,
                height: 56,
              ),
              label: 'GoForCate'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outlined), label: "Group"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: "User")
        ],
      ),
    );
  }
}
