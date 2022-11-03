// 산책 화면

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: (MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    MediaQuery.of(context).padding.top) *
                0.6,
            margin: const EdgeInsets.all(10),
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.2,
                margin: const EdgeInsets.only(left: 3.0, top: 10.0, right: 3.0),
                child: ElevatedButton(
                    // 이미지 있는 버튼으로 변경
                    onPressed: () => print("걸음수 지정 산책 모드 클릭"),
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        primary: Colors.blue.shade100),
                    child: const Text("걸음수 지정 산책 모드",
                        style: TextStyle(color: Colors.black87))),
              ),
              Container(
                width: 80,
                height: (MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.2,
                margin: const EdgeInsets.only(left: 3.0, top: 10.0, right: 3.0),
                child: ElevatedButton(
                    // 이미지 있는 버튼으로 변경
                    onPressed: () => print("가벼운 산책 모드 클릭"),
                    style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        primary: Colors.blue.shade100),
                    child: const Text("가벼운 산책 모드",
                        style: TextStyle(color: Colors.black87))),
              )
            ],
          )
        ],
      ),
    );
  }
}
