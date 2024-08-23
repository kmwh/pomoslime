import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_settings_model.dart';

class FocusSettingProvider with ChangeNotifier {
  final UserSettingsModel _userSettings;

  FocusSettingProvider(this._userSettings);

  bool get focusImmediately => _userSettings.focusImmediately;

  void toggle() {
    _userSettings.focusImmediately = !_userSettings.focusImmediately;
    _userSettings.save();

    notifyListeners();
  }
}
