// To parse this JSON data, do
//
//     final pdInfoListResponse = pdInfoListResponseFromJson(jsonString);

import 'dart:convert';

PdInfoListResponse pdInfoListResponseFromJson(String str) => PdInfoListResponse.fromJson(json.decode(str));

String pdInfoListResponseToJson(PdInfoListResponse data) => json.encode(data.toJson());

class PdInfoListResponse {
  PdInfoListResponse({
    this.userId,
    this.email,
    this.firstName,
    this.lastName,
    this.firstNameBangla,
    this.fullName,
    this.mobile,
    this.nid,
    this.roleName,
    this.roleTitle,
    this.designationName,
    this.officeName,
  });

  String? userId;
  String? email;
  String? firstName;
  String? lastName;
  String? firstNameBangla;
  String? fullName;
  String? mobile;
  String? nid;
  String? roleName;
  String? roleTitle;
  String? designationName;
  String? officeName;

  factory PdInfoListResponse.fromJson(Map<String, dynamic> json) => PdInfoListResponse(
    userId: json["user_id"],
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    firstNameBangla: json["first_name_bangla"],
    fullName: json["full_name"],
    mobile: json["mobile"],
    nid: json["nid"],
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
    "nid": nid,
    "role_name": roleName,
    "role_title": roleTitle,
    "designation_name": designationName,
    "office_name": officeName,
  };
}
