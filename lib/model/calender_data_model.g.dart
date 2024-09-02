// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calender_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalenderDataModelAdapter extends TypeAdapter<CalenderDataModel> {
  @override
  final int typeId = 2;

  @override
  CalenderDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalenderDataModel(
      focusTimeMap: (fields[1] as Map).cast<DateTime, int>(),
      totalFocusTime: fields[2] as int,
      todayFocusTime: fields[3] as int,
      weekFocusTime: fields[4] as int,
      monthFocusTime: fields[5] as int,
      yearFocusTime: fields[6] as int,
      numberView: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CalenderDataModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.focusTimeMap)
      ..writeByte(2)
      ..write(obj.totalFocusTime)
      ..writeByte(3)
      ..write(obj.todayFocusTime)
      ..writeByte(4)
      ..write(obj.weekFocusTime)
      ..writeByte(5)
      ..write(obj.monthFocusTime)
      ..writeByte(6)
      ..write(obj.yearFocusTime)
      ..writeByte(7)
      ..write(obj.numberView);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalenderDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
