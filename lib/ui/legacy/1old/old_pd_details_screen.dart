import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/button_util.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../utils/alert_util.dart';
import '../../../utils/date_util.dart';
import 'image_gallery/image_gallery_screen.dart';
import '../../features/project/inspection/inspection_report_screen.dart';
import '../../features/project/project_details_by_id_controller.dart';
import '../../features/project/locations/project_locations_screen.dart';
import '../../features/drawer_menu/pd_directory/pd_details/pd_details_controller.dart';

class PdDetailsScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;

  const PdDetailsScreen({Key? key, this.allProjectsResponse}) : super(key: key);

  @override
  _PdDetailsScreenState createState() => _PdDetailsScreenState();
}

class _PdDetailsScreenState extends State<PdDetailsScreen> {
  final _controller = Get.put(PdDetailsController());
  final _controllerForProjectDetailsByID =
      Get.put(ProjectDetailsByIDController());

  String? messengerUrl = "https://www.facebook.com/";
  String? messengerUserId = "PlanningTT";
  String? whatsAppUrl = "https://www.whatsapp.com/";
  String? whatsappUserId = "1234";

  /* @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _controller.getData();
      _controller.getPdInfoTadData(stringNullCheck(widget.allProjectsResponse!.projectId));
      _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(stringNullCheck(widget.allProjectsResponse!.projectId));
      _controllerForProjectDetailsByID.getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());
    });
  }*/

