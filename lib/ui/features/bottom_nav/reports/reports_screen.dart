import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/reports/already_completed/already_completed_screen.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/reports/closing_3_6_months/closing3_6months_screen.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/reports/reports_item_view.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/reports/slow_progress_projects/slow_progress_projects_screen.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/reports/slow_projects_50_done/slow_projects_50_done_screen.dart';
import 'package:pmis_flutter/ui/features/search/my_project_search/search_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import '../../../../utils/spacers.dart';
import '3_months_not_visited/3_months_not_visited_screen.dart';
import 'reports_controller.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  _ReportsScreenState createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final _controller = Get.put(ReportsController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _controller.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.theme.colorScheme.surface,
      backgroundColor: bgColor,
      // appBar: appBarMain(context, title: "Ministry_wise".tr),
      /*appBar: appBarMain(context, title: "Reports".tr, actionIcons: [
        */ /*AssetConstants.icSearch,*/ /* //Rokan
        // AssetConstants.icFavoriteFilled
        ],
            */ /*onPress: (index) { //rokan
      if (index == 0) {
        Get.to(() => const MyProjectsSearchScreen());
      } else {
        // Get.to(() => const WatchListScreen());
      }
    }*/ /*
    ),*/

      appBar: appBarMain(context, title: "Reports".tr, actionIcons: [
        AssetConstants.icSearch,
        // AssetConstants.icFavoriteFilled
      ], onPress: (index) {
        if (index == 0) {
          Get.to(() => const MyProjectsSearchScreen());
        } else {
          // Get.to(() => const WatchListScreen());
        }
      }
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
          // Zabir
          children: [
            VSpacer5(),
            ReportsItemView(
              title: 'SlowProgressProjects'.tr,
              onTap: () => Get.to(() => const SlowProgressProjectsScreen()),
              icon: Icons.speed_rounded,
              iconColor: Colors.orange,
            ),
            ReportsItemView(
              title: 'Closing3_6months'.tr,
              onTap: () => Get.to(() => const Closing3To6MonthsScreen()),
              icon: Icons.timer_outlined,
              iconColor: Colors.blue,
            ),
            ReportsItemView(
              title: 'monthsNotVisited'.tr,
              onTap: () => Get.to(() => const Months3NotVisitedScreen()),
              icon: Icons.visibility_off_outlined,
              iconColor: Colors.red,
            ),
            ReportsItemView(
              title: 'slowProjects50Done'.tr,
              onTap: () => Get.to(() => const SlowProjects50DoneScreen()),
              icon: Icons.trending_down_rounded,
              iconColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
