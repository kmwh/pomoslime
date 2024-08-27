import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class ToDoListProvider with ChangeNotifier {
  final UserDataModel _userData;

  ToDoListProvider(this._userData);

  List<List> get toDoList => _userData.toDoList;
  int get toDoListLength => _userData.toDoList.length;

  void addToDoList(List newToDo) {
    _userData.toDoList.add(newToDo);
    _userData.save();

    notifyListeners();
  }

  void deleteToDoList(int index) {
    _userData.toDoList.removeAt(index);
    _userData.save();

    notifyListeners();
  }

  void updateToDoList(int index, List updatedToDo) {
    _userData.toDoList[index] = updatedToDo;
    _userData.save();

    notifyListeners();
  }
}
