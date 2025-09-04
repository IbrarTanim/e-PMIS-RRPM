// To parse this JSON data, do
//
//     final wishListProjectDetailsResponse = wishListProjectDetailsResponseFromJson(jsonString);

import 'dart:convert';

WishListProjectDetailsResponse wishListProjectDetailsResponseFromJson(String str) => WishListProjectDetailsResponse.fromJson(json.decode(str));

String wishListProjectDetailsResponseToJson(WishListProjectDetailsResponse data) => json.encode(data.toJson());

class WishListProjectDetailsResponse {
  int? projectTotalCost;
  int? projectTotalCostGob;
  int? currentYearAllocation;
  int? totalAllocation;
  int? currentYearExpenditure;
  int? totalExpenditure;
  //double? totalExpenditure;
  double? financialProgress;
  //int? physicalProgress;
  double? physicalProgress;
  int? demandAdp;
  int? demandRadp;

  WishListProjectDetailsResponse({
    this.projectTotalCost,
    this.projectTotalCostGob,
    this.currentYearAllocation,
    this.totalAllocation,
    this.currentYearExpenditure,
    this.totalExpenditure,
    this.financialProgress,
    this.physicalProgress,
    this.demandAdp,
    this.demandRadp,
  });

  factory WishListProjectDetailsResponse.fromJson(Map<String, dynamic> json) => WishListProjectDetailsResponse(
    projectTotalCost: json["project_total_cost"]?.round(),
    projectTotalCostGob: json["project_total_cost_gob"]?.round(),
    currentYearAllocation: json["current_year_allocation"]?.round(),
    totalAllocation: json["total_allocation"]?.round(),
    currentYearExpenditure: json["current_year_expenditure"]?.round(),
    totalExpenditure: json["total_expenditure"]?.round(),
    financialProgress: json["financial_progress"]?.toDouble(),
    //physicalProgress: json["physical_progress"]?.round(),
    physicalProgress: json["physical_progress"]?.toDouble(),
    demandAdp: json["demand_adp"]?.round(),
    demandRadp: json["demand_radp"]?.round(),
  );

  Map<String, dynamic> toJson() => {
    "project_total_cost": projectTotalCost,
    "project_total_cost_gob": projectTotalCostGob,
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
