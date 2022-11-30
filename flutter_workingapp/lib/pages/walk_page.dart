// 산책 화면

import 'dart:async';

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
  LatLng _center = LatLng(37.46342905, 126.80314663);
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    if (_state == WalkMode.SETWALK || _state == WalkMode.JUSTWALK) {
      _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        _determinePosition();
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
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
          FutureBuilder(
              future: _determinePosition(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print('noData');
                if (snapshot.hasData == false) {
                  return Container(
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
                        zoom: 17.0,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  print('error');
                  return Container(
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
                        zoom: 17.0,
                      ),
                    ),
                  );
                } else {
                  Position position = snapshot.data;
                  print('Data : $position');
                  _center = LatLng(position.latitude, position.longitude);
                  _markers.add(Marker(
                      markerId: const MarkerId("now"),
                      draggable: false,
                      position: LatLng(position.latitude, position.longitude)));
                  return Container(
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
                        zoom: 17.0,
                      ),
                    ),
                  );
                }
              }),
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
                ),
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
