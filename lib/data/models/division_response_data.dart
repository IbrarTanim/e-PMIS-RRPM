// To parse this JSON data, do
//
//     final divisionResponse = divisionResponseFromJson(jsonString);

import 'dart:convert';

DivisionResponse divisionResponseFromJson(String str) => DivisionResponse.fromJson(json.decode(str));

String divisionResponseToJson(DivisionResponse data) => json.encode(data.toJson());

class DivisionResponse {
  List<ValueObject>? divisions;
  List<ValueObject>? agencies;

  DivisionResponse({
    this.divisions,
    this.agencies,
  });

  factory DivisionResponse.fromJson(Map<String, dynamic> json) => DivisionResponse(
    divisions: json["divisions"] == null ? [] : List<ValueObject>.from(json["divisions"]!.map((x) => ValueObject.fromJson(x))),
    agencies:  json["agencies"] == null ? [] : List<ValueObject>.from(json["agencies"]!.map((x) => ValueObject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "divisions": divisions == null ? [] : List<dynamic>.from(divisions!.map((x) => x.toJson())),
    "agencies": agencies == null ? [] : List<dynamic>.from(agencies!.map((x) => x.toJson())),
  };
}

//test

class ValueObject {
  String? value;
  String? text;

  ValueObject({
    this.value,
    this.text,
  });

  factory ValueObject.fromJson(Map<String, dynamic> json) => ValueObject(
    value: json["value"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "text": text,
  };
}
