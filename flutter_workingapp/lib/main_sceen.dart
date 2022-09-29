import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

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
        children: <Widget>[
          Container(
            width:500,
            height:350,
            color:Colors.amber.shade100,
            margin:const EdgeInsets.only(left:10,top:10,right:10),
            child: const Text("지도가 나올 자리"),
          )
        ],
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
