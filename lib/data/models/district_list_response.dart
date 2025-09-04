// To parse this JSON data, do
//
//     final districtListResponse = districtListResponseFromJson(jsonString);

import 'dart:convert';

DistrictListResponse districtListResponseFromJson(String str) => DistrictListResponse.fromJson(json.decode(str));

String districtListResponseToJson(DistrictListResponse data) => json.encode(data.toJson());

class DistrictListResponse {
  DistrictListResponse({
    this.baseLocationId,
    this.name,
    this.nameBn,
    this.category,
    this.type,
  });

  String? baseLocationId;
  String? name;
  String? nameBn;
  String? category;
  String? type;

  factory DistrictListResponse.fromJson(Map<String, dynamic> json) => DistrictListResponse(
    baseLocationId: json["base_location_id"],
    name: json["name"],
    nameBn: json["name_bn"],
    category: json["category"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "base_location_id": baseLocationId,
    "name": name,
    "name_bn": nameBn,
    "category": category,
    "type": type,
  };
}
