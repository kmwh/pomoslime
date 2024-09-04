import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';
import 'package:vibration/vibration.dart';

class VibrationProvider with ChangeNotifier {
  final UserDataModel _userData;

  VibrationProvider(this._userData);

  bool get vibration => _userData.vibration;

  void toggle() {
    _userData.vibration = !_userData.vibration;
    _userData.save();

    notifyListeners();
  }

  void vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(pattern: [0, 200, 200, 200]);
    }
  }
}
