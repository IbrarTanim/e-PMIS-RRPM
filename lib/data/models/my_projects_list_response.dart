// To parse this JSON data, do
//
//     final myProjectsListResponse = myProjectsListResponseFromJson(jsonString);

import 'dart:convert';

MyProjectsResponse myProjectsListResponseFromJson(String str) => MyProjectsResponse.fromJson(json.decode(str));

String myProjectsListResponseToJson(MyProjectsResponse data) => json.encode(data.toJson());

class MyProjectsResponse {
  MyProjectsResponse({
    this.projectId,
    this.name,
    this.nameBangla,
    this.shortName,
    this.shortNameBangla,
    this.code,
    this.ministryId,
    this.ministryName,
    this.divisionId,
    this.divisionName,
    this.agencyId,
    this.agencyName,
    this.hasMultipleAgency,
    this.isSelfFinanced,
    this.adpSectorId,
    this.adpSectorName,
    this.adpSubSectorId,
    this.adpSubSectorName,
    this.hasForeignLocation,
    this.projectTypeId,
    this.projectTypeName,
    this.currentProjectRevisionNo,
    this.projectNatureId,
    this.projectNatureName,
    this.umbrellaProjectId,
    this.umbrellaProjectName,
    this.programId,
    this.programName,
    this.developmentPlanTypeId,
    this.developmentPlanTypeName,
    this.isOnlyForGobProject,
    this.dateOfCommencement,
    this.dateOfCompletion,
    this.projectOfficeId,
    this.statusId,
    this.statusName,
    this.isFastTrack,
    this.userRoleTitle,
  });

  String? projectId;
  String? name;
  String? nameBangla;
  dynamic shortName;
  dynamic shortNameBangla;
  String? code;
  String? ministryId;
  String? ministryName;
  dynamic divisionId;
  dynamic divisionName;
  String? agencyId;
  String? agencyName;
  bool? hasMultipleAgency;
  dynamic isSelfFinanced;
  String? adpSectorId;
  String? adpSectorName;
  dynamic adpSubSectorId;
  dynamic adpSubSectorName;
  bool? hasForeignLocation;
  String? projectTypeId;
  String? projectTypeName;
  int? currentProjectRevisionNo;
  String? projectNatureId;
  String? projectNatureName;
  String? umbrellaProjectId;
  String? umbrellaProjectName;
  String? programId;
  String? programName;
  dynamic developmentPlanTypeId;
  dynamic developmentPlanTypeName;
  bool? isOnlyForGobProject;
  DateTime? dateOfCommencement;
  DateTime? dateOfCompletion;
  String? projectOfficeId;
  String? statusId;
  String? statusName;
  bool? isFastTrack;
  String? userRoleTitle;

  factory MyProjectsResponse.fromJson(Map<String, dynamic> json) => MyProjectsResponse(
    projectId: json["project_id"],
    name: json["name"],
    nameBangla: json["name_bangla"],
    shortName: json["short_name"],
    shortNameBangla: json["short_name_bangla"],
    code: json["code"],
    ministryId: json["ministry_id"],
    ministryName: json["ministry_name"],
    divisionId: json["division_id"],
    divisionName: json["division_name"],
    agencyId: json["agency_id"],
    agencyName: json["agency_name"],
    hasMultipleAgency: json["has_multiple_agency"],
    isSelfFinanced: json["is_self_financed"],
    adpSectorId: json["adp_sector_id"],
    adpSectorName: json["adp_sector_name"],
    adpSubSectorId: json["adp_sub_sector_id"],
    adpSubSectorName: json["adp_sub_sector_name"],
    hasForeignLocation: json["has_foreign_location"],
    projectTypeId: json["project_type_id"],
    projectTypeName: json["project_type_name"],
    currentProjectRevisionNo: json["current_project_revision_no"],
    projectNatureId: json["project_nature_id"],
    projectNatureName: json["project_nature_name"],
    umbrellaProjectId: json["umbrella_project_id"],
    umbrellaProjectName: json["umbrella_project_name"],
    programId: json["program_id"],
    programName: json["program_name"],
    developmentPlanTypeId: json["development_plan_type_id"],
    developmentPlanTypeName: json["development_plan_type_name"],
    isOnlyForGobProject: json["is_only_for_gob_project"],
    dateOfCommencement: DateTime.parse(json["date_of_commencement"]),
    dateOfCompletion: DateTime.parse(json["date_of_completion"]),
    projectOfficeId: json["project_office_id"],
    statusId: json["status_id"],
    statusName: json["status_name"],
    isFastTrack: json["is_fast_track"],
    userRoleTitle: json["user_role_title"],
  );

  Map<String, dynamic> toJson() => {
    "project_id": projectId,
    "name": name,
    "name_bangla": nameBangla,
    "short_name": shortName,
    "short_name_bangla": shortNameBangla,
    "code": code,
    "ministry_id": ministryId,
    "ministry_name": ministryName,
    "division_id": divisionId,
    "division_name": divisionName,
    "agency_id": agencyId,
    "agency_name": agencyName,
    "has_multiple_agency": hasMultipleAgency,
    "is_self_financed": isSelfFinanced,
    "adp_sector_id": adpSectorId,
    "adp_sector_name": adpSectorName,
    "adp_sub_sector_id": adpSubSectorId,
    "adp_sub_sector_name": adpSubSectorName,
    "has_foreign_location": hasForeignLocation,
    "project_type_id": projectTypeId,
    "project_type_name": projectTypeName,
    "current_project_revision_no": currentProjectRevisionNo,
    "project_nature_id": projectNatureId,
    "project_nature_name": projectNatureName,
    "umbrella_project_id": umbrellaProjectId,
    "umbrella_project_name": umbrellaProjectName,
    "program_id": programId,
    "program_name": programName,
    "development_plan_type_id": developmentPlanTypeId,
    "development_plan_type_name": developmentPlanTypeName,
    "is_only_for_gob_project": isOnlyForGobProject,
    "date_of_commencement": "${dateOfCommencement!.year.toString().padLeft(4, '0')}-${dateOfCommencement!.month.toString().padLeft(2, '0')}-${dateOfCommencement!.day.toString().padLeft(2, '0')}",
    "date_of_completion": "${dateOfCompletion!.year.toString().padLeft(4, '0')}-${dateOfCompletion!.month.toString().padLeft(2, '0')}-${dateOfCompletion!.day.toString().padLeft(2, '0')}",
    "project_office_id": projectOfficeId,
    "status_id": statusId,
    "status_name": statusName,
    "is_fast_track": isFastTrack,
    "user_role_title": userRoleTitle,
  };
}
