// To parse this JSON data, do
//
//     final projectExpenditureCostResponse = projectExpenditureCostResponseFromJson(jsonString);

import 'dart:convert';

ProjectExpenditureCostResponse projectExpenditureCostResponseFromJson(String str) => ProjectExpenditureCostResponse.fromJson(json.decode(str));

String projectExpenditureCostResponseToJson(ProjectExpenditureCostResponse data) => json.encode(data.toJson());

class ProjectExpenditureCostResponse {
  List<ExpenditureDetail>? expenditureDetails;
  String? projectExpenditureSummaryId;
  String? fiscalYearId;
  String? monthId;
  String? monthName;
  String? expenditureStatusId;
  int? physicalProgressPercentage;

  ProjectExpenditureCostResponse({
    this.expenditureDetails,
    this.projectExpenditureSummaryId,
    this.fiscalYearId,
    this.monthId,
    this.monthName,
    this.expenditureStatusId,
    this.physicalProgressPercentage,
  });

  factory ProjectExpenditureCostResponse.fromJson(Map<String, dynamic> json) => ProjectExpenditureCostResponse(
    expenditureDetails: json["expenditure_details"] == null ? [] : List<ExpenditureDetail>.from(json["expenditure_details"]!.map((x) => ExpenditureDetail.fromJson(x))),
    projectExpenditureSummaryId: json["project_expenditure_summary_id"],
    fiscalYearId: json["fiscal_year_id"],
    monthId: json["month_id"],
    monthName: json["month_name"],
    expenditureStatusId: json["expenditure_status_id"],
    physicalProgressPercentage: json["physical_progress_percentage"]?.round(),
  );

  Map<String, dynamic> toJson() => {
    "expenditure_details": expenditureDetails == null ? [] : List<dynamic>.from(expenditureDetails!.map((x) => x.toJson())),
    "project_expenditure_summary_id": projectExpenditureSummaryId,
    "fiscal_year_id": fiscalYearId,
    "month_id": monthId,
    "month_name": monthName,
    "expenditure_status_id": expenditureStatusId,
    "physical_progress_percentage": physicalProgressPercentage,
  };
}

class ExpenditureDetail {
  String? econTypeId;
  double? summaryAmountGob;
  int? summaryAmountGobFe;
  int? summaryAmountRpa;
  int? summaryAmountDpa;
  int? summaryAmountOwnFund;
  int? summaryAmountOwnFundFe;
  int? summaryAmountOther;
  int? summaryAmountCdVat;
  double? detailAmountGob;
  int? detailAmountGobFe;
  int? detailAmountRpa;
  int? detailAmountDpa;
  int? detailAmountOwnFund;
  int? detailAmountOwnFundFe;
  int? detailAmountOther;
  int? detailAmountCdVat;

  ExpenditureDetail({
    this.econTypeId,
    this.summaryAmountGob,
    this.summaryAmountGobFe,
    this.summaryAmountRpa,
    this.summaryAmountDpa,
    this.summaryAmountOwnFund,
    this.summaryAmountOwnFundFe,
    this.summaryAmountOther,
    this.summaryAmountCdVat,
    this.detailAmountGob,
    this.detailAmountGobFe,
    this.detailAmountRpa,
    this.detailAmountDpa,
    this.detailAmountOwnFund,
    this.detailAmountOwnFundFe,
    this.detailAmountOther,
    this.detailAmountCdVat,
  });

  factory ExpenditureDetail.fromJson(Map<String, dynamic> json) => ExpenditureDetail(
    econTypeId: json["econ_type_id"],
    summaryAmountGob: json["summary_amount_gob"]?.toDouble(),
    summaryAmountGobFe: json["summary_amount_gob_fe"]?.round(),
    summaryAmountRpa: json["summary_amount_rpa"]?.round(),
    summaryAmountDpa: json["summary_amount_dpa"]?.round(),
    summaryAmountOwnFund: json["summary_amount_own_fund"]?.round(),
    summaryAmountOwnFundFe: json["summary_amount_own_fund_fe"]?.round(),
    summaryAmountOther: json["summary_amount_other"]?.round(),
    summaryAmountCdVat: json["summary_amount_cd_vat"]?.round(),
    detailAmountGob: json["detail_amount_gob"]?.toDouble(),
    detailAmountGobFe: json["detail_amount_gob_fe"]?.round(),
    detailAmountRpa: json["detail_amount_rpa"]?.round(),
    detailAmountDpa: json["detail_amount_dpa"]?.round(),
    detailAmountOwnFund: json["detail_amount_own_fund"]?.round(),
    detailAmountOwnFundFe: json["detail_amount_own_fund_fe"]?.round(),
    detailAmountOther: json["detail_amount_other"]?.round(),
    detailAmountCdVat: json["detail_amount_cd_vat"]?.round(),
  );

  Map<String, dynamic> toJson() => {
    "econ_type_id": econTypeId,
    "summary_amount_gob": summaryAmountGob,
    "summary_amount_gob_fe": summaryAmountGobFe,
    "summary_amount_rpa": summaryAmountRpa,
    "summary_amount_dpa": summaryAmountDpa,
    "summary_amount_own_fund": summaryAmountOwnFund,
    "summary_amount_own_fund_fe": summaryAmountOwnFundFe,
    "summary_amount_other": summaryAmountOther,
    "summary_amount_cd_vat": summaryAmountCdVat,
    "detail_amount_gob": detailAmountGob,
    "detail_amount_gob_fe": detailAmountGobFe,
    "detail_amount_rpa": detailAmountRpa,
    "detail_amount_dpa": detailAmountDpa,
    "detail_amount_own_fund": detailAmountOwnFund,
    "detail_amount_own_fund_fe": detailAmountOwnFundFe,
    "detail_amount_other": detailAmountOther,
    "detail_amount_cd_vat": detailAmountCdVat,
  };
}
