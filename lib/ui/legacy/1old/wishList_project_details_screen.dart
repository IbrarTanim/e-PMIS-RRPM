import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/projects_list_response.dart';
import 'package:pmis_flutter/ui/legacy/1unused/all_my_projects/all_my_projects_screen.dart';

import 'package:pmis_flutter/ui/legacy/1old/project_allocation_details_screen.dart';
import 'package:pmis_flutter/ui/legacy/1old/project_estimated_cost_details_screen.dart';
import 'package:pmis_flutter/ui/legacy/1old/project_expenditure_cost_details_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/projects/projects_controller.dart';
import 'package:pmis_flutter/ui/features/project/project_details_controller.dart';
import 'package:pmis_flutter/ui/legacy/1old/wishlist_projects_survey_gallery_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/button_util.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import '../../features/project/project_details_by_id_controller.dart';
import '../survey_gallery_screen.dart';

class WishListProjectDetailsScreen extends StatefulWidget {
  final AllProjectsResponse? projectsListResponse;
  //final ProjectsListResponse? projectsListResponse;
  final bool isMyProject = false;

  const WishListProjectDetailsScreen({Key? key, this.projectsListResponse})
      : super(key: key);

  @override
  _WishListProjectDetailsScreenState createState() =>
      _WishListProjectDetailsScreenState();
}

