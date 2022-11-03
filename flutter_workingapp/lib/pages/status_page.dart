// 통계 화면
import 'package:flutter/material.dart';

class StatusSceen extends StatelessWidget {
  const StatusSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              child: const Text("통계화면"),
            )
          ],
        ),
      ),
    );
  }
}
