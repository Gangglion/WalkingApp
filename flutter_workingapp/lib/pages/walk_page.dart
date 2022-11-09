// 산책 화면

import 'package:flutter/material.dart';
import 'package:flutter_workingapp/widget/just_walkmode_widget.dart';
import 'package:flutter_workingapp/widget/nomode_rowwidget.dart';
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

  final LatLng _center = const LatLng(45.521563, -122.677433);
  int walkMode = 0; // 1은 걸음수 지정 산책 모드, 2는 일반 산책 모드 - enum으로 관리 가능할듯
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  WalkMode _state = WalkMode.NONE;
  Widget _content() {
    if (_state == WalkMode.SETWALK)
      return setWalkMode(context);
    else if (_state == WalkMode.JUSTWALK) {
      return justWalkMode(context);
    }
    return noMode_rowWidget(context);
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
          _content(),
        ],
      ),
    );
  }
}
