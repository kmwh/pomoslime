import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_settings_model.dart';

class VibrationProvider with ChangeNotifier {
  final UserSettingsModel _userSettings;

  VibrationProvider(this._userSettings);

  bool get vibration => _userSettings.vibration;

  void toggle() {
    _userSettings.vibration = !_userSettings.vibration;
    _userSettings.save();

    notifyListeners();
  }
}
