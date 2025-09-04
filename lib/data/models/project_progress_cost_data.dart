// To parse this JSON data, do
//
//     final projectProgressAndCostData = projectProgressAndCostDataFromJson(jsonString);

import 'dart:convert';

import '../../utils/number_util.dart';

ProjectProgressAndCostData projectProgressAndCostDataFromJson(String str) => ProjectProgressAndCostData.fromJson(json.decode(str));

String projectProgressAndCostDataToJson(ProjectProgressAndCostData data) => json.encode(data.toJson());

class ProjectProgressAndCostData {
  ProjectProgressAndCostData({
    this.projectTotalCost,
    this.currentYearAllocation,
    this.totalAllocation,
    this.currentYearExpenditure,
    this.totalExpenditure,
    this.financialProgress,
    this.physicalProgress,
    this.demandAdp,
    this.demandRadp,
  });

  int? projectTotalCost;
  int? currentYearAllocation;
  int? totalAllocation;
  int? currentYearExpenditure;
  int? totalExpenditure;
  int? financialProgress;
  int? physicalProgress;
  int? demandAdp;
  int? demandRadp;

  factory ProjectProgressAndCostData.fromJson(Map<String, dynamic> json) => ProjectProgressAndCostData(
    projectTotalCost: makeInt(json["project_total_cost"]),
    currentYearAllocation: makeInt(json["current_year_allocation"]),
    totalAllocation: makeInt(json["total_allocation"]),
    currentYearExpenditure: makeInt(json["current_year_expenditure"]),
    totalExpenditure: makeInt(json["total_expenditure"]),
    financialProgress: makeInt(json["financial_progress"]),
    physicalProgress: makeInt(json["physical_progress"]),
    demandAdp: makeInt(json["demand_adp"]),
    demandRadp: makeInt(json["demand_radp"]),
  );

  Map<String, dynamic> toJson() => {
    "project_total_cost": projectTotalCost,
    "current_year_allocation": currentYearAllocation,
    "total_allocation": totalAllocation,
    "current_year_expenditure": currentYearExpenditure,
    "total_expenditure": totalExpenditure,
    "financial_progress": financialProgress,
    "physical_progress": physicalProgress,
    "demand_adp": demandAdp,
    "demand_radp": demandRadp,
  };
}
