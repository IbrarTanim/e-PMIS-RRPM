import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/agency_list_response.dart';
import 'package:pmis_flutter/data/models/division_response_data.dart';
import 'package:pmis_flutter/data/models/ministry_list_response.dart';
import 'package:pmis_flutter/ui/features/project/common/projects_list_item.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/agency_wise/agency_wise_dropdown.dart';
import 'package:pmis_flutter/ui/features/search/all_projects_search/all_projects_search_screen.dart';
import 'package:pmis_flutter/ui/features/search/my_project_search/search_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/pd_directory/pd_details/pd_details_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/pd_directory/pd_directory_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';

class PdDirectoryScreen extends StatefulWidget {
  const PdDirectoryScreen({Key? key}) : super(key: key);

  @override
  _PdDirectoryScreenState createState() => _PdDirectoryScreenState();
}

class _PdDirectoryScreenState extends State<PdDirectoryScreen> {
  final _controller = Get.put(PdDirectoryController());

  @override
  void initState() {
    super.initState();
    // _controller.selectedValueForMinistry.value = -1;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.selectedValueForMinistry.value =
          MinistryListResponse(value: "");
      _controller.selectedValueForAgency.value = ValueObject(value: "");

      _controller.clearView();
      _controller.getMinistryDropDownList();
      // _controller.getAgencyDropDownList();
      // _controller.getAllMinistryListFromAllProjects(false);
      // _controller.getAllMinistryListFromAllProjects();
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
      // appBar: appBarMain(context, title: "Agency_wise".tr),
      appBar: appBarWithBackAndActions(
        title: "PD_directory".tr,
        // actionIcons: [
        //   AssetConstants.icSearch,
        //   // AssetConstants.icFavoriteFilled
        // ],
        // onPress: (index) {
        //   if (index == 0) {
        //     Get.to(() => const MyProjectsSearchScreen());
        //   } else {
        //     // Get.to(() => const WatchListScreen());
        //   }
        // }
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Obx(() {
                // return dropDownAllProjectForMinistry(
                return NewDropDownAllProjectForMinistry(
                    items: _controller.ministryListResponse,
                    selectedValue: _controller.selectedValueForMinistry.value,
                    hint: "Please_select_a_ministry".tr,
                    onChange: (value) {
                      _controller.selectedValueForMinistry.value = value;
                      _controller.selectedValueForDivision.value =
                          ValueObject(value: "");
                      _controller.selectedValueForAgency.value =
                          ValueObject(value: "");
                      _controller.allProjectsResponseList.clear();

                      //_controller.getAgencyDropDownList();
                      _controller.getDivisionDropDownList(); //Rokan
                      // _controller.getAllMinistryListFromAllProjects(false);
                      // _controller.getAllMinistryListFromAllProjects();
                    },
                    extraWidth: 89);
              }),
            ),
            Obx(() {
              return _controller.divisionListResponse.isEmpty
                  ? const SizedBox()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      // child: dropDownAllProjectForDivision(
                      child: NewDropDownAllProjectForDivision(
                          items: _controller.divisionListResponse,
                          selectedValue:
                              _controller.selectedValueForDivision.value,
                          hint: "Please_select_a_division".tr,
                          onChange: (value) {
                            _controller.selectedValueForDivision.value = value;
                            _controller.selectedValueForAgency.value =
                                ValueObject(value: "");

                            _controller.getAgencyDropDownList();
                            // _controller.getAllMinistryListFromAllProjects(false);
                            // _controller.getAllMinistryListFromAllProjects();
                          },
                          extraWidth: 89),
                    );
            }),
            Obx(() {
              //return _controller.selectedValueForMinistry.value.value!.isEmpty || _controller.agencyListResponse.isEmpty
              return _controller.agencyListResponse.isEmpty
                  ? const SizedBox()
                  :
                  /*_controller.selectedValueForMinistry.value.value!.isEmpty || _controller.selectedValueForDivision.value.value!.isEmpty || _controller.agencyListResponse.isEmpty //rokan
                  ? const SizedBox(width: 0, height: 0)
                  : */
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      // child: dropDownAllProjectForAgency(
                      child: NewDropDownAllProjectForAgency(
                          items: _controller.agencyListResponse,
                          selectedValue:
                              _controller.selectedValueForAgency.value,
                          hint: "Please_select_a_agency".tr,
                          onChange: (value) {
                            _controller.selectedValueForAgency.value = value;
                            _controller.getAllAgencyListFromMyProjects(false);
                            // _controller.getAllMinistryListFromAllProjects();
                          },
                          extraWidth: 89),
                    );
            }),
            const VSpacer10(),
            Obx(() {
              return _controller.allProjectsResponseList.isEmpty
                  ? showEmptyView()
                  : textSpanAutoSize(
                      title: "TotalProjects".tr,
                      subTitle:
                          _controller.allProjectsResponseList.length.toString(),
                      /*_controller.listResponse.value.paginationDto!.total
                              //.allProjectsResponseList.length
                              .toString(),*/
                      colorTitle: Get.theme.primaryColor);
            }),
            const VSpacer10(),
            Expanded(
              child: Obx(() {
                return _controller.listResponse.value.paginationDto == null &&
                        _controller.agencyListResponse.isEmpty &&
                        _controller.selectedValueForAgency.value.value!.isEmpty
                    ? const SizedBox()
                    : _controller.selectedValueForAgency.value.value!.isEmpty ||
                            _controller
                                .selectedValueForMinistry.value.value!.isEmpty
                        ? const SizedBox()
                        : _agencyWiseItemList(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _agencyWiseItemList(BuildContext context) {
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
                      _controller.getAllAgencyListFromMyProjects(true);
                    });
                  }
                  return projectListItem(
                      context, _controller.allProjectsResponseList[index],
                      customRoute: () => PdDetailsScreen(
                          allProjectsResponse:
                              _controller.allProjectsResponseList[index]));
                },
              ),
            );
    });
  }

// Widget _agencyWiseItemList() {
//   return Obx(() {
//     String message = "empty_message".tr;
//     return _controller.agencyWiseItemList!.isEmpty
//         ? handleEmptyViewWithLoading(_controller.isDataLoaded,
//             message: message)
//         : SizedBox(
//             // height: getContentHeight() + kToolbarHeight - dp145,
//             child: ListView.builder(
//               padding: EdgeInsets.zero,
//               scrollDirection: Axis.vertical,
//               itemCount: _controller.agencyWiseItemList!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 // return demoListItemView(_controller.searchedItemList![index]);
//                 return demoListItemView();
//               },
//             ),
//           );
//   });
// }
}
