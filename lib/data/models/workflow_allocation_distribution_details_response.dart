// To parse this JSON data, do
//
//     final workflowAllocationDistributionDetailsResponse = workflowAllocationDistributionDetailsResponseFromJson(jsonString);

import 'dart:convert';

WorkflowAllocationDistributionDetailsResponse workflowAllocationDistributionDetailsResponseFromJson(String str) => WorkflowAllocationDistributionDetailsResponse.fromJson(json.decode(str));

String workflowAllocationDistributionDetailsResponseToJson(WorkflowAllocationDistributionDetailsResponse data) => json.encode(data.toJson());

class WorkflowAllocationDistributionDetailsResponse {
  String? projectRatificationId;
  String? projectId;
  String? fiscalYearId;
  String? developmentTypeId;
  String? developmentTypeName;
  DateTime? timestamp;
  String? status;
  int? totalAmount;
  int? demandAmount;
  int? allocationAmount;
  List<EconomicCodeGroupAllocationDistribution>? economicCodeGroupAllocationDistribution;

  WorkflowAllocationDistributionDetailsResponse({
    this.projectRatificationId,
    this.projectId,
    this.fiscalYearId,
    this.developmentTypeId,
    this.developmentTypeName,
    this.timestamp,
    this.status,
    this.totalAmount,
    this.demandAmount,
    this.allocationAmount,
    this.economicCodeGroupAllocationDistribution,
  });

