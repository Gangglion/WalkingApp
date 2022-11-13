// 산책 화면

import 'package:flutter/material.dart';
import 'package:flutter_workingapp/widget/just_walkmode_widget.dart';
import 'package:flutter_workingapp/widget/nomode_widget.dart';
import 'package:flutter_workingapp/widget/set_walkmode_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum WalkMode { NONE, SETWALK, JUSTWALK }

class WalkSceen extends StatefulWidget {
  const WalkSceen({Key? key}) : super(key: key);

  @override
  State<WalkSceen> createState() => _WalkSceenState();
}

class _WalkSceenState extends State<WalkSceen> {
  late GoogleMapController mapController;
// 37.46342905,126.80314663
  final LatLng _center = const LatLng(37.463429, 126.803146);
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
            setWalkMode(context)
          ] else if (_state == WalkMode.JUSTWALK) ...[
            const justWalkMode()
          ]
        ],
      ),
    );
  }
}
