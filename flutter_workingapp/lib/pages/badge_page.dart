// 걸음수 뱃지 화면
import 'package:flutter/material.dart';

class BadgeSceen extends StatelessWidget {
  const BadgeSceen({super.key});
  final int stepVal = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < 5; i++) ...[
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int j = 0; j < 3; j++) ...[
                      Container(
                        height: 130,
                        width: 130,
                        margin: const EdgeInsets.only(top: 20.0, bottom: 10),
                        child: const Card(
                          shape: CircleBorder(side: BorderSide(width: 5.0)),
                          elevation: 4.0,
                          color: Colors.yellow,
                        ),
                      ),
                    ]
                  ],
                )
              ],
            )
          ]
        ],
      ),
    ));
  }
}
