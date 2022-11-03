// 화면 이동하는 메인 페이지. bottomNavigationBar를 그려주고 각 StateWidget을 불러와 그려줌

import 'package:flutter/material.dart';
import 'package:flutter_workingapp/pages/badge_page.dart';
import 'package:flutter_workingapp/pages/status_page.dart';
import 'package:flutter_workingapp/pages/walk_page.dart';
import 'package:flutter_workingapp/widget/navigation_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static List<Widget> pages = <Widget>[
    const BadgeSceen(),
    const WalkSceen(),
    const StatusSceen()
  ];
  int _selectedIndex = 1;

  void _onBotItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.approval_rounded), label: "달성 뱃지"),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_walk_rounded), label: "산책하기"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "통계보기")
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal.shade300,
        onTap: _onBotItemTapped,
      ),
      drawer: const NavigationDrawer(),
    );
  }
}
