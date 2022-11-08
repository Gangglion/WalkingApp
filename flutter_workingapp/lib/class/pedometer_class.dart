import 'dart:async';

import 'package:pedometer/pedometer.dart';

class ClassPedometer {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String status = 'walking';
  String steps = '?';

  ClassPedometer() {}

  String formatDate(DateTime d) {
    return d.toString().substring(0, 19);
  }

  void onStepCount(StepCount event) {
    print(event);
    steps = event.steps.toString();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    status = event.status;
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    status = 'Pedestrian Status not available';
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    steps = 'Step Count not available';
  }

  void initPlatformState() {
    print('initPlatformState 에서 status의 현재 상태 : $status');
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }
}
