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
  // Default Position : 37.46342905,126.80314663
  late LatLng _center;

  @override
  void initState() {
    super.initState();
  }

  StreamSubscription<Position> _positionStream() {
    return Geolocator.getPositionStream().listen((Position? position) {
      // print(position == null
      //     ? 'Unknown'
      //     : '${position.latitude.toString()}, ${position.longitude.toString()}');
      _markers.add(Marker(
          markerId: const MarkerId("now"),
          draggable: false,
          position: LatLng(position!.latitude, position.longitude)));
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
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
                  _center = const LatLng(37.46342905, 126.80314663);
                  return Container(
                    width: double.infinity,
                    height: (MediaQuery.of(context).size.height -
                            AppBar().preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.6,
                    margin: const EdgeInsets.all(10),
                    child: const Text('가져온 현재 위치 정보가 없습니다.'),
                  );
                } else if (snapshot.hasError) {
                  print('error');
                  _center = const LatLng(37.46342905, 126.80314663);
                  return Container(
                    width: double.infinity,
                    height: (MediaQuery.of(context).size.height -
                            AppBar().preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.6,
                    margin: const EdgeInsets.all(10),
                    child: const Text('위치 정보를 가져오는 중 에러가 발생했습니다.'),
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
                      // child: GoogleMap(
                      //   onMapCreated: _onMapCreated,
                      //   markers: Set.from(_markers),
                      //   initialCameraPosition: CameraPosition(
                      //     target: _center,
                      //     zoom: 17.0,
                      //   ),
                      // ),
                      child: StreamBuilder(
                        stream: Geolocator.getPositionStream(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          Position livePosition = snapshot.data;
                          _markers.add(Marker(
                              markerId: const MarkerId("now"),
                              draggable: false,
                              position: LatLng(livePosition.latitude,
                                  livePosition.longitude)));
                          return GoogleMap(
                            onMapCreated: _onMapCreated,
                            markers: Set.from(_markers),
                            initialCameraPosition: CameraPosition(
                              target: _center,
                              zoom: 17.0,
                            ),
                          );
                        },
                      ));
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
