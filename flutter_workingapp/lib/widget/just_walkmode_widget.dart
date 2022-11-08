import 'package:flutter/material.dart';
import 'package:flutter_workingapp/class/pedometer_class.dart';

class JustWalkMode extends StatefulWidget {
  const JustWalkMode({super.key});

  @override
  State<JustWalkMode> createState() => _JustWalkModeState();
}

class _JustWalkModeState extends State<JustWalkMode> {
  ClassPedometer pedometer_c = ClassPedometer();
  @override
  void initState() {
    super.initState();
    print('justWalkMode 진입');
    pedometer_c.initPlatformState();
    String nowStatus = pedometer_c.status;
    print('현재 상태 : $nowStatus');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(width: 200, height: 100, child: Text(pedometer_c.steps)),
          ElevatedButton(
            onPressed: () {
              print('산책 종료');
              pedometer_c.status = 'stpped';
              String walkcount = pedometer_c.steps;
              print('현재 걸음 수 : $walkcount');
              Navigator.pop(context);
            },
            child: const Text("산책 종료", style: TextStyle(color: Colors.black87)),
          )
        ],
      ),
    ));
  }
}
