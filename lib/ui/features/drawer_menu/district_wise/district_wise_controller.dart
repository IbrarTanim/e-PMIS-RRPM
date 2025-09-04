import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/district_list_response.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/models/response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

class DistrictWiseController extends GetxController {
  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }

  List<int>? myDistrictWiseItemList =
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17].obs;

  // RxList<ProjectList> searchedItemList = <ProjectList>[].obs;

  List<String> getDistrictWiseList() {
    return [
      "Dhaka",
      "Khulna",
      "Feni",
      "Noakhali",
      "GOpalgonj",
      "Bagerhat",
    ];
  }

  RxList<DistrictListResponse> districtListResponse =
      <DistrictListResponse>[].obs;

  Rx<DistrictListResponse> selectedValueForDistrict =
      DistrictListResponse(baseLocationId: "").obs;
  Rx<ListResponse> listResponse = ListResponse().obs;
  RxList<AllProjectsResponse> allProjectsResponseList =
      <AllProjectsResponse>[].obs;

  RxString selectedValue = "".obs;

  int loadedPage = 0;
  bool hasMoreData = true;

  bool isDataLoaded = false;
  bool isLoading = true;

  void clearView() {
    loadedPage = 0;
    hasMoreData = true;
    allProjectsResponseList.clear();
    selectedValueForDistrict.value = DistrictListResponse(baseLocationId: "");
  }

  /// *** District dropdown List Data ***///
  void getDistrictDropDownList() {
    showLoadingDialog();
    APIRepository().getDistrictDropDownList().then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          List<DistrictListResponse> list = List<DistrictListResponse>.from(
              resp.data!.map((x) => DistrictListResponse.fromJson(x)));
          // districtListResponse.addAll(list);
          districtListResponse.value = list;
          selectedValueForDistrict.value = selectedValueForDistrict.value;
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      districtListResponse.clear();
      showToast(err.toString());
    });
  }

  /// *** District dropdown List Data ***///
  Future<List<DistrictListResponse>> getDistricts(String searchQuery) async {
    List<DistrictListResponse> response = [];
    response = districtListResponse
        .where((element) => element.name!
            .trim()
            .toLowerCase()
            .contains(searchQuery.trim().toLowerCase()))
        .toList();
    return response;
  }

  /// *** District List Data ***///
  void getAllDistrictListFromAllProjects(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      allProjectsResponseList.clear();
      isLoading = false;
    }
    isLoading = true;
    //showLoadingDialog();
    var allItems = allProjectsResponseList.length;
    APIRepository()
        .getProjectsListForDistrict(
            selectedValueForDistrict.value.baseLocationId ?? "", loadedPage)
        .then((resp) {
      isLoading = false;
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
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      isLoading = false;
      allProjectsResponseList.clear();
      showToast(err.toString());
    });
  }

  List<AllProjectsResponse> getSuggestions(String query) {
    List<AllProjectsResponse> matches = [];
    matches.addAll(allProjectsResponseList);
    matches.retainWhere((s) => s.name!.contains(query.toLowerCase()));
    return matches;
  }
}