class _WishListProjectDetailsScreenState
    extends State<WishListProjectDetailsScreen> {
  bool isLoading = true;
  ProjectsListResponse? projectsResponse;
  final _projectsController = Get.put(ProjectsController());
  final _controllerForProjectDetailsByID =
      Get.put(ProjectDetailsByIDController());
  final _wishListProjectDetailsController =
      Get.put(WishListProjectDetailsController());

  void initCalls() async {
    await _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(
        stringNullCheck(widget.projectsListResponse!.projectId));
    await _controllerForProjectDetailsByID.getMyProjectListByID(
        widget.projectsListResponse!.projectId.toString());
    await _wishListProjectDetailsController.getWishListProjectReport(
        widget.projectsListResponse!.projectId.toString());
    await _wishListProjectDetailsController.getProjectEstimatedCostData(
        widget.projectsListResponse!.projectId.toString());
    await _wishListProjectDetailsController.getProjectAllocationCostData(
        widget.projectsListResponse!.projectId.toString());
    await _wishListProjectDetailsController.getProjectExpenditureCostData(widget.projectsListResponse!.projectId.toString());
    await _wishListProjectDetailsController.getProjectFundReleaseSummaryData(widget.projectsListResponse!.projectId.toString());
    await _wishListProjectDetailsController.getDataEntryProgress(widget.projectsListResponse!.projectId.toString());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isLoading = false;
      });
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
    final projectID = widget.projectsListResponse!.projectId.toString();
    // print("MyProjectDetailsScreen: "+projectID);
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      appBar: appBarWithBackAndActions(
          title: "ProjectDetails".tr,
          // actionIcons: [AssetConstants.icFavorite],
          onPress: (index) {
            //do active icon job
          }),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.green,
              ))
            : Column(
                children: [
                  Container(
                    height: Platform.isAndroid
                        ? getContentHeight() - 110
                        : getContentHeight() - 195,
                    /*decoration: boxDecorationRoundShadowLight(),*/
                    padding: const EdgeInsets.all(dp10),
                    margin: const EdgeInsets.all(dp10),
                    child: SingleChildScrollView(
                      child: Scrollbar(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textAutoSize(
                                text: "Project Info",
                                maxLines: 1,
                                fontSize: dp16,
                                alignment: Alignment.center,
                                fontWeight: FontWeight.bold),
                            const Divider(),

                            twoSidedTextWithColon2(
                                leftText: "Project_Name".tr,
                                rightText: stringNullCheck(
                                    _controllerForProjectDetailsByID
                                        .projectDetailsById.value.name
                                        .toString())),

                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "code".tr,
                                //rightText: stringNullCheck(widget.projectsListResponse!.nameBangla.toString())),
                                rightText: stringNullCheck(
                                    _controllerForProjectDetailsByID
                                        .projectDetailsById.value.code
                                        .toString())),

                            //rokan

                            _controllerForProjectDetailsByID.projectDetailsById
                                        .value.ministryName ==
                                    null
                                ? const SizedBox(height: 0, width: 0)
                                : Column(
                                    children: [
                                      const Divider(),
                                      twoSidedTextWithColon2(
                                          leftText: "MinistryName".tr,
                                          rightText: stringNullCheck(
                                              _controllerForProjectDetailsByID
                                                  .projectDetailsById
                                                  .value
                                                  .ministryName
                                                  .toString())),
                                    ],
                                  ),
                            _controllerForProjectDetailsByID.projectDetailsById
                                        .value.divisionName ==
                                    null
                                ? const SizedBox(height: 0, width: 0)
                                : Column(
                                    children: [
                                      const Divider(),
                                      twoSidedTextWithColon2(
                                          leftText: "DivisionName".tr,
                                          rightText: stringNullCheck(
                                              _controllerForProjectDetailsByID
                                                  .projectDetailsById
                                                  .value
                                                  .divisionName
                                                  .toString())),
                                    ],
                                  ),
                            _controllerForProjectDetailsByID
                                        .projectDetailsById.value.agencyName ==
                                    null
                                ? const SizedBox(height: 0, width: 0)
                                : Column(
                                    children: [
                                      const Divider(),
                                      twoSidedTextWithColon2(
                                          leftText: "AgencyName".tr,
                                          rightText: stringNullCheck(
                                              _controllerForProjectDetailsByID
                                                  .projectDetailsById
                                                  .value
                                                  .agencyName
                                                  .toString())),
                                    ],
                                  ),

                            const Divider(),

                            InkWell(
                              child: Container(
                                decoration: boxDecorationRoundShadowLight(),
                                margin: const EdgeInsets.all(dp5),
                                padding: const EdgeInsets.all(dp25),
                                child: Column(children: [
                                  textAutoSize(
                                      text: "Project Cost (in Lakh)".tr,
                                      maxLines: 1,
                                      fontSize: dp15,
                                      alignment: Alignment.centerLeft,
                                      fontWeight: FontWeight.bold),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 9,
                                        child: Column(
                                          children: [
                                            textAutoSize(
                                                color: Colors.black,
                                                //text: "${_wishListProjectDetailsController.wishListProjectDetailsResponse.value.projectTotalCost}  ${"Total".tr}",
                                                text:
                                                    "${formatter.format(_wishListProjectDetailsController.wishListProjectDetailsResponse.value.projectTotalCost)}  ${"Total".tr}",
                                                maxLines: 1,
                                                fontSize: dp16,
                                                fontWeight: FontWeight.normal),
                                            textAutoSize(
                                                color: Colors.black,
                                                text:
                                                    "${formatter.format(_wishListProjectDetailsController.wishListProjectDetailsResponse.value.projectTotalCostGob)}  ${"GOB".tr}",
                                                maxLines: 1,
                                                fontSize: dp16,
                                                fontWeight: FontWeight.normal),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: showImageAsset(
                                            imagePath: AssetConstants.icTaka,
                                            height: dp50,
                                            width: dp50),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: const SizedBox(
                                            width: dp5,
                                          )),
                                    ],
                                  ),
                                ]),
                              ),
                              onTap: () {
                                Get.to(
                                    () => ProjectEstimatedCostDetailsScreen());
                              },
                            ),

                            InkWell(
                              child: Container(
                                decoration: boxDecorationRoundShadowLight(),
                                margin: const EdgeInsets.all(dp5),
                                padding: const EdgeInsets.all(dp25),
                                child: Column(children: [
                                  textAutoSize(
                                      text: "Allocation (in Lakh)".tr,
                                      maxLines: 1,
                                      fontSize: dp15,
                                      alignment: Alignment.centerLeft,
                                      fontWeight: FontWeight.bold),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 9,
                                        child: Column(
                                          children: [
                                            textAutoSize(
                                                color: Colors.black,
                                                text:
                                                    "${formatter.format(_wishListProjectDetailsController.wishListProjectDetailsResponse.value.totalAllocation)}  ${"Total".tr}",
                                                maxLines: 1,
                                                fontSize: dp18,
                                                fontWeight: FontWeight.normal),
                                            textAutoSize(
                                                color: Colors.black,
                                                text:
                                                    "${formatter.format(_wishListProjectDetailsController.wishListProjectDetailsResponse.value.currentYearAllocation)}  ${"Current".tr}",
                                                maxLines: 1,
                                                fontSize: dp16,
                                                fontWeight: FontWeight.normal),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: showImageAsset(
                                            imagePath: AssetConstants.icTaka,
                                            height: dp50,
                                            width: dp50),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: const SizedBox(
                                            width: dp5,
                                          )),
                                    ],
                                  ),
                                ]),
                              ),
                              onTap: () {
                                Get.to(() => ProjectAllocationDetailsScreen());
                              },
                            ),

                            InkWell(
                              child: Container(
                                decoration: boxDecorationRoundShadowLight(),
                                margin: const EdgeInsets.all(dp5),
                                padding: const EdgeInsets.all(dp25),
                                child: Column(children: [
                                  textAutoSize(
                                      text: "Expenditure (in Lakh)".tr,
                                      maxLines: 1,
                                      fontSize: dp15,
                                      alignment: Alignment.centerLeft,
                                      fontWeight: FontWeight.bold),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 9,
                                        child: Column(
                                          children: [
                                            textAutoSize(
                                                color: Colors.black,
                                                text:
                                                    "${formatter.format(_wishListProjectDetailsController.wishListProjectDetailsResponse.value.totalExpenditure)}  ${"Total".tr}",
                                                maxLines: 1,
                                                fontSize: dp16,
                                                fontWeight: FontWeight.normal),
                                            textAutoSize(
                                                color: Colors.black,
                                                text:
                                                    "${formatter.format(_wishListProjectDetailsController.wishListProjectDetailsResponse.value.currentYearExpenditure)}  ${"Current".tr}",
                                                maxLines: 1,
                                                fontSize: dp16,
                                                fontWeight: FontWeight.normal),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: showImageAsset(
                                            imagePath: AssetConstants.icTaka,
                                            height: dp50,
                                            width: dp50),
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: const SizedBox(
                                            width: dp5,
                                          )),
                                    ],
                                  ),
                                ]),
                              ),
                              onTap: () {
                                Get.to(() =>
                                    ProjectExpenditureCostDetailsScreen());
                              },
                            ),

                            Container(
                              decoration: boxDecorationRoundShadowLight(),
                              margin: const EdgeInsets.all(dp5),
                              padding: const EdgeInsets.all(dp25),
                              child: Column(children: [
                                textAutoSize(
                                    text: "Progress (cumulative)".tr,
                                    maxLines: 1,
                                    fontSize: dp15,
                                    alignment: Alignment.centerLeft,
                                    fontWeight: FontWeight.bold),
                                const Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Column(
                                        children: [
                                          textAutoSize(
                                              color: Colors.black,
                                              text:
                                                  "${_wishListProjectDetailsController.wishListProjectDetailsResponse.value.financialProgress}%  ${"Financial".tr}",
                                              maxLines: 1,
                                              fontSize: dp16,
                                              fontWeight: FontWeight.normal),
                                          textAutoSize(
                                              color: Colors.black,
                                              text:
                                                  "${_wishListProjectDetailsController.wishListProjectDetailsResponse.value.physicalProgress}%  ${"Physical".tr}",
                                              maxLines: 1,
                                              fontSize: dp16,
                                              fontWeight: FontWeight.normal),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: showImageAsset(
                                          imagePath: AssetConstants.icProgress,
                                          height: dp50,
                                          width: dp50),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: const SizedBox(
                                          width: dp5,
                                        )),
                                  ],
                                ),
                              ]),
                            ),

                            Container(
                              decoration: boxDecorationRoundShadowLight(),
                              margin: const EdgeInsets.all(dp5),
                              padding: const EdgeInsets.all(dp25),
                              child: Column(children: [
                                textAutoSize(
                                    text: "Progress (Report Submission)".tr,
                                    maxLines: 1,
                                    fontSize: dp15,
                                    alignment: Alignment.centerLeft,
                                    fontWeight: FontWeight.bold),
                                const Divider(),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Column(
                                        children: [
                                          textAutoSize(
                                              color: Colors.black87,
                                              text:
                                                  "${_wishListProjectDetailsController.dataEntryProgressResponse.value.dataSubmissionProgressPercentage}%",
                                              maxLines: 1,
                                              fontSize: dp16,
                                              fontWeight: FontWeight.normal),
                                          const SizedBox(height: dp10),
                                          textAutoSize(
                                              color: Colors.black87,
                                              text:
                                                  "Report as submitted to IMED",
                                              maxLines: 1,
                                              fontSize: dp14,
                                              fontWeight: FontWeight.normal)
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: showImageAsset(
                                          imagePath: AssetConstants.icProgress,
                                          height: dp50,
                                          width: dp50),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: const SizedBox(
                                          width: dp5,
                                        )),
                                  ],
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /*const Spacer(),*/

                  surveyGalleryButton(),
                ],
              ),
      ),
    );
  }

  Widget surveyGalleryButton() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Column(
        children: [
          /*const VSpacer10(),*/

          buttonRoundedMain(
              text: "survey_gallery".tr,
              onPressCallback: () {
                Get.to(() => WishListProjectsSurveyGalleryScreen(
                    allProjectsResponse: widget.projectsListResponse));
                //Get.to(() => WishListProjectsSurveyGalleryScreen(projectsListResponse: widget.projectsListResponse));
              }),
          const VSpacer10(),
        ],
      ),
    );
  }
}
