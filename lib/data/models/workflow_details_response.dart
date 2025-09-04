import 'dart:convert';

WorkflowDetailsResponse workflowDetailsResponseFromJson(String str) => WorkflowDetailsResponse.fromJson(json.decode(str));

String workflowDetailsResponseToJson(WorkflowDetailsResponse data) => json.encode(data.toJson());

class WorkflowDetailsResponse {
  String? workflowId;
  String? workflowStatus;
  List<Detail>? details;

  WorkflowDetailsResponse({
    this.workflowId,
    this.workflowStatus,
    this.details,
  });

  factory WorkflowDetailsResponse.fromJson(Map<String, dynamic> json) => WorkflowDetailsResponse(
    workflowId: json["workflow_id"],
    workflowStatus: json["workflow_status"],
    details: json["details"] == null ? [] : List<Detail>.from(json["details"]!.map((x) => Detail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "workflow_id": workflowId,
    "workflow_status": workflowStatus,
    "details": details == null ? [] : List<dynamic>.from(details!.map((x) => x.toJson())),
  };
}

class Detail {
  String? firstName;
  String? lastName;
  String? email;
  int? level;
  String? workflowRole;
  String? userType;
  bool? fileOnHand;

  Detail({
    this.firstName,
    this.lastName,
    this.email,
    this.level,
    this.workflowRole,
    this.userType,
    this.fileOnHand,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    level: json["level"],
    workflowRole: json["workflow_role"],
    userType: json["user_type"],
    fileOnHand: json["file_on_hand"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "level": level,
    "workflow_role": workflowRole,
    "user_type": userType,
    "file_on_hand": fileOnHand,
  };
}
