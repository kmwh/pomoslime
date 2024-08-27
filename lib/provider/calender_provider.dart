import 'package:flutter/material.dart';
import 'package:pomoslime/model/calender_data_model.dart';

class CalenderProvider with ChangeNotifier {
  final CalenderDataModel _calenderData;

  CalenderProvider(this._calenderData);

  Map<DateTime, int> get focusTimeMap => _calenderData.focusTimeMap;

  int get totalFocusTime {
    return 10;
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
}
