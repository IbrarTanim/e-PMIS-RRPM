import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/project/project_details_by_id_controller.dart';
import 'package:pmis_flutter/ui/features/project/project_details_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/text_util.dart';

class ProjectEstimatedCostDetailsScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;

  final bool isMyProject = false;

  const ProjectEstimatedCostDetailsScreen({Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  _ProjectEstimatedCostDetailsScreenState createState() =>
      _ProjectEstimatedCostDetailsScreenState();
}

class _ProjectEstimatedCostDetailsScreenState
    extends State<ProjectEstimatedCostDetailsScreen> {
  final _controllerForProjectDetailsByID =
      Get.put(ProjectDetailsByIDController());
  final _wishListProjectDetailsController =
      Get.put(WishListProjectDetailsController());

  void initCalls() async {
    await _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(
        stringNullCheck(widget.allProjectsResponse!.projectId));
    await _controllerForProjectDetailsByID
        .getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());
    await _controllerForProjectDetailsByID
        .getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());
    await _wishListProjectDetailsController.getProjectEstimatedCostData(
        widget.allProjectsResponse!.projectId.toString());
    //await _wishListProjectDetailsController.getProjectAllocationCostData(widget.allProjectsResponse!.projectId.toString());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  void initState() {
    initCalls();
    super.initState();
  }

  @override
  void dispose() {
    // _controller.clearView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      appBar: appBarWithBackAndActions(
          title: "Project Cost Details (in Lakh)",
          onPress: (index) {
            //do active icon job
          }),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              /*textAutoSize(
                  text: "Project Cost (in Lakh)",
                  maxLines: 1,
                  fontSize: dp16,
                  alignment: Alignment.center,
                  fontWeight: FontWeight.bold),
              const Divider(),*/
              Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    //padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: _wishListProjectDetailsController
                        .projectEstimatedCostResponse.value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return projectEstimatedCostDetailsItemView(
                          context,
                          _wishListProjectDetailsController
                              .projectEstimatedCostResponse[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
