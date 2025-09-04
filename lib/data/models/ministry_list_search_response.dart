// // To parse this JSON data, do
// //
// //     final ministryListSearchResponse = ministryListSearchResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// MinistryListSearchResponse ministryListSearchResponseFromJson(String str) => MinistryListSearchResponse.fromJson(json.decode(str));
//
// String ministryListSearchResponseToJson(MinistryListSearchResponse data) => json.encode(data.toJson());
//
// class MinistryListSearchResponse {
//   MinistryListSearchResponse({
//     this.paginationDto,
//     this.projectSearchDto,
//   });
//
//   PaginationDto? paginationDto;
//   ProjectSearchDto? projectSearchDto;
//
//   factory MinistryListSearchResponse.fromJson(Map<String, dynamic> json) => MinistryListSearchResponse(
//     paginationDto: PaginationDto.fromJson(json["pagination_dto"]),
//     projectSearchDto: ProjectSearchDto.fromJson(json["project_search_dto"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "pagination_dto": paginationDto!.toJson(),
//     "project_search_dto": projectSearchDto!.toJson(),
//   };
// }
//
// class PaginationDto {
//   PaginationDto({
//     this.current,
//     this.pageSize,
//     this.total,
//   });
//
//   int? current;
//   int? pageSize;
//   int? total;
//
//   factory PaginationDto.fromJson(Map<String, dynamic> json) => PaginationDto(
//     current: json["current"],
//     pageSize: json["pageSize"],
//     total: json["total"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "current": current,
//     "pageSize": pageSize,
//     "total": total,
//   };
// }
//
// class ProjectSearchDto {
//   ProjectSearchDto({
//     required this.ministryId,
//   });
//
//   String ministryId;
//
//   factory ProjectSearchDto.fromJson(Map<String, dynamic> json) => ProjectSearchDto(
//     ministryId: json["ministry_id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "ministry_id": ministryId,
//   };
// }
