// To parse this JSON data, do
//
//     final listResponse = listResponseFromJson(jsonString);

import 'dart:convert';

ListResponse listResponseFromJson(String str) => ListResponse.fromJson(json.decode(str));

String listResponseToJson(ListResponse data) => json.encode(data.toJson());

class ListResponse {
  ListResponse({
    this.lists,
    this.paginationDto,
  });

  List<dynamic>? lists;
  PaginationDto? paginationDto;

  factory ListResponse.fromJson(Map<String, dynamic> json) => ListResponse(
    lists: List<dynamic>.from(json["lists"].map((x) => x)),
    paginationDto: PaginationDto.fromJson(json["pagination_dto"]),
  );

  Map<String, dynamic> toJson() => {
    "lists": lists == null ? null : List<dynamic>.from(lists!.map((x) => x.toJson())),
    "pagination_dto": paginationDto!.toJson(),
  };
}

class PaginationDto {
  PaginationDto({
    this.current,
    this.pageSize,
    this.total,
  });

  int? current;
  int? pageSize;
  int? total;

  factory PaginationDto.fromJson(Map<String, dynamic> json) => PaginationDto(
    current: json["current"],
    pageSize: json["pageSize"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current": current,
    "pageSize": pageSize,
    "total": total,
  };
}
