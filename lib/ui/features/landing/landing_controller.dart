import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/LandingProjectCountResponse.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/models/pcr_attachment_view.dart';
import 'package:pmis_flutter/data/models/wish_list_project_details_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

import '../../../../data/models/upload_file_response.dart';
import '../../../data/models/project_details_by_id.dart';

class LandingProjectCountController extends GetxController {

  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }



  /// *** Project Details by Project ID ***///
  Rx<ProjectDetailsById> projectDetailsById = ProjectDetailsById().obs;

  Future<void> getMyProjectListByID(String projectId) async {
    try {
      final resp = await APIRepository().getProjectDetailsByID(projectId);
      hideLoadingDialog();
      if (resp.status == "success" && resp.data != null) {
        projectDetailsById.value = ProjectDetailsById.fromJson(resp.data);
      } else {
        showToast(resp.message, isError: true);
      }
    } catch (err) {
      hideLoadingDialog();
      // Let APIProvider handle auth errors by rethrowing them
      rethrow;
    }
  }



  Rx<LandingProjectCountResponse> landingProjectCount = LandingProjectCountResponse().obs;
  Future<void> getLandingProjectCount() async {
    try {
      final resp = await APIRepository().getLandingProjectCount();
      hideLoadingDialog();
      if (resp.status == "success" && resp.data != null) {
        landingProjectCount.value = LandingProjectCountResponse.fromJson(resp.data);
        debugPrint("LandingProjectCountResponse: ${landingProjectCount.value.currentYearAllocatedAdpRadpProjects.toString()}");
      } else {
        showToast(resp.message, isError: true);
      }
    } catch (err) {
      hideLoadingDialog();
      // Let APIProvider handle auth errors by rethrowing them
      rethrow;
    }
  }




}


