import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class TimerProvider with ChangeNotifier {
  final UserDataModel _userData;

  bool isRunning = false;
  bool isInit = true;
  late int currentSeconds;
  late Timer timer;

  TimerProvider(this._userData) {
    currentSeconds = _userData.currentToDo[2];
  }

  int get currentSessionSeconds {
    if (_userData.currentSession % 2 == 0) {
      return _userData.currentToDo[2];
    } else if (_userData.currentSession % 7 == 0) {
      return _userData.currentToDo[4];
    } else {
      return _userData.currentToDo[3];
    }
  }

  String formatTimer(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  String get formattedCurrentSessionSeconds => formatTimer(currentSeconds);

  int get totalSession => _userData.currentToDo[1];
  int get currentSession => _userData.currentSession;

  void pauseTimer() {
    timer.cancel();
    isRunning = false;
  }

  void onTick(Timer timer) {
    currentSeconds -= 1;

    if (currentSeconds == 0) {
      _userData.currentSession += 1;
      _userData.save();

      currentSeconds = currentSessionSeconds;
      pauseTimer();
    }

    notifyListeners();
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    isRunning = true;
    isInit = false;

    notifyListeners();
  }

  void onPausePressed() {
    pauseTimer();

    notifyListeners();
  }

  void onCancelPressed() {
    currentSeconds = currentSessionSeconds;
    isInit = true;
    pauseTimer();
    _userData.currentSession = 0;
    _userData.save();

    notifyListeners();
  }
}
