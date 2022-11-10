import 'package:flutter/material.dart';
import 'package:flutter_workingapp/widget/loading_widget.dart';
import 'package:health/health.dart';

// Widget justWalkMode(dynamic context) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [SizedBox(height: 20), Container(child: waitWalking()),Text("현재 걸음 수 : ")],
//   );
// }
class justWalkMode extends StatefulWidget {
  const justWalkMode({super.key});

  @override
  State<justWalkMode> createState() => _justWalkModeState();
}

enum DataState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED,
  STEPS_READY,
}

class _justWalkModeState extends State<justWalkMode> {
  DataState _state = DataState.DATA_NOT_FETCHED;
  int _nofSteps = 10;
  HealthFactory health = HealthFactory();

  Future fetchStepData() async {
    int? steps;

    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    bool requested = await health.requestAuthorization([HealthDataType.STEPS]);

    if (requested) {
      try {
        steps = await health.getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print("Caught exception in getTotalStepsInInterval: $error");
      }

      print('Total number of steps: $steps');

      setState(() {
        _nofSteps = (steps == null) ? 0 : steps;
        _state = (steps == null) ? DataState.NO_DATA : DataState.STEPS_READY;
      });
    } else {
      print("Authorization not granted - error in authorization");
      setState(() => _state = DataState.DATA_NOT_FETCHED);
    }
  }

  Widget _stepsFetched() {
    return Text('Total number of steps: $_nofSteps');
  }

  Widget _content() {
    if (_state == DataState.DATA_READY)
      return _contentDataReady();
    else if (_state == DataState.NO_DATA)
      return _contentNoData();
    else if (_state == DataState.FETCHING_DATA)
      return _contentFetchingData();
    else if (_state == DataState.AUTH_NOT_GRANTED)
      return _authorizationNotGranted();
    else if (_state == DataState.STEPS_READY) return _stepsFetched();

    return _contentNotFetched();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Container(child: waitWalking()),
        SizedBox(height: 10),
        fetchStepData();
        SizedBox(height: 20),
        FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.red.shade300,
            child: Icon(Icons.stop_circle))
      ],
    );
  }
}
