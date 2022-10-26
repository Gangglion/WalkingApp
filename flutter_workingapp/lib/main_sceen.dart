import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
class MainSceen extends StatefulWidget {
  const MainSceen({Key? key}) : super(key: key);

  @override
  State<MainSceen> createState() => _MainSceenState();
}

class _MainSceenState extends State<MainSceen> {
  int _selectedIndex = 0;
  void _onBotItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.approval_rounded), label: "달성 뱃지"),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_walk_rounded), label: "산책하기"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "통계보기")
        ],
        currentIndex: 1,
        selectedItemColor: Colors.teal.shade300,
        onTap: _onBotItemTapped,
      ),
    );
  }
}
