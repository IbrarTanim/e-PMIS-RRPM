import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/agency_list_response.dart';
import 'package:pmis_flutter/data/models/division_response_data.dart';
import 'package:pmis_flutter/data/models/ministry_list_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

import '../../../../../data/models/all_projects_list_response.dart';
import '../../../../../data/models/list_response.dart';

class AllProjectsAgencyWiseController extends GetxController {
  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }

  List<String> getAgencyWiseList() {
    return [
      "Ministry of Foreign Affairs",
      "Ministry of Education",
      "Ministry of Land",
      "Ministry of Social Welfare",
      "Ministry of Home Affairs",
      "Ministry of Prime Minister's Office",
    ];
  }

  RxList<MinistryListResponse> ministryListResponse =
      <MinistryListResponse>[].obs;

  RxList<ValueObject> divisionListResponse = <ValueObject>[].obs;
  RxList<ValueObject> agencyListResponse = <ValueObject>[].obs;

  Rx<MinistryListResponse> selectedValueForMinistry =
      MinistryListResponse(value: "").obs;

  Rx<ValueObject> selectedValueForDivision = ValueObject(value: "").obs;
  Rx<ValueObject> selectedValueForAgency = ValueObject(value: "").obs;

  Rx<ListResponse> listResponse = ListResponse().obs;
  RxList<AllProjectsResponse> allProjectsResponseList =
      <AllProjectsResponse>[].obs;

  bool isDataLoading = false;
  int loadedPage = 0;
  bool hasMoreData = true;
  bool isDataLoaded = false;
  bool isLoading = true;

  void clearView() {
    loadedPage = 0;
    hasMoreData = true;
    allProjectsResponseList.clear();
    selectedValueForMinistry.value = MinistryListResponse(value: "");
    selectedValueForAgency.value = ValueObject(value: "");
  }

  /// *** Ministry dropdown List Data ***///
  void getMinistryDropDownList() {
    showLoadingDialog();
    APIRepository().getMinistryDropDownList().then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          List<MinistryListResponse> list = List<MinistryListResponse>.from(resp.data!.map((x) => MinistryListResponse.fromJson(x)));
          // ministryListResponse.addAll(list);
          ministryListResponse.value = list;
          selectedValueForMinistry.value = selectedValueForMinistry.value;
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      ministryListResponse.clear();
      showToast(err.toString());
    });
  }

  /// *** Division dropdown List Data ***///
  void getDivisionDropDownList() {
    APIRepository()
        .getDivisionDropDownList(selectedValueForMinistry.value.value ?? "")
        .then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {

         DivisionResponse divisionResponse = DivisionResponse.fromJson(resp.data);
         if(divisionResponse.divisions != null && divisionResponse.divisions!.isNotEmpty){
           agencyListResponse.clear();
           divisionListResponse.value = divisionResponse.divisions!;
           selectedValueForDivision.value = selectedValueForDivision.value;
         }else{
           divisionListResponse.value.clear();
           selectedValueForDivision.value = ValueObject(value:"");
           if(divisionResponse.agencies != null && divisionResponse.agencies!.isNotEmpty){
             agencyListResponse.value = divisionResponse.agencies!;
             selectedValueForAgency.value = selectedValueForAgency.value;
           }else{
             selectedValueForAgency.value = ValueObject(value:"");
           }
         }

          //List<DivisionListResponse> list = List<DivisionListResponse>.from(resp.data!.map((x) => DivisionListResponse.fromJson(x)));
          // ministryListResponse.addAll(list);

          //divisionListResponse.value = list;
         //selectedValueForDivision.value = selectedValueForDivision.value;
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      divisionListResponse.clear();
      showToast(err.toString());
    });
  }

  /// *** Agency dropdown List Data ***///
  void getAgencyDropDownList() {

    debugPrint("Test Data Agency ${selectedValueForDivision.value.value}");

    APIRepository()
        .getAgencyDropDownList(selectedValueForDivision.value.value ?? "")
        .then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          List<ValueObject> list = List<ValueObject>.from(resp.data!.map((x) => ValueObject.fromJson(x)));
          // ministryListResponse.addAll(list);

          agencyListResponse.value = list;
          selectedValueForAgency.value = selectedValueForAgency.value;
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      agencyListResponse.clear();
      showToast(err.toString());
    });
  }

  /// *** Ministry List Data ***///
  void getAllAgencyListFromAllProjects(bool isFromLoadMore) {
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
        .getProjectsListForAgency(
            selectedValueForAgency.value.value ?? "", loadedPage)
        .then((resp) {
      hideLoadingDialog();
      isLoading = false;
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
      isLoading = false;
      hideLoadingDialog();
      allProjectsResponseList.clear();
      showToast(err.toString());
    });
  }
}
