import 'package:flutter/material.dart';
import 'package:pomoslime/model/calender_data_model.dart';

class CalenderProvider with ChangeNotifier {
  final CalenderDataModel _calenderData;

  CalenderProvider(this._calenderData);

  Map<DateTime, int> get focusTimeMap => _calenderData.focusTimeMap;

  bool get numberView => _calenderData.numberView;

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

  void toggleNumberView(bool value) {
    _calenderData.numberView = value;
    _calenderData.save();

    notifyListeners();
  }

  void addToCalender() {
    DateTime now = DateTime.now();
    DateTime dateOnly = DateUtils.dateOnly(now);
    _calenderData.focusTimeMap[dateOnly] =
        (_calenderData.focusTimeMap[dateOnly] ?? 0) + 1;
    _calenderData.save();

    notifyListeners();
  }
}
