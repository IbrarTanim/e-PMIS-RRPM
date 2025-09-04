import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pending_task/pending_task_controller.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pending_task/projects_list_item_workflow.dart';
import 'package:pmis_flutter/ui/features/root/root_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';

class PendingTaskScreen extends StatefulWidget {
  const PendingTaskScreen({Key? key}) : super(key: key);

  @override
  _PendingTaskScreenState createState() => _PendingTaskScreenState();
}

class _PendingTaskScreenState extends State<PendingTaskScreen> {
  final _controller = Get.put(PendingTaskController());
  final _rootController = Get.put(RootController());
  bool isLoading = true;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _controller.getData();

      setState(() {
        isLoading = false;
      });
      _controller.getPendingTaskList(
          false, _rootController.userInfo.value.id.toString());
      // _controller.getWorkflowNodeData(_rootController.userInfo.value.id.toString());
    });
  }

  @override
  void dispose() {
    _controller.clearView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.theme.colorScheme.surface,
      backgroundColor: bgColor,
      appBar: appBarMain(
        context, title: "PendingTask".tr,
        //appBar: appBarMain(context, title: "FastTrack".tr,
        /*actionIcons: [AssetConstants.icSearch,
            // AssetConstants.icFavoriteFilled
          ],*/
        /*onPress: (index) {
            if (index == 0) {
              Get.to(() => const MyProjectsSearchScreen());
            } else {
              // Get.to(() => const WatchListScreen());
            }
          }*/
      ),
      body:
      SafeArea(
        child: isLoading == true
            ? const Center(
            child: CircularProgressIndicator(color: Colors.green))
            : Column(
          children: [
            const VSpacer10(),
            Obx(() {
              return _controller.listResponse.value.paginationDto == null
                  ? const SizedBox(width: 0, height: 0)
                  : totalProjectsCommonTitle(
                  title: "Total Pending Task : ${stringNullCheck(_controller.listResponse.value.paginationDto!.total.toString(),)}");

            }),
            const VSpacer10(),
            Expanded(
              child: Obx(() {
                return _controller.listResponse.value.paginationDto == null
                    ? showEmptyView()
                    : _pendingTaskItemList(context);
              }),
            ),
          ],
        ),
      ),


      /*SafeArea(
        child: Column(
          children: [
            const VSpacer10(),
            Obx(() {
              return _controller.listResponse.value.paginationDto == null
                  ? const SizedBox(width: 0, height: 0)
                  : textSpanAutoSize(
                      title: "TotalPendingTask".tr,
                      subTitle: _controller
                          .listResponse.value.paginationDto!.total
                          .toString(),
                      colorTitle: Get.theme.primaryColor);
            }),
            const VSpacer10(),
            Expanded(
              child: Obx(() {
                return _controller.listResponse.value.paginationDto == null
                    ? showEmptyView()
                    : _pendingTaskItemList(context);
              }),
            ),

          ],
        ),
      ),*/
    );
  }

  Widget _pendingTaskItemList(BuildContext context) {
    return Obx(() {
      // String message = "empty_message".tr;
      return _controller.allProjectsResponseList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : SizedBox(
              child: ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: _controller.allProjectsResponseList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_controller.allProjectsResponseList.length ==
                      _controller.listResponse.value.paginationDto!.total) {
                    //showToast('No more Data');
                  }
                  if (_controller.hasMoreData &&
                      index ==
                          (_controller.allProjectsResponseList.length - 1)) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      _controller.getPendingTaskList(
                          true, _rootController.userInfo.value.id.toString());
                    });
                  }
                  return projectListItemWorkflow(
                      context, _controller.allProjectsResponseList[index],);

                  /*return pendingTaskListItemView(
                      context,
                      _controller.allProjectsResponseList[index],
                      _controller,
                      _rootController);*/




                },
              ),
            );
    });
  }















}
