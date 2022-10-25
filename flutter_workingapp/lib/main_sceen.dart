import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_kakao_map/flutter_kakao_map.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_kakao_map/kakao_maps_flutter_platform_interface.dart';

class MainSceen extends StatefulWidget {
  const MainSceen({Key? key}) : super(key: key);

  @override
  State<MainSceen> createState() => _MainSceenState();
}

class _MainSceenState extends State<MainSceen> {
  late KakaoMapController mapController;
  MapPoint _visibleRegion = MapPoint(37.5087553, 127.0632877);
  CameraPosition _kInitialPosition =
      CameraPosition(target: MapPoint(37.5087553, 127.0632877), zoom: 5);
  void onMapCreated(KakaoMapController controller) async {
    final MapPoint visibleRegion = await controller.getMapCenterPoint();
    setState(() {
      mapController = controller;
      _visibleRegion = visibleRegion;
    });
  }

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
            width: 500,
            height: 350,
            margin: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: KakaoMap(initialCameraPosition: _kInitialPosition,onMapCreated: onMapCreated,)
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
