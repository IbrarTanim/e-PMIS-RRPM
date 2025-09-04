

import 'dart:convert';

DivisionListResponse divisionListResponseFromJson(String str) =>
    DivisionListResponse.fromJson(json.decode(str));

String divisionListResponseToJson(DivisionListResponse data) =>
    json.encode(data.toJson());

class DivisionList {
  List<DivisionListResponse> divisions;
  dynamic agencies;

  DivisionList({
    required this.divisions,
    this.agencies,
  });

  factory DivisionList.fromJson(Map<String, dynamic> json) => DivisionList(
    divisions: List<DivisionListResponse>.from(json["divisions"].map((x) => DivisionListResponse.fromJson(x))),
    agencies: json["agencies"],
  );

  Map<String, dynamic> toJson() => {"divisions": List<dynamic>.from(divisions.map((x) => x.toJson())), "agencies": agencies,};
}


//test
class DivisionListResponse {
  DivisionListResponse({
    this.value,
    this.text,
  });

  String? value;
  String? text;

  factory DivisionListResponse.fromJson(Map<String, dynamic> json) =>
      DivisionListResponse(
        value: json["value"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
    "value": value,
    "text": text,
  };
}
