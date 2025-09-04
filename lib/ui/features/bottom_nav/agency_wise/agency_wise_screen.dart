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
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import 'agency_wise_controller.dart';

class AgencyWiseScreen extends StatefulWidget {
  const AgencyWiseScreen({Key? key}) : super(key: key);

  @override
  _AgencyWiseScreenState createState() => _AgencyWiseScreenState();
}

class _AgencyWiseScreenState extends State<AgencyWiseScreen> {
  final _controller = Get.put(AgencyWiseController());

  @override
  void initState() {
    super.initState();
    // _controller.selectedValueForMinistry.value = -1;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.selectedValueForMinistry.value = MinistryListResponse(value: "");
      // change Rokan -->
      _controller.selectedValueForDivision.value = ValueObject(value: "");
      _controller.selectedValueForAgency.value = ValueObject(value: "");
      _controller.divisionListResponse.clear();
      _controller.agencyListResponse.clear();

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
      /*appBar: appBarMain(context, title: "Agency_wise".tr, actionIcons: [
        AssetConstants.icSearch,
        // AssetConstants.icFavoriteFilled
      ], onPress: (index) {
        if (index == 0) {
          Get.to(() => const MyProjectsSearchScreen());
        } else {
          //   Get.to(() => const WatchListScreen());
        }
      }),*/

      appBar: appBarWithBackAndActions(
          title: "Agency_wise".tr, onPress: (index) {}),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(7),
              child: Obx(() {
                // return dropDownAllProjectForMinistry(
                // Zabir
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
                      // _controller.allProjectsResponseList.clear();

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
                      padding: const EdgeInsets.all(7),
                      // child: dropDownAllProjectForDivision(
                      // Zabir
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
                      padding: const EdgeInsets.all(7),
                      // child: dropDownAllProjectForAgency(
                      // Zabir
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
            // const VSpacer10(),
            Obx(() {
              return _controller.allProjectsResponseList.isEmpty
                  ? showEmptyView()
                  : totalProjectsCommonTitle(
                      title:
                          "Total Projects : ${stringNullCheck(_controller.listResponse.value.paginationDto!.total.toString())}");

              /*textSpanAutoSize(
                      title: "TotalProjects".tr,
                      subTitle:
                          _controller.listResponse.value.paginationDto!.total
                              //.allProjectsResponseList.length
                              .toString(),
                      colorTitle: Get.theme.primaryColor);*/
            }),
            // const VSpacer10(),
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
                  // return projectListItemViewForMyProject(
                  // Zabir
                  return projectListItem(
                      context, _controller.allProjectsResponseList[index],
                      isMyProject: true);
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
