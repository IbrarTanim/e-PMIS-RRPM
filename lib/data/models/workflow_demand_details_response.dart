import 'dart:convert';

WorkflowDemandDetailsResponse workflowDemandDetailsResponseFromJson(String str) => WorkflowDemandDetailsResponse.fromJson(json.decode(str));

String workflowDemandDetailsResponseToJson(WorkflowDemandDetailsResponse data) => json.encode(data.toJson());

class WorkflowDemandDetailsResponse {
  String? projectDemandId;
  String? projectId;
  String? fiscalYearId;
  String? developmentTypeId;
  String? developmentTypeName;
  DateTime? timestamp;
  String? status;
  bool? isDeclaredCompleted;
  List<EconomicCodeGroupDemand>? economicCodeGroupDemand;

  WorkflowDemandDetailsResponse({
    this.projectDemandId,
    this.projectId,
    this.fiscalYearId,
    this.developmentTypeId,
    this.developmentTypeName,
    this.timestamp,
    this.status,
    this.isDeclaredCompleted,
    this.economicCodeGroupDemand,
  });

  factory WorkflowDemandDetailsResponse.fromJson(Map<String, dynamic> json) => WorkflowDemandDetailsResponse(
    projectDemandId: json["project_demand_id"],
    projectId: json["project_id"],
    fiscalYearId: json["fiscal_year_id"],
    developmentTypeId: json["development_type_id"],
    developmentTypeName: json["development_type_name"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    status: json["status"],
    isDeclaredCompleted: json["is_declared_completed"],
    economicCodeGroupDemand: json["economic_code_group"] == null ? [] : List<EconomicCodeGroupDemand>.from(json["economic_code_group"]!.map((x) => EconomicCodeGroupDemand.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "project_demand_id": projectDemandId,
    "project_id": projectId,
    "fiscal_year_id": fiscalYearId,
    "development_type_id": developmentTypeId,
    "development_type_name": developmentTypeName,
    "timestamp": timestamp?.toIso8601String(),
    "status": status,
    "is_declared_completed": isDeclaredCompleted,
    "economic_code_group": economicCodeGroupDemand == null ? [] : List<dynamic>.from(economicCodeGroupDemand!.map((x) => x.toJson())),
  };
}

class EconomicCodeGroupDemand {
  String? economicCodesTypeId;
  String? economicCodesTypeName;
  List<ProjectDemandEconomicCode>? projectDemandEconomicCodes;

  EconomicCodeGroupDemand({
    this.economicCodesTypeId,
    this.economicCodesTypeName,
    this.projectDemandEconomicCodes,
  });

  factory EconomicCodeGroupDemand.fromJson(Map<String, dynamic> json) => EconomicCodeGroupDemand(
    economicCodesTypeId: json["economic_codes_type_id"],
    economicCodesTypeName: json["economic_codes_type_name"],
    projectDemandEconomicCodes: json["project_demand_economic_codes"] == null ? [] : List<ProjectDemandEconomicCode>.from(json["project_demand_economic_codes"]!.map((x) => ProjectDemandEconomicCode.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "economic_codes_type_id": economicCodesTypeId,
    "economic_codes_type_name": economicCodesTypeName,
    "project_demand_economic_codes": projectDemandEconomicCodes == null ? [] : List<dynamic>.from(projectDemandEconomicCodes!.map((x) => x.toJson())),
  };
}

class ProjectDemandEconomicCode {
  List<DemandFinancialDetail>? demandFinancialDetails;
  String? projectDemandEconomicCodeId;
  String? baseEconomicCodeId;
  String? baseEconomicCode;
  String? baseEconomicCodesDescription;
  String? baseEconomicCodesParentId;
  String? baseEconomicParentCode;
  String? baseEconomicCodesParentDescription;
  String? description;
  int? total;
  int? sequenceNo;

  ProjectDemandEconomicCode({
    this.demandFinancialDetails,
    this.projectDemandEconomicCodeId,
    this.baseEconomicCodeId,
    this.baseEconomicCode,
    this.baseEconomicCodesDescription,
    this.baseEconomicCodesParentId,
    this.baseEconomicParentCode,
    this.baseEconomicCodesParentDescription,
    this.description,
    this.total,
    this.sequenceNo,
  });

  factory ProjectDemandEconomicCode.fromJson(Map<String, dynamic> json) => ProjectDemandEconomicCode(
    demandFinancialDetails: json["demand_financial_details"] == null ? [] : List<DemandFinancialDetail>.from(json["demand_financial_details"]!.map((x) => DemandFinancialDetail.fromJson(x))),
    projectDemandEconomicCodeId: json["project_demand_economic_code_id"],
    baseEconomicCodeId: json["base_economic_code_id"],
    baseEconomicCode: json["base_economic_code"],
    baseEconomicCodesDescription: json["base_economic_codes_description"],
    baseEconomicCodesParentId: json["base_economic_codes_parent_id"],
    baseEconomicParentCode: json["base_economic_parent_code"],
    baseEconomicCodesParentDescription: json["base_economic_codes_parent_description"],
    description: json["description"],
    total: json["total"]?.round(),
    sequenceNo: json["sequence_no"]?.round(),
  );

  Map<String, dynamic> toJson() => {
    "demand_financial_details": demandFinancialDetails == null ? [] : List<dynamic>.from(demandFinancialDetails!.map((x) => x.toJson())),
    "project_demand_economic_code_id": projectDemandEconomicCodeId,
    "base_economic_code_id": baseEconomicCodeId,
    "base_economic_code": baseEconomicCode,
    "base_economic_codes_description": baseEconomicCodesDescription,
    "base_economic_codes_parent_id": baseEconomicCodesParentId,
    "base_economic_parent_code": baseEconomicParentCode,
    "base_economic_codes_parent_description": baseEconomicCodesParentDescription,
    "description": description,
    "total": total,
    "sequence_no": sequenceNo,
  };
}

class DemandFinancialDetail {
  String? projectDemandFinancialSourceId;
  String? baseProjectFinancialSourceId;
  int? sequenceNo;
  String? baseProjectFinancialSourceName;
  int? amountLocal;
  int? amountFe;
  int? yearlyAmountLocal;
  int? yearlyAmountFe;
  int? alreadyDemandAmountLocal;
  int? alreadyDemandAmountFe;

  DemandFinancialDetail({
    this.projectDemandFinancialSourceId,
    this.baseProjectFinancialSourceId,
    this.sequenceNo,
    this.baseProjectFinancialSourceName,
    this.amountLocal,
    this.amountFe,
    this.yearlyAmountLocal,
    this.yearlyAmountFe,
    this.alreadyDemandAmountLocal,
    this.alreadyDemandAmountFe,
  });

  factory DemandFinancialDetail.fromJson(Map<String, dynamic> json) => DemandFinancialDetail(
    projectDemandFinancialSourceId: json["project_demand_financial_source_id"],
    baseProjectFinancialSourceId: json["base_project_financial_source_id"],
    sequenceNo: json["sequence_no"]?.round(),
    baseProjectFinancialSourceName: json["base_project_financial_source_name"],
    amountLocal: json["amount_local"]?.round(),
    amountFe: json["amount_fe"]?.round(),
    yearlyAmountLocal: json["yearly_amount_local"]?.round(),
    yearlyAmountFe: json["yearly_amount_fe"]?.round(),
    alreadyDemandAmountLocal: json["already_demand_amount_local"]?.round(),
    alreadyDemandAmountFe: json["already_demand_amount_fe"]?.round(),
  );

  Map<String, dynamic> toJson() => {
    "project_demand_financial_source_id": projectDemandFinancialSourceId,
    "base_project_financial_source_id": baseProjectFinancialSourceId,
    "sequence_no": sequenceNo,
    "base_project_financial_source_name": baseProjectFinancialSourceName,
    "amount_local": amountLocal,
    "amount_fe": amountFe,
    "yearly_amount_local": yearlyAmountLocal,
    "yearly_amount_fe": yearlyAmountFe,
    "already_demand_amount_local": alreadyDemandAmountLocal,
    "already_demand_amount_fe": alreadyDemandAmountFe,
  };
}
