import 'dart:convert';

WorkflowRolesDataResponse workflowRolesDataResponseFromJson(String str) => WorkflowRolesDataResponse.fromJson(json.decode(str));

String workflowRolesDataResponseToJson(WorkflowRolesDataResponse data) => json.encode(data.toJson());

class WorkflowRolesDataResponse {
  String? id;
  String? name;

  WorkflowRolesDataResponse({
    this.id,
    this.name,
  });

  factory WorkflowRolesDataResponse.fromJson(Map<String, dynamic> json) => WorkflowRolesDataResponse(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}