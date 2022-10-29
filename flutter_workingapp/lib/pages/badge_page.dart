// 걸음수 뱃지 화면
import 'package:flutter/material.dart';

class BadgeSceen extends StatelessWidget {
  const BadgeSceen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Container(child: Text('뱃지화면'),)
          ],
        ),
      )
    );
  }
}