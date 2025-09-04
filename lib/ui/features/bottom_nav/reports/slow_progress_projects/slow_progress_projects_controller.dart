import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

class SlowProgressProjectsController extends GetxController {

  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {//Duration.zero
      // getItemList();
    });

  }

  Rx<ListResponse> listResponse = ListResponse().obs;
  RxList<AllProjectsResponse> allProjectsResponseList = <AllProjectsResponse>[].obs;

  /*bool isLoading = true;*/ //rokan

  int loadedPage = 0;
  bool hasMoreData = true;

  bool isDataLoaded = false;

  void clearView(){
    loadedPage = 0;
    hasMoreData = true;
    allProjectsResponseList.clear();
  }

  void getSlowProgressProjectsList(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      allProjectsResponseList.clear();
      /*isLoading = false;*/ //rokan
    }
    /*showLoadingDialog();*/ //rokan
    /*isLoading = true;*/ //rokan
    var allItems = allProjectsResponseList.length;
    APIRepository().getSlowProgressProjectsList(loadedPage).then((resp) {
      /*isLoading = false;*/ //rokan
      /*hideLoadingDialog();*/ //rokan
      if (resp.status == "success") {
        listResponse.value = ListResponse.fromJson(resp.data);
        var response = listResponse.value;
        if (response.lists != null  && response.lists!.isNotEmpty) {
          List<AllProjectsResponse> list = List<AllProjectsResponse>.from(response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
          allProjectsResponseList.addAll(list);
          listResponse.value.paginationDto =  listResponse.value.paginationDto;
        }
        loadedPage = response.paginationDto!.current ?? 0;
        // hasMoreData = (allItems != response.paginationDto!.total);
        hasMoreData = (loadedPage != response.paginationDto!.pageSize);
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      /*isLoading = false;*/ //rokan
      allProjectsResponseList.clear();
      showToast(err.toString());
    });
  }


/*  void getSlowProgressProjectsList(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      print("*****Called is not isFromLoadMore");
      loadedPage = 0;
      hasMoreData = true;
      allProjectsResponseList.clear();
      // isDataLoaded = false;
      isLoading = false;
    }

    print("*****Called isFromLoadMore");
    isLoading = true;
    showLoadingDialog();
    var allItems = allProjectsResponseList.length;
    APIRepository().getSlowProgressProjectsList(loadedPage).then((resp) {
      hideLoadingDialog();
      isLoading = false;
      if (resp.status == "SUCCESS") {
        // hideLoadingDialog();
        listResponse.value = ListResponse.fromJson(resp.data);
        var response = listResponse.value;
        if (response.lists != null  && response.lists!.isNotEmpty) {

          // allProjectsResponse.value= AllProjectsResponse.fromJson(resp.data);
          List<AllProjectsResponse> list = List<AllProjectsResponse>.from(response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
          // isDataLoaded = true;
          allProjectsResponseList.addAll(list);
          // allProjectsResponseList.value = allProjectsResponseList.value;
          // allProjectsResponseList.value = AllProjectsResponse.fromJson(response.lists.);
          listResponse.value.paginationDto =  listResponse.value.paginationDto;
        }
        loadedPage = response.paginationDto!.current ?? 0;
        hasMoreData = (allItems != response.paginationDto!.total);
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      // isLoading = false;
      allProjectsResponseList.clear();
      showToast(err.toString());
    });
  }*/


/*  void getSlowProgressProjectsList(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      allProjectsResponseList.clear();
      // isDataLoaded = false;
      isLoading = false;
    }
    isLoading = true;
    showLoadingDialog();
    var allItems = allProjectsResponseList.length;
    APIRepository().getSlowProgressProjectsList(loadedPage).then((resp) {
      hideLoadingDialog();
      isLoading = false;
      if (resp.status == "SUCCESS") {
        // hideLoadingDialog();
        listResponse.value = ListResponse.fromJson(resp.data);
        var response = listResponse.value;
        if (response.lists != null  && response.lists!.isNotEmpty) {

          // allProjectsResponse.value= AllProjectsResponse.fromJson(resp.data);
          List<AllProjectsResponse> list = List<AllProjectsResponse>.from(response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
          // isDataLoaded = true;
          allProjectsResponseList.addAll(list);
          // allProjectsResponseList.value = allProjectsResponseList.value;
          // allProjectsResponseList.value = AllProjectsResponse.fromJson(response.lists.);
          listResponse.value.paginationDto =  listResponse.value.paginationDto;
        }
        loadedPage = response.paginationDto!.current ?? 0;
        hasMoreData = (allItems != response.paginationDto!.total);
      } else {
        showToast(resp.message,isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      // isLoading = false;
      allProjectsResponseList.clear();
      showToast(err.toString());
    });
  }*/

  // void getSlowProgressProjectsList(bool isFromLoadMore) {
  //   if (!isFromLoadMore) {
  //     loadedPage = 0;
  //     hasMoreData = true;
  //     allProjectsResponseList.clear();
  //     isLoading = false;
  //   }
  //   showLoadingDialog();
  //   isLoading = true;
  //   var allItems = allProjectsResponseList.length;
  //   APIRepository().getSlowProgressProjectsList(loadedPage).then((resp) {
  //     isLoading = false;
  //     hideLoadingDialog();
  //     if (resp.status == "success") {
  //       listResponse.value = ListResponse.fromJson(resp.data);
  //       var response = listResponse.value;
  //       if (response.lists != null  && response.lists!.isNotEmpty) {
  //         List<AllProjectsResponse> list = List<AllProjectsResponse>.from(response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
  //         allProjectsResponseList.addAll(list);
  //         listResponse.value.paginationDto =  listResponse.value.paginationDto;
  //       }
  //       loadedPage = response.paginationDto!.current ?? 0;
  //       hasMoreData = (allItems != response.paginationDto!.total);
  //     } else {
  //       showToast(resp.message,isError: true);
  //     }
  //   }, onError: (err) {
  //     hideLoadingDialog();
  //     isLoading = false;
  //     allProjectsResponseList.clear();
  //     showToast(err.toString());
  //   });
  // }


}
