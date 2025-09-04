import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/project/common/projects_list_item.dart';
import 'package:pmis_flutter/ui/features/search/my_project_search/search_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import 'fast_track_controller.dart';

class FastTrackScreen extends StatefulWidget {
  const FastTrackScreen({Key? key}) : super(key: key);

  @override
  _FastTrackScreenState createState() => _FastTrackScreenState();
}

class _FastTrackScreenState extends State<FastTrackScreen> {
  final _controller = Get.put(FastTrackController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _controller.getData();
      _controller.getFastTrackList(false);
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
      backgroundColor: bgColor,
      appBar: appBarWithBackAndActions(
        title: "FastTrack".tr,
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
            Obx(() {
              return _controller.listResponse.value.paginationDto == null
                  ? const SizedBox(width: 0, height: 0)
                  : totalProjectsCommonTitle(
                      title:
                          "Total Projects : ${stringNullCheck(_controller.listResponse.value.paginationDto!.total.toString())}");

              /*textSpanAutoSize(
                      title: "TotalProjects".tr,
                      subTitle: _controller.listResponse.value.paginationDto!.total.toString(),
                      colorTitle: Get.theme.primaryColor);*/
            }),
            const VSpacer10(),
            Expanded(
              child: Obx(() {
                return _controller.listResponse.value.paginationDto == null
                    ? showEmptyView()
                    : _fastTrackItemList(context);
              }),
            ),
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

  Widget _fastTrackItemList(BuildContext context) {
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
                      _controller.getFastTrackList(true);
                    });
                  }
                  // return projectListItemView(
                  // Zabir
                  return projectListItem(
                      context, _controller.allProjectsResponseList[index]);
                },
              ),
            );
    });
  }
}
