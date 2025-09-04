import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/project/expenditure/expenditure_list_item.dart';
import 'package:pmis_flutter/ui/features/project/project_details_by_id_controller.dart';
import 'package:pmis_flutter/ui/features/project/project_details_controller.dart';
import 'package:pmis_flutter/ui/features/project/release/release_list_item.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/text_util.dart';

class NewProjectFundReleaseSummeryDetailsScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;
  final bool isMyProject = false;

  const NewProjectFundReleaseSummeryDetailsScreen(
      {Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  _NewProjectFundReleaseSummeryDetailsScreenState createState() =>
      _NewProjectFundReleaseSummeryDetailsScreenState();
}

class _NewProjectFundReleaseSummeryDetailsScreenState
    extends State<NewProjectFundReleaseSummeryDetailsScreen> {
  final _controllerForProjectDetailsByID =
  Get.put(ProjectDetailsByIDController());
  final _wishListProjectDetailsController =
  Get.put(WishListProjectDetailsController());

  void initCalls() async {
    await _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(stringNullCheck(widget.allProjectsResponse!.projectId));
    await _controllerForProjectDetailsByID.getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());
    await _wishListProjectDetailsController.getProjectEstimatedCostData(widget.allProjectsResponse!.projectId.toString());
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBarWithBackAndActions(
        //title: "Expenditure Details (in Lakh)",
          title: " Fund Release",
          onPress: (index) {
            //do active icon job
          }),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          itemCount: _wishListProjectDetailsController.projectFundReleaseSummaryResponse.value.length,
          separatorBuilder: (context, index) => const SizedBox(height: 6),
          itemBuilder: (context, index) {
            return NewProjectFundReleaseSummeryDetailsItemView(projectFundReleaseSummaryResponse: _wishListProjectDetailsController.projectFundReleaseSummaryResponse[index],
            );
          },
        ),
      ),
    );
  }
}
