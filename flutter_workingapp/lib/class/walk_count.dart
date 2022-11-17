import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class WalkCount {
  static late SharedPreferences setWalkPref;

  WalkCount() {
    getInstance();
  }

  static Future<void> getInstance() async {
    setWalkPref = await SharedPreferences.getInstance();
  }

  void setWalk(int setWalk) async {
    await setWalkPref.setInt('settingWalk', setWalk);
    print('지정한 걸음수 : ${setWalkPref.getInt('settingWalk') ?? 0}');
  }

  int getWalk() {
    return setWalkPref.getInt('settingWalk') ?? 0;
  }
}
