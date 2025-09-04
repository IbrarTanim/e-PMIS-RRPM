import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/ministry_list_response.dart';
import 'package:pmis_flutter/ui/features/search/my_project_search/search_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import 'ministry_wise_controller.dart';

class MinistryWiseScreen extends StatefulWidget {
  const MinistryWiseScreen({Key? key}) : super(key: key);

  @override
  _MinistryWiseScreenState createState() => _MinistryWiseScreenState();
}

class _MinistryWiseScreenState extends State<MinistryWiseScreen> {
  final MinistryWiseController _controller = Get.put(MinistryWiseController());

  // final _controllerMyProject = Get.put(MyProjectController());

  @override
  void initState() {
    super.initState();
    // _controller.selectedValueForMinistry.value = -1;
    _controller.selectedValueForMinistry.value =
        MinistryListResponse(value: "");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.clearView();
      _controller.getMinistryDropDownList();
      // _controllerMyProject.getMyProjectList(false);
    });
  }

  @override
  void dispose() {
    // _controller.clearView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      // appBar: appBarMain(context, title: "Ministry_wise".tr),
      appBar: appBarMain(context, title: "Ministry_wise".tr, actionIcons: [
        AssetConstants.icSearch,
        // AssetConstants.icFavoriteFilled
      ], onPress: (index) {
        if (index == 0) {
          Get.to(() => const MyProjectsSearchScreen());
        } else {
          // Get.to(() => const WatchListScreen());
        }
      }),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                // final list = _controller.ministryListResponse.map((e) {
                //   return (stringNullCheck(e.text));
                // }).toList();
                return dropDownAllProjectForMinistry(
                    items: _controller.ministryListResponse,
                    selectedValue: _controller.selectedValueForMinistry.value,
                    hint: "Please_select_a_ministry".tr,
                    onChange: (value) {
                      _controller.selectedValueForMinistry.value = value;
                      _controller.getAllMinistryListFromAllProjects(false);
                      // _controller.getAllMinistryListFromAllProjects();
                    },
                    extraWidth: 89);
                // return dropDownListIndex(
                //     // items: list,
                //     items: _controller.getMinistryNames(),
                //     selectedValue: _controller.selectedValueForMinistry.value,
                //     hint: "Please_select_a_ministry".tr,
                //     onChange: (value) {
                //       _controller.selectedValueForMinistry.value = value;
                //       _controller.getAllMinistryListFromAllProjects(false);
                //       // _controller.getAllMinistryListFromAllProjects();
                //     },
                //     extraWidth: 89);
              }),
            ),
            Obx(() {
              return _controller.listResponse.value.paginationDto == null
                  ? const SizedBox(width: 0, height: 0)
                  : _controller.selectedValueForMinistry.value.value!.isEmpty
                      ? const SizedBox(width: 0, height: 0)
                      : totalProjectsCommonTitle(title: "Total Projects : ${stringNullCheck(_controller.listResponse.value.paginationDto!.total.toString())}");


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
                    : _ministryWiseItemList(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ministryWiseItemList(BuildContext context) {
    return Obx(() {
      // String message = "empty_message".tr;
      return _controller.allProjectsResponseList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : SizedBox(
              // height: getContentHeight() + kToolbarHeight - dp145,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: _controller.allProjectsResponseList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_controller.hasMoreData &&
                      index ==
                          (_controller.allProjectsResponseList.length - 1)) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      _controller.getAllMinistryListFromAllProjects(true);
                    });
                  }
                  return projectListItemView(context,
                      _controller.allProjectsResponseList[index]);
                },
              ),
            );
    });
  }
}
