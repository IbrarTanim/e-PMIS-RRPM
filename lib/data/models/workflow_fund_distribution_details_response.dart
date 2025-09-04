
import 'dart:convert';

WorkflowFundDistributionDetailsResponse workflowFundDistributionDetailsResponseFromJson(String str) => WorkflowFundDistributionDetailsResponse.fromJson(json.decode(str));

String workflowFundDistributionDetailsResponseToJson(WorkflowFundDistributionDetailsResponse data) => json.encode(data.toJson());

class WorkflowFundDistributionDetailsResponse {
  String? fundDistriutionId;
  String? projectId;
  String? fiscalYearId;
  DateTime? timestamp;
  String? status;
  int? totalAmount;
  int? totalReleaseAmount;
  List<EconomicCodeGroupFundDistribution>? economicCodeGroupFundDistribution;

  WorkflowFundDistributionDetailsResponse({
    this.fundDistriutionId,
    this.projectId,
    this.fiscalYearId,
    this.timestamp,
    this.status,
    this.totalAmount,
    this.totalReleaseAmount,
    this.economicCodeGroupFundDistribution,
  });

  factory WorkflowFundDistributionDetailsResponse.fromJson(Map<String, dynamic> json) => WorkflowFundDistributionDetailsResponse(
    fundDistriutionId: json["fund_distriution_id"],
    projectId: json["project_id"],
    fiscalYearId: json["fiscal_year_id"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    status: json["status"],
    totalAmount: json["total_amount"]?.round(),
    totalReleaseAmount: json["total_release_amount"]?.round(),
    economicCodeGroupFundDistribution: json["economic_code_group"] == null ? [] : List<EconomicCodeGroupFundDistribution>.from(json["economic_code_group"]!.map((x) => EconomicCodeGroupFundDistribution.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fund_distriution_id": fundDistriutionId,
    "project_id": projectId,
    "fiscal_year_id": fiscalYearId,
    "timestamp": timestamp?.toIso8601String(),
    "status": status,
    "total_amount": totalAmount,
    "total_release_amount": totalReleaseAmount,
    "economic_code_group": economicCodeGroupFundDistribution == null ? [] : List<dynamic>.from(economicCodeGroupFundDistribution!.map((x) => x.toJson())),
  };
}

class EconomicCodeGroupFundDistribution {
  String? economicCodesTypeId;
  String? economicCodesTypeName;
  String? economicCodesTypeNameBangla;
  List<FundDistributionEconomicCode>? fundDistributionEconomicCodes;

  EconomicCodeGroupFundDistribution({
    this.economicCodesTypeId,
    this.economicCodesTypeName,
    this.economicCodesTypeNameBangla,
    this.fundDistributionEconomicCodes,
  });

  factory EconomicCodeGroupFundDistribution.fromJson(Map<String, dynamic> json) => EconomicCodeGroupFundDistribution(
    economicCodesTypeId: json["economic_codes_type_id"],
    economicCodesTypeName: json["economic_codes_type_name"],
    economicCodesTypeNameBangla: json["economic_codes_type_name_bangla"],
    fundDistributionEconomicCodes: json["fund_distribution_economic_codes"] == null ? [] : List<FundDistributionEconomicCode>.from(json["fund_distribution_economic_codes"]!.map((x) => FundDistributionEconomicCode.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "economic_codes_type_id": economicCodesTypeId,
    "economic_codes_type_name": economicCodesTypeName,
    "economic_codes_type_name_bangla": economicCodesTypeNameBangla,
    "fund_distribution_economic_codes": fundDistributionEconomicCodes == null ? [] : List<dynamic>.from(fundDistributionEconomicCodes!.map((x) => x.toJson())),
  };
}

class FundDistributionEconomicCode {
  String? fundDistributionEconomicCodeId;
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
  List<FundDistributionFinancialDetail>? fundDistributionFinancialDetails;

  FundDistributionEconomicCode({
    this.fundDistributionEconomicCodeId,
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
    this.fundDistributionFinancialDetails,
  });

  factory FundDistributionEconomicCode.fromJson(Map<String, dynamic> json) => FundDistributionEconomicCode(
    fundDistributionEconomicCodeId: json["fund_distribution_economic_code_id"],
    baseEconomicCodesId: json["base_economic_codes_id"],
    baseEconomicCode: json["base_economic_code"],
    baseEconomicCodesDescription: json["base_economic_codes_description"],
    baseEconomicCodesDescriptionBangla: json["base_economic_codes_description_bangla"],
    baseEconomicCodesParentId: json["base_economic_codes_parent_id"],
    baseEconomicParentCode: json["base_economic_parent_code"],
    baseEconomicCodesParentDescription: json["base_economic_codes_parent_description"],
    description: json["description"],
    total: json["total"]?.round(),
    sequenceNo: json["sequence_no"],
    fundDistributionFinancialDetails: json["fund_distribution_financial_details"] == null ? [] : List<FundDistributionFinancialDetail>.from(json["fund_distribution_financial_details"]!.map((x) => FundDistributionFinancialDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fund_distribution_economic_code_id": fundDistributionEconomicCodeId,
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
    "fund_distribution_financial_details": fundDistributionFinancialDetails == null ? [] : List<dynamic>.from(fundDistributionFinancialDetails!.map((x) => x.toJson())),
  };
}

class FundDistributionFinancialDetail {
  String? fundDistributionFinancialSourceId;
  String? baseProjectFinancialSourceId;
  int? sequenceNo;
  String? baseProjectFinancialSourceName;
  int? amountLocal;
  int? amountFe;
  int? allocationAmountLocal;
  int? allocationAmountFe;
  int? allocationDistributedAmountLocal;
  int? allocationDistributedAmountFe;
  int? releasedAmountLocal;
  int? releasedAmountFe;

  FundDistributionFinancialDetail({
    this.fundDistributionFinancialSourceId,
    this.baseProjectFinancialSourceId,
    this.sequenceNo,
    this.baseProjectFinancialSourceName,
    this.amountLocal,
    this.amountFe,
    this.allocationAmountLocal,
    this.allocationAmountFe,
    this.allocationDistributedAmountLocal,
    this.allocationDistributedAmountFe,
    this.releasedAmountLocal,
    this.releasedAmountFe,
  });

  factory FundDistributionFinancialDetail.fromJson(Map<String, dynamic> json) => FundDistributionFinancialDetail(
    fundDistributionFinancialSourceId: json["fund_distribution_financial_source_id"],
    baseProjectFinancialSourceId: json["base_project_financial_source_id"],
    sequenceNo: json["sequence_no"],
    baseProjectFinancialSourceName: json["base_project_financial_source_name"],
    amountLocal: json["amount_local"]?.round(),
    amountFe: json["amount_fe"]?.round(),
    allocationAmountLocal: json["allocation_amount_local"]?.round(),
    allocationAmountFe: json["allocation_amount_fe"]?.round(),
    allocationDistributedAmountLocal: json["allocation_distributed_amount_local"]?.round(),
    allocationDistributedAmountFe: json["allocation_distributed_amount_fe"]?.round(),
    releasedAmountLocal: json["released_amount_local"]?.round(),
    releasedAmountFe: json["released_amount_fe"]?.round(),
  );

  Map<String, dynamic> toJson() => {
    "fund_distribution_financial_source_id": fundDistributionFinancialSourceId,
    "base_project_financial_source_id": baseProjectFinancialSourceId,
    "sequence_no": sequenceNo,
    "base_project_financial_source_name": baseProjectFinancialSourceName,
    "amount_local": amountLocal,
    "amount_fe": amountFe,
    "allocation_amount_local": allocationAmountLocal,
    "allocation_amount_fe": allocationAmountFe,
    "allocation_distributed_amount_local": allocationDistributedAmountLocal,
    "allocation_distributed_amount_fe": allocationDistributedAmountFe,
    "released_amount_local": releasedAmountLocal,
    "released_amount_fe": releasedAmountFe,
  };
}
