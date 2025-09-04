// To parse this JSON data, do
//
//     final userListResponse = userListResponseFromJson(jsonString);

import 'dart:convert';

UserListResponse userListResponseFromJson(String str) => UserListResponse.fromJson(json.decode(str));

String userListResponseToJson(UserListResponse data) => json.encode(data.toJson());

class UserListResponse {
  String? userOfficeMappingId;
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? adminHierarchyName;
  bool? isMonitoringOfficer;
  bool? hasToChangePassword;
  List<Role>? role;
  String? designation;

  UserListResponse({
    this.userOfficeMappingId,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.adminHierarchyName,
    this.isMonitoringOfficer,
    this.hasToChangePassword,
    this.role,
    this.designation,
  });

  factory UserListResponse.fromJson(Map<String, dynamic> json) => UserListResponse(
    userOfficeMappingId: json["user_office_mapping_id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    mobileNumber: json["mobile_number"],
    adminHierarchyName: json["admin_hierarchy_name"],
    isMonitoringOfficer: json["is_monitoring_officer"],
    hasToChangePassword: json["has_to_change_password"],
    role: json["role"] == null ? [] : List<Role>.from(json["role"]!.map((x) => Role.fromJson(x))),
    designation: json["designation"],
  );

  Map<String, dynamic> toJson() => {
    "user_office_mapping_id": userOfficeMappingId,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "mobile_number": mobileNumber,
    "admin_hierarchy_name": adminHierarchyName,
    "is_monitoring_officer": isMonitoringOfficer,
    "has_to_change_password": hasToChangePassword,
    "role": role == null ? [] : List<dynamic>.from(role!.map((x) => x.toJson())),
    "designation": designation,
  };
}

class Role {
  String? id;
  String? name;
  String? title;
  String? type;
  bool? hasOffice;

  Role({
    this.id,
    this.name,
    this.title,
    this.type,
    this.hasOffice,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    title: json["title"],
    type: json["type"],
    hasOffice: json["hasOffice"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "title": title,
    "type": type,
    "hasOffice": hasOffice,
  };
}
