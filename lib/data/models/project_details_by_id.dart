// To parse this JSON data, do
//
//     final projectDetailsById = projectDetailsByIdFromJson(jsonString);

import 'dart:convert';

import 'package:pmis_flutter/utils/number_util.dart';

ProjectDetailsById projectDetailsByIdFromJson(String str) => ProjectDetailsById.fromJson(json.decode(str));

String projectDetailsByIdToJson(ProjectDetailsById data) => json.encode(data.toJson());

class ProjectDetailsById {
  ProjectDetailsById({
    this.isSelfFinanced,
    this.isFastTrack,
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
    this.concernedPlanningCommissionDivisionId,
    this.concernedPlanningCommissionDivisionName,
    this.projectTypeId,
    this.pcrStatus,
    this.projectTypeName,
    this.currentProjectRevisionNo,
    this.isOnlyForGobProject,
    this.dateOfCommencement,
    this.dateOfCompletion,
    this.hasOldData,
    this.projectTappContactInfo,
    this.developmentPartners,
    this.responsibleOfficers,
    this.projectAgencyMapping,
    this.objectives,
    this.projectExchangeRates,
    this.totalInvestment,
    this.loanAmount,
    this.projectDirector,
  });

  bool? isSelfFinanced;
  bool? isFastTrack;
  dynamic adpSectorId;
  dynamic adpSectorName;
  dynamic adpSubSectorId;
  dynamic adpSubSectorName;
  String? agencyId;
  String? agencyName;
  String? code;
  String? developmentPlanTypeId;
  dynamic developmentPlanTypeName;
  dynamic divisionId;
  dynamic divisionName;
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
  String? concernedPlanningCommissionDivisionId;
  dynamic concernedPlanningCommissionDivisionName;
  String? projectTypeId;
  String? pcrStatus;
  String? projectTypeName;
  int? currentProjectRevisionNo;
  bool? isOnlyForGobProject;
  DateTime? dateOfCommencement;
  DateTime? dateOfCompletion;
  bool? hasOldData;
  dynamic projectTappContactInfo;
  List<dynamic>? developmentPartners;
  List<dynamic>? responsibleOfficers;
  List<dynamic>? projectAgencyMapping;
  List<dynamic>? objectives;
  dynamic projectExchangeRates;
  double? totalInvestment;
  int? loanAmount;
  ProjectDirector? projectDirector;

  factory ProjectDetailsById.fromJson(Map<String, dynamic> json) => ProjectDetailsById(
    isSelfFinanced: json["is_self_financed"],
    isFastTrack: json["is_fast_track"],
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
    concernedPlanningCommissionDivisionId: json["concerned_planning_commission_division_id"],
    concernedPlanningCommissionDivisionName: json["concerned_planning_commission_division_name"],
    projectTypeId: json["project_type_id"],
    pcrStatus: json["pcr_status"],
    projectTypeName: json["project_type_name"],
    currentProjectRevisionNo: json["current_project_revision_no"],
    isOnlyForGobProject: json["is_only_for_gob_project"],
    dateOfCommencement: json["date_of_commencement"] == null ? null : DateTime.parse(json["date_of_commencement"]),
    dateOfCompletion: json["date_of_completion"] == null ? null : DateTime.parse(json["date_of_completion"]),
    hasOldData: json["has_old_data"],
    projectTappContactInfo: json["project_tapp_contact_info"],
    developmentPartners: json["development_partners"] == null ? [] : List<dynamic>.from(json["development_partners"]!.map((x) => x)),
    responsibleOfficers: json["responsible_officers"] == null ? [] : List<dynamic>.from(json["responsible_officers"]!.map((x) => x)),
    projectAgencyMapping: json["project_agency_mapping"] == null ? [] : List<dynamic>.from(json["project_agency_mapping"]!.map((x) => x)),
    objectives: json["objectives"] == null ? [] : List<dynamic>.from(json["objectives"]!.map((x) => x)),
    projectExchangeRates: json["project_exchange_rates"],
    totalInvestment: json["total_investment"]?.toDouble(),
    loanAmount: makeInt(json["loan_amount"]),
    projectDirector: json["project_director"] == null ? null : ProjectDirector.fromJson(json["project_director"]),
  );

  Map<String, dynamic> toJson() => {
    "is_self_financed": isSelfFinanced,
    "is_fast_track": isFastTrack,
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
    "concerned_planning_commission_division_id": concernedPlanningCommissionDivisionId,
    "concerned_planning_commission_division_name": concernedPlanningCommissionDivisionName,
    "project_type_id": projectTypeId,
    "pcr_status": pcrStatus,
    "project_type_name": projectTypeName,
    "current_project_revision_no": currentProjectRevisionNo,
    "is_only_for_gob_project": isOnlyForGobProject,
    "date_of_commencement": "${dateOfCommencement!.year.toString().padLeft(4, '0')}-${dateOfCommencement!.month.toString().padLeft(2, '0')}-${dateOfCommencement!.day.toString().padLeft(2, '0')}",
    "date_of_completion": "${dateOfCompletion!.year.toString().padLeft(4, '0')}-${dateOfCompletion!.month.toString().padLeft(2, '0')}-${dateOfCompletion!.day.toString().padLeft(2, '0')}",
    "has_old_data": hasOldData,
    "project_tapp_contact_info": projectTappContactInfo,
    "development_partners": developmentPartners == null ? [] : List<dynamic>.from(developmentPartners!.map((x) => x)),
    "responsible_officers": responsibleOfficers == null ? [] : List<dynamic>.from(responsibleOfficers!.map((x) => x)),
    "project_agency_mapping": projectAgencyMapping == null ? [] : List<dynamic>.from(projectAgencyMapping!.map((x) => x)),
    "objectives": objectives == null ? [] : List<dynamic>.from(objectives!.map((x) => x)),
    "project_exchange_rates": projectExchangeRates,
    "total_investment": totalInvestment,
    "loan_amount": loanAmount,
    "project_director": projectDirector?.toJson(),
  };
}

class ProjectDirector {
  ProjectDirector({
    this.pdUserId,
    this.firstName,
    this.lastName,
    this.designation,
    this.nid,
  });

  String? pdUserId;
  String? firstName;
  String? lastName;
  String? designation;
  String? nid;

  factory ProjectDirector.fromJson(Map<String, dynamic> json) => ProjectDirector(
    pdUserId: json["pd_user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    designation: json["designation"],
    nid: json["nid"],
  );

  Map<String, dynamic> toJson() => {
    "pd_user_id": pdUserId,
    "first_name": firstName,
    "last_name": lastName,
    "designation": designation,
    "nid": nid,
  };
}
