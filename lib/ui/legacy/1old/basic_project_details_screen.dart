import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/project/basic_project_details_view.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import '../../features/project/project_details_by_id_controller.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;
  const ProjectDetailsScreen({Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  final _controllerForProjectDetailsByID =
      Get.put(ProjectDetailsByIDController());

  @override
  void initState() {
    super.initState();
    initCalls();
  }

  void initCalls() async {
    await _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(
        stringNullCheck(widget.allProjectsResponse!.projectId));
    await _controllerForProjectDetailsByID
        .getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBarWithBackAndActions(title: 'ProjectDetails'.tr),
      body: BsicProjectDetailsView(
        projectData: widget.allProjectsResponse!,
        controller: _controllerForProjectDetailsByID,
      ),
    );
  }
}
