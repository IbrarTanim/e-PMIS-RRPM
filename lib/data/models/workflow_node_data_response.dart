import 'dart:convert';


WorkflowNodeDataResponse workflowNodeDataResponseFromJson(String str) => WorkflowNodeDataResponse.fromJson(json.decode(str));

String workflowNodeDataResponseToJson(WorkflowNodeDataResponse data) => json.encode(data.toJson());

class WorkflowNodeDataResponse {
  String? workflowId;
  String? projectId;
  String? workflowStatus;
  DateTime? timestamp;
  String? eventId;
  String? eventName;
  String? initiatorName;
  String? initiatorUserId;
  String? workflowRoleId;
  String? workflowRole;
  String? workflowType;
  String? associatedId;
  List<WorkflowNode>? workflowNode;

  WorkflowNodeDataResponse({
    this.workflowId,
    this.projectId,
    this.workflowStatus,
    this.timestamp,
    this.eventId,
    this.eventName,
    this.initiatorName,
    this.initiatorUserId,
    this.workflowRoleId,
    this.workflowRole,
    this.workflowType,
    this.associatedId,
    this.workflowNode,
  });

  factory WorkflowNodeDataResponse.fromJson(Map<String, dynamic> json) => WorkflowNodeDataResponse(
    workflowId: json["workflow_id"],
    projectId: json["project_id"],
    workflowStatus: json["workflow_status"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    eventId: json["event_id"],
    eventName: json["event_name"],
    initiatorName: json["initiator_name"],
    initiatorUserId: json["initiator_user_id"],
    workflowRoleId: json["workflow_role_id"],
    workflowRole: json["workflow_role"],
    workflowType: json["workflow_type"],
    associatedId: json["associated_id"],
    workflowNode: json["workflow_node"] == null ? [] : List<WorkflowNode>.from(json["workflow_node"]!.map((x) => WorkflowNode.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "workflow_id": workflowId,
    "project_id": projectId,
    "workflow_status": workflowStatus,
    "timestamp": "${timestamp!.year.toString().padLeft(4, '0')}-${timestamp!.month.toString().padLeft(2, '0')}-${timestamp!.day.toString().padLeft(2, '0')}",
    "event_id": eventId,
    "event_name": eventName,
    "initiator_name": initiatorName,
    "initiator_user_id": initiatorUserId,
    "workflow_role_id": workflowRoleId,
    "workflow_role": workflowRole,
    "workflow_type": workflowType,
    "associated_id": associatedId,
    "workflow_node": workflowNode == null ? [] : List<dynamic>.from(workflowNode!.map((x) => x.toJson())),
  };
}

class WorkflowNode {
  String? workflowRoleId;
  String? workflowRoleName;
  String? workflowNodeId;
  int? workflowLevel;
  bool? fileOnHand;
  String? workflowUserName;
  String? workflowUserId;

  WorkflowNode({
    this.workflowRoleId,
    this.workflowRoleName,
    this.workflowNodeId,
    this.workflowLevel,
    this.fileOnHand,
    this.workflowUserName,
    this.workflowUserId,
  });

  factory WorkflowNode.fromJson(Map<String, dynamic> json) => WorkflowNode(
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
