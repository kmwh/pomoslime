import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';

class LanguageProvider with ChangeNotifier {
  final UserDataModel _userData;

  LanguageProvider(this._userData);

  int get language => _userData.language;

  void selectLanguage(int language) {
    _userData.language = language;
    _userData.save();

    notifyListeners();
  }
}
