
import 'dart:convert';

WorkflowFundReleaseDetailsResponse workflowFundReleaseDetailsResponseFromJson(String str) => WorkflowFundReleaseDetailsResponse.fromJson(json.decode(str));

String workflowFundReleaseDetailsResponseToJson(WorkflowFundReleaseDetailsResponse data) => json.encode(data.toJson());

class WorkflowFundReleaseDetailsResponse {
  String? projectFundReleaseId;
  String? projectId;
  String? fiscalYearId;
  DateTime? timestamp;
  String? status;
  List<ReleaseQuarter>? releaseQuarters;
  List<FundReleaseFinancialSourceDetail>? fundReleaseFinancialSourceDetails;

  WorkflowFundReleaseDetailsResponse({
    this.projectFundReleaseId,
    this.projectId,
    this.fiscalYearId,
    this.timestamp,
    this.status,
    this.releaseQuarters,
    this.fundReleaseFinancialSourceDetails,
  });

  factory WorkflowFundReleaseDetailsResponse.fromJson(Map<String, dynamic> json) => WorkflowFundReleaseDetailsResponse(
    projectFundReleaseId: json["project_fund_release_id"],
    projectId: json["project_id"],
    fiscalYearId: json["fiscal_year_id"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    status: json["status"],
    releaseQuarters: json["release_quarters"] == null ? [] : List<ReleaseQuarter>.from(json["release_quarters"]!.map((x) => ReleaseQuarter.fromJson(x))),
    fundReleaseFinancialSourceDetails: json["fund_release_financial_source_details"] == null ? [] : List<FundReleaseFinancialSourceDetail>.from(json["fund_release_financial_source_details"]!.map((x) => FundReleaseFinancialSourceDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "project_fund_release_id": projectFundReleaseId,
    "project_id": projectId,
    "fiscal_year_id": fiscalYearId,
    "timestamp": timestamp?.toIso8601String(),
    "status": status,
    "release_quarters": releaseQuarters == null ? [] : List<dynamic>.from(releaseQuarters!.map((x) => x.toJson())),
    "fund_release_financial_source_details": fundReleaseFinancialSourceDetails == null ? [] : List<dynamic>.from(fundReleaseFinancialSourceDetails!.map((x) => x.toJson())),
  };
}

class FundReleaseFinancialSourceDetail {
  String? fundReleaseFinancialSourceId;
  String? baseProjectFinancialSourceId;
  String? baseProjectFinancialSourceName;
  int? sequenceNo;
  double? amountLocal;
  double? amountFe;
  double? amountTotal;
  double? allocationAmountLocal;
  double? allocationAmountFe;
  double? releasedAmountLocal;
  double? releasedAmountFe;

  FundReleaseFinancialSourceDetail({
    this.fundReleaseFinancialSourceId,
    this.baseProjectFinancialSourceId,
    this.baseProjectFinancialSourceName,
    this.sequenceNo,
    this.amountLocal,
    this.amountFe,
    this.amountTotal,
    this.allocationAmountLocal,
    this.allocationAmountFe,
    this.releasedAmountLocal,
    this.releasedAmountFe,
  });

  factory FundReleaseFinancialSourceDetail.fromJson(Map<String, dynamic> json) => FundReleaseFinancialSourceDetail(
    fundReleaseFinancialSourceId: json["fund_release_financial_source_id"],
    baseProjectFinancialSourceId: json["base_project_financial_source_id"],
    baseProjectFinancialSourceName: json["base_project_financial_source_name"],
    sequenceNo: json["sequence_no"],
    amountLocal: json["amount_local"],
    amountFe: json["amount_fe"],
    amountTotal: json["amount_total"],
    allocationAmountLocal: json["allocation_amount_local"],
    allocationAmountFe: json["allocation_amount_fe"],
    releasedAmountLocal: json["released_amount_local"],
    releasedAmountFe: json["released_amount_fe"],
  );

  Map<String, dynamic> toJson() => {
    "fund_release_financial_source_id": fundReleaseFinancialSourceId,
    "base_project_financial_source_id": baseProjectFinancialSourceId,
    "base_project_financial_source_name": baseProjectFinancialSourceName,
    "sequence_no": sequenceNo,
    "amount_local": amountLocal,
    "amount_fe": amountFe,
    "amount_total": amountTotal,
    "allocation_amount_local": allocationAmountLocal,
    "allocation_amount_fe": allocationAmountFe,
    "released_amount_local": releasedAmountLocal,
    "released_amount_fe": releasedAmountFe,
  };
}

class ReleaseQuarter {
  int? baseYearQuarterId;

  ReleaseQuarter({
    this.baseYearQuarterId,
  });

  factory ReleaseQuarter.fromJson(Map<String, dynamic> json) => ReleaseQuarter(
    baseYearQuarterId: json["base_year_quarter_id"],
  );

  Map<String, dynamic> toJson() => {
    "base_year_quarter_id": baseYearQuarterId,
  };
}
