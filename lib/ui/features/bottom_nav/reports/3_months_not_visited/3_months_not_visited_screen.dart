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
import '../../../../../utils/date_util.dart';
import '3_months_not_visited_controller.dart';

class Months3NotVisitedScreen extends StatefulWidget {
  const Months3NotVisitedScreen({Key? key}) : super(key: key);

  @override
  _Months3NotVisitedScreenState createState() =>
      _Months3NotVisitedScreenState();
}

class _Months3NotVisitedScreenState extends State<Months3NotVisitedScreen> {
  final _controller = Get.put(Months3NotVisitedController());

  DateTime today = DateTime.now();
  String? todayDate;
  String? todayDateToBefore90Days;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getMyProjectNotVisited3MonthsByIMEDList(
          false, todayDateToBefore90Days!);
    });

    setState(() {
      todayDate = formatDateToYYYYMMDD(today);
      todayDateToBefore90Days =
          formatDateToYYYYMMDD(today.subtract(const Duration(days: 90)));
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

      appBar: appBarWithBackAndActions(title: "monthsNotVisited".tr),

      /*appBar: appBarWithBackAndActions(
          title: "monthsNotVisited".tr,
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
          }),*/

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
                    : _myProjectNotVisited3MonthsByIMEDItemList(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _myProjectNotVisited3MonthsByIMEDItemList(BuildContext context) {
    return Obx(() {
      // String message = "empty_message".tr;
      return _controller.allProjectsResponseList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : SizedBox(
              // height: Get.height - (kToolbarHeight+kToolbarHeight),
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
                      _controller.getMyProjectNotVisited3MonthsByIMEDList(
                          true, todayDateToBefore90Days!);
                    });
                  }
                  // return projectListItemViewForMyProject(
                  return projectListItem(
                    context,
                    _controller.allProjectsResponseList[index],
                    isMyProject: true,
                  );
                },
              ),
            );
    });
  }
}
