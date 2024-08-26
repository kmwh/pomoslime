import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class FocusImmediatelyProvider with ChangeNotifier {
  final UserDataModel _userData;

  FocusImmediatelyProvider(this._userData);

  bool get focusImmediately => _userData.focusImmediately;

  void toggle() {
    _userData.focusImmediately = !_userData.focusImmediately;
    _userData.save();

    notifyListeners();
  }
}
