import 'dart:convert';

WorkflowNodeResponse workflowNodeResponseFromJson(String str) =>
    WorkflowNodeResponse.fromJson(json.decode(str));

String workflowNodeResponseToJson(WorkflowNodeResponse data) =>
    json.encode(data.toJson());

class WorkflowNodeResponse {
  String? workflowRoleId;
  String? workflowRoleName;
  String? workflowNodeId;
  int? workflowLevel;
  bool? fileOnHand;
  String? workflowUserName;
  String? workflowUserId;

  WorkflowNodeResponse({
    this.workflowRoleId,
    this.workflowRoleName,
    this.workflowNodeId,
    this.workflowLevel,
    this.fileOnHand,
    this.workflowUserName,
    this.workflowUserId,
  });

  factory WorkflowNodeResponse.fromJson(Map<String, dynamic> json) =>
      WorkflowNodeResponse(
        workflowRoleId: json["workflow_role_id"],
        workflowRoleName: json["workflow_role_name"],
        workflowNodeId: json["workflow_node_id"],
        workflowLevel: json["workflow_level"],
        fileOnHand: json["file_on_hand"],
        workflowUserName: json["workflow_user_name"],
        workflowUserId: json["workflow_user_id"],
      );

  Map<String, dynamic> toJson() => {
        "workflow_role_id": workflowRoleId,
        "workflow_role_name": workflowRoleName,
        "workflow_node_id": workflowNodeId,
        "workflow_level": workflowLevel,
        "file_on_hand": fileOnHand,
        "workflow_user_name": workflowUserName,
        "workflow_user_id": workflowUserId,
      };
}
