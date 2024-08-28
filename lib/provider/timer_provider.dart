import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class TimerProvider with ChangeNotifier {
  final UserDataModel _userData;

  bool isInit = true;
  late int currentSeconds;
  late String currentSessionName;
  late Timer timer;

  TimerProvider(this._userData) {
    currentSeconds = _userData.toDoList[_userData.currentToDo][2];
    currentSessionName = 'focus';
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    timer.cancel();
  }

  int get currentSessionSeconds {
    if ((_userData.currentSession + 1) % 8 == 0 &&
        _userData.currentSession != 0) {
      currentSessionName = 'long';
      return _userData.toDoList[_userData.currentToDo][4];
    } else if (_userData.currentSession % 2 == 0) {
      currentSessionName = 'focus';
      return _userData.toDoList[_userData.currentToDo][2];
    } else {
      currentSessionName = 'short';
      return _userData.toDoList[_userData.currentToDo][3];
    }
  }

  String get formattedCurrentSessionSeconds => formatTimer(currentSeconds);

  int get totalSession => _userData.toDoList[_userData.currentToDo][1] * 2 - 1;

  int get currentSession => _userData.currentSession;

  bool get isRunning => timer.isActive;

  String formatTimer(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  void onTick(Timer timer) {
    currentSeconds -= 1;

    if (currentSeconds == 0) {
      _userData.currentSession += 1;
      currentSeconds = currentSessionSeconds;

      if (_userData.currentSession >= totalSession) {
        _userData.currentSession = 0;
        timer.cancel();
        currentSeconds = currentSessionSeconds;
        isInit = true;
      }

      _userData.save();

      if (currentSessionName == 'focus' && !_userData.focusImmediately) {
        timer.cancel();
      }
    }

    notifyListeners();
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    isInit = false;

    notifyListeners();
  }

  void onPausePressed() {
    timer.cancel();

    notifyListeners();
  }

  void onCancelPressed() {
    _userData.currentSession = 0;
    _userData.save();
    timer.cancel();
    currentSeconds = currentSessionSeconds;
    isInit = true;

    notifyListeners();
  }
}
