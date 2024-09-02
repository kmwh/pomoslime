import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomoslime/model/calender_data_model.dart';
import 'package:pomoslime/model/user_data_model.dart';

class TimerProvider with ChangeNotifier {
  final UserDataModel _userData;
  final CalenderDataModel _calenderData;

  bool isInit = true;
  late String currentSessionName;
  late Timer timer;

  TimerProvider(this._userData, this._calenderData) {
    _userData.currentTime =
        _userData.toDoList[_userData.currentToDo]["focusTime"] * 60;
    currentSessionName = 'focus';
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    timer.cancel();
    if (_userData.currentSession != 0) {
      isInit = false;
    }
  }

  int get currentSessionSeconds {
    if ((_userData.currentSession + 1) % 8 == 0 &&
        _userData.currentSession != 0) {
      currentSessionName = 'long';
      return _userData.toDoList[_userData.currentToDo]["longBreakTime"] * 60;
    } else if (_userData.currentSession % 2 == 0) {
      currentSessionName = 'focus';
      return _userData.toDoList[_userData.currentToDo]["focusTime"] * 60;
    } else {
      currentSessionName = 'short';
      return _userData.toDoList[_userData.currentToDo]["shortBreakTime"] * 60;
    }
  }

  String get formattedCurrentSessionSeconds =>
      formatTimer(_userData.currentTime);

  int get totalSession =>
      _userData.toDoList[_userData.currentToDo]["focusCount"] * 2 - 1;

  int get currentSession => _userData.currentSession;

  bool get isRunning => timer.isActive;

  ///////// 캘린더
  Map<DateTime, int> get focusTimeMap => _calenderData.focusTimeMap;

  int get totalFocusTime {
    return 20;
  }

  int get todayFocusTime {
    return 10;
  }

  int get weekFocusTime {
    return 10;
  }

  int get monthFocusTime {
    return 10;
  }

  int get yearFocusTime {
    return 10;
  }

  int getPeriodTimes(int index) {
    if (index == 0) {
      return totalFocusTime;
    } else if (index == 1) {
      return todayFocusTime;
    } else if (index == 2) {
      return weekFocusTime;
    } else if (index == 3) {
      return monthFocusTime;
    } else {
      return yearFocusTime;
    }
  }
  /////////

  String formatTimer(int seconds) {
    var duration = Duration(seconds: seconds);
    if (duration.inHours > 0) {
      return duration.toString().split('.').first;
    } else {
      return duration.toString().split('.').first.substring(2, 7);
    }
  }

  void onTick(Timer timer) {
    _userData.currentTime -= 1;

    if (_userData.currentTime == 0) {
      // 캘린더 기록
      if (currentSessionName == 'focus') {
        DateTime now = DateTime.now();
        DateTime dateOnly = DateUtils.dateOnly(now);
        _calenderData.focusTimeMap[dateOnly] =
            (_calenderData.focusTimeMap[dateOnly] ?? 0) + 1;
        _calenderData.save();
      }

      // 다음 세션으로 넘기는 작업
      _userData.currentSession += 1;
      _userData.currentTime = currentSessionSeconds;

      if (_userData.currentSession >= totalSession) {
        _userData.currentSession = 0;
        timer.cancel();
        _userData.currentTime = currentSessionSeconds;
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
    _userData.currentTime = currentSessionSeconds;
    isInit = true;

    notifyListeners();
  }
}
