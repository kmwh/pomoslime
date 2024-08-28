import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class ToDoListProvider with ChangeNotifier {
  final UserDataModel _userData;

  ToDoListProvider(this._userData);

  List<List> get toDoList => _userData.toDoList;

  int get toDoListLength => _userData.toDoList.length;

  int get currentToDo => _userData.currentToDo;

  String get currentToDoName => _userData.toDoList[_userData.currentToDo][0];

  int get currentToDoColor => _userData.toDoList[_userData.currentToDo][5];

  void setCurrentToDo(int index) {
    _userData.currentToDo = index;
    _userData.currentSession = 0;
    _userData.save();

    notifyListeners();
  }

  void addToDo(List newToDo) {
    _userData.toDoList.add(newToDo);
    _userData.save();

    notifyListeners();
  }

  void deleteToDo(int index) {
    _userData.toDoList.removeAt(index);
    _userData.save();

    notifyListeners();
  }

  void updateToDo(int index, List updatedToDo) {
    _userData.toDoList[index] = updatedToDo;
    _userData.save();

    notifyListeners();
  }
}
