// To parse this JSON data, do
//
//     final projectsSearchResponse = projectsSearchResponseFromJson(jsonString);

import 'dart:convert';

ProjectsSearchResponse projectsSearchResponseFromJson(String str) => ProjectsSearchResponse.fromJson(json.decode(str));

String projectsSearchResponseToJson(ProjectsSearchResponse data) => json.encode(data.toJson());

class ProjectsSearchResponse {
  ProjectsSearchResponse({
    this.paginationDto,
    this.projectSearchDto,
  });

  PaginationDto? paginationDto;
  ProjectSearchDto? projectSearchDto;

  factory ProjectsSearchResponse.fromJson(Map<String, dynamic> json) => ProjectsSearchResponse(
    paginationDto: PaginationDto.fromJson(json["pagination_dto"]),
    projectSearchDto: ProjectSearchDto.fromJson(json["project_search_dto"]),
  );

  Map<String, dynamic> toJson() => {
    "pagination_dto": paginationDto!.toJson(),
    "project_search_dto": projectSearchDto!.toJson(),
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

class ProjectSearchDto {
  ProjectSearchDto({
    this.adpSectorId,
    this.adpSubSectorId,
    this.agencyId,
    this.code,
    this.currentProjectRevisionNo,
    this.dateOfCommencement,
    this.dateOfCompletion,
    this.developmentPlanTypeId,
    this.divisionId,
    this.districtId,
    this.fiscalYearId,
    this.hasForeignLocation,
    this.hasMultipleAgency,
    this.isOnlyForGobProject,
    this.isSelfFinanced,
    this.ministryId,
    this.ministryName,
    this.name,
    this.programId,
    this.projectNatureId,
    this.projectOfficeId,
    this.projectTypeId,
    this.umbrellaProjectId,
    this.statusName,
    this.isFastTrack,
  });

  String? adpSectorId;
  String? adpSubSectorId;
  String? agencyId;
  String? code;
  int? currentProjectRevisionNo;
  dynamic dateOfCommencement;
  dynamic dateOfCompletion;
  String? developmentPlanTypeId;
  String? divisionId;
  String? districtId;
  String? fiscalYearId;
  dynamic hasForeignLocation;
  dynamic hasMultipleAgency;
  dynamic isOnlyForGobProject;
  dynamic isSelfFinanced;
  String? ministryId;
  String? ministryName;
  String? name;
  String? programId;
  String? projectNatureId;
  String? projectOfficeId;
  String? projectTypeId;
  String? umbrellaProjectId;
  String? statusName;
  dynamic isFastTrack;

  factory ProjectSearchDto.fromJson(Map<String, dynamic> json) => ProjectSearchDto(
    adpSectorId: json["adp_sector_id"],
    adpSubSectorId: json["adp_sub_sector_id"],
    agencyId: json["agency_id"],
    code: json["code"],
    currentProjectRevisionNo: json["current_project_revision_no"],
    dateOfCommencement: json["date_of_commencement"],
    dateOfCompletion: json["date_of_completion"],
    developmentPlanTypeId: json["development_plan_type_id"],
    divisionId: json["division_id"],
    districtId: json["district_id"],
    fiscalYearId: json["fiscal_year_id"],
    hasForeignLocation: json["has_foreign_location"],
    hasMultipleAgency: json["has_multiple_agency"],
    isOnlyForGobProject: json["is_only_for_gob_project"],
    isSelfFinanced: json["is_self_financed"],
    ministryId: json["ministry_id"],
    ministryName: json["ministry_name"],
    name: json["name"],
    programId: json["program_id"],
    projectNatureId: json["project_nature_id"],
    projectOfficeId: json["project_office_id"],
    projectTypeId: json["project_type_id"],
    umbrellaProjectId: json["umbrella_project_id"],
    statusName: json["status_name"],
    isFastTrack: json["is_fast_track"],
  );

  Map<String, dynamic> toJson() => {
    "adp_sector_id": adpSectorId,
    "adp_sub_sector_id": adpSubSectorId,
    "agency_id": agencyId,
    "code": code,
    "current_project_revision_no": currentProjectRevisionNo,
    "date_of_commencement": dateOfCommencement,
    "date_of_completion": dateOfCompletion,
    "development_plan_type_id": developmentPlanTypeId,
    "division_id": divisionId,
    "district_id": districtId,
    "fiscal_year_id": fiscalYearId,
    "has_foreign_location": hasForeignLocation,
    "has_multiple_agency": hasMultipleAgency,
    "is_only_for_gob_project": isOnlyForGobProject,
    "is_self_financed": isSelfFinanced,
    "ministry_id": ministryId,
    "ministry_name": ministryName,
    "name": name,
    "program_id": programId,
    "project_nature_id": projectNatureId,
    "project_office_id": projectOfficeId,
    "project_type_id": projectTypeId,
    "umbrella_project_id": umbrellaProjectId,
    "status_name": statusName,
    "is_fast_track": isFastTrack,
  };
}
