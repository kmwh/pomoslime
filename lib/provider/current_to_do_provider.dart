import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class CurrentToDoProvider with ChangeNotifier {
  final UserDataModel _userData;

  CurrentToDoProvider(this._userData);

  List get currentToDo => _userData.currentToDo;

  void setCurrentToDo(String toDo) {
    _userData.currentToDo[0] = toDo;
    _userData.currentToDo[1] =
        _userData.toDoMap[toDo]![0] * 2 - 1; // 휴식까지 포함한 총 세션 수
    _userData.currentToDo[2] = _userData.toDoMap[toDo]![1]; // 집중 시간(초)
    _userData.currentToDo[3] = _userData.toDoMap[toDo]![2]; // 짧은 휴식
    _userData.currentToDo[4] = _userData.toDoMap[toDo]![3]; // 긴 휴식

    _userData.currentSession = 0;
    _userData.save();

    // debugPrint(_userData.currentToDo.toString());

    notifyListeners();
  }
}
