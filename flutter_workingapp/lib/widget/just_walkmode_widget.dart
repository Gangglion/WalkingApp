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
  NO_DATA,
  AUTH_NOT_GRANTED,
  STEPS_READY,
}

class _justWalkModeState extends State<justWalkMode> {
  DataState _state = DataState.DATA_NOT_FETCHED;
  int _nofSteps = 10;
  HealthFactory health = HealthFactory();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchStepData();
  }

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

  Text _stepsFetched() {
    return Text('걸음수 : $_nofSteps');
  }

  Widget _contentNoData() {
    return const Text('측정된 걸음수가 없습니다');
  }

  Widget _contentNotFetched() {
    return const Text('걸음수를 가져오고 있습니다...');
  }

  Widget _authorizationNotGranted() {
    return Text('Authorization not given. '
        'For Android please check your OAUTH2 client ID is correct in Google Developer Console. '
        'For iOS check your permissions in Apple Health.');
  }

  Widget _content() {
    if (_state == DataState.NO_DATA)
      return _contentNoData();
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
        const SizedBox(height: 20),
        Container(child: waitWalking()),
        const SizedBox(height: 10),
        _content(),
        const SizedBox(height: 20),
        FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: Colors.red.shade300,
            child: Icon(Icons.stop_circle))
      ],
    );
  }
}
