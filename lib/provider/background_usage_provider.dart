import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_settings_model.dart';

class BackgroundUsageProvider with ChangeNotifier {
  final UserSettingsModel _userSettings;

  BackgroundUsageProvider(this._userSettings);

  bool get backgroundUsage => _userSettings.backgroundUsage;

  void toggle() {
    _userSettings.backgroundUsage = !_userSettings.backgroundUsage;
    _userSettings.save();

    notifyListeners();
  }
}
