// To parse this JSON data, do
//
//     final uploadFileResponse = uploadFileResponseFromJson(jsonString);

import 'dart:convert';

UploadFileResponse uploadFileResponseFromJson(String str) =>
    UploadFileResponse.fromJson(json.decode(str));

String uploadFileResponseToJson(UploadFileResponse data) =>
    json.encode(data.toJson());

class UploadFileResponse {
  UploadFileResponse({
    this.fileName,
    this.fileId,
    this.status,
    this.info,
    this.fileSize,
  });

  String? fileName;
  String? fileId;
  String? status;
  String? info;
  int? fileSize;

  factory UploadFileResponse.fromJson(Map<String, dynamic> json) =>
      UploadFileResponse(
        fileName: json["file_name"],
        fileId: json["file_id"],
        status: json["status"],
        info: json["info"],
        fileSize: json["file_size"],
      );

  Map<String, dynamic> toJson() => {
        "file_name": fileName,
        "file_id": fileId,
        "status": status,
        "info": info,
        "file_size": fileSize,
      };
}
