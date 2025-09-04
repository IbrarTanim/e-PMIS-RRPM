import 'dart:convert';

ProjectEstimatedCostResponse projectEstimatedCostResponseFromJson(String str) => ProjectEstimatedCostResponse.fromJson(json.decode(str));

String projectEstimatedCostResponseToJson(ProjectEstimatedCostResponse data) => json.encode(data.toJson());

class ProjectEstimatedCostResponse {
  bool? hasRevision;
  List<ProjectFinancialSource>? projectFinancialSource;
  List<ProjectFinancialSourceMode>? projectFinancialSourceMode;

  ProjectEstimatedCostResponse({
    this.hasRevision,
    this.projectFinancialSource,
    this.projectFinancialSourceMode,
  });

  factory ProjectEstimatedCostResponse.fromJson(Map<String, dynamic> json) => ProjectEstimatedCostResponse(
    hasRevision: json["has_revision"],
    projectFinancialSource: json["project_financial_source"] == null ? [] : List<ProjectFinancialSource>.from(json["project_financial_source"]!.map((x) => ProjectFinancialSource.fromJson(x))),
    projectFinancialSourceMode: json["project_financial_source_mode"] == null ? [] : List<ProjectFinancialSourceMode>.from(json["project_financial_source_mode"]!.map((x) => ProjectFinancialSourceMode.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "has_revision": hasRevision,
    "project_financial_source": projectFinancialSource == null ? [] : List<dynamic>.from(projectFinancialSource!.map((x) => x.toJson())),
    "project_financial_source_mode": projectFinancialSourceMode == null ? [] : List<dynamic>.from(projectFinancialSourceMode!.map((x) => x.toJson())),
  };
}

class ProjectFinancialSource {
  String? baseProjectFinancialSourceId;

  ProjectFinancialSource({
    this.baseProjectFinancialSourceId,
  });

  factory ProjectFinancialSource.fromJson(Map<String, dynamic> json) => ProjectFinancialSource(
    baseProjectFinancialSourceId: json["base_project_financial_source_id"],
  );

  Map<String, dynamic> toJson() => {
    "base_project_financial_source_id": baseProjectFinancialSourceId,
  };
}

class ProjectFinancialSourceMode {
  String? projectProformaSourceModeFinancingId;
  String? baseProjectFinancialModeId;
  String? baseProjectFinancialModeName;
  String? baseProjectFinancialSourceId;
  String? baseProjectFinancialSourceName;
  String? baseProjectFinancialSourceParentId;
  String? baseProjectFinancialSourceParentName;
  dynamic developmentPartnersId;
  dynamic developmentPartnersName;
  dynamic description;
  int? inKind;
  double? cashLocal;
  int? cashFe;

  ProjectFinancialSourceMode({
    this.projectProformaSourceModeFinancingId,
    this.baseProjectFinancialModeId,
    this.baseProjectFinancialModeName,
    this.baseProjectFinancialSourceId,
    this.baseProjectFinancialSourceName,
    this.baseProjectFinancialSourceParentId,
    this.baseProjectFinancialSourceParentName,
    this.developmentPartnersId,
    this.developmentPartnersName,
    this.description,
    this.inKind,
    this.cashLocal,
    this.cashFe,
  });

  factory ProjectFinancialSourceMode.fromJson(Map<String, dynamic> json) => ProjectFinancialSourceMode(
    projectProformaSourceModeFinancingId: json["project_proforma_source_mode_financing_id"],
    baseProjectFinancialModeId: json["base_project_financial_mode_id"],
    baseProjectFinancialModeName: json["base_project_financial_mode_name"],
    baseProjectFinancialSourceId: json["base_project_financial_source_id"],
    baseProjectFinancialSourceName: json["base_project_financial_source_name"],
    baseProjectFinancialSourceParentId: json["base_project_financial_source_parent_id"],
    baseProjectFinancialSourceParentName: json["base_project_financial_source_parent_name"],
    developmentPartnersId: json["development_partners_id"],
    developmentPartnersName: json["development_partners_name"],
    description: json["description"],
    inKind: json["in_kind"]?.round(),
    cashLocal: json["cash_local"],
    cashFe: json["cash_fe"]?.round(),
  );

  Map<String, dynamic> toJson() => {
    "project_proforma_source_mode_financing_id": projectProformaSourceModeFinancingId,
    "base_project_financial_mode_id": baseProjectFinancialModeId,
    "base_project_financial_mode_name": baseProjectFinancialModeName,
    "base_project_financial_source_id": baseProjectFinancialSourceId,
    "base_project_financial_source_name": baseProjectFinancialSourceName,
    "base_project_financial_source_parent_id": baseProjectFinancialSourceParentId,
    "base_project_financial_source_parent_name": baseProjectFinancialSourceParentName,
    "development_partners_id": developmentPartnersId,
    "development_partners_name": developmentPartnersName,
    "description": description,
    "in_kind": inKind,
    "cash_local": cashLocal,
    "cash_fe": cashFe,
  };
}


