import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'asset_collection.g.dart';

@HiveType(typeId: 1)
class AssetCollection {
  @HiveField(0)
  String? projectId;
  @HiveField(1)
  String? projectName;
  @HiveField(2)
  String? imageName;
  @HiveField(3)
  String? imageCaption;
  @HiveField(4)
  String? imageSize;
  @HiveField(5)
  String? imageUrl;
  @HiveField(6)
  String? imageLatValue;
  @HiveField(7)
  String? imageLongValue;
  @HiveField(8)
  String? imagePickUpLocation;
  @HiveField(9)
  String? imageShootingDate;
  @HiveField(10)
  String? imageShootingTime;
  @HiveField(11)
  bool? isImageSynchronized;
  // @HiveField(12)
  // String? videoName;
  // @HiveField(12)
  // String? videoCaption;
  // @HiveField(13)
  // String? videoSize;
  // @HiveField(14)
  // String? videoUrl;
  // @HiveField(15)
  // String? videoLatValue;
  // @HiveField(16)
  // String? videoLongValue;
  // @HiveField(17)
  // String? videoPickUpLocation;
  // @HiveField(18)
  // String? videoPickUpDate;
  // @HiveField(19)
  // bool? isVideoSynchronized;

  AssetCollection({
    @required this.projectId,
    @required this.projectName,
    @required this.imageName,
    @required this.imageCaption,
    @required this.imageSize,
    @required this.imageUrl,
    @required this.imageLatValue,
    @required this.imageLongValue,
    @required this.imagePickUpLocation,
    @required this.imageShootingDate,
    @required this.imageShootingTime,
    @required this.isImageSynchronized,
    // @required this.videoName,
    // @required this.videoCaption,
    // @required this.videoSize,
    // @required this.videoUrl,
    // @required this.videoLatValue,
    // @required this.videoLongValue,
    // @required this.videoPickUpLocation,
    // @required this.videoPickUpDate,
    // @required this.isVideoSynchronized,
  });
}
