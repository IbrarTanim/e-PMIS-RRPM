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
import 'closing3_6months_controller.dart';

class Closing3To6MonthsScreen extends StatefulWidget {
  const Closing3To6MonthsScreen({Key? key}) : super(key: key);

  @override
  _Closing3To6MonthsScreenState createState() =>
      _Closing3To6MonthsScreenState();
}

class _Closing3To6MonthsScreenState extends State<Closing3To6MonthsScreen> {
  final _controller = Get.put(Closing3To6MonthsController());

  DateTime today = DateTime.now();
  String? todayDate;

  // DateTime? todayDate;
  String? todayDateTo90Days;
  String? todayDateTo90To180Days;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getMyProjectClosingIn3To6List(
          false, todayDateTo90Days!, todayDateTo90To180Days!);
    });

    setState(() {
      // todayDate = formatDateToYYYYMMDDString(today.toString());
      todayDate = formatDateToYYYYMMDD(today);
      todayDateTo90Days =
          formatDateToYYYYMMDD(today.add(const Duration(days: 90)));
      todayDateTo90To180Days =
          formatDateToYYYYMMDD(today.add(const Duration(days: 180)));
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

      appBar: appBarWithBackAndActions(title: "Closing3_6months".tr),

      /*appBar: appBarWithBackAndActions(
          title: "Closing3_6months".tr,
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
                      subTitle: _controller
                          .listResponse.value.paginationDto!.total
                          .toString(),
                      colorTitle: Get.theme.primaryColor);*/
            }),
            const VSpacer10(),
            Expanded(
              child: Obx(() {
                return _controller.listResponse.value.paginationDto == null
                    ? showEmptyView()
                    : _myProjectClosingIn3To6ItemList(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _myProjectClosingIn3To6ItemList(BuildContext context) {
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
                      _controller.getMyProjectClosingIn3To6List(
                          true, todayDateTo90Days!, todayDateTo90To180Days!);
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
