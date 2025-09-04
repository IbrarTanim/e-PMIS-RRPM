import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

class AllProjectsSearchController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController searchController = TextEditingController();
  List<int>? searchedItemList =
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17].obs;
  List<int>? searchedTypeItemList =
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17].obs;

  // RxList<ProjectList> searchedItemList = <ProjectList>[].obs;

  TabController? tabController;
  final tabSelectedIndex = 0.obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 3);
    super.onInit();
  }

  Rx<ListResponse> listResponse = ListResponse().obs;
  RxList<AllProjectsResponse> allProjectsResponseList =
      <AllProjectsResponse>[].obs;

  int loadedPage = 0;
  bool hasMoreData = true;

  bool isDataLoaded = false;
  bool isLoading = true;

  List<String> getSearchTypeList() {
    return [
      "Search by name",
      "Search by code",
      "Search by agency",

      /*"By name",
      "By code",
      "By agency",*/
    ];
  }

  RxString selectedValue = "".obs;

  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }

  void clearView() {
    loadedPage = 0;
    hasMoreData = true;
    // searchedItemList!.clear();
    allProjectsResponseList.clear();
    selectedValue.value == "";
  }


  void getSearchDataByName(bool isFromLoadMore) {
    var nameValue = searchController.text.trim();
    if (nameValue.isEmpty || searchController.text.trim().isEmpty) {
      showToast("Search key can't be empty".tr, isError: true);
      return;
    }

    showLoadingDialog();
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      allProjectsResponseList.clear();
      isLoading = false;
    }
    isLoading = true;
    var allItems = allProjectsResponseList.length;

    debugPrint("Rokan Name Value : $nameValue" );
    APIRepository()
        .getProjectsListForAllProjectsSearchByName(nameValue, loadedPage).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        listResponse.value = ListResponse.fromJson(resp.data);
        var response = listResponse.value;
        if (response.lists != null && response.lists!.isNotEmpty) {
          List<AllProjectsResponse> list = List<AllProjectsResponse>.from(
              response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
          allProjectsResponseList.addAll(list);
          listResponse.value.paginationDto = listResponse.value.paginationDto;
        }
        loadedPage = response.paginationDto!.current ?? 0;
        hasMoreData = (allItems != response.paginationDto!.total);
      } else {
        showToast(resp.message);
      }
    }, onError: (err) {
          //Rokan Hide 23.02.2025
      /*hideLoadingDialog();
      isLoading = false;
      allProjectsResponseList.clear();
      showToast(err.toString());*/
    });
  }

  void getSearchDataByCode(bool isFromLoadMore) {
    var codeValue = searchController.text.trim();

    if (codeValue.isEmpty || searchController.text.trim().isEmpty) {
      showToast("Search key can't be empty".tr, isError: true);
      return;
    }

    showLoadingDialog();
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      allProjectsResponseList.clear();
      isLoading = false;
    }
    isLoading = true;
    var allItems = allProjectsResponseList.length;

    debugPrint("Rokan Name Value : $codeValue" );
    APIRepository()
        .getProjectsListForAllProjectsSearchByCode(codeValue, loadedPage).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        listResponse.value = ListResponse.fromJson(resp.data);
        var response = listResponse.value;
        if (response.lists != null && response.lists!.isNotEmpty) {
          List<AllProjectsResponse> list = List<AllProjectsResponse>.from(
              response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
          allProjectsResponseList.addAll(list);
          listResponse.value.paginationDto = listResponse.value.paginationDto;
        }
        loadedPage = response.paginationDto!.current ?? 0;
        hasMoreData = (allItems != response.paginationDto!.total);
      } else {
        showToast(resp.message);
      }
    }, onError: (err) {
      //Rokan Hide 23.02.2025
      /*hideLoadingDialog();
      isLoading = false;
      allProjectsResponseList.clear();
      showToast(err.toString());*/
    });
  }

  /*void getSearchData(bool isFromLoadMore) {
    //bool isCode = true;
    int searchType = 0;
    // var searchKey = searchController!.text.trim();
    String searchKey;
    var nameValue = searchController.text.trim();
    var codeValue = searchController.text.trim();
    var agencyValue = searchController.text.trim();
    // String codeValue;
    // if (searchKey.isEmpty) {
    if (nameValue.isEmpty ||
        codeValue.isEmpty ||
        agencyValue.isEmpty ||
        searchController.text.trim().isEmpty) {
      showToast("Search key can't be empty".tr, isError: true);
      return;
    }
    if (selectedValue.value.isEmpty) {
      showToast("Please_select_search_type".tr, isError: true);
      return;
    }
    // if (!isFromLoadMore) {
    //   clearView();
    // }
    showLoadingDialog();
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      allProjectsResponseList.clear();
      isLoading = false;
    }
    isLoading = true;
    var allItems = allProjectsResponseList.length;
    // selectedValue.value == "Search by name" ? isCode = false : isCode = true;
    // if(selectedValue.value == "Search by name"){
    //   searchKey = nameValue;
    //   isCode = false;
    // }    if(selectedValue.value == "Search by code"){
    //   searchKey = codeValue;
    //   isCode = true;
    // }

    //selectedValue.value == "Search by name" ? searchKey = nameValue :  searchKey = codeValue;
    selectedValue.value == "Search by name"
        ? searchKey = nameValue
        : selectedValue.value == "Search by code"
        ? searchKey = codeValue
        : searchKey = agencyValue;

    selectedValue.value == "Search by name" ? searchType = 0 : selectedValue.value == "Search by code" ? searchType = 1 : searchType = 2;

    APIRepository()
        .getProjectsListForAllProjectsSearch(searchKey, loadedPage, searchType)
        .then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        // loadedPage++;
        // ListResponse response = ListResponse.fromJson(resp.data);
        listResponse.value = ListResponse.fromJson(resp.data);
        var response = listResponse.value;
        if (response.lists != null && response.lists!.isNotEmpty) {
          List<AllProjectsResponse> list = List<AllProjectsResponse>.from(
              response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
          allProjectsResponseList.addAll(list);
          listResponse.value.paginationDto = listResponse.value.paginationDto;
        }
        loadedPage = response.paginationDto!.current ?? 0;
        hasMoreData = (allItems != response.paginationDto!.total);
      } else {
        showToast(resp.message);
      }
    }, onError: (err) {
    //Rokan Hide 23.02.2025
      hideLoadingDialog();
      isLoading = false;
      allProjectsResponseList.clear();
      showToast(err.toString());
    });
  }*/

// void getSearchData(bool isFromLoadMore) {
//   var searchKey = searchController!.text.trim();
//   if (searchKey.isEmpty) {
//     showToast("Search key can't be empty".tr, isError: true);
//     return;
//   }
//   if (!isFromLoadMore) {
//     clearView();
//   }
//   showLoadingDialog();
//   APIRepository().getSearchedItems(loadedPage + 1, searchKey).then((resp) {
//     hideLoadingDialog();
//     if (resp.success) {
//       ListResponse listResponse = ListResponse.fromJson(resp.data);
//       if (listResponse != null) {
//         loadedPage = listResponse.auctionLists.currentPage;
//         searchedItemList.addAll(listResponse.auctionLists.data);
//         hasMoreData = listResponse.auctionLists.nextPageUrl != null;
//         hasSearchList.value = true;
//       }
//       saveSearchKey(searchKey);
//     } else {
//       showToast(resp.message);
//     }
//   }, onError: (err) {
//     hideLoadingDialog();
//     showToast(err.toString());
//   });
// }
}
