import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/search/my_project_search/search_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import '../../../../../utils/common_utils.dart';
import 'already_completed_controller.dart';

class AlreadyCompletedScreen extends StatefulWidget {
  const AlreadyCompletedScreen({Key? key}) : super(key: key);

  @override
  _AlreadyCompletedScreenState createState() => _AlreadyCompletedScreenState();
}

class _AlreadyCompletedScreenState extends State<AlreadyCompletedScreen> {
  final _controller = Get.put(AlreadyCompletedController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _controller.getData();
      _controller.getMyCompletedProjectListWithPcrReceived(false);
      _controller.getMyCompletedProjectListWithPcrNotReceived(false);
    });
  }
  @override
  void didUpdateWidget(covariant AlreadyCompletedScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(_controller.tabSelectedIndex.value ==1){
        _controller.getMyCompletedProjectListWithPcrReceived(false);
      }else if(_controller.tabSelectedIndex.value ==2){
        _controller.getMyCompletedProjectListWithPcrNotReceived(false);
      }
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
      backgroundColor: context.theme.colorScheme.surface,
      appBar: appBarWithBackAndActions(
          title: "AlreadyCompleted".tr,
          actionIcons: [
            AssetConstants.icSearch,
            // AssetConstants.icFavoriteFilled
          ],
          onPress: (index) {
            if (index == 0) {
              Get.to(() => const MyProjectsSearchScreen());
            } else {
              // Get.to(() => const WatchListScreen());
            }
          }),
      body: SafeArea(
        child: Column(
          children: [
            getTabView(
              titles: ["PCRReceived".tr, "PCRNotReceived".tr],
              controller: _controller.tabController,
              onTap: (selected) {
                _controller.tabSelectedIndex.value = selected;
              },
            ),
            Expanded(
              child: TabBarView(
                  controller: _controller.tabController,
                  children: [_pcrReceivedTab(), _pcrNotReceivedTab()]),
            ),
/*            const VSpacer10(),
            Obx(() {
              return _controller.listResponse.value.paginationDto == null
                  ? const SizedBox(width: 0, height: 0)
                  : textSpanAutoSize(
                  title: "TotalProjects".tr,
                  subTitle: _controller.listResponse.value.paginationDto!.total.toString(),
                  colorTitle: Get.theme.primaryColor);
            }),
            const VSpacer10(),
            Expanded(
              child: Obx(() {
                return _controller.listResponse.value.paginationDto == null
                    ? showEmptyView()
                    : _myCompletedProjectItemList(context);
              }),
            ),*/
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
          return _controller.listResponseForPcrReceived.value.paginationDto == null
              ? const SizedBox(width: 0, height: 0)
              : Container(
            margin: const EdgeInsets.only(left: 16),
            alignment: Alignment.centerLeft,
                child: totalProjectsCommonTitle(title: "Total Projects : ${stringNullCheck(_controller.listResponseForPcrReceived.value.paginationDto!.total.toString())}"),


            /*textSpanAutoSize(
                title: "TotalProjects".tr,
                subTitle: _controller.listResponseForPcrReceived.value.paginationDto!.total.toString(),
                colorTitle: Get.theme.primaryColor,
            textAlign: TextAlign.left
          ),*/
              );
        }),
        const VSpacer10(),
        Obx(() {
          // String message = "empty_message".tr;
          return _controller.allProjectsResponseListWithPcrReceived.isEmpty
              ? handleEmptyViewWithLoading(_controller.isDataLoaded)
              : SizedBox(
                  height: Platform.isAndroid
                      ? getContentHeight() - 115
                      : getContentHeight() - 185,
                  child: ListView.builder(
                    //physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: _controller.allProjectsResponseListWithPcrReceived.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (_controller.hasMoreData &&
                          index ==
                              (_controller.allProjectsResponseListWithPcrReceived.length - 1)) {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          _controller.getMyCompletedProjectListWithPcrReceived(true);
                        });
                      }
                      return projectListItemViewForMyProject(
                          context, _controller.allProjectsResponseListWithPcrReceived[index]);
                    },
                  ),
                );
        }),
      ],
    );
  }

  Widget _pcrNotReceivedTab() {
    return Column(
      children: [
        const VSpacer10(),
        Obx(() {
          return _controller.listResponseForPcrNotReceived.value.paginationDto == null
              ? const SizedBox(width: 0, height: 0)
              : Container(
            margin: const EdgeInsets.only(right: 16),
            alignment: Alignment.centerRight,
                child: totalProjectsCommonTitle(title: "Total Projects : ${stringNullCheck(_controller.listResponseForPcrNotReceived.value.paginationDto!.total.toString())}"),

              /*textSpanAutoSize(
                title: "TotalProjects".tr,
                subTitle: _controller.listResponseForPcrNotReceived.value.paginationDto!.total.toString(),
                colorTitle: Get.theme.primaryColor,
                textAlign: TextAlign.right),*/
              );
        }),
        const VSpacer10(),
        Obx(() {
          // String message = "empty_message".tr;
          return _controller.allProjectsResponseListWithPcrNotReceived.isEmpty
              ? handleEmptyViewWithLoading(_controller.isDataLoaded)
              : SizedBox(
                  height: Platform.isAndroid
                      ? getContentHeight() - 115
                      : getContentHeight() - 185,
                  child: ListView.builder(
                    //physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: _controller.allProjectsResponseListWithPcrNotReceived.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (_controller.hasMoreData &&
                          index ==
                              (_controller.allProjectsResponseListWithPcrNotReceived.length - 1)) {
                        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                          _controller.getMyCompletedProjectListWithPcrNotReceived(true);
                        });
                      }
                      return projectListItemViewForMyProject(
                          context, _controller.allProjectsResponseListWithPcrNotReceived[index]);
                    },
                  ),
                );
        }),
      ],
    );
  }

/*  Widget _myCompletedProjectItemList(BuildContext context) {
    return Obx(() {
      // String message = "empty_message".tr;
      return _controller.allProjectsResponseListWithPcrReceived.isEmpty
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : SizedBox(
              child: ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: _controller.allProjectsResponseListWithPcrReceived.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_controller.hasMoreData &&
                      index ==
                          (_controller.allProjectsResponseListWithPcrReceived.length - 1)) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      _controller.getMyCompletedProjectListWithPcrReceived(true);
                    });
                  }
                  return projectListItemViewForMyProject(
                      context, _controller.allProjectsResponseListWithPcrReceived[index]);
                },
              ),
            );
    });
  }*/
}
