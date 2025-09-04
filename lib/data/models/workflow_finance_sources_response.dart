import 'dart:convert';


WorkflowFinanceSourcesResponse workflowFinanceSourcesResponseFromJson(String str) => WorkflowFinanceSourcesResponse.fromJson(json.decode(str));

String workflowFinanceSourcesResponseToJson(WorkflowFinanceSourcesResponse data) => json.encode(data.toJson());

class WorkflowFinanceSourcesResponse {
  String? parentFinancialSourceId;
  String? parentFinancialSourceName;
  int? sequenceNo;
  int? groupCount;
  dynamic financialSourceSubGroup;

  WorkflowFinanceSourcesResponse({
    this.parentFinancialSourceId,
    this.parentFinancialSourceName,
    this.sequenceNo,
    this.groupCount,
    this.financialSourceSubGroup,
  });

  factory WorkflowFinanceSourcesResponse.fromJson(Map<String, dynamic> json) => WorkflowFinanceSourcesResponse(
    parentFinancialSourceId: json["parent_financial_source_id"],
    parentFinancialSourceName: json["parent_financial_source_name"],
    sequenceNo: json["sequence_no"],
    groupCount: json["group_count"],
    financialSourceSubGroup: json["financial_source_sub_group"],
  );

  Map<String, dynamic> toJson() => {
    "parent_financial_source_id": parentFinancialSourceId,
    "parent_financial_source_name": parentFinancialSourceName,
    "sequence_no": sequenceNo,
    "group_count": groupCount,
    "financial_source_sub_group": financialSourceSubGroup,
  };
}



