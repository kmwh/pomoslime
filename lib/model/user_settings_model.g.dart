// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSettingsModelAdapter extends TypeAdapter<UserSettingsModel> {
  @override
  final int typeId = 1;

  @override
  UserSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSettingsModel(
      premium: fields[0] == null ? false : fields[0] as bool,
      vibration: fields[1] as bool,
      notificationIndex: fields[2] as int,
      whiteNoiseIndex: fields[3] as int,
      darkMode: fields[4] as bool,
      backgroundUsage: fields[5] as bool,
      language: fields[6] as String,
      focusImmediately: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserSettingsModel obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.focusImmediately);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
