// To parse this JSON data, do
//
//     final pcrAttachmentViewResponse = pcrAttachmentViewResponseFromJson(jsonString);

import 'dart:convert';

import 'package:pmis_flutter/utils/common_utils.dart';

PcrAttachmentViewResponse pcrAttachmentViewResponseFromJson(String str) => PcrAttachmentViewResponse.fromJson(json.decode(str));

String pcrAttachmentViewResponseToJson(PcrAttachmentViewResponse data) => json.encode(data.toJson());

class PcrAttachmentViewResponse {
  PcrAttachmentViewResponse({
    this.completionReportAttachmentsId,
    this.remarks,
    this.fileId,
    this.fileName,
    this.receivedDate,
  });

  String? completionReportAttachmentsId;
  String? remarks;
  String? fileId;
  String? fileName;
  String? receivedDate;

  factory PcrAttachmentViewResponse.fromJson(Map<String, dynamic> json) => PcrAttachmentViewResponse(
    completionReportAttachmentsId: json["completion_report_attachments_id"],
    remarks: stringNullCheck(json["remarks"]),
    fileId: json["file_id"],
    fileName: json["file_name"],
    receivedDate: stringNullCheck(json["received_date"]),
  );

  Map<String, dynamic> toJson() => {
    "completion_report_attachments_id": completionReportAttachmentsId,
    "remarks": remarks,
    "file_id": fileId,
    "file_name": fileName,
    "received_date": receivedDate,
  };
}
