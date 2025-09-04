import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

class PCRController extends GetxController with GetSingleTickerProviderStateMixin{

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


  void clearView(){
    loadedPageForPcrReceived = 0;
    hasMoreDataForPcrReceived = true;
    pcrReceivedResponseItemList.clear();

    loadedPageForPcrNotReceived = 0;
    hasMoreDataForPcrNotReceived = true;
    pcrNotReceivedResponseItemList.clear();
  }

  Rx<ListResponse> listResponseForPcrReceived = ListResponse().obs;
  RxList<AllProjectsResponse> pcrReceivedResponseItemList = <AllProjectsResponse>[].obs;
  bool isLoadingForPcrReceived = true;
  int loadedPageForPcrReceived = 0;
  bool hasMoreDataForPcrReceived = true;
  bool isDataLoadedForPcrReceived = false;

  /// Load my already completed project With Pcr Received and pagination
  void getMyCompletedProjectListWithPcrReceived(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPageForPcrReceived = 0;
      hasMoreDataForPcrReceived = true;
      pcrReceivedResponseItemList.clear();
      // isDataLoaded = false;
      isLoadingForPcrReceived = false;
    }
    isLoadingForPcrReceived = true;
    showLoadingDialog();
    var allItems = pcrReceivedResponseItemList.length;
    APIRepository().myProjectsCompletedWithPcrStatusReceived(loadedPageForPcrReceived, false).then((resp) {
      hideLoadingDialog();
      isLoadingForPcrReceived = false;
      if (resp.status == "success") {
        // hideLoadingDialog();
        listResponseForPcrReceived.value = ListResponse.fromJson(resp.data);
        var response = listResponseForPcrReceived.value;
        if (response.lists != null  && response.lists!.isNotEmpty) {

          // allProjectsResponse.value= AllProjectsResponse.fromJson(resp.data);
          List<AllProjectsResponse> list = List<AllProjectsResponse>.from(response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
          // isDataLoaded = true;
          pcrReceivedResponseItemList.addAll(list);
          // allProjectsResponseList.value = allProjectsResponseList.value;
          // allProjectsResponseList.value = AllProjectsResponse.fromJson(response.lists.);
          listResponseForPcrReceived.value.paginationDto =  listResponseForPcrReceived.value.paginationDto;
        }
        loadedPageForPcrReceived = response.paginationDto!.current ?? 0;
        hasMoreDataForPcrReceived = (allItems != response.paginationDto!.total);
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      // isLoading = false;
      pcrReceivedResponseItemList.clear();
      showToast(err.toString());
    });
  }


  Rx<ListResponse> listResponseForPcrNotReceived = ListResponse().obs;
  RxList<AllProjectsResponse> pcrNotReceivedResponseItemList = <AllProjectsResponse>[].obs;
  bool isLoadingForPcrNotReceived = true;
  int loadedPageForPcrNotReceived = 0;
  bool hasMoreDataForPcrNotReceived = true;
  bool isDataLoadedForPcrNotReceived = false;

  /// Load my already completed project With Pcr Not Received and pagination
  void getMyCompletedProjectListWithPcrNotReceived(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPageForPcrNotReceived = 0;
      hasMoreDataForPcrNotReceived = true;
      pcrNotReceivedResponseItemList.clear();
      // isDataLoaded = false;
      isLoadingForPcrNotReceived = false;
    }
    isLoadingForPcrNotReceived = true;
    showLoadingDialog();
    var allItems = pcrNotReceivedResponseItemList.length;
    APIRepository().myProjectsCompletedWithPcrStatusNotReceived(loadedPageForPcrNotReceived, true).then((resp) {
      hideLoadingDialog();
      isLoadingForPcrNotReceived = false;
      if (resp.status == "success") {
        // hideLoadingDialog();
        listResponseForPcrNotReceived.value = ListResponse.fromJson(resp.data);
        var response = listResponseForPcrNotReceived.value;
        if (response.lists != null  && response.lists!.isNotEmpty) {

          // allProjectsResponse.value= AllProjectsResponse.fromJson(resp.data);
          List<AllProjectsResponse> list = List<AllProjectsResponse>.from(response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
          // isDataLoaded = true;
          pcrNotReceivedResponseItemList.addAll(list);
          // allProjectsResponseList.value = allProjectsResponseList.value;
          // allProjectsResponseList.value = AllProjectsResponse.fromJson(response.lists.);
          listResponseForPcrNotReceived.value.paginationDto =  listResponseForPcrNotReceived.value.paginationDto;
        }
        loadedPageForPcrNotReceived = response.paginationDto!.current ?? 0;
        hasMoreDataForPcrNotReceived = (allItems != response.paginationDto!.total);
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      // isLoading = false;
      pcrNotReceivedResponseItemList.clear();
      showToast(err.toString());
    });
  }

}
