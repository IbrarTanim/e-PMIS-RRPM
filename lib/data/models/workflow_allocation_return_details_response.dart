
import 'dart:convert';

WorkflowAllocationReturnDetailsResponse workflowAllocationReturnDetailsResponseFromJson(String str) => WorkflowAllocationReturnDetailsResponse.fromJson(json.decode(str));

String workflowAllocationReturnDetailsResponseToJson(WorkflowAllocationReturnDetailsResponse data) => json.encode(data.toJson());

class WorkflowAllocationReturnDetailsResponse {
  List<FinancialDetail>? allocationFinancialDetails;
  List<FinancialDetail>? fundReleaseFinancialDetails;
  List<FinancialDetail>? expenditureFinancialDetails;
  List<FinancialDetail>? allocationReturnsFinancialDetails;
  String? allocationReturnId;
  String? projectId;
  String? fiscalYearId;
  DateTime? timestamp;
  String? status;

  WorkflowAllocationReturnDetailsResponse({
    this.allocationFinancialDetails,
    this.fundReleaseFinancialDetails,
    this.expenditureFinancialDetails,
    this.allocationReturnsFinancialDetails,
    this.allocationReturnId,
    this.projectId,
    this.fiscalYearId,
    this.timestamp,
    this.status,
  });

  factory WorkflowAllocationReturnDetailsResponse.fromJson(Map<String, dynamic> json) => WorkflowAllocationReturnDetailsResponse(
    allocationFinancialDetails: json["allocation_financial_details"] == null ? [] : List<FinancialDetail>.from(json["allocation_financial_details"]!.map((x) => FinancialDetail.fromJson(x))),
    fundReleaseFinancialDetails: json["fund_release_financial_details"] == null ? [] : List<FinancialDetail>.from(json["fund_release_financial_details"]!.map((x) => FinancialDetail.fromJson(x))),
    expenditureFinancialDetails: json["expenditure_financial_details"] == null ? [] : List<FinancialDetail>.from(json["expenditure_financial_details"]!.map((x) => FinancialDetail.fromJson(x))),
    allocationReturnsFinancialDetails: json["allocation_returns_financial_details"] == null ? [] : List<FinancialDetail>.from(json["allocation_returns_financial_details"]!.map((x) => FinancialDetail.fromJson(x))),
    allocationReturnId: json["allocation_return_id"],
    projectId: json["project_id"],
    fiscalYearId: json["fiscal_year_id"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "allocation_financial_details": allocationFinancialDetails == null ? [] : List<dynamic>.from(allocationFinancialDetails!.map((x) => x.toJson())),
    "fund_release_financial_details": fundReleaseFinancialDetails == null ? [] : List<dynamic>.from(fundReleaseFinancialDetails!.map((x) => x.toJson())),
    "expenditure_financial_details": expenditureFinancialDetails == null ? [] : List<dynamic>.from(expenditureFinancialDetails!.map((x) => x.toJson())),
    "allocation_returns_financial_details": allocationReturnsFinancialDetails == null ? [] : List<dynamic>.from(allocationReturnsFinancialDetails!.map((x) => x.toJson())),
    "allocation_return_id": allocationReturnId,
    "project_id": projectId,
    "fiscal_year_id": fiscalYearId,
    "timestamp": timestamp?.toIso8601String(),
    "status": status,
  };
}

class FinancialDetail {
  String? baseProjectFinancialSourceId;
  BaseProjectFinancialSourceName? baseProjectFinancialSourceName;
  int? sequenceNo;
  int? amountLocal;
  int? amountFe;
  int? amountTotal;

  FinancialDetail({
    this.baseProjectFinancialSourceId,
    this.baseProjectFinancialSourceName,
    this.sequenceNo,
    this.amountLocal,
    this.amountFe,
    this.amountTotal,
  });

  factory FinancialDetail.fromJson(Map<String, dynamic> json) => FinancialDetail(
    baseProjectFinancialSourceId: json["base_project_financial_source_id"],
    baseProjectFinancialSourceName: baseProjectFinancialSourceNameValues.map[json["base_project_financial_source_name"]]!,
    sequenceNo: json["sequence_no"],
    amountLocal: json["amount_local"]?.round(),
    amountFe: json["amount_fe"]?.round(),
    amountTotal: json["amount_total"]?.round(),
  );

  Map<String, dynamic> toJson() => {
    "base_project_financial_source_id": baseProjectFinancialSourceId,
    "base_project_financial_source_name": baseProjectFinancialSourceNameValues.reverse[baseProjectFinancialSourceName],
    "sequence_no": sequenceNo,
    "amount_local": amountLocal,
    "amount_fe": amountFe,
    "amount_total": amountTotal,
  };
}

enum BaseProjectFinancialSourceName {
  GO_B,
  THROUGH_DP,
  THROUGH_PD
}

final baseProjectFinancialSourceNameValues = EnumValues({
  "GoB": BaseProjectFinancialSourceName.GO_B,
  "Through DP": BaseProjectFinancialSourceName.THROUGH_DP,
  "Through PD": BaseProjectFinancialSourceName.THROUGH_PD
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
