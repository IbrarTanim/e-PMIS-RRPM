import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/district_list_response.dart';
import 'package:pmis_flutter/ui/features/project/common/projects_list_item.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/district_wise/district_wise_typeahead.dart';
import 'package:pmis_flutter/ui/legacy/1old/basic_project_details_screen.dart';
import 'package:pmis_flutter/ui/features/search/my_project_search/search_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import '../../../../utils/dimens.dart';
import '../../search/all_projects_search/all_projects_search_screen.dart';
import 'district_wise_controller.dart';

class DistrictWiseScreen extends StatefulWidget {
  const DistrictWiseScreen({Key? key}) : super(key: key);

  @override
  _DistrictWiseScreenState createState() => _DistrictWiseScreenState();
}

class _DistrictWiseScreenState extends State<DistrictWiseScreen> {
  final DistrictWiseController _controller = Get.put(DistrictWiseController());

  final TextEditingController queryControler = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.selectedValueForDistrict.value =
        DistrictListResponse(baseLocationId: "");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.clearView();
      _controller.getDistrictDropDownList();
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
      // backgroundColor: context.theme.colorScheme.surface,
      backgroundColor: bgColor,
      // appBar: appBarMain(context, title: "District_wise".tr),
      //appBar: appBarMain(context, title: "District_wise".tr,
      // appBar: appBarWithBack(title: "District_wise".tr),
      // Zabir
      appBar: appBarWithBackAndActions(
          title: "District_wise".tr, onPress: (index) {}),

      /* appBar: appBarWithBackAndActions(title: "District_wise".tr,
          actionIcons: [AssetConstants.icSearch,
     // AssetConstants.icFavoriteFilled
      ], onPress: (index) {
        if (index == 0) {
          //Get.to(() => const MyProjectsSearchScreen());
          Get.to(() => const AllProjectSearchScreen());
        } else {
     //   Get.to(() => const WatchListScreen());
        }
      }),*/

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DistrictWiseTypeahead(
                controller: queryControler,
                onSelected: (suggestion) {
                  queryControler.text = suggestion.name ?? "";
                  _controller.selectedValueForDistrict.value = suggestion;
                  _controller.getAllDistrictListFromAllProjects(false);
                },
                onSearch: (query) async {
                  return await _controller.getDistricts(query);
                },
              ),
            ),

            /*Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {


                return dropDownAllProjectForDistrict(
                    items: _controller.districtListResponse,
                    selectedValue: _controller.selectedValueForDistrict.value,
                    hint: "Please_select_a_district".tr,
                    onChange: (value) {
                      _controller.selectedValueForDistrict.value = value;
                      _controller.getAllDistrictListFromAllProjects(false);
                    },
                    extraWidth: 89);
              }),
            ),*/

            // textSpanAutoSize(
            //     title: "TotalProjects".tr,
            //     subTitle: "348",
            //     colorTitle: Get.theme.primaryColor),

            Obx(() {
              return _controller.listResponse.value.paginationDto == null
                  ? const SizedBox(width: 0, height: 0)
                  : _controller.selectedValueForDistrict.value.baseLocationId!
                          .isEmpty
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
                    : _districtWiseItemList(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _districtWiseItemList(BuildContext context) {
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
                      _controller.getAllDistrictListFromAllProjects(true);
                    });
                  }
                  // return projectListItemView(
                  //Zabir
                  return projectListItem(
                    context,
                    _controller.allProjectsResponseList[index],
                  );
                },
              ),
            );
    });
  }

// Widget _myProjectItemList() {
//   return Obx(() {
//     String message = "empty_message".tr;
//     return _controller.myDistrictWiseItemList!.isEmpty
//         ? handleEmptyViewWithLoading(_controller.isDataLoaded,
//             message: message)
//         : SizedBox(
//             // height: getContentHeight() + kToolbarHeight - dp145,
//             child: ListView.builder(
//               padding: EdgeInsets.zero,
//               scrollDirection: Axis.vertical,
//               itemCount: _controller.myDistrictWiseItemList!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 // return demoListItemView(_controller.searchedItemList![index]);
//                 return demoListItemView();
//               },
//             ),
//           );
//   });
// }
}
