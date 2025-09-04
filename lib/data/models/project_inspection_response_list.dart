// To parse this JSON data, do
//
//     final projectInspectionResponseList = projectInspectionResponseListFromJson(jsonString);

import 'dart:convert';

ProjectInspectionResponseList projectInspectionResponseListFromJson(String str) => ProjectInspectionResponseList.fromJson(json.decode(str));

String projectInspectionResponseListToJson(ProjectInspectionResponseList data) => json.encode(data.toJson());

class ProjectInspectionResponseList {
  ProjectInspectionResponseList({
    this.projectInspectionId,
    this.projectId,
    this.timestamp,
    this.sectorId,
    this.sectorName,
    this.fiscalYearId,
    this.inspectorUserId,
    this.inspectorUserFullName,
    this.inspectionDate,
    this.inspectionLocation,
    this.inspectorDesignation,
    this.previousInspectionId,
    this.financialDeviationRate,
    this.projectOfficeLocation,
    this.pmisLastEntryDate,
    this.comments,
  });

  String? projectInspectionId;
  String? projectId;
  DateTime? timestamp;
  String? sectorId;
  dynamic sectorName;
  String? fiscalYearId;
  String? inspectorUserId;
  String? inspectorUserFullName;
  DateTime? inspectionDate;
  String? inspectionLocation;
  String? inspectorDesignation;
  dynamic previousInspectionId;
  dynamic financialDeviationRate;
  dynamic projectOfficeLocation;
  dynamic pmisLastEntryDate;
  dynamic comments;

  factory ProjectInspectionResponseList.fromJson(Map<String, dynamic> json) => ProjectInspectionResponseList(
    projectInspectionId: json["project_inspection_id"],
    projectId: json["project_id"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    sectorId: json["sector_id"],
    sectorName: json["sector_name"],
    fiscalYearId: json["fiscal_year_id"],
    inspectorUserId: json["inspector_user_id"],
    inspectorUserFullName: json["inspector_user_full_name"],
    inspectionDate: json["inspection_date"] == null ? null : DateTime.parse(json["inspection_date"]),
    inspectionLocation: json["inspection_location"],
    inspectorDesignation: json["inspector_designation"],
    previousInspectionId: json["previous_inspection_id"],
    financialDeviationRate: json["financial_deviation_rate"],
    projectOfficeLocation: json["project_office_location"],
    pmisLastEntryDate: json["pmis_last_entry_date"],
    comments: json["comments"],
  );

  Map<String, dynamic> toJson() => {
    "project_inspection_id": projectInspectionId,
    "project_id": projectId,
    "timestamp": timestamp?.toIso8601String(),
    "sector_id": sectorId,
    "sector_name": sectorName,
    "fiscal_year_id": fiscalYearId,
    "inspector_user_id": inspectorUserId,
    "inspector_user_full_name": inspectorUserFullName,
    "inspection_date": "${inspectionDate!.year.toString().padLeft(4, '0')}-${inspectionDate!.month.toString().padLeft(2, '0')}-${inspectionDate!.day.toString().padLeft(2, '0')}",
    "inspection_location": inspectionLocation,
    "inspector_designation": inspectorDesignation,
    "previous_inspection_id": previousInspectionId,
    "financial_deviation_rate": financialDeviationRate,
    "project_office_location": projectOfficeLocation,
    "pmis_last_entry_date": pmisLastEntryDate,
    "comments": comments,
  };
}
