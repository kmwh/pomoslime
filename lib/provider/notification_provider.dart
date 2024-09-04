import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class NotificationProvider with ChangeNotifier {
  final UserDataModel _userData;

  NotificationProvider(this._userData);

  void setNotification(int index) {
    _userData.notificationIndex = index;
    _userData.save();

    notifyListeners();
  }
}
