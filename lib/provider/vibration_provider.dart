import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class VibrationProvider with ChangeNotifier {
  final UserDataModel _userData;

  VibrationProvider(this._userData);

  bool get vibration => _userData.vibration;

  void toggle() {
    _userData.vibration = !_userData.vibration;
    _userData.save();

    notifyListeners();
  }
}
