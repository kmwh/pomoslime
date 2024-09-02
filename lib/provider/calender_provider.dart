import 'package:flutter/material.dart';
import 'package:pomoslime/model/calender_data_model.dart';

class CalenderProvider with ChangeNotifier {
  final CalenderDataModel _calenderData;

  CalenderProvider(this._calenderData);

  Map<DateTime, int> get focusTimeMap => _calenderData.focusTimeMap;

  bool get numberView => _calenderData.numberView;

  void toggleNumberView(bool value) {
    _calenderData.numberView = value;
    _calenderData.save();

    notifyListeners();
  }

  void readCalenderData() {
    setPeriodTimes();
  }

  void addToCalender(int time) {
    DateTime now = DateTime.now();
    DateTime dateOnly = DateUtils.dateOnly(now);
    _calenderData.focusTimeMap[dateOnly] =
        (_calenderData.focusTimeMap[dateOnly] ?? 0) + time;
    _calenderData.save();

    setPeriodTimes();

    notifyListeners();
  }

  int getPeriodTime(int periodIndex) {
    switch (periodIndex) {
      case 0:
        return _calenderData.totalFocusTime;
      case 1:
        return _calenderData.todayFocusTime;
      case 2:
        return _calenderData.weekFocusTime;
      case 3:
        return _calenderData.monthFocusTime;
      case 4:
      default:
        return _calenderData.yearFocusTime;
    }
  }

  Future<void> setPeriodTimes() async {
    await Future.wait([
      _updateTotalFocusTime(),
      _updateTodayFocusTime(),
      _updateWeekFocusTime(),
      _updateMonthFocusTime(),
      _updateYearFocusTime(),
    ]);

    notifyListeners();
  }

  Future<void> _updateTotalFocusTime() async {
    int totalFocusTime =
        focusTimeMap.values.fold(0, (sum, value) => sum + value);

    _calenderData.totalFocusTime = totalFocusTime;
    print("aa");

    _calenderData.save();
  }

  Future<void> _updateTodayFocusTime() async {
    DateTime now = DateTime.now();
    DateTime dateOnly = DateUtils.dateOnly(now);

    _calenderData.todayFocusTime = focusTimeMap[dateOnly] ?? 0;
    print("bb");

    _calenderData.save();
  }

  Future<void> _updateWeekFocusTime() async {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;
    DateTime startOfWeek = now.subtract(Duration(days: currentWeekday - 1));
    DateTime endOfWeek =
        now.add(Duration(days: DateTime.daysPerWeek - currentWeekday));

    _calenderData.weekFocusTime = focusTimeMap.entries
        .where((entry) =>
            entry.key.isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
            entry.key.isBefore(endOfWeek.add(const Duration(days: 1))))
        .fold(0, (sum, entry) => sum + entry.value);
    print("cc");

    _calenderData.save();
  }

  Future<void> _updateMonthFocusTime() async {
    DateTime now = DateTime.now();
    DateTime startOfMonth = DateTime(now.year, now.month, 1);
    DateTime endOfMonth =
        DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));

    _calenderData.monthFocusTime = focusTimeMap.entries
        .where((entry) =>
            entry.key.isAfter(startOfMonth.subtract(const Duration(days: 1))) &&
            entry.key.isBefore(endOfMonth.add(const Duration(days: 1))))
        .fold(0, (sum, entry) => sum + entry.value);
    print("dd");

    _calenderData.save();
  }

  Future<void> _updateYearFocusTime() async {
    DateTime now = DateTime.now();
    DateTime startOfYear = DateTime(now.year, 1, 1);
    DateTime endOfYear =
        DateTime(now.year + 1, 1, 1).subtract(const Duration(days: 1));

    _calenderData.yearFocusTime = focusTimeMap.entries
        .where((entry) =>
            entry.key.isAfter(startOfYear.subtract(const Duration(days: 1))) &&
            entry.key.isBefore(endOfYear.add(const Duration(days: 1))))
        .fold(0, (sum, entry) => sum + entry.value);
    print("ee");

    _calenderData.save();
  }
}
