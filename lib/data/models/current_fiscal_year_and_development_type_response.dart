// To parse this JSON data, do
//
//     final currentFiscalYearAndDevelopmentTypeResponse = currentFiscalYearAndDevelopmentTypeResponseFromJson(jsonString);

import 'dart:convert';

CurrentFiscalYearAndDevelopmentTypeResponse currentFiscalYearAndDevelopmentTypeResponseFromJson(String str) => CurrentFiscalYearAndDevelopmentTypeResponse.fromJson(json.decode(str));

String currentFiscalYearAndDevelopmentTypeResponseToJson(CurrentFiscalYearAndDevelopmentTypeResponse data) => json.encode(data.toJson());

class CurrentFiscalYearAndDevelopmentTypeResponse {
  String? fiscalYearId;
  String? developmentPlanTypeId;
  String? developmentPlanTypeName;
  String? developmentPlanTypeNameBn;

  CurrentFiscalYearAndDevelopmentTypeResponse({
    this.fiscalYearId,
    this.developmentPlanTypeId,
    this.developmentPlanTypeName,
    this.developmentPlanTypeNameBn,
  });

  factory CurrentFiscalYearAndDevelopmentTypeResponse.fromJson(Map<String, dynamic> json) => CurrentFiscalYearAndDevelopmentTypeResponse(
    fiscalYearId: json["fiscal_year_id"],
    developmentPlanTypeId: json["development_plan_type_id"],
    developmentPlanTypeName: json["development_plan_type_name"],
    developmentPlanTypeNameBn: json["development_plan_type_name_bn"],
  );

  Map<String, dynamic> toJson() => {
    "fiscal_year_id": fiscalYearId,
    "development_plan_type_id": developmentPlanTypeId,
    "development_plan_type_name": developmentPlanTypeName,
    "development_plan_type_name_bn": developmentPlanTypeNameBn,
  };
}
