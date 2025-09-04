import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/project/allocation/allocation_details_list_item.dart';
import 'package:pmis_flutter/ui/features/project/project_details_by_id_controller.dart';
import 'package:pmis_flutter/ui/features/project/project_details_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/text_util.dart';

class NewProjectAllocationDetailsScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;
  final bool isMyProject = false;

  const NewProjectAllocationDetailsScreen({Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  _NewProjectAllocationDetailsScreenState createState() =>
      _NewProjectAllocationDetailsScreenState();
}

class _NewProjectAllocationDetailsScreenState
    extends State<NewProjectAllocationDetailsScreen> {
  final _controllerForProjectDetailsByID =
      Get.put(ProjectDetailsByIDController());
  final _wishListProjectDetailsController =
      Get.put(WishListProjectDetailsController());

  void initCalls() async {
    await _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(stringNullCheck(widget.allProjectsResponse!.projectId));
    await _controllerForProjectDetailsByID.getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());
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
          title: "Allocation Details (in Lakh)",
          onPress: (index) {
            //do active icon job
          }),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          itemCount: _wishListProjectDetailsController.projectAllocationCostResponse.value.length,
          separatorBuilder: (context, index) => const SizedBox(height: 6),
          itemBuilder: (context, index) {
            return NewProjectAllocationCostDetailsItemView(
              projectAllocationCostResponse: _wishListProjectDetailsController.projectAllocationCostResponse[index],
            );
          },
        ),
      ),
    );
  }
}
