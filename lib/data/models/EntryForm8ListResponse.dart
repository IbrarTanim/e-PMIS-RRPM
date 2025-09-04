// To parse this JSON data, do
//
//     final entryForm8ListResponse = entryForm8ListResponseFromJson(jsonString);

import 'dart:convert';

EntryForm8ListResponse entryForm8ListResponseFromJson(String str) => EntryForm8ListResponse.fromJson(json.decode(str));

String entryForm8ListResponseToJson(EntryForm8ListResponse data) => json.encode(data.toJson());

class EntryForm8ListResponse {
  String? projectExpenditureSummaryId;
  String? projectId;
  String? fiscalYearId;
  int? monthId;
  List<EconCodeTypeDetail>? econCodeTypeDetail;

  EntryForm8ListResponse({
    this.projectExpenditureSummaryId,
    this.projectId,
    this.fiscalYearId,
    this.monthId,
    this.econCodeTypeDetail,
  });

  factory EntryForm8ListResponse.fromJson(Map<String, dynamic> json) => EntryForm8ListResponse(
    projectExpenditureSummaryId: json["project_expenditure_summary_id"],
    projectId: json["project_id"],
    fiscalYearId: json["fiscal_year_id"],
    monthId: json["month_id"]?.round(),
    econCodeTypeDetail: json["econ_code_type_detail"] == null ? [] : List<EconCodeTypeDetail>.from(json["econ_code_type_detail"]!.map((x) => EconCodeTypeDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "project_expenditure_summary_id": projectExpenditureSummaryId,
    "project_id": projectId,
    "fiscal_year_id": fiscalYearId,
    "month_id": monthId,
    "econ_code_type_detail": econCodeTypeDetail == null ? [] : List<dynamic>.from(econCodeTypeDetail!.map((x) => x.toJson())),
  };
}

class EconCodeTypeDetail {
  String? economicCodesTypeId;
  String? economicCodesTypeName;
  String? economicCodesTypeNameBangla;
  int? baseEconomicTypeSequence;
  List<TargetAchievementDatum>? targetAchievementData;

  EconCodeTypeDetail({
    this.economicCodesTypeId,
    this.economicCodesTypeName,
    this.economicCodesTypeNameBangla,
    this.baseEconomicTypeSequence,
    this.targetAchievementData,
  });

  factory EconCodeTypeDetail.fromJson(Map<String, dynamic> json) => EconCodeTypeDetail(
    economicCodesTypeId: json["economic_codes_type_id"],
    economicCodesTypeName: json["economic_codes_type_name"],
    economicCodesTypeNameBangla: json["economic_codes_type_name_bangla"],
    baseEconomicTypeSequence: json["base_economic_type_sequence"]?.round(),
    targetAchievementData: json["target_achievement_data"] == null ? [] : List<TargetAchievementDatum>.from(json["target_achievement_data"]!.map((x) => TargetAchievementDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "economic_codes_type_id": economicCodesTypeId,
    "economic_codes_type_name": economicCodesTypeName,
    "economic_codes_type_name_bangla": economicCodesTypeNameBangla,
    "base_economic_type_sequence": baseEconomicTypeSequence,
    "target_achievement_data": targetAchievementData == null ? [] : List<dynamic>.from(targetAchievementData!.map((x) => x.toJson())),
  };
}

class TargetAchievementDatum {
  String? projectExpenditureEconomicCodeProgressId;
  String? baseEconomicCode;
  String? baseEconomicCodesDescription;
  String? baseEconomicCodesId;
  String? baseEconomicParentCode;
  String? baseEconomicCodesParentDescription;
  dynamic quantity;
  dynamic unitName;
  dynamic unitNameBangla;
  double? estimatedCost;
  String? description;
  double? financialProgressUptoLastJune;
  double? physicalProgressUptoLastJune;
  int? quantityUptoLastJune;
  double? financialTargetOfCurrentYear;
  double? physicalTargetOfCurrentYear;
  int? quantityOfCurrentYear;
  double? financialProgressUptoCurrentMonth;
  int? physicalProgressUptoCurrentMonth;
  int? quantityUptoCurrentMonth;
  int? financialProgressOfCurrentMonth;
  int? physicalProgressOfCurrentMonth;
  int? quantityOfCurrentMonth;
  dynamic remarks;
  dynamic fileId;

  TargetAchievementDatum({
    this.projectExpenditureEconomicCodeProgressId,
    this.baseEconomicCode,
    this.baseEconomicCodesDescription,
    this.baseEconomicCodesId,
    this.baseEconomicParentCode,
    this.baseEconomicCodesParentDescription,
    this.quantity,
    this.unitName,
    this.unitNameBangla,
    this.estimatedCost,
    this.description,
    this.financialProgressUptoLastJune,
    this.physicalProgressUptoLastJune,
    this.quantityUptoLastJune,
    this.financialTargetOfCurrentYear,
    this.physicalTargetOfCurrentYear,
    this.quantityOfCurrentYear,
    this.financialProgressUptoCurrentMonth,
    this.physicalProgressUptoCurrentMonth,
    this.quantityUptoCurrentMonth,
    this.financialProgressOfCurrentMonth,
    this.physicalProgressOfCurrentMonth,
    this.quantityOfCurrentMonth,
    this.remarks,
    this.fileId,
  });

  factory TargetAchievementDatum.fromJson(Map<String, dynamic> json) => TargetAchievementDatum(
    projectExpenditureEconomicCodeProgressId: json["project_expenditure_economic_code_progress_id"],
    baseEconomicCode: json["base_economic_code"],
    baseEconomicCodesDescription: json["base_economic_codes_description"],
    baseEconomicCodesId: json["base_economic_codes_id"],
    baseEconomicParentCode: json["base_economic_parent_code"],
    baseEconomicCodesParentDescription: json["base_economic_codes_parent_description"],
    quantity: json["quantity"],
    unitName: json["unit_name"],
    unitNameBangla: json["unit_name_bangla"],
    estimatedCost: json["estimated_cost"]?.toDouble(),
    description: json["description"],
    financialProgressUptoLastJune: json["financial_progress_upto_last_june"]?.toDouble(),
    physicalProgressUptoLastJune: json["physical_progress_upto_last_june"]?.toDouble(),
    quantityUptoLastJune: json["quantity_upto_last_june"]?.round(),
    financialTargetOfCurrentYear: json["financial_target_of_current_year"]?.toDouble(),
    physicalTargetOfCurrentYear: json["physical_target_of_current_year"]?.toDouble(),
    quantityOfCurrentYear: json["quantity_of_current_year"]?.round(),
    financialProgressUptoCurrentMonth: json["financial_progress_upto_current_month"]?.toDouble(),
    physicalProgressUptoCurrentMonth: json["physical_progress_upto_current_month"]?.round(),
    quantityUptoCurrentMonth: json["quantity_upto_current_month"]?.round(),
    financialProgressOfCurrentMonth: json["financial_progress_of_current_month"]?.round(),
    physicalProgressOfCurrentMonth: json["physical_progress_of_current_month"]?.round(),
    quantityOfCurrentMonth: json["quantity_of_current_month"]?.round(),
    remarks: json["remarks"],
    fileId: json["file_id"],
  );

  Map<String, dynamic> toJson() => {
    "project_expenditure_economic_code_progress_id": projectExpenditureEconomicCodeProgressId,
    "base_economic_code": baseEconomicCode,
    "base_economic_codes_description": baseEconomicCodesDescription,
    "base_economic_codes_id": baseEconomicCodesId,
    "base_economic_parent_code": baseEconomicParentCode,
    "base_economic_codes_parent_description": baseEconomicCodesParentDescription,
    "quantity": quantity,
    "unit_name": unitName,
    "unit_name_bangla": unitNameBangla,
    "estimated_cost": estimatedCost,
    "description": description,
    "financial_progress_upto_last_june": financialProgressUptoLastJune,
    "physical_progress_upto_last_june": physicalProgressUptoLastJune,
    "quantity_upto_last_june": quantityUptoLastJune,
    "financial_target_of_current_year": financialTargetOfCurrentYear,
    "physical_target_of_current_year": physicalTargetOfCurrentYear,
    "quantity_of_current_year": quantityOfCurrentYear,
    "financial_progress_upto_current_month": financialProgressUptoCurrentMonth,
    "physical_progress_upto_current_month": physicalProgressUptoCurrentMonth,
    "quantity_upto_current_month": quantityUptoCurrentMonth,
    "financial_progress_of_current_month": financialProgressOfCurrentMonth,
    "physical_progress_of_current_month": physicalProgressOfCurrentMonth,
    "quantity_of_current_month": quantityOfCurrentMonth,
    "remarks": remarks,
    "file_id": fileId,
  };
}
