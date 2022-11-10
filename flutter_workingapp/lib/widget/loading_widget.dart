import 'package:flutter/material.dart';

Widget waitWalking() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
          padding: const EdgeInsets.all(20),
          child: const CircularProgressIndicator(
            strokeWidth: 10,
          )),
      const Text('산책중...')
    ],
  );
}
