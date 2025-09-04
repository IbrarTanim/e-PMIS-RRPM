import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/pending_task_list_response.dart';
import 'package:pmis_flutter/data/models/workflow_allocation_distribution_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_reappropriation_details_response.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pending_task/workflow_expenditure_information_screen.dart';
import 'package:pmis_flutter/ui/features/project/estimate/estimated_cost_details_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/button_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import '../../../../utils/common_widget.dart';
import '../../../../utils/date_util.dart';
import 'work_flow_details_controller.dart';

class WorkFlowDetailsScreen extends StatefulWidget {
  final PendingTaskResponse? allProjectsResponse;

  const WorkFlowDetailsScreen({Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  State<WorkFlowDetailsScreen> createState() => _WorkFlowDetailsScreenState();
}

class _WorkFlowDetailsScreenState extends State<WorkFlowDetailsScreen> {
  final _controller = Get.put(WorkFlowDetailsController());

  XFile? _image;
  final now = DateTime.now();

  // DateTime? imageShootingDate =DateTime.now();
  // DateTime? imageShootingTime=DateTime.now();

  @override
  void dispose() {
    _controller.clearView();
    _controller.clearInputData();
    _image == null;
    // hideKeyboard(context);
    super.dispose();
  }

  void initCalls() async {
    await _controller.getWorkflowExpenditureDetailseData(
        widget.allProjectsResponse!.associatedId);
    await _controller.getWorkflowDemandDetailseData(
        widget.allProjectsResponse!.associatedId);
    await _controller.getWorkflowAllocationDistributionDetailseData(
        widget.allProjectsResponse!.associatedId);
    await _controller.getWorkflowFundReleaseDetailseData(
        widget.allProjectsResponse!.associatedId);
    await _controller.getWorkflowFundDistributionDetailseData(
        widget.allProjectsResponse!.associatedId);
    await _controller.getWorkflowAllocationReturnDetailseData(
        widget.allProjectsResponse!.associatedId);
    await _controller.getWorkflowReappropriationDetailseData(
        widget.allProjectsResponse!.projectId);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  void initState() {
    initCalls();
    _controller.clearInputData();
    //_controller.getWorkflowRolesData();
    _controller.getWorkflowNodeData(widget.allProjectsResponse!.workflowId);
    _controller
        .getWorkflowActivityHistoryData(widget.allProjectsResponse!.workflowId);
    _controller
        .getWorkflowFinanceSourcesData(widget.allProjectsResponse!.projectId);
    _controller
        .getWorkflowAllocationData(widget.allProjectsResponse!.associatedId);
    _controller.getWorkflowDetails(widget.allProjectsResponse!.workflowType,
        widget.allProjectsResponse!.associatedId);

    super.initState();
  }

  getImageFromCamera() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }

    setState(() {
      _image = image;
      _controller.imageShootingTime = formatDateToHHMMAPM(now.toString());
    });
    print(_image);
  }

  getImageFromGallery() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBarWithBackAndActions(
        title: "WorkFlowDetails".tr,
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          child: Column(
            children: [
              getTabView(
                titles: ["Comment", "Activities", "Details"],
                controller: _controller.tabController,
                onTap: (selected) {
                  _controller.tabSelectedIndex.value = selected;
                },
              ),
              Expanded(
                child: TabBarView(
                    controller: _controller.tabController,
                    children: [
                      _addCommentTab(),
                      _ActivitiesItemList(context),
                      //_WorkflowDetailsTab(context)
                      //_AllocationDetailsTab(context)
                      widget.allProjectsResponse!.workflowType!.toLowerCase() ==
                              WorkflowType.Allocation.toLowerCase()
                          ? _AllocationDetailsTab(context)
                          : widget.allProjectsResponse!.workflowType!.toLowerCase() ==
                                  WorkflowType.Expenditure.toLowerCase()
                              ? _WorkflowExpenditureDetailsTab(context)
                              : widget.allProjectsResponse!.workflowType!.toLowerCase() ==
                                      WorkflowType.Demand.toLowerCase()
                                  ? _WorkflowDemandDetailsTab(context)
                                  : widget.allProjectsResponse!.workflowType!.toLowerCase() ==
                                          WorkflowType.AllocationDistribution
                                              .toLowerCase()
                                      ? _WorkflowAllocationDistributionDetailsTab(
                                          context)
                                      : widget.allProjectsResponse!.workflowType!.toLowerCase() ==
                                              WorkflowType.FundRelease
                                                  .toLowerCase()
                                          ? _WorkflowFundReleaseDetailsTab(
                                              context)
                                          : widget.allProjectsResponse!.workflowType!
                                                      .toLowerCase() ==
                                                  WorkflowType.FundDistribution
                                                      .toLowerCase()
                                              ? _WorkflowFundDistributionDetailsTab(
                                                  context)
                                              : widget.allProjectsResponse!.workflowType!
                                                          .toLowerCase() ==
                                                      WorkflowType.AllocationReturn
                                                          .toLowerCase()
                                                  ? _WorkflowAllocationReturnDetailsTab(
                                                      context)
                                                  : widget.allProjectsResponse!
                                                              .workflowType!
                                                              .toLowerCase() ==
                                                          WorkflowType.Reappropriation.toLowerCase()
                                                      ? _WorkflowReappropriationDetailsTab(context)
                                                      : const SizedBox()
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addCommentTab() {
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: accentBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            stringNullCheck(
                                widget.allProjectsResponse!.workflowStatus),
                            style: TextStyle(
                              color: accentBlue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: accentGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: accentGreenText,
                                size: 14,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "${formatDateToDDMMYYYY(widget.allProjectsResponse!.timestamp.toString())}, ${formatDateToHHMMAPM(widget.allProjectsResponse!.timestamp.toString())} ",
                                style: const TextStyle(
                                  color: accentGreenText,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      stringNullCheck(widget.allProjectsResponse!.projectName),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.business,
                              size: 16, color: Color(0xFF4A90E2)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Event Name: ${stringNullCheck(widget.allProjectsResponse!.workflowEventName)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.person,
                              size: 16, color: Color(0xFF50E3C2)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Initiator Name:  ${stringNullCheck(widget.allProjectsResponse!.initiatorName)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.verified_user_sharp,
                              size: 16, color: Color(0xFF10A3C2)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "User Status:  ${stringNullCheck(widget.allProjectsResponse!.userStatus)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.drive_file_rename_outline,
                              size: 16, color: Color(0xFF60B6C2)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "From User Name:  ${stringNullCheck(widget.allProjectsResponse!.fromUserName)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.call_to_action,
                              size: 16, color: Color(0xFF99E3C2)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "From User Action:  ${stringNullCheck(widget.allProjectsResponse!.fromUserAction)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.type_specimen,
                              size: 16, color: Color(0xFF33E3C2)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Workflow Type:  ${stringNullCheck(widget.allProjectsResponse!.workflowType)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          /*const Icon(Icons.business,
                              size: 16, color: Color(0xFF4A90E2)),*/
                          const SizedBox(width: 8),
                          Expanded(
                            child: twoSidedTextWithTextFieldWorkflowComment(
                                leftTextColor: Colors.grey[800],
                                leftText: "Comment",
                                controller: _controller.remarksEditController),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Obx(() {
                              return _controller.workflowReturnId.value != "-1"
                                  ? buttonRoundedMain(
                                      bgColor: accentGreenText,
                                      textColor: Colors.white,
                                      height: dp40,
                                      //width: double.maxFinite,
                                      text: "workflow_return".tr,
                                      onPressCallback: () async {
                                        if (_controller
                                            .remarksEditController.value.text
                                            .toString()
                                            .isEmpty) {
                                          showToast('Please write a comment.');
                                        } else {
                                          if (_controller
                                                  .workflowReturnId.value !=
                                              "-1") {
                                            await _controller.uploadWorkFlowImageFile(
                                                context: context,
                                                imageFile: _image != null
                                                    ? File(_image!.path)
                                                    : null,
                                                remarks: stringNullCheck(
                                                    _controller
                                                        .remarksEditController
                                                        .value
                                                        .text
                                                        .toString()),
                                                workflowId: widget
                                                    .allProjectsResponse!
                                                    .workflowId
                                                    .toString(),
                                                workflowActionId: _controller
                                                    .workflowReturnId.value);
                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                                    (timeStamp) {
                                              Get.back();
                                            }); //Navigator.pop(context);
                                          }
                                        }
                                      })
                                  : const SizedBox();
                            }),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          Expanded(child: Obx(
                            () {
                              return _controller.workflowForwardId.value != "-1"
                                  ? buttonRoundedMain(
                                      bgColor: accentGreenText,
                                      textColor: Colors.white,
                                      height: dp40,
                                      text:
                                          _controller.workflowForwardId.value ==
                                                  "1"
                                              ? "Approve"
                                              : "Forward",
                                      onPressCallback: () async {
                                        if (_controller
                                            .remarksEditController.value.text
                                            .toString()
                                            .isEmpty) {
                                          showToast('Please write a comment.');
                                        } else {
                                          if (_controller
                                                  .workflowForwardId.value !=
                                              "-1") {
                                            await _controller.uploadWorkFlowImageFile(
                                                context: context,
                                                imageFile: _image != null
                                                    ? File(_image!.path)
                                                    : null,
                                                remarks: stringNullCheck(
                                                    _controller
                                                        .remarksEditController
                                                        .value
                                                        .text
                                                        .toString()),
                                                workflowId: widget
                                                    .allProjectsResponse!
                                                    .workflowId
                                                    .toString(),
                                                workflowActionId: _controller
                                                    .workflowForwardId.value);

                                            WidgetsBinding.instance
                                                .addPostFrameCallback(
                                                    (timeStamp) {
                                              Get.back();
                                            });
                                            //Navigator.pop(context);
                                          }
                                        }
                                      })
                                  : const SizedBox();
                            },
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _ActivitiesItemList(BuildContext context) {
    return Obx(() {
      return _controller
              .workflowActivityHistoryResponse.value.workflowActivities!.isEmpty
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : SizedBox(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: _controller.workflowActivityHistoryResponse.value
                    .workflowActivities!.length,
                itemBuilder: (BuildContext context, int index) {
                  return activityHistoryListItemView(
                      context,
                      _controller.workflowActivityHistoryResponse.value,
                      _controller.workflowActivityHistoryResponse.value
                          .workflowActivities![index]);
                  //return activityHistoryListItemForImageView(context, _controller.workflowActivityHistoryResponse.value.workflowActivities![index]);
                },
              ),
            );
    });
  }

  Widget _WorkflowDetailsTab(BuildContext context) {
    return Obx(() {
      return _controller.workflowDetailsResponse.value.details == null
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : SizedBox(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount:
                    _controller.workflowDetailsResponse.value.details!.length,
                itemBuilder: (BuildContext context, int index) {
                  return workflowDetailsListItemView(
                      context,
                      _controller.workflowDetailsResponse.value,
                      _controller
                          .workflowDetailsResponse.value.details![index]);
                  //return activityHistoryListItemForImageView(context, _controller.workflowActivityHistoryResponse.value.workflowActivities![index]);
                },
              ),
            );
    });
  }

  Widget _WorkflowExpenditureDetailsTab(BuildContext context) {
    return Obx(() {
      return _controller.workflowExpenditureDetailsResponse.value == null
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: accentBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                stringNullCheck(_controller
                                    .workflowExpenditureDetailsResponse
                                    .value
                                    .voucherNo
                                    .toString()),
                                style: TextStyle(
                                  color: accentBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: accentGreen.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: accentGreenText,
                                    size: 14,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    " ${formatDateToDDMMYYYY(_controller.workflowExpenditureDetailsResponse.value.voucherDate.toString())}, ${formatDateToHHMMAPM(_controller.workflowExpenditureDetailsResponse.value.voucherDate.toString())}",
                                    style: const TextStyle(
                                      color: accentGreenText,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          stringNullCheck(_controller
                              .workflowExpenditureDetailsResponse
                              .value
                              .packageDescription
                              .toString()),
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.home,
                                  size: 16, color: Color(0xFF4A90E2)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Project Office: ${stringNullCheck(_controller.workflowExpenditureDetailsResponse.value.projectOfficeName.toString())}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),


                          _controller.workflowExpenditureDetailsResponse.value.packageDescription.toString() == "null" ? const SizedBox(height: 0) :
                          Column(
                            children: [
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.numbers,
                                      size: 16, color: Color(0xFF50E3C2)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "Package Details:  ${stringNullCheck(_controller.workflowExpenditureDetailsResponse.value.packageDescription.toString())}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          _controller.workflowExpenditureDetailsResponse.value.locationName.toString() == "null" ? const SizedBox(height: 0) :
                          Column(
                            children: [
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.numbers,
                                      size: 16, color: Color(0xFF50E3C2)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "Location:  ${stringNullCheck(_controller.workflowExpenditureDetailsResponse.value.locationName.toString())}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),


                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.numbers,
                                  size: 16, color: Color(0xFF50E3C2)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Bank Name:  ${stringNullCheck(_controller.workflowExpenditureDetailsResponse.value.bankName.toString())}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.numbers,
                                  size: 16, color: Color(0xFF50E3C2)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Account No :  ${stringNullCheck(_controller.workflowExpenditureDetailsResponse.value.accountNo.toString())}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),


                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.numbers,
                                  size: 16, color: Color(0xFF50E3C2)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Account Name :  ${stringNullCheck(_controller.workflowExpenditureDetailsResponse.value.accountName.toString())}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),


                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.numbers,
                                  size: 16, color: Color(0xFF50E3C2)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Remarks:  ${stringNullCheck(_controller.workflowExpenditureDetailsResponse.value.remarks.toString())}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.numbers,
                                  size: 16, color: Color(0xFF50E3C2)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Tax Office Name:  ${stringNullCheck(_controller.workflowExpenditureDetailsResponse.value.taxOfficeName.toString())}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.verified_user_sharp,
                                  size: 16, color: Color(0xFF10A3C2)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Expenditure Amount:  ${formatter.format(_controller.workflowExpenditureDetailsResponse.value.expenditureAmount)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ));
    });
  }

  Widget _AllocationDetailsTab(BuildContext context) {
    return Obx(() {
      return _controller.workflowAllocationResponse.value.economicCodeGroup ==
              null
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : Container(
        alignment: Alignment.topRight,
        margin:
        const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
        padding:
        const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
            child: Column(
              children: [

                Container(
                  //padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: accentBlue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      stringNullCheck(_controller.workflowAllocationResponse.value.status.toString()),
                                      style: TextStyle(
                                        color: accentBlue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: accentGreen.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          color: accentGreenText,
                                          size: 14,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          " ${formatDateToDDMMYYYY(_controller.workflowAllocationResponse.value.timestamp.toString())}, ${formatDateToHHMMAPM(_controller.workflowAllocationResponse.value.timestamp.toString())}",
                                          style: const TextStyle(
                                            color: accentGreenText,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.home,
                                      size: 16, color: Color(0xFF4A90E2)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "Development Type: ${stringNullCheck(_controller
                                          .workflowAllocationResponse
                                          .value
                                          .developmentTypeName
                                          .toString())}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.home,
                                      size: 16, color: Color(0xFF4A90E2)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "Fiscal Year: ${stringNullCheck(_controller
                                          .workflowAllocationResponse
                                          .value
                                          .fiscalYearId
                                          .toString())}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),

                      ],
                    )),
                const SizedBox(height: 16),


                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: _controller
                        .workflowAllocationResponse.value.economicCodeGroup!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return allocationListItemView(
                          context,
                          _controller.workflowAllocationResponse.value,
                          _controller.workflowAllocationResponse.value
                              .economicCodeGroup![index]);
                    },
                  ),
                ),
              ],
            ),
          );
    });
  }

  Widget _WorkflowDemandDetailsTab(BuildContext context) {
    return Obx(() {
      //return _controller.workflowAllocationResponse.value.economicCodeGroup!.isEmpty
      return _controller.workflowDemandDetailsResponse.value == null
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : Container(
              alignment: Alignment.topRight,
              margin:
                  const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
              padding:
                  const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
              child: Column(
                children: [

                  /*Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textAutoSize(
                          text: "Amount: (Lakh BDT)",
                          maxLines: 1,
                          fontSize: dp16,
                          alignment: Alignment.center,
                          fontWeight: FontWeight.bold),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Status",
                          rightText: stringNullCheck(_controller.workflowDemandDetailsResponse.value.status.toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Development Type ",
                          rightText: stringNullCheck(_controller
                              .workflowDemandDetailsResponse
                              .value
                              .developmentTypeName
                              .toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Fiscal Year",
                          rightText: stringNullCheck(_controller
                              .workflowDemandDetailsResponse.value.fiscalYearId
                              .toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Date and Time",
                          rightText: stringNullCheck(
                              " ${formatDateToDDMMYYYY(_controller.workflowDemandDetailsResponse.value.timestamp.toString())}, ${formatDateToHHMMAPM(_controller.workflowDemandDetailsResponse.value.timestamp.toString())} ")),
                      const Divider(),
                    ],
                  ),*/

                  Container(
                    //padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: accentBlue.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        stringNullCheck(_controller.workflowDemandDetailsResponse.value.status.toString()),
                                        style: TextStyle(
                                          color: accentBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: accentGreen.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: accentGreenText,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            " ${formatDateToDDMMYYYY(_controller.workflowDemandDetailsResponse.value.timestamp.toString())}, ${formatDateToHHMMAPM(_controller.workflowDemandDetailsResponse.value.timestamp.toString())}",
                                            style: const TextStyle(
                                              color: accentGreenText,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.home,
                                        size: 16, color: Color(0xFF4A90E2)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Development Type: ${stringNullCheck(_controller
                                            .workflowDemandDetailsResponse
                                            .value
                                            .developmentTypeName
                                            .toString())}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                /*const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.verified_user_sharp,
                                        size: 16, color: Color(0xFF10A3C2)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Demand Amount:  ${formatter.format(data.demandAmount)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),*/
                                /*const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.verified_user_sharp,
                                        size: 16, color: Color(0xFF10A3C2)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Total Amount:  ${formatter.format(data.totalAmount)}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),*/
                              ],
                            ),
                          ),

                        ],
                      )),
                  const SizedBox(height: 16),

                  Expanded(
                    child: ListView.builder(
                      //padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: _controller.workflowDemandDetailsResponse
                          .value.economicCodeGroupDemand!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return workflowDemandListItemView(
                            context,
                            _controller.workflowDemandDetailsResponse.value,
                            _controller.workflowDemandDetailsResponse.value
                                .economicCodeGroupDemand![index]);
                      },
                    ),
                  ),
                ],
              ),
            );

    });
  }

  //rokan 29.05.2025
  /*Widget _WorkflowAllocationDistributionDetailsTab(BuildContext context) {
    return Obx(() {
      //return _controller.workflowAllocationResponse.value.economicCodeGroup!.isEmpty
      return _controller.workflowAllocationDistributionDetailsResponse.value ==
              null
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : Container(
              //decoration: boxDecorationRoundShadowLight(),
              alignment: Alignment.topRight,
              margin:
                  const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
              padding:
                  const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textAutoSize(
                          text: "Amount: (Lakh BDT)",
                          maxLines: 1,
                          fontSize: dp16,
                          alignment: Alignment.center,
                          fontWeight: FontWeight.bold),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Status",
                          rightText: stringNullCheck(_controller
                              .workflowAllocationDistributionDetailsResponse
                              .value
                              .status
                              .toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Development Type ",
                          rightText: stringNullCheck(_controller
                              .workflowAllocationDistributionDetailsResponse
                              .value
                              .developmentTypeName
                              .toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Fiscal Year",
                          rightText: stringNullCheck(_controller
                              .workflowAllocationDistributionDetailsResponse
                              .value
                              .fiscalYearId
                              .toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Total Amount",
                          rightText: stringNullCheck(_controller
                              .workflowAllocationDistributionDetailsResponse
                              .value
                              .totalAmount
                              .toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Demand Amount",
                          rightText: stringNullCheck(_controller
                              .workflowAllocationDistributionDetailsResponse
                              .value
                              .demandAmount
                              .toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Allocation Amount",
                          rightText: stringNullCheck(_controller
                              .workflowAllocationDistributionDetailsResponse
                              .value
                              .allocationAmount
                              .toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Date and Time",
                          rightText: stringNullCheck(
                              " ${formatDateToDDMMYYYY(_controller.workflowAllocationDistributionDetailsResponse.value.timestamp!.toString())}, ${formatDateToHHMMAPM(_controller.workflowAllocationDistributionDetailsResponse.value.timestamp!.toString())} ")),
                      const Divider(),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        //padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: _controller
                            .workflowAllocationDistributionDetailsResponse
                            .value
                            .economicCodeGroupAllocationDistribution!
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return workflowAllocationDistributionListItemView(
                              context,
                              _controller
                                  .workflowAllocationDistributionDetailsResponse
                                  .value,
                              _controller
                                  .workflowAllocationDistributionDetailsResponse
                                  .value
                                  .economicCodeGroupAllocationDistribution![index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }*/

  Widget _WorkflowAllocationDistributionDetailsTab(BuildContext context) {
    return Obx(() {
      final data =
          _controller.workflowAllocationDistributionDetailsResponse.value;

      if (data == null)
        return handleEmptyViewWithLoading(_controller.isDataLoaded);

      return Container(
        alignment: Alignment.topRight,
        margin: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
        child: Column(
          children: [

            Container(
                //padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: accentBlue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  stringNullCheck(data.status),
                                  style: TextStyle(
                                    color: accentBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: accentGreen.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_today,
                                      color: accentGreenText,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      " ${formatDateToDDMMYYYY(data.timestamp.toString())}, ${formatDateToHHMMAPM(data.timestamp.toString())}",
                                      style: const TextStyle(
                                        color: accentGreenText,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.home,
                                  size: 16, color: Color(0xFF4A90E2)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Development Type: ${stringNullCheck(data.developmentTypeName)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.verified_user_sharp,
                                  size: 16, color: Color(0xFF10A3C2)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Demand Amount:  ${formatter.format(data.demandAmount)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Icon(Icons.verified_user_sharp,
                                  size: 16, color: Color(0xFF10A3C2)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "Total Amount:  ${formatter.format(data.totalAmount)}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  ],
                )),
            const SizedBox(height: 16),

            //rokan june
            Expanded(
              child: ListView.builder(
                itemCount:
                    data.economicCodeGroupAllocationDistribution?.length ?? 0,
                itemBuilder: (context, index) {
                  final group =
                      data.economicCodeGroupAllocationDistribution![index];
                  return _economicCodeGroupAllocationDistributionItemView(
                      context, data, group);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _economicCodeGroupAllocationDistributionItemView(
    BuildContext context,
    WorkflowAllocationDistributionDetailsResponse headerData,
    EconomicCodeGroupAllocationDistribution group,
  ) {
    List<RatificationFinancialDetail> allDetails = [];
    for (var econCode in group.projectRatificationEconomicCodes ?? []) {
      allDetails.addAll(econCode.ratificationFinancialDetails ?? []);
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        children: allDetails.map((detail) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: accentBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        stringNullCheck(group.economicCodesTypeName),
                        style: TextStyle(
                          color: accentBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    /*const Spacer(),
                    Row(
                      children: [
                        Icon(Icons.calendar_today,
                            color: accentGreenText, size: 14),
                        const SizedBox(width: 6),
                        Text(
                          "${formatDateToDDMMYYYY(headerData.timestamp.toString())}, ${formatDateToHHMMAPM(headerData.timestamp.toString())}",
                          style: const TextStyle(
                            color: accentGreenText,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),*/
                  ],
                ),
                const SizedBox(height: 12),
                _infoRow(Icons.source, "Financial Source",
                    detail.baseProjectFinancialSourceName),
                _infoRow(Icons.numbers, "Local Amount",
                    detail.amountLocal.toString()),
                _infoRow(
                    Icons.numbers, "FE Amount", detail.amountFe.toString()),
                _infoRow(Icons.numbers, "Total Amount",
                    detail.amountTotal.toString()),
                _infoRow(Icons.numbers, "Demand (Local)",
                    detail.demandAmountLocal.toString()),
                _infoRow(Icons.numbers, "Demand (FE)",
                    detail.demandAmountFe.toString()),
                _infoRow(Icons.numbers, "Allocation (Local)",
                    detail.allocationAmountLocal.toString()),
                _infoRow(Icons.numbers, "Allocation (FE)",
                    detail.allocationAmountFe.toString()),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Color(0xFF1190E9)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "$title: ${stringNullCheck(value)}",
              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _WorkflowFundReleaseDetailsTab(BuildContext context) {
    return Obx(() {
      //return _controller.workflowAllocationResponse.value.economicCodeGroup!.isEmpty
      return _controller.workflowFundReleaseDetailsResponse.value == null
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : Container(
              //decoration: boxDecorationRoundShadowLight(),
              alignment: Alignment.topRight,
              margin:
                  const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
              padding:
                  const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
              child: Column(
                children: [

                  /*Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textAutoSize(
                          text: "Amount: (Lakh BDT)",
                          maxLines: 1,
                          fontSize: dp16,
                          alignment: Alignment.center,
                          fontWeight: FontWeight.bold),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Status",
                          rightText: stringNullCheck(_controller
                              .workflowFundReleaseDetailsResponse.value.status
                              .toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Fiscal Year",
                          rightText: stringNullCheck(_controller
                              .workflowFundReleaseDetailsResponse
                              .value
                              .fiscalYearId
                              .toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Date and Time",
                          rightText: stringNullCheck(
                              " ${formatDateToDDMMYYYY(_controller.workflowFundReleaseDetailsResponse.value.timestamp!.toString())}, ${formatDateToHHMMAPM(_controller.workflowFundReleaseDetailsResponse.value.timestamp!.toString())} ")),
                      const Divider(),
                    ],
                  ),*/


                  Container(
                    //padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: accentBlue.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        stringNullCheck(_controller.workflowFundReleaseDetailsResponse.value.status.toString()),
                                        style: TextStyle(
                                          color: accentBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: accentGreen.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: accentGreenText,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            " ${formatDateToDDMMYYYY(_controller.workflowFundReleaseDetailsResponse.value.timestamp!.toString())}, ${formatDateToHHMMAPM(_controller.workflowFundReleaseDetailsResponse.value.timestamp!.toString())}",
                                            style: const TextStyle(
                                              color: accentGreenText,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.home,
                                        size: 16, color: Color(0xFF4A90E2)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Fiscal Year: ${stringNullCheck(_controller.workflowFundReleaseDetailsResponse.value.fiscalYearId.toString())}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      )),
                  const SizedBox(height: 16),


                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        //padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: _controller
                            .workflowFundReleaseDetailsResponse
                            .value
                            .fundReleaseFinancialSourceDetails!
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return workflowFundReleaseListItemView(
                              context,
                              _controller
                                  .workflowFundReleaseDetailsResponse
                                  .value
                                  .fundReleaseFinancialSourceDetails![index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }

  Widget _WorkflowAllocationReturnDetailsTab(BuildContext context) {
    return Obx(() {
      //return _controller.workflowAllocationResponse.value.economicCodeGroup!.isEmpty
      return _controller.workflowAllocationReturnDetailsResponse.value == null
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : Container(
              //decoration: boxDecorationRoundShadowLight(),
              alignment: Alignment.topRight,
              margin:
                  const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
              padding:
                  const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
              child: Column(
                children: [

                  /*Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textAutoSize(
                          text: "Amount: (Lakh BDT)",
                          maxLines: 1,
                          fontSize: dp16,
                          alignment: Alignment.center,
                          fontWeight: FontWeight.bold),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Status",
                          rightText: stringNullCheck(_controller
                              .workflowAllocationReturnDetailsResponse
                              .value
                              .status
                              .toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Fiscal Year",
                          rightText: stringNullCheck(_controller
                              .workflowAllocationReturnDetailsResponse
                              .value
                              .fiscalYearId
                              .toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Date and Time",
                          rightText: stringNullCheck(
                              " ${formatDateToDDMMYYYY(_controller.workflowAllocationReturnDetailsResponse.value.timestamp!.toString())}, "
                                  "${formatDateToHHMMAPM(_controller.workflowAllocationReturnDetailsResponse.value.timestamp!.toString())} ")),
                      const Divider(),
                    ],
                  ),*/

                  Container(
                    //padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: accentBlue.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        stringNullCheck(_controller
                                            .workflowAllocationReturnDetailsResponse
                                            .value
                                            .status
                                            .toString()),
                                        style: TextStyle(
                                          color: accentBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: accentGreen.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: accentGreenText,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            " ${formatDateToDDMMYYYY(_controller.workflowAllocationReturnDetailsResponse.value.timestamp!.toString())}, "
                                                "${formatDateToHHMMAPM(_controller.workflowAllocationReturnDetailsResponse.value.timestamp!.toString())} ",
                                            style: const TextStyle(
                                              color: accentGreenText,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.home,
                                        size: 16, color: Color(0xFF4A90E2)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Fiscal Year: ${stringNullCheck(_controller
                                            .workflowAllocationReturnDetailsResponse
                                            .value
                                            .fiscalYearId
                                            .toString())}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        ],
                      )),
                  const SizedBox(height: 16),


                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        //padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: _controller
                            .workflowAllocationReturnDetailsResponse
                            .value
                            .allocationFinancialDetails!
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return workflowAllocationReturnListItemView(
                              context,
                              _controller
                                  .workflowAllocationReturnDetailsResponse
                                  .value
                                  .allocationFinancialDetails![index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }

  Widget _WorkflowReappropriationDetailsTab(BuildContext context) {
    return Obx(() {
      return _controller.workflowReappropriationDetailsResponse.value == null
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : Container(
              //decoration: boxDecorationRoundShadowLight(),
              alignment: Alignment.topRight,
              margin:
                  const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
              padding:
                  const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
              child: Column(
                children: [
                  /*textAutoSize(
                      text: "Amount: (Lakh BDT)",
                      maxLines: 1,
                      fontSize: dp16,
                      alignment: Alignment.center,
                      fontWeight: FontWeight.bold),
                  const Divider(),*/

                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: _controller
                            .workflowReappropriationDetailsResponse
                            .value!
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return workflowReappropriationListItemView(
                              context,
                              _controller.workflowReappropriationDetailsResponse
                                  .value![index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
    });
  }

  /*Widget _WorkflowReappropriationDetailsTab(BuildContext context) {
    return Obx(() {
      return _controller.workflowReappropriationDetailsResponse.value == null
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : SizedBox(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: _controller.workflowReappropriationDetailsResponse.value!.length,
          itemBuilder: (BuildContext context, int index) {
            return workflowReappropriationListItemView(context, _controller.workflowReappropriationDetailsResponse.value![index]);
          },
        ),
      );
    });
  }*/

  Widget _WorkflowFundDistributionDetailsTab(BuildContext context) {
    return Obx(() {
      //return _controller.workflowAllocationResponse.value.economicCodeGroup!.isEmpty
      return _controller.workflowFundDistributionDetailsResponse.value == null
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : Container(
              //decoration: boxDecorationRoundShadowLight(),
              alignment: Alignment.topRight,
              margin:
                  const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
              padding:
                  const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
              child: Column(
                children: [
                  /*Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textAutoSize(
                          text: "Amount: (Lakh BDT)",
                          maxLines: 1,
                          fontSize: dp16,
                          alignment: Alignment.center,
                          fontWeight: FontWeight.bold),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Status",
                          rightText: stringNullCheck(_controller.workflowFundDistributionDetailsResponse.value.status.toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Total Amount ",
                          rightText: stringNullCheck(_controller.workflowFundDistributionDetailsResponse.value.totalAmount.toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Total Release Amount ",
                          rightText: stringNullCheck(_controller.workflowFundDistributionDetailsResponse.value.totalReleaseAmount.toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Fiscal Year",
                          rightText: stringNullCheck(_controller
                              .workflowFundDistributionDetailsResponse
                              .value
                              .fiscalYearId
                              .toString())),
                      const Divider(),
                      twoSidedTextWithColon2(
                          leftText: "Date and Time",
                          rightText: stringNullCheck(
                              " ${formatDateToDDMMYYYY(_controller.workflowFundDistributionDetailsResponse.value.timestamp.toString())}, "
                              "${formatDateToHHMMAPM(_controller.workflowFundDistributionDetailsResponse.value.timestamp.toString())} ")),
                      const Divider(),
                    ],
                  ),*/


                  Container(
                    //padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: accentBlue.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        stringNullCheck(_controller.workflowFundDistributionDetailsResponse.value.status.toString()),
                                        style: TextStyle(
                                          color: accentBlue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: accentGreen.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: accentGreenText,
                                            size: 14,
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            " ${formatDateToDDMMYYYY(_controller.workflowFundDistributionDetailsResponse.value.timestamp.toString())}, "
                                                "${formatDateToHHMMAPM(_controller.workflowFundDistributionDetailsResponse.value.timestamp.toString())}",

                                            style: const TextStyle(
                                              color: accentGreenText,
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.home,
                                        size: 16, color: Color(0xFF4A90E2)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Fiscal Year: ${stringNullCheck(_controller.workflowFundDistributionDetailsResponse.value.fiscalYearId.toString())}",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.money,
                                        size: 16, color: Color(0xFF4A90E2)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        //"Total Release Amount: ${stringNullCheck(_controller.workflowFundDistributionDetailsResponse.value.totalReleaseAmount.toString())}",
                                        stringNullCheck("Total Release Amount: ${formatter.format(_controller.workflowFundDistributionDetailsResponse.value.totalReleaseAmount)}"),

                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.money,
                                        size: 16, color: Color(0xFF4A90E2)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        //"Total Amount: ${stringNullCheck(_controller.workflowFundDistributionDetailsResponse.value.totalAmount.toString())}",
                                        stringNullCheck("Total Amount: ${formatter.format(_controller.workflowFundDistributionDetailsResponse.value.totalAmount)}"),

                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),


                              ],
                            ),
                          ),

                        ],
                      )),
                  const SizedBox(height: 16),

                  Expanded(
                    child: SizedBox(
                      child: ListView.builder(
                        //padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        itemCount: _controller
                            .workflowFundDistributionDetailsResponse
                            .value
                            .economicCodeGroupFundDistribution!
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return workflowFundDistributionListItemView(
                              context,
                              _controller
                                  .workflowFundDistributionDetailsResponse
                                  .value,
                              _controller
                                  .workflowFundDistributionDetailsResponse
                                  .value
                                  .economicCodeGroupFundDistribution![index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );

    });
  }
}
