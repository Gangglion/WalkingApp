// 통계 화면
import 'package:flutter/material.dart';
import 'package:flutter_workingapp/class/StepValue_class.dart';

import '../class/datebaseHelper_class.dart';

class StatusSceen extends StatelessWidget {
  const StatusSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<StepValue>>(
            future: DatabaseHelper.instance.getStepValue(),
            builder: (BuildContext context,
                AsyncSnapshot<List<StepValue>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('Loading...'));
              }
              return ListView(
                  children: snapshot.data!.map((stepValue) {
                return Center(
                    child: ListTile(
                  title: Text(stepValue.dates),
                  subtitle: Text(stepValue.step.toString()),
                ));
              }).toList());
            }),
      ),
    );
  }
}
