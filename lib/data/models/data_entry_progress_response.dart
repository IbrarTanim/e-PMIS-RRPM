// To parse this JSON data, do
//
//     final dataEntryProgressResponse = dataEntryProgressResponseFromJson(jsonString);

import 'dart:convert';

DataEntryProgressResponse dataEntryProgressResponseFromJson(String str) => DataEntryProgressResponse.fromJson(json.decode(str));

String dataEntryProgressResponseToJson(DataEntryProgressResponse data) => json.encode(data.toJson());

class DataEntryProgressResponse {
  String? projectId;
  String? projectName;
  dynamic projectCode;
  double? dataSubmissionProgressPercentage;
  int? noOfMonth;
  int? dataSubmittedNoOfMonth;
  dynamic projectDirectorName;
  dynamic projectDirectorUserId;
  dynamic dateOfCommencement;
  dynamic dateOfCompletion;

  DataEntryProgressResponse({
    this.projectId,
    this.projectName,
    this.projectCode,
    this.dataSubmissionProgressPercentage,
    this.noOfMonth,
    this.dataSubmittedNoOfMonth,
    this.projectDirectorName,
    this.projectDirectorUserId,
    this.dateOfCommencement,
    this.dateOfCompletion,
  });

  factory DataEntryProgressResponse.fromJson(Map<String, dynamic> json) => DataEntryProgressResponse(
    projectId: json["project_id"],
    projectName: json["project_name"],
    projectCode: json["project_code"],
    dataSubmissionProgressPercentage: json["data_submission_progress_percentage"]?.toDouble(),
    noOfMonth: json["no_of_month"]?.round(),
    dataSubmittedNoOfMonth: json["data_submitted_no_of_month"]?.round(),
    projectDirectorName: json["project_director_name"],
    projectDirectorUserId: json["project_director_user_id"],
    dateOfCommencement: json["date_of_commencement"],
    dateOfCompletion: json["date_of_completion"],
  );

  Map<String, dynamic> toJson() => {
    "project_id": projectId,
    "project_name": projectName,
    "project_code": projectCode,
    "data_submission_progress_percentage": dataSubmissionProgressPercentage,
    "no_of_month": noOfMonth,
    "data_submitted_no_of_month": dataSubmittedNoOfMonth,
    "project_director_name": projectDirectorName,
    "project_director_user_id": projectDirectorUserId,
    "date_of_commencement": dateOfCommencement,
    "date_of_completion": dateOfCompletion,
  };
}
