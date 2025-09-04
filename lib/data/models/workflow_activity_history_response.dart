import 'dart:convert';

WorkflowActivityHistoryResponse workflowActivityHistoryResponseFromJson(
        String str) =>
    WorkflowActivityHistoryResponse.fromJson(json.decode(str));

String workflowActivityHistoryResponseToJson(
        WorkflowActivityHistoryResponse data) =>
    json.encode(data.toJson());

class WorkflowActivityHistoryResponse {
  String? id;
  String? projectId;
  String? workflowEventId;
  String? workflowEventName;
  String? initiatorUserId;
  String? initiatorName;
  DateTime? timestamp;
  String? status;
  List<WorkflowActivity>? workflowActivities;

  WorkflowActivityHistoryResponse({
    this.id,
    this.projectId,
    this.workflowEventId,
    this.workflowEventName,
    this.initiatorUserId,
    this.initiatorName,
    this.timestamp,
    this.status,
    this.workflowActivities,
  });

  factory WorkflowActivityHistoryResponse.fromJson(Map<String, dynamic> json) =>
      WorkflowActivityHistoryResponse(
        id: json["id"],
        projectId: json["project_id"],
        workflowEventId: json["workflow_event_id"],
        workflowEventName: json["workflow_event_name"],
        initiatorUserId: json["initiator_user_id"],
        initiatorName: json["initiator_name"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
        status: json["status"],
        workflowActivities: json["workflow_activities"] == null
            ? []
            : List<WorkflowActivity>.from(json["workflow_activities"]!
                .map((x) => WorkflowActivity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "project_id": projectId,
        "workflow_event_id": workflowEventId,
        "workflow_event_name": workflowEventName,
        "initiator_user_id": initiatorUserId,
        "initiator_name": initiatorName,
        "timestamp": timestamp?.toIso8601String(),
        "status": status,
        "workflow_activities": workflowActivities == null
            ? []
            : List<dynamic>.from(workflowActivities!.map((x) => x.toJson())),
      };
}

class WorkflowActivity {
  String? id;
  String? workflowNodeFromId;
  String? workflowNodeToId;
  String? workflowActionId;
  String? workflowActionName;
  String? workflowNodeFromUsername;
  String? workflowNodeToUsername;
  DateTime? timestamp;
  String? workflowNodeFromComment;
  String? workflowNodeFromRoleId;
  String? workflowNodeFromRoleName;
  String? workflowNodeToRoleId;
  String? workflowNodeToRoleName;
  bool? workflowNodeToFileOnHand;
  List<WorkflowNodeFromAttachmentFileId>? workflowNodeFromAttachmentFileIds;

  WorkflowActivity({
    this.id,
    this.workflowNodeFromId,
    this.workflowNodeToId,
    this.workflowActionId,
    this.workflowActionName,
    this.workflowNodeFromUsername,
    this.workflowNodeToUsername,
    this.timestamp,
    this.workflowNodeFromComment,
    this.workflowNodeFromRoleId,
    this.workflowNodeFromRoleName,
    this.workflowNodeToRoleId,
    this.workflowNodeToRoleName,
    this.workflowNodeToFileOnHand,
    this.workflowNodeFromAttachmentFileIds,
  });

  factory WorkflowActivity.fromJson(Map<String, dynamic> json) =>
      WorkflowActivity(
        id: json["id"],
        workflowNodeFromId: json["workflow_node_from_id"],
        workflowNodeToId: json["workflow_node_to_id"],
        workflowActionId: json["workflow_action_id"],
        workflowActionName: json["workflow_action_name"],
        workflowNodeFromUsername: json["workflow_node_from_username"],
        workflowNodeToUsername: json["workflow_node_to_username"],
        timestamp: json["timestamp"] == null
            ? null
            : DateTime.parse(json["timestamp"]),
        workflowNodeFromComment: json["workflow_node_from_comment"],
        workflowNodeFromRoleId: json["workflow_node_from_role_id"],
        workflowNodeFromRoleName: json["workflow_node_from_role_name"],
        workflowNodeToRoleId: json["workflow_node_to_role_id"],
        workflowNodeToRoleName: json["workflow_node_to_role_name"],
        workflowNodeToFileOnHand: json["workflow_node_to_file_on_hand"],
        workflowNodeFromAttachmentFileIds:
            json["workflow_node_from_attachment_file_ids"] == null
                ? []
                : List<WorkflowNodeFromAttachmentFileId>.from(
                    json["workflow_node_from_attachment_file_ids"]!.map(
                        (x) => WorkflowNodeFromAttachmentFileId.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "workflow_node_from_id": workflowNodeFromId,
        "workflow_node_to_id": workflowNodeToId,
        "workflow_action_id": workflowActionId,
        "workflow_action_name": workflowActionName,
        "workflow_node_from_username": workflowNodeFromUsername,
        "workflow_node_to_username": workflowNodeToUsername,
        "timestamp": timestamp?.toIso8601String(),
        "workflow_node_from_comment": workflowNodeFromComment,
        "workflow_node_from_role_id": workflowNodeFromRoleId,
        "workflow_node_from_role_name": workflowNodeFromRoleName,
        "workflow_node_to_role_id": workflowNodeToRoleId,
        "workflow_node_to_role_name": workflowNodeToRoleName,
        "workflow_node_to_file_on_hand": workflowNodeToFileOnHand,
        "workflow_node_from_attachment_file_ids":
            workflowNodeFromAttachmentFileIds == null
                ? []
                : List<dynamic>.from(
                    workflowNodeFromAttachmentFileIds!.map((x) => x.toJson())),
      };
}

class WorkflowNodeFromAttachmentFileId {
  String? fileId;
  String? fileName;

  WorkflowNodeFromAttachmentFileId({
    this.fileId,
    this.fileName,
  });

  factory WorkflowNodeFromAttachmentFileId.fromJson(
          Map<String, dynamic> json) =>
      WorkflowNodeFromAttachmentFileId(
        fileId: json["file_id"],
        fileName: json["file_name"],
      );

  Map<String, dynamic> toJson() => {
        "file_id": fileId,
        "file_name": fileName,
      };
}
