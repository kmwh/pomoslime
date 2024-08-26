import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class ToDoListProvider with ChangeNotifier {
  final UserDataModel _userData;

  ToDoListProvider(this._userData);

  Map<String, List> get toDoList => _userData.toDoMap;

  void addToDoList(Map<String, List> newTodo) {
    _userData.toDoMap.addAll(newTodo);
    _userData.save();

    notifyListeners();
  }

  void deleteToDoList(String name) {
    _userData.toDoMap.remove(name);
    _userData.save();

    notifyListeners();
  }

  void updateToDoList(String name, List settings) {
    _userData.toDoMap.update(name, (value) => settings);
    _userData.save();

    notifyListeners();
  }
}
