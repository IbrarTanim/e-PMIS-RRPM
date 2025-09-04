// To parse this JSON data, do
//
//     final ministryListResponse = ministryListResponseFromJson(jsonString);

import 'dart:convert';

  MinistryListResponse ministryListResponseFromJson(String str) => MinistryListResponse.fromJson(json.decode(str));

String ministryListResponseToJson(MinistryListResponse data) => json.encode(data.toJson());

class MinistryListResponse {
  MinistryListResponse({
    this.value,
    this.text,
  });

  String? value;
  String? text;

  factory MinistryListResponse.fromJson(Map<String, dynamic> json) => MinistryListResponse(
    value: json["value"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "text": text,
  };
}
