// To parse this JSON data, do
//
//     final workflowExpenditureInformationResponse = workflowExpenditureInformationResponseFromJson(jsonString);

import 'dart:convert';

WorkflowExpenditureInformationResponse workflowExpenditureInformationResponseFromJson(String str) => WorkflowExpenditureInformationResponse.fromJson(json.decode(str));

String workflowExpenditureInformationResponseToJson(WorkflowExpenditureInformationResponse data) => json.encode(data.toJson());

class WorkflowExpenditureInformationResponse {
  String? projectExpenditureId;
  String? projectExpenditureEconomicCodeId;
  String? baseEconomicCodesCode;
  String? baseEconomicCodesName;
  String? baseParentEconomicCodesCode;
  String? baseParentEconomicCodesName;
  String? description;
  String? baseUnitId;
  String? baseUnitName;
  int? quantity;
  String? remarks;
  List<ExpenditureFinancialSource>? expenditureFinancialSources;

  WorkflowExpenditureInformationResponse({
    this.projectExpenditureId,
    this.projectExpenditureEconomicCodeId,
    this.baseEconomicCodesCode,
    this.baseEconomicCodesName,
    this.baseParentEconomicCodesCode,
    this.baseParentEconomicCodesName,
    this.description,
    this.baseUnitId,
    this.baseUnitName,
    this.quantity,
    this.remarks,
    this.expenditureFinancialSources,
  });

  factory WorkflowExpenditureInformationResponse.fromJson(Map<String, dynamic> json) => WorkflowExpenditureInformationResponse(
    projectExpenditureId: json["project_expenditure_id"],
    projectExpenditureEconomicCodeId: json["project_expenditure_economic_code_id"],
    baseEconomicCodesCode: json["base_economic_codes_code"],
    baseEconomicCodesName: json["base_economic_codes_name"],
    baseParentEconomicCodesCode: json["base_parent_economic_codes_code"],
    baseParentEconomicCodesName: json["base_parent_economic_codes_name"],
    description: json["description"],
    baseUnitId: json["base_unit_id"],
    baseUnitName: json["base_unit_name"],
    quantity: json["quantity"],
    remarks: json["remarks"],
    expenditureFinancialSources: json["expenditure_financial_sources"] == null ? [] : List<ExpenditureFinancialSource>.from(json["expenditure_financial_sources"]!.map((x) => ExpenditureFinancialSource.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "project_expenditure_id": projectExpenditureId,
    "project_expenditure_economic_code_id": projectExpenditureEconomicCodeId,
    "base_economic_codes_code": baseEconomicCodesCode,
    "base_economic_codes_name": baseEconomicCodesName,
    "base_parent_economic_codes_code": baseParentEconomicCodesCode,
    "base_parent_economic_codes_name": baseParentEconomicCodesName,
    "description": description,
    "base_unit_id": baseUnitId,
    "base_unit_name": baseUnitName,
    "quantity": quantity,
    "remarks": remarks,
    "expenditure_financial_sources": expenditureFinancialSources == null ? [] : List<dynamic>.from(expenditureFinancialSources!.map((x) => x.toJson())),
  };
}

class ExpenditureFinancialSource {
  String? projectExpenditureFinancialSourcesId;
  String? projectExpenditureEconomicCodeId;
  String? baseProjectFinancialSourceId;
  String? baseProjectFinancialSourceName;
  int? amountLocal;
  int? amountFe;

  ExpenditureFinancialSource({
    this.projectExpenditureFinancialSourcesId,
    this.projectExpenditureEconomicCodeId,
    this.baseProjectFinancialSourceId,
    this.baseProjectFinancialSourceName,
    this.amountLocal,
    this.amountFe,
  });

  factory ExpenditureFinancialSource.fromJson(Map<String, dynamic> json) => ExpenditureFinancialSource(
    projectExpenditureFinancialSourcesId: json["project_expenditure_financial_sources_id"],
    projectExpenditureEconomicCodeId: json["project_expenditure_economic_code_id"],
    baseProjectFinancialSourceId: json["base_project_financial_source_id"],
    baseProjectFinancialSourceName: json["base_project_financial_source_name"],
    amountLocal: json["amount_local"],
    amountFe: json["amount_fe"],
  );

  Map<String, dynamic> toJson() => {
    "project_expenditure_financial_sources_id": projectExpenditureFinancialSourcesId,
    "project_expenditure_economic_code_id": projectExpenditureEconomicCodeId,
    "base_project_financial_source_id": baseProjectFinancialSourceId,
    "base_project_financial_source_name": baseProjectFinancialSourceName,
    "amount_local": amountLocal,
    "amount_fe": amountFe,
  };
}
