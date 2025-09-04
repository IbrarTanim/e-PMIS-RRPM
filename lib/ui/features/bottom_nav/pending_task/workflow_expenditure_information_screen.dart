import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/workflow_expenditure_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_expenditure_infprmation_response.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pending_task/workflow_expenditure_information_controller.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pending_task/workflow_expenditure_information_list_item.dart';
import 'package:pmis_flutter/ui/features/project/common/projects_list_item.dart';
import 'package:pmis_flutter/ui/features/search/my_project_search/search_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/projects/projects_controller.dart';
import 'package:pmis_flutter/ui/features/root/root_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';

class WorkflowExpenditureInformationScreen extends StatefulWidget {
  final WorkflowExpenditureDetailsResponse? allProjectsResponse;


  const WorkflowExpenditureInformationScreen(
      {Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  _WorkflowExpenditureInformationScreenState createState() => _WorkflowExpenditureInformationScreenState();
}

class _WorkflowExpenditureInformationScreenState extends State<WorkflowExpenditureInformationScreen> {

  final _workflowExpenditureInformationController = Get.put(WorkflowExpenditureInformationController());


  bool isLoading = true;

  void initCalls() async {
     _workflowExpenditureInformationController.getWorkflowExpenditureInformationList (false, widget.allProjectsResponse!.projectExpenditureId.toString());

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

  /*@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _controller.getData();
      _controller.getProjectsList(_rootController.userInfo.value.id.toString());
    });
  }*/





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBarWithBackAndActions(
        title: " Monthly Expenditure",
        onPress: (index) {
        }),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
            child: CircularProgressIndicator(color: Colors.green))
            : Column(
          children: [
            const VSpacer10(),
            Obx(() {
              return _workflowExpenditureInformationController.allProjectsResponseList.isEmpty
                  ? const SizedBox(width: 0, height: 0)
                  : totalProjectsCommonTitle(
                  title: "Total Projects : ${stringNullCheck(_workflowExpenditureInformationController.allProjectsResponseList.length.toString())}");

            }),
            const VSpacer10(),
            Expanded(
              child: _projectsItemList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _projectsItemList(BuildContext context) {
    return Obx(() {
      // String message = "empty_message".tr;
      return /*_controller.projectsListResponse.isEmpty
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          :*/
        SizedBox(
          child: ListView.builder(
            //physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: _workflowExpenditureInformationController.allProjectsResponseList.length,
            itemBuilder: (BuildContext context, int index) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  _workflowExpenditureInformationController.getWorkflowExpenditureInformationList(false, widget.allProjectsResponse!.projectExpenditureId.toString());
                });

              // return projectItemView(
              return WorkflowExpenditureInformationListItem(projectExpenditureCostResponse: _workflowExpenditureInformationController.allProjectsResponseList[index],);
            },
          ),
        );
    });
  }
}
