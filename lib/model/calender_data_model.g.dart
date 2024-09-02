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
      numberView: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, CalenderDataModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.focusTimeMap)
      ..writeByte(2)
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
