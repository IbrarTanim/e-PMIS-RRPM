import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user_collection.g.dart';

@HiveType(typeId: 0)
class AssetCollection {
  @HiveField(0)
  String? userEmail;

  AssetCollection({
    @required this.userEmail,
  });
}
