// To parse this JSON data, do
//
//     final userOfficeHistoryListItemResponse = userOfficeHistoryListItemResponseFromJson(jsonString);

import 'dart:convert';

List<UserOfficeHistoryListItemResponse> userOfficeHistoryListItemResponseFromJson(String str) => List<UserOfficeHistoryListItemResponse>.from(json.decode(str).map((x) => UserOfficeHistoryListItemResponse.fromJson(x)));

String userOfficeHistoryListItemResponseToJson(List<UserOfficeHistoryListItemResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserOfficeHistoryListItemResponse {
  UserOfficeHistoryListItemResponse({
    this.userOfficeHistoryId,
    this.userId,
    this.officeId,
    this.designationId,
    this.userName,
    this.designationName,
    this.officeName,
    this.gradeId,
    this.payScaleId,
    this.joinDate,
    this.releaseDate,
    this.goCode,
    this.goDocumentId,
  });

  String? userOfficeHistoryId;
  String? userId;
  String? officeId;
  String? designationId;
  String? userName;
  String? designationName;
  String? officeName;
  String? gradeId;
  String? payScaleId;
  String? joinDate;
  dynamic releaseDate;
  dynamic goCode;
  dynamic goDocumentId;

  factory UserOfficeHistoryListItemResponse.fromJson(Map<String, dynamic> json) => UserOfficeHistoryListItemResponse(
    userOfficeHistoryId: json["user_office_history_id"],
    userId: json["user_id"],
    officeId: json["office_id"],
    designationId: json["designation_id"],
    userName: json["user_name"],
    designationName: json["designation_name"],
    officeName: json["office_name"],
    gradeId: json["grade_id"],
    payScaleId: json["pay_scale_id"],
    joinDate: json["join_date"],
    releaseDate: json["release_date"],
    goCode: json["go_code"],
    goDocumentId: json["go_document_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_office_history_id": userOfficeHistoryId,
    "user_id": userId,
    "office_id": officeId,
    "designation_id": designationId,
    "user_name": userName,
    "designation_name": designationName,
    "office_name": officeName,
    "grade_id": gradeId,
    "pay_scale_id": payScaleId,
    "join_date": joinDate,
    "release_date": releaseDate,
    "go_code": goCode,
    "go_document_id": goDocumentId,
  };
}
