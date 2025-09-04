
import 'dart:convert';

WorkflowReappropriationDetailsResponse workflowReappropriationDetailsResponseFromJson(String str) => WorkflowReappropriationDetailsResponse.fromJson(json.decode(str));

String workflowReappropriationDetailsResponseToJson(WorkflowReappropriationDetailsResponse data) => json.encode(data.toJson());

class WorkflowReappropriationDetailsResponse {
  String? parentFinancialSourceId;
  String? parentFinancialSourceName;
  int? sequenceNo;
  int? groupCount;
  List<FinancialSourceSubGroup>? financialSourceSubGroup;

  WorkflowReappropriationDetailsResponse({
    this.parentFinancialSourceId,
    this.parentFinancialSourceName,
    this.sequenceNo,
    this.groupCount,
    this.financialSourceSubGroup,
  });

  factory WorkflowReappropriationDetailsResponse.fromJson(Map<String, dynamic> json) => WorkflowReappropriationDetailsResponse(
    parentFinancialSourceId: json["parent_financial_source_id"],
    parentFinancialSourceName: json["parent_financial_source_name"],
    sequenceNo: json["sequence_no"]?.round(),
    groupCount: json["group_count"]?.round(),
    financialSourceSubGroup: json["financial_source_sub_group"] == null ? [] : List<FinancialSourceSubGroup>.from(json["financial_source_sub_group"]!.map((x) => FinancialSourceSubGroup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "parent_financial_source_id": parentFinancialSourceId,
    "parent_financial_source_name": parentFinancialSourceName,
    "sequence_no": sequenceNo,
    "group_count": groupCount,
    "financial_source_sub_group": financialSourceSubGroup == null ? [] : List<dynamic>.from(financialSourceSubGroup!.map((x) => x.toJson())),
  };
}

class FinancialSourceSubGroup {
  String? subFinancialSourceId;
  String? subFinancialSourceName;
  int? sequenceNo;
  int? groupCount;
  List<FinancialDetailReappropriation>? financialDetailsReappropriation;

  FinancialSourceSubGroup({
    this.subFinancialSourceId,
    this.subFinancialSourceName,
    this.sequenceNo,
    this.groupCount,
    this.financialDetailsReappropriation,
  });

  factory FinancialSourceSubGroup.fromJson(Map<String, dynamic> json) => FinancialSourceSubGroup(
    subFinancialSourceId: json["sub_financial_source_id"],
    subFinancialSourceName: json["sub_financial_source_name"],
    sequenceNo: json["sequence_no"]?.round(),
    groupCount: json["group_count"]?.round(),
    financialDetailsReappropriation: json["financial_details"] == null ? [] : List<FinancialDetailReappropriation>.from(json["financial_details"]!.map((x) => FinancialDetailReappropriation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "sub_financial_source_id": subFinancialSourceId,
    "sub_financial_source_name": subFinancialSourceName,
    "sequence_no": sequenceNo,
    "group_count": groupCount,
    "financial_details": financialDetailsReappropriation == null ? [] : List<dynamic>.from(financialDetailsReappropriation!.map((x) => x.toJson())),
  };
}

class FinancialDetailReappropriation {
  String? baseProjectFinancialSourceId;
  String? baseProjectFinancialSourceName;
  int? sequenceNo;

  FinancialDetailReappropriation({
    this.baseProjectFinancialSourceId,
    this.baseProjectFinancialSourceName,
    this.sequenceNo,
  });

  factory FinancialDetailReappropriation.fromJson(Map<String, dynamic> json) => FinancialDetailReappropriation(
    baseProjectFinancialSourceId: json["base_project_financial_source_id"],
    baseProjectFinancialSourceName: json["base_project_financial_source_name"],
    sequenceNo: json["sequence_no"]?.round(),
  );

  Map<String, dynamic> toJson() => {
    "base_project_financial_source_id": baseProjectFinancialSourceId,
    "base_project_financial_source_name": baseProjectFinancialSourceName,
    "sequence_no": sequenceNo,
  };
}
