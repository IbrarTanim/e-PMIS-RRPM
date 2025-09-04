import 'dart:convert';

WorkflowActionsListResponse workflowActionsListResponseFromJson(String str) =>
    WorkflowActionsListResponse.fromJson(json.decode(str));

String workflowActionsListResponseToJson(WorkflowActionsListResponse data) =>
    json.encode(data.toJson());

class WorkflowActionsListResponse {
  String? id;
  String? action;
  String? actionType;

  WorkflowActionsListResponse({
    this.id,
    this.action,
    this.actionType,
  });


  factory WorkflowActionsListResponse.fromJson(Map<String, dynamic> json) =>WorkflowActionsListResponse(
        id: json["id"],
        action: json["action"],
        actionType: json["actionType"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "action": action,
        "actionType": actionType,
      };
}
