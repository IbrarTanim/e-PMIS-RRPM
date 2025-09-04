import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/ui/features/project/common/projects_list_item.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/agency_wise/agency_wise_screen.dart';
import 'package:pmis_flutter/ui/features/root/root_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';

import 'all_projects_search_controller.dart';

class AllProjectSearchScreen extends StatefulWidget {
  const AllProjectSearchScreen({Key? key}) : super(key: key);

  @override
  _AllProjectSearchScreenState createState() => _AllProjectSearchScreenState();
}

class _AllProjectSearchScreenState extends State<AllProjectSearchScreen> {
  final _controller = Get.put(AllProjectsSearchController());

  @override
  void initState() {
    super.initState();
    _controller.selectedValue.value = "";
    _controller.searchController.text.trim() == "";
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.clearView();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: context.theme.backgroundColor,
      backgroundColor: context.theme.colorScheme.surface,
      appBar: appBarWithBack(title: "AllProjectsSearch".tr),
      body: SafeArea(
        child: Column(
          children: [
            getTabView(
              titles: ["Name_wise".tr, "Code_wise".tr, "Agency_wise".tr],
              //titles: ["Name_wise".tr, "Code_wise".tr],
              controller: _controller.tabController,
              onTap: (selected) {
                /*_controller.searchController.clear();
                _controller.clearView();
                _controller.tabSelectedIndex.value = selected;*/

                if (selected == 2) {
                  //Get.put(RootController()).selectedIndex.value = 1;
                  //Get.to(() => const AgencyWiseScreen());
                  Get.back();
                } else {
                  _controller.searchController.clear();
                  _controller.clearView();
                  _controller.tabSelectedIndex.value = selected;
                }
              },
            ),
            Expanded(
              child: TabBarView(
                  controller: _controller.tabController,
                  children: [
                    _searchByName(),
                    _searchByCode(),
                    const SizedBox()
                  ]),
            ),
          ],
        ),

        /*child: Column(
          children: [
            Container(
              // color: Get.theme.primaryColorDark,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              decoration: boxDecorationRoundBorderBottom(
                  bgColor: Get.theme.backgroundColor),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Obx(() {
                          return dropDownList(
                              items: _controller.getSearchTypeList(),
                              selectedValue: _controller.selectedValue.value,
                              hint: "Please_select_a_search_type".tr,
                              onChange: (value) {
                                _controller.selectedValue.value = value;
                                _controller.getSearchData(false);
                                _controller.searchController.text.trim() == "";
                              },
                              viewWidth: Get.width / 3.5,
                              extraWidth: 29,
                              hPadding: dp5);
                        }),
                      ),
                      const HSpacer10(),
                      Expanded(
                        flex: 8,
                        child: _buildSearchBox(),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                          onPressed: () {
                            _controller.searchController.clear();
                            _controller.selectedValue.value == "Please_select_a_search_type".tr;
                          },
                          icon: const Icon(Icons.refresh,
                              color: Colors.redAccent, size: 30),
                        ),
                      ),
                    ],
                  ),
                  const VSpacer5(),
                ],
              ),
            ),
            const VSpacer20(),
            // textSpanAutoSize(
            //     title: "TotalProjectsFound".tr,
            //     subTitle: "31",
            //     colorTitle: Get.theme.primaryColor),
            Obx(() {
              return _controller.listResponse.value.paginationDto == null
                  ? const SizedBox(width: 0, height: 0)
                  : _controller.selectedValue.value.isEmpty
                  ? const SizedBox(width: 0, height: 0)
                  : textSpanAutoSize(
                  title: "TotalProjects".tr,
                  subTitle: _controller.listResponse.value.paginationDto!.total.toString(),
                  colorTitle: Get.theme.primaryColor);
            }),
            const VSpacer10(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _controller.getData,
                child: Obx(() {
                  return _controller.listResponse.value.paginationDto == null
                      ? showEmptyView()
                      : _searchedItemList(context);
                }),
              ),
            ),
            // Expanded(
            //   child: RefreshIndicator(
            //     onRefresh: _controller.getData,
            //     child: _searchedItemList(),
            //   ),
            // ),
          ],
        ),*/
      ),
    );
  }

  Widget _searchByName() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                  margin:
                      const EdgeInsets.only(left: 16, top: dp10, bottom: dp10),
                  //margin: const EdgeInsets.only(top: 6),
                  height: kToolbarHeight,
                  child: TextField(
                    controller: _controller.searchController,
                    textInputAction: TextInputAction.search,
                    cursorColor: Colors.redAccent,
                    decoration: decorationSearchBox(
                        hint: "Enter Project Name".tr,
                        rightIconAction: () {
                          _controller.getSearchDataByName(true);
                        }),
                    onSubmitted: (value) {
                      _controller.getSearchDataByName(true);
                    },
                  )),
            ),
            IconButton(
              onPressed: () {
                _controller.searchController.clear();
                _controller.clearView();
              },
              icon:
                  const Icon(Icons.refresh, color: Colors.redAccent, size: 30),
            ),
          ],
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
                      subTitle: _controller.listResponse.value.paginationDto!.total.toString(),
                      colorTitle: Get.theme.primaryColor),*/
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
        Row(
          children: [
            Expanded(
              child: Container(
                  margin:
                      const EdgeInsets.only(left: 16, top: dp10, bottom: dp10),
                  //margin: const EdgeInsets.only(top: 6),
                  height: kToolbarHeight,
                  child: TextField(
                    controller: _controller.searchController,
                    textInputAction: TextInputAction.search,
                    cursorColor: Colors.redAccent,
                    decoration: decorationSearchBox(
                        hint: "Enter Project Code".tr,
                        rightIconAction: () {
                          _controller.getSearchDataByCode(true);
                        }),
                    onSubmitted: (value) {
                      _controller.getSearchDataByCode(true);
                    },
                  )),
            ),
            IconButton(
              onPressed: () {
                _controller.searchController.clear();
                _controller.clearView();
              },
              icon:
                  const Icon(Icons.refresh, color: Colors.redAccent, size: 30),
            ),
          ],
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
                      subTitle: _controller.listResponse.value.paginationDto!.total.toString(),
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

  /*Widget _buildSearchBox() {
    return Container(
        // margin: const EdgeInsets.only(left: 16, top: dp10, right: 16, bottom: dp10),
        margin: const EdgeInsets.only(top: 6),
        height: kToolbarHeight,
        child: TextField(
          controller: _controller.searchController,
          textInputAction: TextInputAction.search,
          cursorColor: Colors.redAccent,
          decoration: decorationSearchBox(rightIconAction: () {
            _controller.getSearchData(true);
          }),
          onSubmitted: (value) {
            _controller.getSearchData(true);
          },
        ));
  }*/

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
                  // return projectListItemView(
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
                  // return projectListItemView(
                  return projectListItem(
                      context, _controller.allProjectsResponseList[index]);
                },
              ),
            );
    });
  }

  /*Widget _searchedItemList(BuildContext context) {
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
                      _controller.getSearchData(true);
                    });
                  }
                  return projectListItemView(
                      context, _controller.allProjectsResponseList[index]);
                },
              ),
            );
    });
  }*/

// Widget _searchedItemList() {
//   return Obx(() {
//     String message = "empty_message".tr;
//     return _controller.allProjectsResponseList!.isEmpty
//         ? handleEmptyViewWithLoading(_controller.isDataLoaded,
//             message: message)
//         : SizedBox(
//             // height: getContentHeight()-144,
//             child: ListView.builder(
//               padding: EdgeInsets.zero,
//               scrollDirection: Axis.vertical,
//               itemCount: _controller.allProjectsResponseList!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 // return demoListItemView(_controller.searchedItemList![index]);
//                 return demoListItemView();
//               },
//             ),
//           );
//   });
// }
}
