import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class CurrentToDoProvider with ChangeNotifier {
  final UserDataModel _userData;

  CurrentToDoProvider(this._userData);

  String get currentToDoName => _userData.toDoList[_userData.currentToDo][0];

  int get currentToDo => _userData.currentToDo;

  int get currentToDoColor => _userData.toDoList[_userData.currentToDo][5];

  int get toDoListLength => _userData.toDoList.length;

  void setCurrentToDo(int index) {
    _userData.currentToDo = index;
    _userData.currentSession = 0;
    _userData.save();

    notifyListeners();
  }
}
