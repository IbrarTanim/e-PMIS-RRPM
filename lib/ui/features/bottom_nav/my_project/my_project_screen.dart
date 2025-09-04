import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/project/common/projects_list_item.dart';
import 'package:pmis_flutter/ui/legacy/1unused/all_my_projects/all_my_projects_screen.dart';
import 'package:pmis_flutter/ui/features/project/project_details_bottom_bar.dart';
import 'package:pmis_flutter/ui/features/search/my_project_search/search_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import 'my_project_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyProjectScreen extends StatefulWidget {
  const MyProjectScreen({Key? key}) : super(key: key);

  @override
  _MyProjectScreenState createState() => _MyProjectScreenState();
}

class _MyProjectScreenState extends State<MyProjectScreen> {
  final _controller = Get.put(MyProjectController());

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // _controller.clearView();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _controller.clearView();
      // _controller.clearView();
      _controller.getMyProjectList(false);
      _controller.getMyProjectListForLength();

      setState(() {
        isLoading = false;
      });
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
      appBar:

      //appBarMain(context, title: "Projects".tr, actionIcons: [
      appBarMain(context, title:
           GetStorage().read(PreferenceKey.TagComeFrom) == TotalMyAssignedProjects.toString() ? "My Assigned Projects"
          :GetStorage().read(PreferenceKey.TagComeFrom) == TotalOngoingDevelopmentProjects.toString() ? "Development Projects"
          : GetStorage().read(PreferenceKey.TagComeFrom) == TotalOngoingTAProjects.toString() ? "Technical Assistance Projects"
          : GetStorage().read(PreferenceKey.TagComeFrom) == TotalFeasibilityStudyProjects.toString() ? "Feasibility Study Projects"
          : "Projects",

          actionIcons: [
        AssetConstants.icSearch,
        // AssetConstants.icFavoriteFilled
      ],

          onPress: (index) {
            if (index == 0) {
              //Get.to(() => const AllProjectSearchScreen());
              Get.to(() => const MyProjectsSearchScreen());
            } else {
              // Get.to(() => const WatchListScreen());
            }
          }),


      /*appBarWithBackAndActions(
          title: "My_projects".tr,
          actionIcons: [
            AssetConstants.icSearch,
          ],

       onPress: (index) {
        if (index == 0) {
          Get.to(() => const MyProjectsSearchScreen());
        } else {
          //   Get.to(() => const WatchListScreen());
        }
      }),*/


      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(color: Colors.green))
            : Column(
                children: [
                  Obx(() {
                    return _controller.allProjectsResponseListForLength.isEmpty
                        ? const SizedBox(width: 0, height: 0)
                        : listTitle(
                            //title: "My_projects".tr,
                            title:
                                "Total Projects : ${stringNullCheck(_controller.allProjectsResponseListForLength.length.toString())}",
                            //buttonTitle: "See_All".tr,
                            buttonTitle: "",
                            /*action: () {
                              Get.to(() => const AllMyProjectsScreen());
                            }*/
                          );
                  }),

                  const VSpacer10(),
                  Obx(() {
                    // String message = "empty_message".tr;
                    //return _controller.allProjectsResponseList.isEmpty
                    return _controller.allProjectsResponseListUpdated.isEmpty &&
                            _controller.allProjectsResponseListForLength.isEmpty
                        // ? handleEmptyViewWithLoading(_controller.isDataLoaded, message: message)
                        ? handleEmptyViewWithLoading(_controller.isDataLoaded)
                        : Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              //itemCount: _controller.allProjectsResponseList.length,
                              itemCount: _controller
                                  .allProjectsResponseListUpdated.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (_controller.hasMoreData &&
                                    //index == (_controller.allProjectsResponseList.length - 1)) {
                                    index == (_controller.allProjectsResponseListUpdated.length - 1)) {
                                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                    _controller.getMyProjectList(true);
                                  });
                                }
                                //return projectListItemViewForMyProject(context, _controller.allProjectsResponseList[index]);
                                // Zabir
                                return projectListItem(
                                    context,
                                    _controller
                                        .allProjectsResponseListUpdated[index],
                                    isMyProject: true);
                              },
                            ),
                          );
                  }),
                  // _myAllProjectItemList(),
                ],
              ),
      ),
    );
  }
}
