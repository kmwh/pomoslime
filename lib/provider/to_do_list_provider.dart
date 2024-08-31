import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class ToDoListProvider with ChangeNotifier {
  final UserDataModel _userData;

  ToDoListProvider(this._userData);

  List<Map> get toDoList => _userData.toDoList;

  int get toDoListLength => _userData.toDoList.length;

  int get currentToDo => _userData.currentToDo;

  String get currentToDoName =>
      _userData.toDoList[_userData.currentToDo]["name"];

  void setCurrentToDo(int index) {
    _userData.currentToDo = index;
    _userData.currentSession = 0;
    _userData.save();

    notifyListeners();
  }

  void addToDo(Map newToDo) {
    _userData.toDoList.add(newToDo);
    _userData.save();

    notifyListeners();
  }

  void deleteToDo(int index) {
    _userData.toDoList.removeAt(index);
    if (index < _userData.currentToDo) {
      _userData.currentToDo -= 1;
    }
    _userData.save();

    notifyListeners();
  }

  void updateToDo(int index, Map updatedToDo) {
    _userData.toDoList[index] = updatedToDo;
    _userData.save();

    notifyListeners();
  }
}
