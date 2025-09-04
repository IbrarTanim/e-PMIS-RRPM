import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/ministry_list_response.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/agency_wise/agency_wise_controller.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/agency_wise/agency_wise_dropdown.dart';
import 'package:pmis_flutter/ui/features/project/common/projects_list_item.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/agency_wise/agency_wise_screen.dart';
import 'package:pmis_flutter/ui/features/search/my_project_search/search_bar.dart';
import 'package:pmis_flutter/ui/features/root/root_controller.dart';
import 'package:pmis_flutter/ui/features/root/root_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import '../../../../data/models/division_response_data.dart';
import 'search_controller.dart';

class MyProjectsSearchScreen extends StatefulWidget {
  const MyProjectsSearchScreen({Key? key}) : super(key: key);

  @override
  _MyProjectsSearchScreenState createState() => _MyProjectsSearchScreenState();
}

class _MyProjectsSearchScreenState extends State<MyProjectsSearchScreen> {
  final _controller = Get.put(MyProjectsSearchController());
  final _controllerAgencyWise = Get.put(AgencyWiseController());


  @override
  void initState() {
    super.initState();
    _controller.selectedValue.value = "";
    _controller.searchController.text.trim() == "";
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.clearView();
      _controllerAgencyWise.clearView();

      _controllerAgencyWise.selectedValueForMinistry.value = MinistryListResponse(value: "");
      // change Rokan -->
      _controllerAgencyWise.selectedValueForDivision.value = ValueObject(value: "");
      _controllerAgencyWise.selectedValueForAgency.value = ValueObject(value: "");
      _controllerAgencyWise.divisionListResponse.clear();
      _controllerAgencyWise.agencyListResponse.clear();

      _controllerAgencyWise.getMinistryDropDownList();

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
      // appBar: appBarWithBack(title: "MyProjectsSearch".tr),
      appBar: appBarWithBackAndActions(title: "MyProjectsSearch".tr),
      body: SafeArea(
        child: Column(
          children: [
            getTabView(
              titles: ["Name_wise".tr, "Code_wise".tr, "Agency_wise".tr],
              //titles: ["Name_wise".tr, "Code_wise".tr],
              controller: _controller.tabController,
              onTap: (selected) {
                _controller.searchController.clear();
                _controller.clearView();
                _controller.tabSelectedIndex.value = selected;
                _controllerAgencyWise.clearView();
                _controllerAgencyWise.divisionListResponse.clear();
                _controllerAgencyWise.agencyListResponse.clear();

                /*if (selected == 2) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    DefaultValue.selectedBottomIndex = 1;
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) {
                      return AgencyWiseScreen();
                      //return RootScreen();
                    }), (route) => false);
                  });
                } else {
                  _controller.searchController.clear();
                  _controller.clearView();
                  _controller.tabSelectedIndex.value = selected;
                }*/
              },
            ),
            Expanded(
              child: TabBarView(
                  controller: _controller.tabController,
                  children: [
                    _searchByName(),
                    _searchByCode(),
                    _searchByAgency(),
                    //const SizedBox()
                  ]),
            ),
          ],
        ),

      ),
    );
  }



  Widget _searchByAgency() {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(7),
          child: Obx(() {
            // return dropDownAllProjectForMinistry(
            // Zabir
            return NewDropDownAllProjectForMinistry(
                items: _controllerAgencyWise.ministryListResponse,
                selectedValue: _controllerAgencyWise.selectedValueForMinistry.value,
                hint: "Please_select_a_ministry".tr,
                onChange: (value) {
                  _controllerAgencyWise.selectedValueForMinistry.value = value;
                  _controllerAgencyWise.selectedValueForDivision.value = ValueObject(value: "");
                  _controllerAgencyWise.selectedValueForAgency.value = ValueObject(value: "");
                  // _controller.allProjectsResponseList.clear();

                  //_controller.getAgencyDropDownList();
                  _controllerAgencyWise.getDivisionDropDownList(); //Rokan
                  // _controller.getAllMinistryListFromAllProjects(false);
                  // _controller.getAllMinistryListFromAllProjects();
                },
                extraWidth: 89);
          }),
        ),
        Obx(() {
          return _controllerAgencyWise.divisionListResponse.isEmpty
              ? const SizedBox()
              : Padding(
            padding: const EdgeInsets.all(7),
            // child: dropDownAllProjectForDivision(
            // Zabir
            child: NewDropDownAllProjectForDivision(
                items: _controllerAgencyWise.divisionListResponse,
                selectedValue:
                _controllerAgencyWise.selectedValueForDivision.value,
                hint: "Please_select_a_division".tr,
                onChange: (value) {
                  _controllerAgencyWise.selectedValueForDivision.value = value;
                  _controllerAgencyWise.selectedValueForAgency.value =
                      ValueObject(value: "");

                  _controllerAgencyWise.getAgencyDropDownList();
                  // _controller.getAllMinistryListFromAllProjects(false);
                  // _controller.getAllMinistryListFromAllProjects();
                },
                extraWidth: 89),
          );
        }),
        Obx(() {
          //return _controller.selectedValueForMinistry.value.value!.isEmpty || _controller.agencyListResponse.isEmpty
          return _controllerAgencyWise.agencyListResponse.isEmpty
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
                items: _controllerAgencyWise.agencyListResponse,
                selectedValue:
                _controllerAgencyWise.selectedValueForAgency.value,
                hint: "Please_select_a_agency".tr,
                onChange: (value) {
                  _controllerAgencyWise.selectedValueForAgency.value = value;
                  _controllerAgencyWise.getAllAgencyListFromMyProjects(false);
                  // _controller.getAllMinistryListFromAllProjects();
                },
                extraWidth: 89),
          );
        }),
        // const VSpacer10(),
        Obx(() {
          return _controllerAgencyWise.allProjectsResponseList.isEmpty
              ? showEmptyView()
              : totalProjectsCommonTitle(
              title:
              "Total Projects : ${stringNullCheck(_controllerAgencyWise.listResponse.value.paginationDto!.total.toString())}");

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
            return _controllerAgencyWise.listResponse.value.paginationDto == null &&
                _controllerAgencyWise.agencyListResponse.isEmpty &&
                _controllerAgencyWise.selectedValueForAgency.value.value!.isEmpty
                ? const SizedBox()
                : _controllerAgencyWise.selectedValueForAgency.value.value!.isEmpty ||
                _controllerAgencyWise.selectedValueForMinistry.value.value!.isEmpty
                ? const SizedBox()
                : _agencyWiseItemList(context);
          }),
        ),
      ],
    );
  }


  Widget _searchByName() {
    return Column(
      children: [
        // Zabir
        SearchBarWithRefresh(
          controller: _controller.searchController,
          hintText: "Enter Project Name".tr,
          onSearch: () => _controller.getSearchDataByName(true),
          onRefresh: () {
            _controller.searchController.clear();
            _controller.clearView();
          },
        ),
        Obx(() {
          return _controller.allProjectsResponseList.isEmpty
              ? const SizedBox(width: 0, height: 0)
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: totalProjectsCommonTitle(
                      title:
                          "Total Projects : ${stringNullCheck(_controller.listResponse.value.paginationDto!.total.toString())}"),

                );
        }),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _controller.getData,
            child: Obx(() {
              return _controller.listResponse.value.paginationDto == null
                  ? showEmptyView()
                  : _searchedItemListByName(context);
            }),
          ),
        ),
      ],
    );
  }

  Widget _searchByCode() {
    return Column(
      children: [
        // Zabir
        SearchBarWithRefresh(
          controller: _controller.searchController,
          hintText: "Enter Project Code".tr,
          onSearch: () => _controller.getSearchDataByCode(true),
          onRefresh: () {
            _controller.searchController.clear();
            _controller.clearView();
          },
        ),
        Obx(() {
          return _controller.allProjectsResponseList.isEmpty
              ? const SizedBox(width: 0, height: 0)
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: totalProjectsCommonTitle(
                      title:
                          "Total Projects : ${stringNullCheck(_controller.listResponse.value.paginationDto!.total.toString())}"),

                  /*textSpanAutoSize(
                      title: "TotalProjects".tr,
                      subTitle: _controller
                          .listResponse.value.paginationDto!.total
                          .toString(),
                      colorTitle: Get.theme.primaryColor),*/
                );
        }),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _controller.getData,
            child: Obx(() {
              return _controller.listResponse.value.paginationDto == null
                  ? showEmptyView()
                  : _searchedItemListByCode(context);
            }),
          ),
        ),
      ],
    );
  }


  Widget _searchedItemListByName(BuildContext context) {
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
                      _controller.getSearchDataByName(true);
                    });
                  }
                  // return projectListItemViewForMyProject(
                  return projectListItem(
                      context, _controller.allProjectsResponseList[index]);
                },
              ),
            );
    });
  }

  Widget _searchedItemListByCode(BuildContext context) {
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
                      _controller.getSearchDataByCode(true);
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

  Widget _agencyWiseItemList(BuildContext context) {
    return Obx(() {
      // String message = "empty_message".tr;
      return _controllerAgencyWise.allProjectsResponseList.isEmpty
          ? handleEmptyViewWithLoading(_controllerAgencyWise.isDataLoaded)
          : SizedBox(
        // height: getContentHeight() + kToolbarHeight - dp145,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: _controllerAgencyWise.allProjectsResponseList.length,
          itemBuilder: (BuildContext context, int index) {
            if (_controllerAgencyWise.hasMoreData &&
                index ==
                    (_controllerAgencyWise.allProjectsResponseList.length - 1)) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                _controllerAgencyWise.getAllAgencyListFromMyProjects(true);
              });
            }
            // return projectListItemViewForMyProject(
            // Zabir
            return projectListItem(
                context, _controllerAgencyWise.allProjectsResponseList[index],
                isMyProject: true);
          },
        ),
      );
    });
  }



}
