import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class PremiumProvider with ChangeNotifier {
  final UserDataModel _userData;

  PremiumProvider(this._userData);

  bool get isPremium =>
      DateTime.now().difference(_userData.premium).inHours < 24;

  void activatePremium() {
    _userData.premium = DateTime.now();
    _userData.save();

    notifyListeners();
  }
}
