import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/project/common/projects_list_item.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/my_project/my_project_controller.dart';
import 'package:pmis_flutter/ui/features/search/my_project_search/search_screen.dart';
import 'package:pmis_flutter/ui/legacy/1unused/all_my_projects/watch_list/watch_list_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/text_util.dart';

import '../../../../utils/spacers.dart';

// TODO: this is unused
class AllMyProjectsScreen extends StatefulWidget {
  const AllMyProjectsScreen({Key? key}) : super(key: key);

  @override
  _AllMyProjectsScreenState createState() => _AllMyProjectsScreenState();
}

class _AllMyProjectsScreenState extends State<AllMyProjectsScreen> {
  // final _controller = Get.put(AllMyProjectsController());
  final _controller = Get.put(MyProjectController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _controller.getData();

      /*_controller.getMyProjectList(false);
      _controller.getMyProjectListForLength();*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      appBar: appBarWithBackAndActions(
          title: "My_all_projects".tr,
          actionIcons: [
            AssetConstants.icSearch,
            // AssetConstants.icFavoriteFilled
          ],
          onPress: (index) {
            if (index == 0) {
              Get.to(() => const MyProjectsSearchScreen());
            } else {
              Get.to(() => const WatchListScreen());
            }
          }),
      body: SafeArea(
        child: Column(
          children: [
            const VSpacer10(),
            Obx(() {
              return _controller.listResponse.value.paginationDto == null
                  ? const SizedBox(width: 0, height: 0)
                  : totalProjectsCommonTitle(
                      title:
                          "Total Projects : ${stringNullCheck(_controller.allProjectsResponseListForLength.length.toString())}");
            }),
            const VSpacer10(),
            Expanded(
              child: Obx(() {
                return _controller.listResponse.value.paginationDto == null
                    ? showEmptyView()
                    : _myAllProjectItemList(context);
              }),
            ),
            // Expanded(
            //   child: RefreshIndicator(
            //     onRefresh: _controller.getData,
            //     child: _myAllProjectItemList(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _myAllProjectItemList(BuildContext context) {
    return Obx(() {
      // String message = "empty_message".tr;
      return _controller.allProjectsResponseListUpdated.isEmpty
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : ListView.builder(
              //physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: _controller.allProjectsResponseListUpdated.length,
              itemBuilder: (BuildContext context, int index) {
                if (_controller.hasMoreData &&
                    index ==
                        (_controller.allProjectsResponseListUpdated.length -
                            1)) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    _controller.getMyProjectList(true);
                  });
                }
                // return projectListItemViewForMyProject(context, _controller.allProjectsResponseListUpdated[index]);
                // Zabir
                return projectListItem(
                    context, _controller.allProjectsResponseListUpdated[index],
                    isMyProject: true);
              },
            );
    });
  }
}
