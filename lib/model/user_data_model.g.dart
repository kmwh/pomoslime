// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataModelAdapter extends TypeAdapter<UserDataModel> {
  @override
  final int typeId = 1;

  @override
  UserDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDataModel(
      premium: fields[0] as bool,
      vibration: fields[1] as bool,
      notificationIndex: fields[2] as int,
      whiteNoiseIndex: fields[3] as int,
      darkMode: fields[4] as bool,
      backgroundUsage: fields[5] as bool,
      language: fields[6] as int,
      focusImmediately: fields[7] as bool,
      toDoList: (fields[8] as List)
          .map((dynamic e) => (e as Map).cast<dynamic, dynamic>())
          .toList(),
      currentToDo: fields[9] as int,
      currentSession: fields[10] as int,
      currentTime: fields[11] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserDataModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.premium)
      ..writeByte(1)
      ..write(obj.vibration)
      ..writeByte(2)
      ..write(obj.notificationIndex)
      ..writeByte(3)
      ..write(obj.whiteNoiseIndex)
      ..writeByte(4)
      ..write(obj.darkMode)
      ..writeByte(5)
      ..write(obj.backgroundUsage)
      ..writeByte(6)
      ..write(obj.language)
      ..writeByte(7)
      ..write(obj.focusImmediately)
      ..writeByte(8)
      ..write(obj.toDoList)
      ..writeByte(9)
      ..write(obj.currentToDo)
      ..writeByte(10)
      ..write(obj.currentSession)
      ..writeByte(11)
      ..write(obj.currentTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
