import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/project/common/project_header_card.dart';
import 'package:pmis_flutter/ui/features/project/project_details_bottom_bar.dart';
import 'package:pmis_flutter/ui/legacy/1old/basic_project_details_screen.dart';
import 'package:pmis_flutter/utils/alert_util.dart';
// Zabir

Widget projectListItem(
    BuildContext context, AllProjectsResponse allProjectsResponse,
    {bool? isFavorite = true,
    bool isMyProject = false,
    Widget Function()? customRoute}) {
  return ProjectHeaderCard(
    projectData: allProjectsResponse,
    onLongPress: () {
      alertForInfo(
          context: context,
          title: 'ProjectFullName'.tr,
          message: allProjectsResponse.name.toString());
    },
    onTap: () {
      Get.to(() =>
          customRoute?.call() ??
          (isMyProject
              ? ProjectDetailsBottomBar(
                  allProjectsResponse: allProjectsResponse)
              : ProjectDetailsScreen(
                  allProjectsResponse: allProjectsResponse)));
    },
  );
}
