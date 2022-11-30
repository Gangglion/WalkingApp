import 'package:flutter/material.dart';
import 'package:flutter_workingapp/widget/loading_widget.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../class/StepValue_class.dart';
import '../class/datebaseHelper_class.dart';
import '../pages/home_page.dart';

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
  int _nofSteps = 0;
  HealthFactory health = HealthFactory();
  late Timer _timer;
  bool _isCounting = false;
  int? startSteps;
  late bool requested;
  @override
  void initState() {
    super.initState();
    getStartStepData(); // 시작했을때 걸음 수 가져옴
    _isCounting = !_isCounting;
    if (_isCounting) {
      _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
        setState(() {
          fetchStepData(); // 실시간으로 걸으면서 걸음 수 가져옴
        });
      });
    } else {
      _timer.cancel();
    }
  }

  // 타이머 객체 해제
  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  Future getStartStepData() async {
    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    requested = await health.requestAuthorization([HealthDataType.STEPS]);

    if (requested) {
      try {
        startSteps = await health.getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print("Caught exception in getTotalStepsInInterval: $error");
      }

      print('Start number of steps: $startSteps');
    } else {
      print("Authorization not granted - error in authorization");
    }
  }

  Future fetchStepData() async {
    int? steps;

    // get steps for today (i.e., since midnight)
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);

    if (requested) {
      try {
        steps = await health.getTotalStepsInInterval(midnight, now);
      } catch (error) {
        print("Caught exception in getTotalStepsInInterval: $error");
      }

      print('Total number of steps: $steps');

      setState(() {
        _nofSteps = (steps == null) ? 0 : (steps - startSteps!);
        _state = (steps == null) ? DataState.NO_DATA : DataState.STEPS_READY;
      });
    } else {
      print("Authorization not granted - error in authorization");
      setState(() => _state = DataState.DATA_NOT_FETCHED);
    }
  }

  Text _stepsFetched() {
    return Text(
      '걸음수 : $_nofSteps',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
    );
  }

  Widget _contentNoData() {
    return const Text('측정된 걸음수가 없습니다');
  }

  Widget _contentNotFetched() {
    return const Text('걸음수를 가져오고 있습니다...');
  }

  Widget _authorizationNotGranted() {
    return const Text('Authorization not given. '
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
              var now = DateTime.now();
              String nowDate = DateFormat('yy-MM-dd/HH:mm:ss').format(now);
              _timer.cancel();
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Column(
                        children: const <Widget>[Text('완료')],
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('산책을 종료합니다!\n걸음수 : $_nofSteps')
                        ],
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Text("확인"),
                          onPressed: () {
                            StepValue stepValue =
                                StepValue(dates: nowDate, step: _nofSteps);
                            DatabaseHelper.instance.add(stepValue);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          },
                        ),
                      ],
                    );
                  });
            },
            backgroundColor: Colors.red.shade300,
            child: const Icon(Icons.stop_circle))
      ],
    );
  }
}
