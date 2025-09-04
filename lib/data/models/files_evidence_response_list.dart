// To parse this JSON data, do
//
//     final filesEvidenceResponseList = filesEvidenceResponseListFromJson(jsonString);

import 'dart:convert';

FilesEvidenceResponseList filesEvidenceResponseListFromJson(String str) => FilesEvidenceResponseList.fromJson(json.decode(str));

String filesEvidenceResponseListToJson(FilesEvidenceResponseList data) => json.encode(data.toJson());

class FilesEvidenceResponseList {
  FilesEvidenceResponseList({
    this.evidenceFilesId,
    this.projectId,
    this.fileName,
    this.fileId,
    this.fileTypeId,
    this.latitude,
    this.longitude,
    this.userId,
    this.userName,
    this.evidenceLocation,
    this.timestamp,
  });

  String? evidenceFilesId;
  String? projectId;
  String? fileName;
  String? fileId;
  String? fileTypeId;
  double? latitude;
  double? longitude;
  String? userId;
  String? userName;
  String? evidenceLocation;
  String? timestamp;

  factory FilesEvidenceResponseList.fromJson(Map<String, dynamic> json) => FilesEvidenceResponseList(
    evidenceFilesId: json["evidence_files_id"],
    projectId: json["project_id"],
    fileName: json["file_name"],
    fileId: json["file_id"],
    fileTypeId: json["file_type_id"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    userId: json["user_id"],
    userName: json["user_name"],
    evidenceLocation: json["evidence_location"],
    timestamp: json["timestamp"],
  );

  Map<String, dynamic> toJson() => {
    "evidence_files_id": evidenceFilesId,
    "project_id": projectId,
    "file_name": fileName,
    "file_id": fileId,
    "file_type_id": fileTypeId,
    "latitude": latitude,
    "longitude": longitude,
    "user_id": userId,
    "user_name": userName,
    "evidence_location": evidenceLocation,
    "timestamp": timestamp,
  };
}
