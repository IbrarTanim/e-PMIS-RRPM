import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/pending_task_list_response.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pending_task/project_header_card_workflow.dart';
import 'package:pmis_flutter/utils/alert_util.dart';

import 'work_flow_details_screen.dart';
// Zabir

Widget projectListItemWorkflow(
    BuildContext context, PendingTaskResponse pendingTaskResponse,
    {bool? isFavorite = true,
    bool isMyProject = false,
    Widget Function()? customRoute}) {
  return ProjectHeaderCardWorkflow(
    projectData: pendingTaskResponse,
    onLongPress: () {
      alertForInfo(
          context: context,
          title: 'ProjectFullName'.tr,
          message: pendingTaskResponse.projectName.toString());
    },
    onTap: () {
      Get.to(() => WorkFlowDetailsScreen(allProjectsResponse: pendingTaskResponse));
    },
  );
}
