import 'package:flutter/material.dart';
import 'package:flutter_workingapp/pages/badge_page.dart';
import 'package:flutter_workingapp/pages/status_page.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class WalkSceen extends StatefulWidget {
  const WalkSceen({Key? key}) : super(key: key);

  @override
  State<WalkSceen> createState() => _WalkSceenState();
}

class _WalkSceenState extends State<WalkSceen> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  static List<Widget> pages = <Widget>[
    WalkSceen(),
    BadgeSceen(),
    StatusSceen()
  ];
  int _selectedIndex = 1;

  void _onBotItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Column(
      //   children: <Widget>[
      //     Container(
      //       width: double.infinity,
      //       height: (MediaQuery.of(context).size.height -
      //               AppBar().preferredSize.height -
      //               MediaQuery.of(context).padding.top) *
      //           0.4,
      //       margin: const EdgeInsets.all(10),
      //       child: GoogleMap(
      //         onMapCreated: _onMapCreated,
      //         initialCameraPosition: CameraPosition(
      //           target: _center,
      //           zoom: 11.0,
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      body:pages[_selectedIndex],
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
    );
  }
}
