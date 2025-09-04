// To parse this JSON data, do
//
//     final projectAllocationCostResponse = projectAllocationCostResponseFromJson(jsonString);

import 'dart:convert';

ProjectAllocationCostResponse projectAllocationCostResponseFromJson(String str) => ProjectAllocationCostResponse.fromJson(json.decode(str));

String projectAllocationCostResponseToJson(ProjectAllocationCostResponse data) => json.encode(data.toJson());

class ProjectAllocationCostResponse {
  String? projectAllocationSummaryId;
  String? fiscalYearId;
  String? developmentTypeId;
  String? developmentTypeName;
  dynamic physicalProgressTarget;
  List<AllocationDetail>? allocationDetails;

  ProjectAllocationCostResponse({
    this.projectAllocationSummaryId,
    this.fiscalYearId,
    this.developmentTypeId,
    this.developmentTypeName,
    this.physicalProgressTarget,
    this.allocationDetails,
  });

  factory ProjectAllocationCostResponse.fromJson(Map<String, dynamic> json) => ProjectAllocationCostResponse(
    projectAllocationSummaryId: json["project_allocation_summary_id"],
    fiscalYearId: json["fiscal_year_id"],
    developmentTypeId: json["development_type_id"],
    developmentTypeName: json["development_type_name"],
    physicalProgressTarget: json["physical_progress_target"],
    allocationDetails: json["allocation_details"] == null ? [] : List<AllocationDetail>.from(json["allocation_details"]!.map((x) => AllocationDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "project_allocation_summary_id": projectAllocationSummaryId,
    "fiscal_year_id": fiscalYearId,
    "development_type_id": developmentTypeId,
    "development_type_name": developmentTypeName,
    "physical_progress_target": physicalProgressTarget,
    "allocation_details": allocationDetails == null ? [] : List<dynamic>.from(allocationDetails!.map((x) => x.toJson())),
  };
}

class AllocationDetail {
  String? econTypeId;
  int? amountGob;
  //int? amountGobFe;
  double? amountGobFe;
  int? amountRpa;
  int? amountDpa;
  int? amountOwnFund;
  int? amountOwnFundFe;
  int? amountCdVat;

  AllocationDetail({
    this.econTypeId,
    this.amountGob,
    this.amountGobFe,
    this.amountRpa,
    this.amountDpa,
    this.amountOwnFund,
    this.amountOwnFundFe,
    this.amountCdVat,
  });

  factory AllocationDetail.fromJson(Map<String, dynamic> json) => AllocationDetail(
    econTypeId: json["econ_type_id"],
    amountGob: json["amount_gob"]?.round(),
    //amountGobFe: json["amount_gob_fe"]?.round(),
    amountGobFe: (json["amount_gob_fe"] as num?)!.toDouble(),


    amountRpa: json["amount_rpa"]?.round(),
    amountDpa: json["amount_dpa"]?.round(),
    amountOwnFund: json["amount_own_fund"]?.round(),
    amountOwnFundFe: json["amount_own_fund_fe"]?.round(),
    amountCdVat: json["amount_cd_vat"]?.round(),
  );

  Map<String, dynamic> toJson() => {
    "econ_type_id": econTypeId,
    "amount_gob": amountGob,
    "amount_gob_fe": amountGobFe,
    "amount_rpa": amountRpa,
    "amount_dpa": amountDpa,
    "amount_own_fund": amountOwnFund,
    "amount_own_fund_fe": amountOwnFundFe,
    "amount_cd_vat": amountCdVat,
  };
}
