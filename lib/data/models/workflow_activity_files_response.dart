// To parse this JSON data, do
//
//     final filesEvidenceResponseList = filesEvidenceResponseListFromJson(jsonString);

import 'dart:convert';

WorkflowActivityFilesResponseList filesEvidenceResponseListFromJson(
        String str) =>
    WorkflowActivityFilesResponseList.fromJson(json.decode(str));

String filesEvidenceResponseListToJson(
        WorkflowActivityFilesResponseList data) =>
    json.encode(data.toJson());

class WorkflowActivityFilesResponseList {
  WorkflowActivityFilesResponseList({
    this.fileName,
    this.fileId,
    this.fileSize,
  });

  String? fileName;
  String? fileId;
  String? fileSize;

  factory WorkflowActivityFilesResponseList.fromJson(
          Map<String, dynamic> json) =>
      WorkflowActivityFilesResponseList(
        fileName: json["file_name"],
        fileId: json["file_id"],
        fileSize: json["file_size"],
      );

  Map<String, dynamic> toJson() => {
        "file_name": fileName,
        "file_id": fileId,
        "file_size": fileSize,
      };
}
