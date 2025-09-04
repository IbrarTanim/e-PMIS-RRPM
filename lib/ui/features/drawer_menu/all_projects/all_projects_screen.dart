import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/project/common/projects_list_item.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/agency_wise/agency_wise_controller.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/agency_wise/agency_wise_screen.dart';
import 'package:pmis_flutter/ui/legacy/1old/basic_project_details_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import 'all_projects_agency_wise/all_projects_agency_wise_screen.dart';
import '../../search/all_projects_search/all_projects_search_screen.dart';
import 'all_projects_controller.dart';

class AllProjectsScreen extends StatefulWidget {
  const AllProjectsScreen({Key? key}) : super(key: key);

  @override
  _AllProjectsScreenState createState() => _AllProjectsScreenState();
}

class _AllProjectsScreenState extends State<AllProjectsScreen> {
  final _controller = Get.put(AllProjectsController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _controller.getData();
      _controller.getAllProjectsList(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.theme.colorScheme.surface,
      backgroundColor: bgColor,
      appBar: appBarWithBackAndActions(
          title: "AllProjects".tr,
          actionIcons: [
            AssetConstants.icSearch,
            // AssetConstants.icFavoriteFilled
          ],
          onPress: (index) {
            if (index == 0) {
              //Get.to(() => const AllProjectSearchScreen());
              Get.to(() => const AllProjectsAgencyWiseScreen());
            } else {
              // Get.to(() => const WatchListScreen());
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
                          "Total Projects : ${stringNullCheck(_controller.listResponse.value.paginationDto!.total.toString())}");
            }),
            const VSpacer10(),
            Expanded(
              child: Obx(() {
                return _controller.listResponse.value.paginationDto == null
                    ? showEmptyView()
                    : _allProjectsItemList(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _allProjectsItemList(BuildContext context) {
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
                  if (_controller.hasMoreData &&
                      index ==
                          (_controller.allProjectsResponseList.length - 1)) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      _controller.getAllProjectsList(true);
                    });
                  }
                  // return projectListItemView(
                  // Zabir
                  return projectListItem(
                    context,
                    _controller.allProjectsResponseList[index],
                  );
                },
              ),
            );
    });
  }
}
