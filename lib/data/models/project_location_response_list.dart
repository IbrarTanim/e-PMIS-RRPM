// To parse this JSON data, do
//
//     final projectLocationResponseList = projectLocationResponseListFromJson(jsonString);

import 'dart:convert';

ProjectLocationResponseList projectLocationResponseListFromJson(String str) => ProjectLocationResponseList.fromJson(json.decode(str));

String projectLocationResponseListToJson(ProjectLocationResponseList data) => json.encode(data.toJson());

class ProjectLocationResponseList {
  ProjectLocationResponseList({
    this.projectProformaLocationId,
    this.projectProformaLocationMasterId,
    this.divisionLocationId,
    this.divisionLocationName,
    this.districtLocationId,
    this.districtLocationName,
    this.locations,
  });

  String? projectProformaLocationId;
  String? projectProformaLocationMasterId;
  String? divisionLocationId;
  String? divisionLocationName;
  String? districtLocationId;
  String? districtLocationName;
  String? locations;

  factory ProjectLocationResponseList.fromJson(Map<String, dynamic> json) => ProjectLocationResponseList(
    projectProformaLocationId: json["project_proforma_location_id"],
    projectProformaLocationMasterId: json["project_proforma_location_master_id"],
    divisionLocationId: json["division_location_id"],
    divisionLocationName: json["division_location_name"],
    districtLocationId: json["district_location_id"],
    districtLocationName: json["district_location_name"],
    locations: json["locations"],
  );

  Map<String, dynamic> toJson() => {
    "project_proforma_location_id": projectProformaLocationId,
    "project_proforma_location_master_id": projectProformaLocationMasterId,
    "division_location_id": divisionLocationId,
    "division_location_name": divisionLocationName,
    "district_location_id": districtLocationId,
    "district_location_name": districtLocationName,
    "locations": locations,
  };
}
