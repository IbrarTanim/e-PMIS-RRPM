// To parse this JSON data, do
//
//     final projectFundReleaseSummaryResponse = projectFundReleaseSummaryResponseFromJson(jsonString);

import 'dart:convert';

ProjectFundReleaseSummaryResponse projectFundReleaseSummaryResponseFromJson(String str) => ProjectFundReleaseSummaryResponse.fromJson(json.decode(str));

String projectFundReleaseSummaryResponseToJson(ProjectFundReleaseSummaryResponse data) => json.encode(data.toJson());

class ProjectFundReleaseSummaryResponse {
  String? projectFundReleaseSummaryId;
  String? fiscalYearId;
  dynamic fundReleaseFileId;
  dynamic fundReleaseFileName;
  List<ReleaseQuarter>? releaseQuarters;
  ReleaseDetails? releaseDetails;

  ProjectFundReleaseSummaryResponse({
    this.projectFundReleaseSummaryId,
    this.fiscalYearId,
    this.fundReleaseFileId,
    this.fundReleaseFileName,
    this.releaseQuarters,
    this.releaseDetails,
  });

  factory ProjectFundReleaseSummaryResponse.fromJson(Map<String, dynamic> json) => ProjectFundReleaseSummaryResponse(
    projectFundReleaseSummaryId: json["project_fund_release_summary_id"],
    fiscalYearId: json["fiscal_year_id"],
    fundReleaseFileId: json["fund_release_file_id"],
    fundReleaseFileName: json["fund_release_file_name"],
    releaseQuarters: json["release_quarters"] == null ? [] : List<ReleaseQuarter>.from(json["release_quarters"]!.map((x) => ReleaseQuarter.fromJson(x))),
    releaseDetails: json["release_details"] == null ? null : ReleaseDetails.fromJson(json["release_details"]),
  );

  Map<String, dynamic> toJson() => {
    "project_fund_release_summary_id": projectFundReleaseSummaryId,
    "fiscal_year_id": fiscalYearId,
    "fund_release_file_id": fundReleaseFileId,
    "fund_release_file_name": fundReleaseFileName,
    "release_quarters": releaseQuarters == null ? [] : List<dynamic>.from(releaseQuarters!.map((x) => x.toJson())),
    "release_details": releaseDetails?.toJson(),
  };
}

class ReleaseDetails {
  int? amountGob;
  int? amountGobFe;
  int? amountRpa;
  int? amountDpa;
  int? amountOwnFund;
  int? amountOwnFundFe;
  int? amountCdVat;

  ReleaseDetails({
    this.amountGob,
    this.amountGobFe,
    this.amountRpa,
    this.amountDpa,
    this.amountOwnFund,
    this.amountOwnFundFe,
    this.amountCdVat,
  });

  factory ReleaseDetails.fromJson(Map<String, dynamic> json) => ReleaseDetails(
    amountGob: json["amount_gob"]?.round(),
    amountGobFe: json["amount_gob_fe"]?.round(),
    amountRpa: json["amount_rpa"]?.round(),
    amountDpa: json["amount_dpa"]?.round(),
    amountOwnFund: json["amount_own_fund"]?.round(),
    amountOwnFundFe: json["amount_own_fund_fe"]?.round(),
    amountCdVat: json["amount_cd_vat"]?.round(),
  );

  Map<String, dynamic> toJson() => {
    "amount_gob": amountGob,
    "amount_gob_fe": amountGobFe,
    "amount_rpa": amountRpa,
    "amount_dpa": amountDpa,
    "amount_own_fund": amountOwnFund,
    "amount_own_fund_fe": amountOwnFundFe,
    "amount_cd_vat": amountCdVat,
  };
}

class ReleaseQuarter {
  int? baseYearQuarterId;
  String? baseYearQuarterName;

  ReleaseQuarter({
    this.baseYearQuarterId,
    this.baseYearQuarterName,
  });

  factory ReleaseQuarter.fromJson(Map<String, dynamic> json) => ReleaseQuarter(
    baseYearQuarterId: json["base_year_quarter_id"]?.round(),
    baseYearQuarterName: json["base_year_quarter_name"],
  );

  Map<String, dynamic> toJson() => {
    "base_year_quarter_id": baseYearQuarterId,
    "base_year_quarter_name": baseYearQuarterName,
  };
}
