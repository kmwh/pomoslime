import 'package:hive/hive.dart';

part 'calender_data_model.g.dart';

@HiveType(typeId: 2)
class CalenderDataModel extends HiveObject {
  @HiveField(1)
  Map<DateTime, int> focusTimeMap;

  @HiveField(2)
  bool numberView;

  CalenderDataModel({
    required this.focusTimeMap,
    required this.numberView,
  });
}
