import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class PremiumProvider with ChangeNotifier {
  final UserDataModel _userData;

  PremiumProvider(this._userData);

  bool get isPremium => _userData.premium;

  void setPremium(bool value) {
    _userData.premium = value;
    _userData.save();

    notifyListeners();
  }
}
