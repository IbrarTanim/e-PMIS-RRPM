import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/project/common/projects_list_item.dart';
import 'package:pmis_flutter/ui/features/search/my_project_search/search_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/projects/projects_controller.dart';
import 'package:pmis_flutter/ui/features/root/root_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  _ProjectsScreenState createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final _controller = Get.put(ProjectsController());
  final _rootController = Get.put(RootController());

  bool isLoading = true;

  void initCalls() async {
    //await _controller.getProjectsList(_rootController.userInfo.value.id.toString()); // rokan June



    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    initCalls();

    if (!_controller.isDataLoaded) {
      _controller.getProjectsList(_rootController.userInfo.value.id.toString());
    }
    super.initState();
  }

  /*@override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // _controller.getData();
      _controller.getProjectsList(_rootController.userInfo.value.id.toString());
    });
  }*/





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar:

      /*appBarWithBackAndActions(
          title: "My Assigned projects",
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


          //appBarMain(context, title: "Projects".tr,
          appBarMain(context,  title: "My Assigned projects",
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
      body: SafeArea(
        child: isLoading == true
            ? const Center(
            child: CircularProgressIndicator(color: Colors.green))
            : Column(
          children: [
            const VSpacer10(),
            Obx(() {
              return _controller.projectsListResponse.isEmpty
                  ? const SizedBox(width: 0, height: 0)
                  : totalProjectsCommonTitle(
                      title: "Total Projects : ${stringNullCheck(_controller.projectsListResponse.length.toString())}");

            }),
            const VSpacer10(),
            Expanded(
              child: _projectsItemList(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _projectsItemList(BuildContext context) {
    return Obx(() {
      // String message = "empty_message".tr;
      return /*_controller.projectsListResponse.isEmpty
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          :*/
      SizedBox(
              child: ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: _controller.projectsListResponse.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_controller.hasMoreData && index == (_controller.projectsListResponse.length - 1)) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      _controller.getProjectsList(_rootController.userInfo.value.id.toString());
                      // GetStorage().read(PreferenceKey.currentUserId)  // rokan June
                    });
                  }
                  // return projectItemView(
                  return projectListItem(
                      context, _controller.projectsListResponse[index],
                      isMyProject: true);
                },
              ),
            );
    });
  }
}
