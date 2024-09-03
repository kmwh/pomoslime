import 'package:flutter/material.dart';
import 'package:pomoslime/model/user_data_model.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageProvider with ChangeNotifier {
  final UserDataModel _userData;

  LanguageProvider(this._userData);

  String get language => _userData.language;

  Future<void> selectLanguage(BuildContext context, String language) async {
    _userData.language = language;
    _userData.save();

    if (language == "English") {
      await context.setLocale(const Locale('en'));
    } else if (language == '한국어') {
      await context.setLocale(const Locale('ko'));
    }

    notifyListeners();
  }
}
