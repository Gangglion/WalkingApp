// 산책 화면

import 'package:flutter/material.dart';
import 'package:flutter_workingapp/widget/just_walkmode_widget.dart';
import 'package:flutter_workingapp/widget/set_walkmode_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum WalkMode { NONE, SETWALK, JUSTWALK }

class WalkSceen extends StatefulWidget {
  const WalkSceen({Key? key}) : super(key: key);

  @override
  State<WalkSceen> createState() => _WalkSceenState();
}

class _WalkSceenState extends State<WalkSceen> {
  List<Marker> _markers = [];
  // 37.46342905,126.80314663
  late LatLng _center;
  @override
  Future<void> initState() async {
    super.initState();
    try {
      // 여기서 에러를 뿜는데...!! 권한체크를 안해주었음. 퍼미션 체크하는 코드 앱 시작 전 main에서 해보자
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _center = LatLng(position.latitude, position.longitude);
      _markers.add(Marker(
          markerId: MarkerId("now"),
          draggable: false,
          position: LatLng(position.latitude, position.longitude)));
    } catch (e) {
      print(e.toString());
    }
  }

  late GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  WalkMode _state = WalkMode.NONE;

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
              markers: Set.from(_markers),
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              ),
            ),
          ),
          if (_state == WalkMode.NONE) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 130,
                  height: (MediaQuery.of(context).size.height -
                          AppBar().preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.2,
                  child: ElevatedButton(
                      // 이미지 있는 버튼으로 변경
                      onPressed: () {
                        print("걸음수 지정 산책 모드 클릭");
                        setState(() {
                          _state = WalkMode.SETWALK;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          primary: Colors.blue.shade100),
                      child: const Text("걸음수 지정 산책 모드",
                          style: TextStyle(color: Colors.black87))),
                ),
                Container(
                  width: 130,
                  height: (MediaQuery.of(context).size.height -
                          AppBar().preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.2,
                  child: ElevatedButton(
                      // 이미지 있는 버튼으로 변경
                      onPressed: () {
                        setState(() {
                          _state = WalkMode.JUSTWALK;
                        });
                      },
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
          ] else if (_state == WalkMode.SETWALK) ...[
            const setWalkMode()
          ] else if (_state == WalkMode.JUSTWALK) ...[
            const justWalkMode()
          ]
        ],
      ),
    );
  }
}
