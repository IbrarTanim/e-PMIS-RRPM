// To parse this JSON data, do
//
//     final userInfoResponse = userInfoResponseFromJson(jsonString);

import 'dart:convert';

UserInfoResponse userInfoResponseFromJson(String str) => UserInfoResponse.fromJson(json.decode(str));

String userInfoResponseToJson(UserInfoResponse data) => json.encode(data.toJson());

class UserInfoResponse {
  UserInfoResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.nid,
    this.email,
    this.hasToChangePassword,
    this.administrativeHierarchyId,
    this.hierarchyTypeId,
    this.officeId,
    this.designationName,
    this.role,
  });

  String? id;
  String? firstName;
  String? lastName;
  String? nid;
  String? email;
  bool? hasToChangePassword;
  String? administrativeHierarchyId;
  String? hierarchyTypeId;
  String? officeId;
  String? designationName;
  List<Role>? role;

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) => UserInfoResponse(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    nid: json["nid"],
    email: json["email"],
    hasToChangePassword: json["has_to_change_password"],
    administrativeHierarchyId: json["administrative_hierarchy_id"],
    hierarchyTypeId: json["hierarchy_type_id"],
    officeId: json["office_id"],
    designationName: json["designation_name"],
    role: List<Role>.from(json["role"].map((x) => Role.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "nid": nid,
    "email": email,
    "has_to_change_password": hasToChangePassword,
    "administrative_hierarchy_id": administrativeHierarchyId,
    "hierarchy_type_id": hierarchyTypeId,
    "office_id": officeId,
    "designation_name": designationName,
    "role": role == null ? null : List<dynamic>.from(role!.map((x) => x.toJson())),
  };
}

class Role {
  Role({
    this.id,
    this.name,
    this.title,
    this.type,
    this.hasOffice,
  });

  String? id;
  String? name;
  String? title;
  String? type;
  bool? hasOffice;

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
