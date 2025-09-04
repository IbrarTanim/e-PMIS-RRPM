// To parse this JSON data, do
//
//     final projectUserListResponse = projectUserListResponseFromJson(jsonString);

import 'dart:convert';

ProjectUserListResponse projectUserListResponseFromJson(String str) => ProjectUserListResponse.fromJson(json.decode(str));

String projectUserListResponseToJson(ProjectUserListResponse data) => json.encode(data.toJson());

class ProjectUserListResponse {
  String? userId;
  String? email;
  String? firstName;
  String? lastName;
  String? firstNameBangla;
  String? fullName;
  String? mobile;
  String? roleName;
  String? roleTitle;
  String? designationName;
  String? officeName;

  ProjectUserListResponse({
    this.userId,
    this.email,
    this.firstName,
    this.lastName,
    this.firstNameBangla,
    this.fullName,
    this.mobile,
    this.roleName,
    this.roleTitle,
    this.designationName,
    this.officeName,
  });

  factory ProjectUserListResponse.fromJson(Map<String, dynamic> json) => ProjectUserListResponse(
    userId: json["user_id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    firstNameBangla: json["first_name_bangla"],
    fullName: json["full_name"],
    mobile: json["mobile"],
    roleName: json["role_name"],
    roleTitle: json["role_title"],
    designationName: json["designation_name"],
    officeName: json["office_name"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "first_name_bangla": firstNameBangla,
    "full_name": fullName,
    "mobile": mobile,
    "role_name": roleName,
    "role_title": roleTitle,
    "designation_name": designationName,
    "office_name": officeName,
  };
}
