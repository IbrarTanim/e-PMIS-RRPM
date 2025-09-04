// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_collection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssetCollectionAdapter extends TypeAdapter<AssetCollection> {
  @override
  final int typeId = 1;

  @override
  AssetCollection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssetCollection(
      projectId: fields[0] as String?,
      projectName: fields[1] as String?,
      imageName: fields[2] as String?,
      imageCaption: fields[3] as String?,
      imageSize: fields[4] as String?,
      imageUrl: fields[5] as String?,
      imageLatValue: fields[6] as String?,
      imageLongValue: fields[7] as String?,
      imagePickUpLocation: fields[8] as String?,
      imageShootingDate: fields[9] as String?,
      imageShootingTime: fields[10] as String?,
      isImageSynchronized: fields[11] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, AssetCollection obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.projectId)
      ..writeByte(1)
      ..write(obj.projectName)
      ..writeByte(2)
      ..write(obj.imageName)
      ..writeByte(3)
      ..write(obj.imageCaption)
      ..writeByte(4)
      ..write(obj.imageSize)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.imageLatValue)
      ..writeByte(7)
      ..write(obj.imageLongValue)
      ..writeByte(8)
      ..write(obj.imagePickUpLocation)
      ..writeByte(9)
      ..write(obj.imageShootingDate)
      ..writeByte(10)
      ..write(obj.imageShootingTime)
      ..writeByte(11)
      ..write(obj.isImageSynchronized);
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