  factory WorkflowAllocationDistributionDetailsResponse.fromJson(Map<String, dynamic> json) => WorkflowAllocationDistributionDetailsResponse(
    projectRatificationId: json["project_ratification_id"],
    projectId: json["project_id"],
    fiscalYearId: json["fiscal_year_id"],
    developmentTypeId: json["development_type_id"],
    developmentTypeName: json["development_type_name"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    status: json["status"],
    totalAmount: json["total_amount"]?.round(),
    demandAmount: json["demand_amount"]?.round(),
    allocationAmount: json["allocation_amount"]?.round(),
    economicCodeGroupAllocationDistribution: json["economic_code_group"] == null ? [] : List<EconomicCodeGroupAllocationDistribution>.from(json["economic_code_group"]!.map((x) => EconomicCodeGroupAllocationDistribution.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "project_ratification_id": projectRatificationId,
    "project_id": projectId,
    "fiscal_year_id": fiscalYearId,
    "development_type_id": developmentTypeId,
    "development_type_name": developmentTypeName,
    "timestamp": timestamp?.toIso8601String(),
    "status": status,
    "total_amount": totalAmount,
    "demand_amount": demandAmount,
    "allocation_amount": allocationAmount,
    "economic_code_group": economicCodeGroupAllocationDistribution == null ? [] : List<dynamic>.from(economicCodeGroupAllocationDistribution!.map((x) => x.toJson())),
  };
}

class EconomicCodeGroupAllocationDistribution {
  String? economicCodesTypeId;
  String? economicCodesTypeName;
  String? economicCodesTypeNameBangla;
  List<ProjectRatificationEconomicCode>? projectRatificationEconomicCodes;

  EconomicCodeGroupAllocationDistribution({
    this.economicCodesTypeId,
    this.economicCodesTypeName,
    this.economicCodesTypeNameBangla,
    this.projectRatificationEconomicCodes,
  });

  factory EconomicCodeGroupAllocationDistribution.fromJson(Map<String, dynamic> json) => EconomicCodeGroupAllocationDistribution(
    economicCodesTypeId: json["economic_codes_type_id"],
    economicCodesTypeName: json["economic_codes_type_name"],
    economicCodesTypeNameBangla: json["economic_codes_type_name_bangla"],
    projectRatificationEconomicCodes: json["project_ratification_economic_codes"] == null ? [] : List<ProjectRatificationEconomicCode>.from(json["project_ratification_economic_codes"]!.map((x) => ProjectRatificationEconomicCode.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "economic_codes_type_id": economicCodesTypeId,
    "economic_codes_type_name": economicCodesTypeName,
    "economic_codes_type_name_bangla": economicCodesTypeNameBangla,
    "project_ratification_economic_codes": projectRatificationEconomicCodes == null ? [] : List<dynamic>.from(projectRatificationEconomicCodes!.map((x) => x.toJson())),
  };
}

class ProjectRatificationEconomicCode {
  String? projectRatificationEconomicCodeId;
  String? baseEconomicCodesId;
  String? baseEconomicCode;
  String? baseEconomicCodesDescription;
  String? baseEconomicCodesDescriptionBangla;
  String? baseEconomicCodesParentId;
  String? baseEconomicParentCode;
  String? baseEconomicCodesParentDescription;
  String? description;
  int? total;
  int? sequenceNo;
  List<RatificationFinancialDetail>? ratificationFinancialDetails;

  ProjectRatificationEconomicCode({
    this.projectRatificationEconomicCodeId,
    this.baseEconomicCodesId,
    this.baseEconomicCode,
    this.baseEconomicCodesDescription,
    this.baseEconomicCodesDescriptionBangla,
    this.baseEconomicCodesParentId,
    this.baseEconomicParentCode,
    this.baseEconomicCodesParentDescription,
    this.description,
    this.total,
    this.sequenceNo,
    this.ratificationFinancialDetails,
  });

  factory ProjectRatificationEconomicCode.fromJson(Map<String, dynamic> json) => ProjectRatificationEconomicCode(
    projectRatificationEconomicCodeId: json["project_ratification_economic_code_id"],
    baseEconomicCodesId: json["base_economic_codes_id"],
    baseEconomicCode: json["base_economic_code"],
    baseEconomicCodesDescription: json["base_economic_codes_description"],
    baseEconomicCodesDescriptionBangla: json["base_economic_codes_description_bangla"],
    baseEconomicCodesParentId: json["base_economic_codes_parent_id"],
    baseEconomicParentCode: json["base_economic_parent_code"],
    baseEconomicCodesParentDescription: json["base_economic_codes_parent_description"],
    description: json["description"],
    total: json["total"]?.round(),
    sequenceNo: json["sequence_no"]?.round(),
    ratificationFinancialDetails: json["ratification_financial_details"] == null ? [] : List<RatificationFinancialDetail>.from(json["ratification_financial_details"]!.map((x) => RatificationFinancialDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "project_ratification_economic_code_id": projectRatificationEconomicCodeId,
    "base_economic_codes_id": baseEconomicCodesId,
    "base_economic_code": baseEconomicCode,
    "base_economic_codes_description": baseEconomicCodesDescription,
    "base_economic_codes_description_bangla": baseEconomicCodesDescriptionBangla,
    "base_economic_codes_parent_id": baseEconomicCodesParentId,
    "base_economic_parent_code": baseEconomicParentCode,
    "base_economic_codes_parent_description": baseEconomicCodesParentDescription,
    "description": description,
    "total": total,
    "sequence_no": sequenceNo,
    "ratification_financial_details": ratificationFinancialDetails == null ? [] : List<dynamic>.from(ratificationFinancialDetails!.map((x) => x.toJson())),
  };
}

class RatificationFinancialDetail {
  String? projectRatificationFinancialSourceId;
  String? baseProjectFinancialSourceId;
  int? sequenceNo;
  String? baseProjectFinancialSourceName;
  int? amountLocal;
  int? amountFe;
  int? amountTotal;
  int? demandAmountLocal;
  int? demandAmountFe;
  int? allocationAmountLocal;
  int? allocationAmountFe;

  RatificationFinancialDetail({
    this.projectRatificationFinancialSourceId,
    this.baseProjectFinancialSourceId,
    this.sequenceNo,
    this.baseProjectFinancialSourceName,
    this.amountLocal,
    this.amountFe,
    this.amountTotal,
    this.demandAmountLocal,
    this.demandAmountFe,
    this.allocationAmountLocal,
    this.allocationAmountFe,
  });

  factory RatificationFinancialDetail.fromJson(Map<String, dynamic> json) => RatificationFinancialDetail(
    projectRatificationFinancialSourceId: json["project_ratification_financial_source_id"],
    baseProjectFinancialSourceId: json["base_project_financial_source_id"],
    sequenceNo: json["sequence_no"],
    baseProjectFinancialSourceName: json["base_project_financial_source_name"],
    amountLocal: json["amount_local"]?.round(),
    amountFe: json["amount_fe"]?.round(),
    amountTotal: json["amount_total"]?.round(),
    demandAmountLocal: json["demand_amount_local"]?.round(),
    demandAmountFe: json["demand_amount_fe"]?.round(),
    allocationAmountLocal: json["allocation_amount_local"]?.round(),
    allocationAmountFe: json["allocation_amount_fe"]?.round(),
  );

  Map<String, dynamic> toJson() => {
    "project_ratification_financial_source_id": projectRatificationFinancialSourceId,
    "base_project_financial_source_id": baseProjectFinancialSourceId,
    "sequence_no": sequenceNo,
    "base_project_financial_source_name": baseProjectFinancialSourceName,
    "amount_local": amountLocal,
    "amount_fe": amountFe,
    "amount_total": amountTotal,
    "demand_amount_local": demandAmountLocal,
    "demand_amount_fe": demandAmountFe,
    "allocation_amount_local": allocationAmountLocal,
    "allocation_amount_fe": allocationAmountFe,
  };
}
