import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class BackgroundUsageProvider with ChangeNotifier {
  final UserDataModel _userData;

  BackgroundUsageProvider(this._userData);

  bool get backgroundUsage => _userData.backgroundUsage;

  void toggle() {
    _userData.backgroundUsage = !_userData.backgroundUsage;
    _userData.save();

    notifyListeners();
  }
}
