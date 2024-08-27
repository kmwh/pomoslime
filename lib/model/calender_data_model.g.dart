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
    );
  }

  @override
  void write(BinaryWriter writer, CalenderDataModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.focusTimeMap);
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
