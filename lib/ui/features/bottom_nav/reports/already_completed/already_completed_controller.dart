import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

class AlreadyCompletedController extends GetxController with GetSingleTickerProviderStateMixin{

  TabController? tabController;
  final tabSelectedIndex = 0.obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
  }


  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {//Duration.zero
      // getItemList();
    });

  }

  Rx<ListResponse> listResponseForPcrReceived = ListResponse().obs;
  Rx<ListResponse> listResponseForPcrNotReceived = ListResponse().obs;
  RxList<AllProjectsResponse> allProjectsResponseListWithPcrReceived = <AllProjectsResponse>[].obs;
  RxList<AllProjectsResponse> allProjectsResponseListWithPcrNotReceived = <AllProjectsResponse>[].obs;

  bool isLoading = true;

  int loadedPage = 0;
  bool hasMoreData = true;

  bool isDataLoaded = false;

  void clearView(){
    loadedPage = 0;
    hasMoreData = true;
    allProjectsResponseListWithPcrReceived.clear();
    allProjectsResponseListWithPcrNotReceived.clear();
  }


  /// Load my already completed project With Pcr Received and pagination
  void getMyCompletedProjectListWithPcrReceived(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      allProjectsResponseListWithPcrReceived.clear();
      // isDataLoaded = false;
      isLoading = false;
    }
    isLoading = true;
    //showLoadingDialog();
    var allItems = allProjectsResponseListWithPcrReceived.length;
    APIRepository().myProjectsCompletedWithPcrStatusReceived(loadedPage, false).then((resp) {
      hideLoadingDialog();
      isLoading = false;
      if (resp.status == "success") {
        // hideLoadingDialog();
        listResponseForPcrReceived.value = ListResponse.fromJson(resp.data);
        var response = listResponseForPcrReceived.value;
        if (response.lists != null  && response.lists!.isNotEmpty) {

          // allProjectsResponse.value= AllProjectsResponse.fromJson(resp.data);
          List<AllProjectsResponse> list = List<AllProjectsResponse>.from(response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
          // isDataLoaded = true;
          allProjectsResponseListWithPcrReceived.addAll(list);
          // allProjectsResponseList.value = allProjectsResponseList.value;
          // allProjectsResponseList.value = AllProjectsResponse.fromJson(response.lists.);
          listResponseForPcrReceived.value.paginationDto =  listResponseForPcrReceived.value.paginationDto;
        }
        loadedPage = response.paginationDto!.current ?? 0;
        hasMoreData = (allItems != response.paginationDto!.total);
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      // isLoading = false;
      allProjectsResponseListWithPcrReceived.clear();
      showToast(err.toString());
    });
  }

  /// Load my already completed project With Pcr Not Received and pagination
  void getMyCompletedProjectListWithPcrNotReceived(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      allProjectsResponseListWithPcrNotReceived.clear();
      // isDataLoaded = false;
      isLoading = false;
    }
    isLoading = true;
    //showLoadingDialog();
    var allItems = allProjectsResponseListWithPcrNotReceived.length;
    APIRepository().myProjectsCompletedWithPcrStatusNotReceived(loadedPage, true).then((resp) {
      hideLoadingDialog();
      isLoading = false;
      if (resp.status == "success") {
        // hideLoadingDialog();
        listResponseForPcrNotReceived.value = ListResponse.fromJson(resp.data);
        var response = listResponseForPcrNotReceived.value;
        if (response.lists != null  && response.lists!.isNotEmpty) {

          // allProjectsResponse.value= AllProjectsResponse.fromJson(resp.data);
          List<AllProjectsResponse> list = List<AllProjectsResponse>.from(response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
          // isDataLoaded = true;
          allProjectsResponseListWithPcrNotReceived.addAll(list);
          // allProjectsResponseList.value = allProjectsResponseList.value;
          // allProjectsResponseList.value = AllProjectsResponse.fromJson(response.lists.);
          listResponseForPcrNotReceived.value.paginationDto =  listResponseForPcrNotReceived.value.paginationDto;
        }
        loadedPage = response.paginationDto!.current ?? 0;
        hasMoreData = (allItems != response.paginationDto!.total);
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      // isLoading = false;
      allProjectsResponseListWithPcrNotReceived.clear();
      showToast(err.toString());
    });
  }


}