  void initCalls() async {
    await _controller.getPdInfoTadData(
        stringNullCheck(widget.allProjectsResponse!.projectId));
    await _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(
        stringNullCheck(widget.allProjectsResponse!.projectId));
    await _controllerForProjectDetailsByID
        .getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  void initState() {
    initCalls();
    super.initState();

    /*WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(stringNullCheck(widget.allProjectsResponse!.projectId));
      _controllerForProjectDetailsByID.getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());
      _controller.getProjectProgressAndCostData(widget.allProjectsResponse!.projectId.toString());
      debugPrint("RokanAifazFarabiBaba: ${_controllerForProjectDetailsByID.projectDetailsById.value.name.toString()}");

    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      appBar: appBarWithBack(title: "PDDetails".tr),
      // appBar: appBarWithBackAndActions(title: "PDDetails".tr, actionIcons: [
      //   AssetConstants.icFavorite
      // ], onPress: (index) {
      //   //do active icon job
      // }),
      body: SafeArea(
        child: Column(
          children: [
            getTabView(
              titles: ["ProjectInfo".tr, "PDInfo".tr],
              controller: _controller.tabController,
              onTap: (selected) {
                _controller.tabSelectedIndex.value = selected;
              },
            ),
            Expanded(
              child: TabBarView(
                  controller: _controller.tabController,
                  children: [_projectInfoTab(), _pdInfoTab()]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _projectInfoTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: _controller.getData,
            child: Column(
              children: [
                Container(
                  //height: Platform.isAndroid ? getContentHeight() - 145 : getContentHeight() - 215,
                  decoration: boxDecorationRoundShadowLight(),
                  padding: const EdgeInsets.all(dp16),
                  margin: const EdgeInsets.all(dp5),
                  child: SingleChildScrollView(
                    child: Scrollbar(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          /*twoSidedTextWithColon2(
                              leftText: "Project_Name".tr,
                              rightText: stringNullCheck(
                                  widget.allProjectsResponse!.name)),
                          const Divider(),
                          twoSidedTextWithColon2(
                              leftText: "code".tr,
                              rightText: stringNullCheck(widget
                                  .allProjectsResponse!.code
                                  .toString())),
                          const Divider(),
                          twoSidedTextWithColon2(
                              leftText: "MinistryName".tr,
                              rightText: stringNullCheck(
                                  widget.allProjectsResponse!.ministryName)),
                          const Divider(),
                          twoSidedTextWithColon2(
                              leftText: "DivisionName".tr,
                              rightText: stringNullCheck(
                                  widget.allProjectsResponse!.divisionName)),
                          const Divider(),
                          twoSidedTextWithColon2(
                              leftText: "AgencyName".tr,
                              rightText: stringNullCheck(
                                  widget.allProjectsResponse!.agencyName)),*/

                          twoSidedTextWithColon2(
                              leftText: "Project_Name".tr,
                              rightText: stringNullCheck(
                                  _controllerForProjectDetailsByID
                                      .projectDetailsById.value.name
                                      .toString())),
                          const Divider(),
                          twoSidedTextWithColon2(
                              leftText: "code".tr,
                              //rightText: stringNullCheck(widget.allProjectsResponse!.code.toString())),
                              rightText: stringNullCheck(
                                  _controllerForProjectDetailsByID
                                      .projectDetailsById.value.code
                                      .toString())),

                          //rokan

                          _controllerForProjectDetailsByID
                                      .projectDetailsById.value.ministryName ==
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
                          _controllerForProjectDetailsByID
                                      .projectDetailsById.value.divisionName ==
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
                          twoSidedTextWithColon2(
                              leftText: "ProjectTimeline".tr,
                              rightText:
                                  "${formatDateToDDMMYYYY(widget.allProjectsResponse!.dateOfCommencement.toString())}  To  ${formatDateToDDMMYYYY(widget.allProjectsResponse!.dateOfCompletion.toString())}"),
                          const Divider(),
/*                          twoSidedTextWithColon2(
                              leftText: "EstimatedCost".tr,
                              // rightText: "date Of Completion"
                              rightText: '12,2800 Lakh BDT'),
                          const Divider(),
                          twoSidedTextWithColon2(
                              leftText: "ProgressFinancial".tr,
                              rightText: '500 Lakh BDT(30%)'),
                          const Divider(),
                          twoSidedTextWithColon2(
                              leftText: "ProgressPhysical".tr,
                              rightText: '70%'),
                          const Divider(),*/
                          twoSidedTextWithTextActionAndIcon(
                              leftText: "InspectionDetail".tr,
                              rightText: 'SeeDetailsOfInspection'.tr,
                              rightIcon: AssetConstants.icInspectionReport,
                              iconAction: () {
                                Get.to(() => InspectionReportScreen(
                                    allProjectsResponse:
                                        widget.allProjectsResponse));
                              }),
                          Obx(() {
                            return _controllerForProjectDetailsByID
                                        .projectDetailsById.value.pcrStatus
                                        .toString() ==
                                    "Received"
                                ? Column(
                                    children: [
                                      const Divider(),
                                      twoSidedTextWithIconAndTextAction(
                                          leftText: "PCRStatus".tr,
                                          rightText: 'Received'.tr,
                                          rightTextColor:
                                              Get.theme.primaryColor,
                                          rightActionText: 'ViewEvidence'.tr,
                                          rightTextAction: () {
                                            alertDialogViewForPCREvidence(
                                              context: context,
                                              title: 'PCREvidence'.tr,
                                              fileId: _controllerForProjectDetailsByID
                                                  .pcrAttachmentViewListResponse
                                                  .first
                                                  .fileId
                                                  .toString(),
                                              receivedDate:
                                                  _controllerForProjectDetailsByID
                                                      .pcrAttachmentViewListResponse
                                                      .first
                                                      .receivedDate
                                                      .toString(),
                                              remarks:
                                                  _controllerForProjectDetailsByID
                                                      .pcrAttachmentViewListResponse
                                                      .first
                                                      .remarks
                                                      .toString(),
                                            );
                                          }),
                                    ],
                                  )
                                : const SizedBox();
                          }),
                          const Divider(),
                          widget.allProjectsResponse!.projectTypeId
                                      .toString() ==
                                  "ProjectType_DPP"
                              ? Column(
                                  children: [
                                    twoSidedTextWithTextActionAndIcon(
                                        leftText: "Location".tr,
                                        rightText: 'SeeLocations'.tr,
                                        rightIcon: AssetConstants.icLocation,
                                        iconAction: () {
                                          Get.to(() => ProjectLocationsScreen(
                                              allProjectsResponse:
                                                  widget.allProjectsResponse));
                                        }),
                                    const Divider(),
                                  ],
                                )
                              : const SizedBox(),
/*                            twoSidedTextWithIcon(
                                leftText: "Location".tr,
                                rightText: 'SeeLocationOnGoogleMap'.tr,
                                rightIcon: AssetConstants.icLocation,
                                iconAction: () async {
                                  Position position = await _determinePosition();
                                  // print(
                                  //     'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
                                  // // location = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
                                  // getLocationAddressFromLatLong(position);
                                  // setState(() {
                                  //   location = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
                                  // });
                                  // _liveLocation();
                                  openMap(stringNullCheck(position.latitude.toString()),
                                      stringNullCheck(position.longitude.toString()));
                                }),
                            const Divider(),*/
                          twoSidedTextWithTextActionAndIcon(
                              leftText: "VisualEvidence".tr,
                              rightText: 'SeeProjectImages'.tr,
                              rightIcon: AssetConstants.icGallery,
                              iconAction: () {
                                Get.to(() => ImageGalleryScreen(
                                    allProjectsResponse:
                                        widget.allProjectsResponse));
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: Column(
                //     children: [
                //       const VSpacer10(),
                //       buttonRoundedMain(
                //           text: "survey_gallery".tr,
                //           onPressCallback: () {
                //             Get.to(() => const SurveyGalleryScreen());
                //             // _controller.isInPutDataValid(context);
                //           }),
                //       const VSpacer20(),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
        /*Expanded(
          child: SingleChildScrollView(
            child: Container(
              decoration: boxDecorationRoundShadowLight(),
              padding: const EdgeInsets.all(dp16),
              margin: const EdgeInsets.all(dp16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  twoSidedTextWithColon2(
                      leftText: "Project_Name".tr,
                      rightText: "Full Project Name"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "name_bangla".tr,
                      rightText:
                          "মাতারবাড়ী আল্ট্রা সুপার ক্রিটিক্যাল কোল ফায়ারড"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "code".tr, rightText: "1234"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "MinistryName".tr, rightText: "Ministry Name"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "AgencyName".tr, rightText: "Agency Name"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "HasMultipleAgency".tr, rightText: "Yes"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "IsSelfFinanced".tr, rightText: "No"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "HasForeignLocation".tr,
                      rightText: "Has Foreign Location"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "ProjectTypeName".tr,
                      rightText: "ProjectTypeName"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "CurrentProjectRevisionNo".tr,
                      rightText: "true"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "ProjectNatureName".tr,
                      rightText: "Project Nature Name"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "IsOnlyForGobProject".tr,
                      rightText: "Is Only For Gob Project"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "DateOfCommencement".tr,
                      rightText: "Date Of Commencement"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "dateOfCompletion".tr,
                      rightText: "date Of Completion"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "StatusName".tr, rightText: "Status Name"),
                  const Divider(),
                  twoSidedTextWithColon2(
                      leftText: "IsFastTrack".tr, rightText: "No"),
                ],
              ),
            ),
          ),
        ),*/
      ],
    );
  }

  Widget _pdInfoTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          return Expanded(
            child: SingleChildScrollView(
              child: Container(
                  decoration: boxDecorationRoundShadowLight(),
                  padding: const EdgeInsets.all(dp16),
                  margin: const EdgeInsets.all(dp5),
                  child: _controller.pdInfoListResponse.isEmpty
                      ? showEmptyViewForPDInfo()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            twoSidedTextWithColon2(
                                // leftText: "FullName".tr, rightText: "PD full Name"),
                                leftText: "FullName".tr,
                                rightText: stringNullCheck(_controller
                                    .pdInfoListResponse.first.fullName
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "Mobile".tr,
                                rightText: stringNullCheck(_controller
                                    .pdInfoListResponse.first.mobile
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "email".tr,
                                rightText: stringNullCheck(_controller
                                    .pdInfoListResponse.first.email
                                    .toString())),
                            /*const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "nid".tr,
                                rightText: stringNullCheck(_controller
                                    .pdInfoListResponse.first.nid
                                    .toString())),*/
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "RoleName".tr,
                                rightText: stringNullCheck(_controller
                                    .pdInfoListResponse.first.roleName
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "RoleTitle".tr,
                                rightText: stringNullCheck(_controller
                                    .pdInfoListResponse.first.roleTitle
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "DesignationName".tr,
                                rightText: stringNullCheck(_controller
                                    .pdInfoListResponse.first.designationName
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "OfficeName".tr,
                                rightText: stringNullCheck(_controller
                                    .pdInfoListResponse.first.officeName
                                    .toString())),
                            // Spacer(),
                            const Divider(),
                            const VSpacer20(),

                            Center(
                              child: Row(
                                children: [
                                  contactItem(AssetConstants.icCall, "Phone",
                                      () {
                                    // leadProfileScreenController.addContactActivities({'contact_type': 'phone'});
                                    // launchUrlString("tel:" '+8801722823099');
                                    launchUrlString(
                                        "tel:${stringNullCheck(_controller.pdInfoListResponse.first.mobile.toString())}");
                                  }),
                                  contactItem(
                                      AssetConstants.icMessage, "Message", () {
                                    // leadProfileScreenController.addContactActivities({'contact_type': 'phone'});
                                    launchUrlString(
                                        "tel:${stringNullCheck(_controller.pdInfoListResponse.first.mobile.toString())}");
                                  }),
                                  contactItem(AssetConstants.icEmail, "Email",
                                      () {
                                    // leadProfileScreenController.addContactActivities({'contact_type': 'phone'});
                                    // launchUrlString("mailto:" 'user@gmail.com');
                                    launchUrlString(
                                        "mailto:${stringNullCheck(_controller.pdInfoListResponse.first.email.toString())}");
                                  }),
                                ],
                              ),
                            ),

                            /*Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: buttonRoundedMain(
                                text: "Contact".tr,
                                onPressCallback: () {
                                  contactBottomSheet();
                                },
                                width: Get.width / 3.5,
                              ),
                            ),*/

                            const VSpacer20(),
                          ],
                        )),
              /* child: _controller.roleListResponse.value.roleName == null
                      ? showEmptyViewForPDInfo()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            twoSidedTextWithColon2(
                                // leftText: "FullName".tr, rightText: "PD full Name"),
                                leftText: "FullName".tr,
                                rightText: stringNullCheck(_controller
                                    .roleListResponse.value.fullName
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "Mobile".tr,
                                rightText: stringNullCheck(_controller
                                    .roleListResponse.value.mobile
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "email".tr,
                                rightText: stringNullCheck(_controller
                                    .roleListResponse.value.email
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "nid".tr,
                                rightText: stringNullCheck(_controller
                                    .roleListResponse.value.nid
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "RoleName".tr,
                                rightText: stringNullCheck(_controller
                                    .roleListResponse.value.roleName
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "RoleTitle".tr,
                                rightText: stringNullCheck(_controller
                                    .roleListResponse.value.roleTitle
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "DesignationName".tr,
                                rightText: stringNullCheck(_controller
                                    .roleListResponse.value.designationName
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "OfficeName".tr,
                                rightText: stringNullCheck(_controller
                                    .roleListResponse.value.officeName
                                    .toString())),
                            // Spacer(),
                            const Divider(),
                            const VSpacer20(),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: buttonRoundedMain(
                                text: "Contact".tr,
                                onPressCallback: () {
                                  contactBottomSheet();
                                },
                                width: Get.width / 3.5,
                              ),
                            ),
                            const VSpacer20(),
                          ],
                        )),*/
            ),
          );
        })
      ],
    );
  }

  Future contactBottomSheet() {
    return showModalBottomSheet(
      context: context,
      // color is applied to main screen when modal bottom screen is displayed
      //barrierColor: Colors.greenAccent,
      //background color for modal bottom screen
      backgroundColor: Get.theme.colorScheme.surface,
      //elevates modal bottom screen
      elevation: 10,
      // gives rounded corner to modal bottom screen
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        // UDE : SizedBox instead of Container for whitespaces
        return SingleChildScrollView(
          child: SizedBox(
            //height: 400,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: textAutoSize(
                              text: "Contacts", fontWeight: FontWeight.bold
                              // width: Get.width / 2,
                              )),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: textAutoSize(
                              // width: Get.width / 2,
                              text: 'Cancel',
                              color: Get.theme.colorScheme.secondary,
                              textAlign: TextAlign.end),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      //alignment: WrapAlignment.center,
                      children: [
                        contactItem(AssetConstants.icCall, "Phone", () {
                          // leadProfileScreenController.addContactActivities({'contact_type': 'phone'});
                          // launchUrlString("tel:" '+8801722823099');
                          launchUrlString(
                              "tel:${stringNullCheck(_controller.pdInfoListResponse.first.mobile.toString())}");
                        }),
                        contactItem(AssetConstants.icMessage, "Message", () {
                          // leadProfileScreenController.addContactActivities({'contact_type': 'phone'});
                          launchUrlString(
                              "tel:${stringNullCheck(_controller.pdInfoListResponse.first.mobile.toString())}");
                        }),
                        contactItem(AssetConstants.icEmail, "Email", () {
                          // leadProfileScreenController.addContactActivities({'contact_type': 'phone'});
                          // launchUrlString("mailto:" 'user@gmail.com');
                          launchUrlString(
                              "mailto:${stringNullCheck(_controller.pdInfoListResponse.first.email.toString())}");
                        }),

                        // contactItem(AssetConstants.icWhatsapp, "WhatsApp", () {
                        //   // leadProfileScreenController.addContactActivities({'contact_type': 'phone'});
                        //   launchUrlString('{$whatsAppUrl {$whatsappUserId}',mode: LaunchMode.externalApplication);
                        // }),
                        // contactItem(AssetConstants.icMessenger, "Messenger", () {
                        //   // leadProfileScreenController.addContactActivities({'contact_type': 'phone'});
                        //   launchUrlString('{$messengerUrl {$messengerUserId}',mode: LaunchMode.externalApplication);
                        // }),
                        /*contactItem("call", "Phone", () {
                          leadProfileScreenController.addContactActivities({'contact_type': 'phone'});
                          launchUrlString("tel:" +
                              leadProfileScreenController
                                  .leadModel.value.wholeNumber
                                  .toString());
                        }),
                        contactItem("message", "Message", () {
                          leadProfileScreenController.addContactActivities(
                              {'contact_type': 'message'});
                          launchUrlString("sms:" +
                              leadProfileScreenController
                                  .leadModel.value.wholeNumber
                                  .toString());
                        }),
                        contactItem("email", "Email", () {
                          leadProfileScreenController
                              .addContactActivities({'contact_type': 'email'});
                          launchUrlString("mailto:" +
                              leadProfileScreenController.leadModel.value.email
                                  .toString());
                        }),
                        contactItem(item.name.toString(),
                            item.name.toString().capitalizeFirst!, () {
                          leadProfileScreenController.addContactActivities(
                              {'contact_type': item.name});
                          String url = "";
                          switch (item.name.toString()) {
                            case "facebook":
                              url =
                                  "https://www.facebook.com/${item.id.toString()}";
                              break;

                            case "whatsapp":
                              url =
                                  "https://www.whatsapp.com/${item.id.toString()}";
                              break;
                          }
                          launchUrlString(url,
                              mode: LaunchMode.externalApplication);
                        }),*/

                        /*        if (leadProfileScreenController
                            .leadModel.value.wholeNumber !=
                            null) ...[
                          contactItem("call", "Phone", () {
                            leadProfileScreenController.addContactActivities(
                                {'contact_type': 'phone'});
                            launchUrlString("tel:" +
                                leadProfileScreenController
                                    .leadModel.value.wholeNumber
                                    .toString());
                          }),
                          contactItem("message", "Message", () {
                            leadProfileScreenController.addContactActivities(
                                {'contact_type': 'message'});
                            launchUrlString("sms:" +
                                leadProfileScreenController
                                    .leadModel.value.wholeNumber
                                    .toString());
                          }),
                        ],
                        if (leadProfileScreenController
                            .leadModel.value.email !=
                            null) ...[
                          contactItem("email", "Email", () {
                            leadProfileScreenController.addContactActivities(
                                {'contact_type': 'email'});
                            launchUrlString("mailto:" +
                                leadProfileScreenController
                                    .leadModel.value.email
                                    .toString());
                          }),
                          if (leadProfileScreenController
                              .leadModel.value.socialIds !=
                              null) ...[
                            for (var item in leadProfileScreenController
                                .leadModel.value.socialIds!)
                              contactItem(item.name.toString(),
                                  item.name.toString().capitalizeFirst!, () {
                                    leadProfileScreenController
                                        .addContactActivities(
                                        {'contact_type': item.name});
                                    String url = "";
                                    switch (item.name.toString()) {
                                      case "facebook":
                                        url =
                                        "https://www.facebook.com/${item.id.toString()}";
                                        break;

                                      case "whatsapp":
                                        url =
                                        "https://www.whatsapp.com/${item.id.toString()}";
                                        break;
                                    }
                                    launchUrlString(url,
                                        mode: LaunchMode.externalApplication);
                                  }),
                          ]
                        ],
                        if (leadProfileScreenController
                            .leadModel.value.socialIds ==
                            null ||
                            leadProfileScreenController
                                .leadModel.value.socialIds!.length !=
                                6) ...[
                        ]*/
                      ]),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget contactItem(String icon, String title, Function() onClick) {
    return InkWell(
      onTap: onClick,
      child: SizedBox(
        width: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 22,
                backgroundColor: Get.theme.primaryColor,
                // child: SvgPicture.asset("assets/icons/$icon.svg")),
                child: SvgPicture.asset(
                  icon,
                  color: Colors.white,
                )),
            const SizedBox(height: 5),
            textAutoSize(text: title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
