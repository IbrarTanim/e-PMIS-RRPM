// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_collection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssetCollectionAdapter extends TypeAdapter<AssetCollection> {
  @override
  final int typeId = 0;

  @override
  AssetCollection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssetCollection(
      userEmail: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, AssetCollection obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.userEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssetCollectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
