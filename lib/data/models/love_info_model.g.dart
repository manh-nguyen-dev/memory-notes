// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'love_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoveInfoAdapter extends TypeAdapter<LoveInfo> {
  @override
  final int typeId = 0;

  @override
  LoveInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoveInfo(
      title: fields[0] as String,
      subtitle: fields[1] as String,
      startDate: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LoveInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subtitle)
      ..writeByte(2)
      ..write(obj.startDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoveInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
