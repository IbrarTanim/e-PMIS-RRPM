// To parse this JSON data, do
//
//     final projectsListResponse = projectsListResponseFromJson(jsonString);

import 'dart:convert';

ProjectsListResponse projectsListResponseFromJson(String str) => ProjectsListResponse.fromJson(json.decode(str));

String projectsListResponseToJson(ProjectsListResponse data) => json.encode(data.toJson());

class ProjectsListResponse {
  String? projectId;
  dynamic isSelfFinanced;
  String? adpSectorId;
  String? adpSectorName;
  String? adpSubSectorId;
  String? adpSubSectorName;
  String? agencyId;
  String? agencyName;
  String? code;
  String? developmentPlanTypeId;
  String? developmentPlanTypeName;
  String? divisionId;
  String? divisionName;
  bool? hasForeignLocation;
  bool? hasMultipleAgency;
  String? ministryId;
  String? ministryName;
  String? name;
  String? nameBangla;
  dynamic programId;
  dynamic programName;
  dynamic projectNatureId;
  dynamic projectNatureName;
  dynamic shortName;
  dynamic shortNameBangla;
  dynamic umbrellaProjectId;
  dynamic umbrellaProjectName;
  String? projectTypeName;
  String? projectTypeId;
  int? currentProjectRevisionNo;
  bool? isOnlyForGobProject;
  DateTime? dateOfCommencement;
  DateTime? dateOfCompletion;
  String? statusId;
  String? statusName;
  bool? isFastTrack;
  String? userRoleTitle;
  String? projectSpecificRole;

  ProjectsListResponse({
    this.projectId,
    this.isSelfFinanced,
    this.adpSectorId,
    this.adpSectorName,
    this.adpSubSectorId,
    this.adpSubSectorName,
    this.agencyId,
    this.agencyName,
    this.code,
    this.developmentPlanTypeId,
    this.developmentPlanTypeName,
    this.divisionId,
    this.divisionName,
    this.hasForeignLocation,
    this.hasMultipleAgency,
    this.ministryId,
    this.ministryName,
    this.name,
    this.nameBangla,
    this.programId,
    this.programName,
    this.projectNatureId,
    this.projectNatureName,
    this.shortName,
    this.shortNameBangla,
    this.umbrellaProjectId,
    this.umbrellaProjectName,
    this.projectTypeName,
    this.projectTypeId,
    this.currentProjectRevisionNo,
    this.isOnlyForGobProject,
    this.dateOfCommencement,
    this.dateOfCompletion,
    this.statusId,
    this.statusName,
    this.isFastTrack,
    this.userRoleTitle,
    this.projectSpecificRole,
  });

  factory ProjectsListResponse.fromJson(Map<String, dynamic> json) => ProjectsListResponse(
    projectId: json["project_id"],
    isSelfFinanced: json["is_self_financed"],
    adpSectorId: json["adp_sector_id"],
    adpSectorName: json["adp_sector_name"],
    adpSubSectorId: json["adp_sub_sector_id"],
    adpSubSectorName: json["adp_sub_sector_name"],
    agencyId: json["agency_id"],
    agencyName: json["agency_name"],
    code: json["code"],
    developmentPlanTypeId: json["development_plan_type_id"],
    developmentPlanTypeName: json["development_plan_type_name"],
    divisionId: json["division_id"],
    divisionName: json["division_name"],
    hasForeignLocation: json["has_foreign_location"],
    hasMultipleAgency: json["has_multiple_agency"],
    ministryId: json["ministry_id"],
    ministryName: json["ministry_name"],
    name: json["name"],
    nameBangla: json["name_bangla"],
    programId: json["program_id"],
    programName: json["program_name"],
    projectNatureId: json["project_nature_id"],
    projectNatureName: json["project_nature_name"],
    shortName: json["short_name"],
    shortNameBangla: json["short_name_bangla"],
    umbrellaProjectId: json["umbrella_project_id"],
    umbrellaProjectName: json["umbrella_project_name"],
    projectTypeName: json["project_type_name"],
    projectTypeId: json["project_type_id"],
    currentProjectRevisionNo: json["current_project_revision_no"]?.round(),
    isOnlyForGobProject: json["is_only_for_gob_project"],
    dateOfCommencement: json["date_of_commencement"] == null ? null : DateTime.parse(json["date_of_commencement"]),
    dateOfCompletion: json["date_of_completion"] == null ? null : DateTime.parse(json["date_of_completion"]),
    statusId: json["status_id"],
    statusName: json["status_name"],
    isFastTrack: json["is_fast_track"],
    userRoleTitle: json["user_role_title"],
    projectSpecificRole: json["project_specific_role"],
  );

  Map<String, dynamic> toJson() => {
    "project_id": projectId,
    "is_self_financed": isSelfFinanced,
    "adp_sector_id": adpSectorId,
    "adp_sector_name": adpSectorName,
    "adp_sub_sector_id": adpSubSectorId,
    "adp_sub_sector_name": adpSubSectorName,
    "agency_id": agencyId,
    "agency_name": agencyName,
    "code": code,
    "development_plan_type_id": developmentPlanTypeId,
    "development_plan_type_name": developmentPlanTypeName,
    "division_id": divisionId,
    "division_name": divisionName,
    "has_foreign_location": hasForeignLocation,
    "has_multiple_agency": hasMultipleAgency,
    "ministry_id": ministryId,
    "ministry_name": ministryName,
    "name": name,
    "name_bangla": nameBangla,
    "program_id": programId,
    "program_name": programName,
    "project_nature_id": projectNatureId,
    "project_nature_name": projectNatureName,
    "short_name": shortName,
    "short_name_bangla": shortNameBangla,
    "umbrella_project_id": umbrellaProjectId,
    "umbrella_project_name": umbrellaProjectName,
    "project_type_name": projectTypeName,
    "project_type_id": projectTypeId,
    "current_project_revision_no": currentProjectRevisionNo,
    "is_only_for_gob_project": isOnlyForGobProject,
    "date_of_commencement": "${dateOfCommencement!.year.toString().padLeft(4, '0')}-${dateOfCommencement!.month.toString().padLeft(2, '0')}-${dateOfCommencement!.day.toString().padLeft(2, '0')}",
    "date_of_completion": "${dateOfCompletion!.year.toString().padLeft(4, '0')}-${dateOfCompletion!.month.toString().padLeft(2, '0')}-${dateOfCompletion!.day.toString().padLeft(2, '0')}",
    "status_id": statusId,
    "status_name": statusName,
    "is_fast_track": isFastTrack,
    "user_role_title": userRoleTitle,
    "project_specific_role": projectSpecificRole,
  };
}
