import 'package:flutter/material.dart';
import 'package:flutter_workingapp/widget/setwalk_picker.dart';

import '../class/datebaseHelper_class.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool _gpsEnable = true;

  Widget buildHeader(BuildContext context) {
    return Container(
        color: Colors.green,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: Column(
          children: const [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://previews.123rf.com/images/chrisdorney/chrisdorney1607/chrisdorney160700100/61360644-%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD-%EC%9C%84%EC%97%90-%EC%83%98%ED%94%8C-%EB%8F%84%EC%9E%A5%EC%9E%85%EB%8B%88%EB%8B%A4-.jpg'),
            ),
            SizedBox(height: 12),
            Text('Gangglion',
                style: TextStyle(fontSize: 28, color: Colors.white)),
            Text('o0tmdguq0o@gmail.com',
                style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ));
  }

  Widget buildMenuItems(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: const Text('로그아웃'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.gps_fixed),
          title: const Text('GPS기록 변경'),
          trailing: Switch(
            value: _gpsEnable,
            onChanged: (value) {
              setState(() {
                _gpsEnable = value;
              });
            },
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('기록 초기화'),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Column(
                      children: const <Widget>[Text('기록 삭제')],
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[Text('정말 데이터를 삭제하시겠습니까?')],
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: const Text("삭제"),
                        onPressed: () {
                          DatabaseHelper.instance.delete();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                });
          },
        ),
        ListTile(
          leading: const Icon(Icons.directions_walk),
          title: const Text('목표 걸음수 설정'),
          onTap: () {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return const SetWalkPicker();
                });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ]),
    ));
  }
}
