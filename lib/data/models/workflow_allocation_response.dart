import 'dart:convert';


WorkflowAllocationResponse workflowAllocationResponseFromJson(String str) => WorkflowAllocationResponse.fromJson(json.decode(str));

String workflowAllocationResponseToJson(WorkflowAllocationResponse data) => json.encode(data.toJson());


class WorkflowAllocationResponse {
  String? projectAllocationId;
  String? projectId;
  String? fiscalYearId;
  String? developmentTypeId;
  String? developmentTypeName;
  DateTime? timestamp;
  String? status;
  List<EconomicCodeGroup>? economicCodeGroup;

  WorkflowAllocationResponse({
    this.projectAllocationId,
    this.projectId,
    this.fiscalYearId,
    this.developmentTypeId,
    this.developmentTypeName,
    this.timestamp,
    this.status,
    this.economicCodeGroup,
  });

  factory WorkflowAllocationResponse.fromJson(Map<String, dynamic> json) => WorkflowAllocationResponse(
    projectAllocationId: json["project_allocation_id"],
    projectId: json["project_id"],
    fiscalYearId: json["fiscal_year_id"],
    developmentTypeId: json["development_type_id"],
    developmentTypeName: json["development_type_name"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    status: json["status"],
    economicCodeGroup: json["economic_code_group"] == null ? [] : List<EconomicCodeGroup>.from(json["economic_code_group"]!.map((x) => EconomicCodeGroup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "project_allocation_id": projectAllocationId,
    "project_id": projectId,
    "fiscal_year_id": fiscalYearId,
    "development_type_id": developmentTypeId,
    "development_type_name": developmentTypeName,
    "timestamp": timestamp?.toIso8601String(),
    "status": status,
    "economic_code_group": economicCodeGroup == null ? [] : List<dynamic>.from(economicCodeGroup!.map((x) => x.toJson())),
  };
}

class EconomicCodeGroup {
  String? economicCodesTypeId;
  String? economicCodesTypeName;
  List<AllocationFinancialDetail>? allocationFinancialDetails;

  EconomicCodeGroup({
    this.economicCodesTypeId,
    this.economicCodesTypeName,
    this.allocationFinancialDetails,
  });

  factory EconomicCodeGroup.fromJson(Map<String, dynamic> json) => EconomicCodeGroup(
    economicCodesTypeId: json["economic_codes_type_id"],
    economicCodesTypeName: json["economic_codes_type_name"],
    allocationFinancialDetails: json["allocation_financial_details"] == null ? [] : List<AllocationFinancialDetail>.from(json["allocation_financial_details"]!.map((x) => AllocationFinancialDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "economic_codes_type_id": economicCodesTypeId,
    "economic_codes_type_name": economicCodesTypeName,
    "allocation_financial_details": allocationFinancialDetails == null ? [] : List<dynamic>.from(allocationFinancialDetails!.map((x) => x.toJson())),
  };
}

class AllocationFinancialDetail {
  String? projectAllocationFinancialSourcesId;
  String? baseProjectFinancialSourceId;
  int? sequenceNo;
  String? baseProjectFinancialSourceName;
  double? amountLocal;
  double? amountFe;
  double? amountTotal;

  AllocationFinancialDetail({
    this.projectAllocationFinancialSourcesId,
    this.baseProjectFinancialSourceId,
    this.sequenceNo,
    this.baseProjectFinancialSourceName,
    this.amountLocal,
    this.amountFe,
    this.amountTotal,
  });

  factory AllocationFinancialDetail.fromJson(Map<String, dynamic> json) => AllocationFinancialDetail(
    projectAllocationFinancialSourcesId: json["project_allocation_financial_sources_id"],
    baseProjectFinancialSourceId: json["base_project_financial_source_id"],
    sequenceNo: json["sequence_no"]?.round(),
    baseProjectFinancialSourceName: json["base_project_financial_source_name"],
    amountLocal: json["amount_local"],
    amountFe: json["amount_fe"],
    amountTotal: json["amount_total"],
  );

  Map<String, dynamic> toJson() => {
    "project_allocation_financial_sources_id": projectAllocationFinancialSourcesId,
    "base_project_financial_source_id": baseProjectFinancialSourceId,
    "sequence_no": sequenceNo,
    "base_project_financial_source_name": baseProjectFinancialSourceName,
    "amount_local": amountLocal,
    "amount_fe": amountFe,
    "amount_total": amountTotal,
  };
}