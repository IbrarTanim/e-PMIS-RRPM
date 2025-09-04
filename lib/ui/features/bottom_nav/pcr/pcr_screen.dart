import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/project/common/projects_list_item.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pcr/pcr_tab_bar.dart';
import 'package:pmis_flutter/ui/features/search/my_project_search/search_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import '../../../../utils/common_utils.dart';
import 'pcr_controller.dart';

class PCRScreen extends StatefulWidget {
  const PCRScreen({Key? key}) : super(key: key);

  @override
  _PCRScreenState createState() => _PCRScreenState();
}

class _PCRScreenState extends State<PCRScreen> {
  final _controller = Get.put(PCRController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _controller.getData();
      _controller.getMyCompletedProjectListWithPcrReceived(false);
      _controller.getMyCompletedProjectListWithPcrNotReceived(false);
    });
  }

  // @override
  // void didUpdateWidget(covariant PCRScreen oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     if(_controller.tabSelectedIndex.value ==1){
  //       _controller.getMyCompletedProjectListWithPcrReceived(true);
  //     }else if(_controller.tabSelectedIndex.value ==2){
  //       _controller.getMyCompletedProjectListWithPcrNotReceived(true);
  //     }
  //   });
  // }

  @override
  void dispose() {
    _controller.clearView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      // appBar: appBarMain(context, title: "Ministry_wise".tr),
      appBar: appBarMain(
        context,
        title: "PCRForCompletedProjects".tr,
        actionIcons: [
          /*AssetConstants.icSearch,*/ //Rokan
          // AssetConstants.icFavoriteFilled
        ],
        /*onPress: (index) { //Rokan
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
            PCRTabs(
              controller: _controller.tabController,
              onTap: (selected) {
                _controller.tabSelectedIndex.value = selected;
              },
              pcrReceivedCount: _controller
                      .listResponseForPcrReceived.value.paginationDto?.total ??
                  0,
              pcrNotReceivedCount: _controller.listResponseForPcrNotReceived
                      .value.paginationDto?.total ??
                  0,
            ),
            Expanded(
              child: TabBarView(
                  controller: _controller.tabController,
                  children: [_pcrReceivedTab(), _pcrNotReceivedTab()]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pcrReceivedTab() {
    return Column(
      children: [
        const VSpacer10(),
        Obx(() {
          return _controller.listResponseForPcrReceived.value.paginationDto ==
                  null
              ? const SizedBox(width: 0, height: 0)
              : Container(
                  margin: const EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  child: textSpanAutoSize(
                      title: "TotalPcrReceivedProjects".tr,
                      subTitle: _controller
                          .listResponseForPcrReceived.value.paginationDto!.total
                          .toString(),
                      colorTitle: Get.theme.primaryColor,
                      textAlign: TextAlign.left),
                );
        }),
        const VSpacer10(),
        Expanded(
          child: Obx(() {
            return _controller.listResponseForPcrReceived.value.paginationDto ==
                    null
                ? showEmptyView()
                : _pendingPcrProjectItemList(context);
          }),
        ),
      ],
    );
  }

  Widget _pendingPcrProjectItemList(BuildContext context) {
    return Obx(() {
      // String message = "empty_message".tr;
      return _controller.pcrReceivedResponseItemList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isDataLoadedForPcrReceived)
          : SizedBox(
              height: Platform.isAndroid
                  ? getContentHeight() - 170
                  : getContentHeight() - 236,
              child: ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: _controller.pcrReceivedResponseItemList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_controller.hasMoreDataForPcrReceived &&
                      index ==
                          (_controller.pcrReceivedResponseItemList.length -
                              1)) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      _controller
                          .getMyCompletedProjectListWithPcrReceived(true);
                    });
                  }
                  // return projectListItemViewForMyProject(
                  return projectListItem(
                      context, _controller.pcrReceivedResponseItemList[index],
                      isMyProject: true);
                },
              ),
            );
    });
  }

  Widget _pcrNotReceivedTab() {
    return Column(
      children: [
        const VSpacer10(),
        Obx(() {
          return _controller
                      .listResponseForPcrNotReceived.value.paginationDto ==
                  null
              ? const SizedBox(width: 0, height: 0)
              : Container(
                  margin: const EdgeInsets.only(right: 16),
                  alignment: Alignment.centerRight,
                  child: textSpanAutoSize(
                      title: "TotalPcrNotReceivedProjects".tr,
                      subTitle: _controller.listResponseForPcrNotReceived.value
                          .paginationDto!.total
                          .toString(),
                      colorTitle: Get.theme.primaryColor,
                      textAlign: TextAlign.right),
                );
        }),
        const VSpacer10(),
        Expanded(
          child: Obx(() {
            return _controller
                        .listResponseForPcrNotReceived.value.paginationDto ==
                    null
                ? showEmptyView()
                : _pcrNotReceivedProjectItemList(context);
          }),
        ),
      ],
    );
  }

  Widget _pcrNotReceivedProjectItemList(BuildContext context) {
    return Obx(() {
      // String message = "empty_message".tr;
      return _controller.pcrNotReceivedResponseItemList.isEmpty
          ? handleEmptyViewWithLoading(
              _controller.isDataLoadedForPcrNotReceived)
          : SizedBox(
              height: Platform.isAndroid
                  ? getContentHeight() - 170
                  : getContentHeight() - 236,
              child: ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: _controller.pcrNotReceivedResponseItemList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_controller.hasMoreDataForPcrNotReceived &&
                      index ==
                          (_controller.pcrNotReceivedResponseItemList.length -
                              1)) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      _controller
                          .getMyCompletedProjectListWithPcrNotReceived(true);
                    });
                  }
                  // return projectListItemViewForMyProject(
                  return projectListItem(context,
                      _controller.pcrNotReceivedResponseItemList[index]);
                },
              ),
            );
    });
  }
}
