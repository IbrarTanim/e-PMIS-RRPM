// To parse this JSON data, do
//
//     final agencyListResponse = agencyListResponseFromJson(jsonString);

import 'dart:convert';

AgencyListResponse agencyListResponseFromJson(String str) =>
    AgencyListResponse.fromJson(json.decode(str));

String agencyListResponseToJson(AgencyListResponse data) =>
    json.encode(data.toJson());

class AgencyListResponse {
  AgencyListResponse({
    this.value,
    this.text,
  });

  String? value;
  String? text;

  factory AgencyListResponse.fromJson(Map<String, dynamic> json) =>
      AgencyListResponse(
        value: json["value"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "text": text,
      };
}
