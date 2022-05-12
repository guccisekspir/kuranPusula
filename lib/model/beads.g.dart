// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beads.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BeadsAdapter extends TypeAdapter<Beads> {
  @override
  final int typeId = 0;

  @override
  Beads read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Beads(
      id: fields[0] as int?,
      bead: fields[1] as String?,
      meaning: fields[2] as String?,
      prefCount: fields[3] as int?,
      beadedCount: fields[4] as int,
      createdTime: fields[5] as DateTime?,
      badges: (fields[6] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, Beads obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.bead)
      ..writeByte(2)
      ..write(obj.meaning)
      ..writeByte(3)
      ..write(obj.prefCount)
      ..writeByte(4)
      ..write(obj.beadedCount)
      ..writeByte(5)
      ..write(obj.createdTime)
      ..writeByte(6)
      ..write(obj.badges);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BeadsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
