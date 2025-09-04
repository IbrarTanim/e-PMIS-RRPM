import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/notification/notification_controller.dart';
import 'package:pmis_flutter/ui/features/search/my_project_search/search_screen.dart';
import 'package:pmis_flutter/ui/features/root/root_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final _controller = Get.put(NotificationController());
  final _rootController = Get.put(RootController());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _controller.getData();
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
        context, title: "Notification",
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
      body: SafeArea(
        child: Column(
          children: [
            const VSpacer10(),
            /*Obx(() {
              return _controller.listResponse.value.paginationDto == null
                  ? const SizedBox(width: 0, height: 0)
                  : textSpanAutoSize(
                      title: "Total Notification",
                      subTitle: _controller
                          .listResponse.value.paginationDto!.total
                          .toString(),
                      colorTitle: Get.theme.primaryColor);
            }),*/
            const VSpacer10(),
            /*Expanded(
              child: Obx(() {
                return _controller.listResponse.value.paginationDto == null
                    ? showEmptyView()
                    : _pendingTaskItemList(context);
              }),
            ),*/
/*            Expanded(
              child: RefreshIndicator(
                onRefresh: _controller.getData,
                child: Obx(() {
                  return _controller.listResponse.value.paginationDto == null
                      ? showEmptyView()
                      : _fastTrackItemList(context);
                }), //_ministryWiseItem(),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  /*Widget _pendingTaskItemList(BuildContext context) {
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
                  return pendingTaskListItemView(
                      context,
                      _controller.allProjectsResponseList[index],
                      _controller,
                      _rootController);
                },
              ),
            );
    });
  }*/
}
