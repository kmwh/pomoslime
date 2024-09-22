import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';
import 'package:pomoslime/provider/calender_provider.dart';
import 'package:pomoslime/provider/notification_provider.dart';
import 'package:pomoslime/provider/premium_provider.dart';
import 'package:pomoslime/provider/vibration_provider.dart';
import 'package:pomoslime/provider/white_noise_provider.dart';
import 'package:provider/provider.dart';

class TimerProvider with ChangeNotifier {
  final UserDataModel _userData;

  bool isInit = true;
  late String currentSessionName;
  late Timer timer;

  TimerProvider(this._userData) {
    // Init 설정
    currentSessionSeconds;
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => onTick(timer, null),
    );
    timer.cancel();
    if (_userData.currentSession > 0 ||
        _userData.currentTime !=
            (_userData.toDoList[_userData.currentToDo]["focusTime"] * 60)) {
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

  String get sessionName => currentSessionName;

  bool get isRunning => timer.isActive;

  String formatTimer(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.inHours > 0
        ? duration.toString().split('.').first
        : duration.toString().split('.').first.substring(2, 7);
  }

  void onTick(Timer timer, BuildContext? context) {
    _userData.currentTime -= 1;
    _userData.save();

    if (_userData.currentTime == 0) {
      // 캘린더 기록
      if (currentSessionName == 'focus' && context != null) {
        context
            .read<CalenderProvider>()
            .addToCalender(currentSessionSeconds ~/ 60);
      }

      // 다음 세션으로 넘어갈 때 알람
      if (_userData.notificationIndex != 0 && context != null) {
        context
            .read<NotificationProvider>()
            .playNotification(_userData.notificationIndex);
      }

      // 다음 세션으로 넘어갈 때 진동
      if (_userData.vibration && context != null) {
        context.read<VibrationProvider>().vibrate();
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

      // 휴식이 끝나고 다음 세션이 집중이면 focusImmediately 옵션에 따라 일시정지 혹은 바로 시작
      if (currentSessionName == 'focus' && !_userData.focusImmediately) {
        timer.cancel();
      }

      // 백색소음 세팅
      if (!isRunning ||
          currentSessionName == 'short' ||
          currentSessionName == 'long' ||
          !context!.read<PremiumProvider>().isPremium) {
        context!.read<WhiteNoiseProvider>().pauseWhiteNoise(); // 백색소음 중지
      } else if (currentSessionName == 'focus' && _userData.focusImmediately) {
        context.read<WhiteNoiseProvider>().playWhiteNoise(); // 백색소음 시작
      }

      _userData.save();
    }

    notifyListeners();
  }

  void onStartPressed(BuildContext context) {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) => onTick(timer, context),
    );
    isInit = false;

    if (currentSessionName == 'focus') {
      context.read<WhiteNoiseProvider>().playWhiteNoise(); // 백색소음 시작
    }

    notifyListeners();
  }

  void onPausePressed(BuildContext context) {
    timer.cancel();
    context.read<WhiteNoiseProvider>().pauseWhiteNoise(); // 백색소음 중지

    notifyListeners();
  }

  void onCancelPressed() {
    _userData.currentSession = 0;
    _userData.currentTime = currentSessionSeconds;
    _userData.save();
    timer.cancel();
    isInit = true;

    notifyListeners();
  }
}
