import 'dart:ui';

import 'package:flutter/Material.dart';
import 'package:flutter_workingapp/class/walk_count.dart';
import 'package:numberpicker/numberpicker.dart';

class SetWalkPicker extends StatefulWidget {
  const SetWalkPicker({super.key});

  @override
  State<SetWalkPicker> createState() => _SetWalkPickerState();
}

class _SetWalkPickerState extends State<SetWalkPicker> {
  int _currentValue = 5;
  int minValue = 0;
  int maxValue = 10;
  WalkCount walkCount = WalkCount();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.white,
          width: 300,
          height: 50,
          child: const Text(
            "목표 걸음수를 설정하세요!",
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          color: Colors.white,
          width: 300,
          height: 300,
          child: NumberPicker(
            value: _currentValue,
            minValue: minValue,
            maxValue: maxValue,
            step: 1,
            itemHeight: 100,
            axis: Axis.vertical,
            onChanged: (value) {
              setState(() {
                _currentValue = value;

                walkCount.setWalk(_currentValue);
              });
            },
          ),
        ),
      ],
    );
  }
}
