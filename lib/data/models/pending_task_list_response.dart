import 'dart:convert';

PendingTaskResponse pendingTaskResponseFromJson(String str) => PendingTaskResponse.fromJson(json.decode(str));
String pendingTaskResponseToJson(PendingTaskResponse data) => json.encode(data.toJson());

class PendingTaskResponse {
  String? workflowId;
  String? workflowEventName;
  String? projectId;
  String? projectName;
  String? initiatorUserId;
  String? initiatorName;
  String? workflowStatus;
  String? userStatus;
  String? fromUserName;
  String? fromUserAction;
  String? workflowType;
  String? associatedId;
  DateTime? timestamp;

  PendingTaskResponse({
    this.workflowId,
    this.workflowEventName,
    this.projectId,
    this.projectName,
    this.initiatorUserId,
    this.initiatorName,
    this.workflowStatus,
    this.userStatus,
    this.fromUserName,
    this.fromUserAction,
    this.workflowType,
    this.associatedId,
    this.timestamp,
  });

  factory PendingTaskResponse.fromJson(Map<String, dynamic> json) => PendingTaskResponse(
    workflowId: json["workflow_id"],
    workflowEventName: json["workflow_event_name"],
    projectId: json["project_id"],
    projectName: json["project_name"],
    initiatorUserId: json["initiator_user_id"],
    initiatorName: json["initiator_name"],
    workflowStatus: json["workflow_status"],
    userStatus: json["user_status"],
    fromUserName: json["from_user_name"],
    fromUserAction: json["from_user_action"],
    workflowType: json["workflow_type"],
    associatedId: json["associated_id"],
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "workflow_id": workflowId,
    "workflow_event_name": workflowEventName,
    "project_id": projectId,
    "project_name": projectName,
    "initiator_user_id": initiatorUserId,
    "initiator_name": initiatorName,
    "workflow_status": workflowStatus,
    "user_status": userStatus,
    "from_user_name": fromUserName,
    "from_user_action": fromUserAction,
    "workflow_type": workflowType,
    "associated_id": associatedId,
    "timestamp": timestamp?.toIso8601String(),
  };
}