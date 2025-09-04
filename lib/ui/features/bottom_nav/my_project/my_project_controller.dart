import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/LandingProjectCountResponse.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

import '../../../../data/models/project_progress_cost_data.dart';

class MyProjectController extends GetxController {



  late int currentIndex = 0;

  List<String> carouselListImage = [
    AssetConstants.image_1,
    AssetConstants.image_2,
    AssetConstants.image_3,
    AssetConstants.image_4
  ];

  List<String> carouselListText = [
    "materbari".tr,
    "metro_rail_shortnote".tr,
    "padma_bride_rail".tr,
    "padma_bride".tr,
  ];


  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }

  // List<int>? myProjectItemList = <int>[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17].obs;
  List<int>? myProjectItemListDemo = <int>[1, 2, 3, 4, 5].obs;

  // RxList<ProjectList> searchedItemList = <ProjectList>[].obs;
  // RxList<dynamic> myProjectItemList = <dynamic>[].obs;
  Rx<ListResponse> listResponse = ListResponse().obs;

  //RxList<AllProjectsResponse> allProjectsResponseList = <AllProjectsResponse>[].obs;

  ////by Rasel
  RxList<AllProjectsResponse> allProjectsResponseListUpdated = <AllProjectsResponse>[].obs;
  RxList<AllProjectsResponse> allProjectsResponseListForLength = <AllProjectsResponse>[].obs;

  // Rx<AllProjectsResponse> allProjectsResponse = AllProjectsResponse().obs;
  // RxList<MyProjectsResponse> myProjectsResponseList = <MyProjectsResponse>[].obs;

  bool isLoading = true;

  int loadedPage = 0;
  bool hasMoreData = true;
  bool isDataLoaded = true;

  void clearView() {
    loadedPage = 0;
    hasMoreData = true;
    allProjectsResponseListUpdated.clear();
    allProjectsResponseListForLength.clear();
    //allProjectsResponseList.clear(); ////hidr by rokan
  }

  /// Load my project without pagination
  void getMyProjectListForLength() {
    isDataLoaded = true;
    APIRepository().myProjectsWithoutPagination().then((resp) {
      if (resp.status == "success") {
        listResponse.value = ListResponse.fromJson(resp.data);
        var response = listResponse.value;
        if (response.lists != null && response.lists!.isNotEmpty) {
          allProjectsResponseListForLength.clear();
          List? data = response.lists;
          List<AllProjectsResponse> localList = [];
          for (var element in data!) {
            final event = AllProjectsResponse.fromJson(element);
            /*if ((event.statusName == 'Approved') ||
                (event.statusName == 'Draft')) {
              localList.add(event);
            }*/

            if ((event.statusId == 'Projectstatus_Approved') ||
                (event.statusId == 'Projectstatus_draft')) {
              localList.add(event);
            }
          }
          if (localList.isNotEmpty) {
            allProjectsResponseListForLength.addAll(localList);
          }
        }
      } else {
        showToast(resp.message, isError: true);
      }
      isDataLoaded = false;
    }, onError: (err) {
      //Rokan Hide 23.02.2025
      //showToast(err.toString());
    });
  }

  /// Load my project with pagination
  void getMyProjectList(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      allProjectsResponseListUpdated.clear();
      //allProjectsResponseList.clear();/// hide by rokan
      // isDataLoaded = false;
      isLoading = false;
    }
    isLoading = true;
    //showLoadingDialog();
    var allItems = allProjectsResponseListUpdated.length;
    //var allItems = allProjectsResponseList.length; //// hide by rokan
    APIRepository().myProjects(loadedPage).then((resp) {
      //hideLoadingDialog();
      isLoading = false;
      if (resp.status == "success") {
        // hideLoadingDialog();
        listResponse.value = ListResponse.fromJson(resp.data);
        var response = listResponse.value;
        if (response.lists != null && response.lists!.isNotEmpty) {
          // allProjectsResponse.value= AllProjectsResponse.fromJson(resp.data);
          List<AllProjectsResponse> list = List<AllProjectsResponse>.from(
              response.lists!.map((x) => AllProjectsResponse.fromJson(x)));

          ////

          List? data = response.lists;
          // List<AllProjectsResponse> data = List<AllProjectsResponse>.from(response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
          for (var element in data!) {
            final event = AllProjectsResponse.fromJson(element);
            /*if ((event.statusName == 'Approved') ||
                (event.statusName == 'Draft')) {
              allProjectsResponseListUpdated.add(event);*/

            if ((event.statusId == 'Projectstatus_Approved') || (event.statusId == 'Projectstatus_draft')) {
              allProjectsResponseListUpdated.add(event);
            }
          }

          listResponse.value.paginationDto = listResponse.value.paginationDto;
        }
        loadedPage = response.paginationDto!.current ?? 0;
        hasMoreData = (allItems != response.paginationDto!.total);
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      //Rokan Hide 23.02.2025
      hideLoadingDialog();
      // isLoading = false;
      //allProjectsResponseListUpdated.clear();
      //allProjectsResponseList.clear(); /// hide by rokan
      //showToast(err.toString());
    });
  }

  /// *** Project Progress and Cost Data ***///
  /*Rx<ProjectProgressAndCostData> projectProgressAndCostData =
      ProjectProgressAndCostData().obs;

  void getProjectProgressAndCostData(String projectId) {
    showLoadingDialog(isDismissible: true);
    APIRepository().getProjectProgressAndCostData(projectId).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          projectProgressAndCostData.value =
              ProjectProgressAndCostData.fromJson(resp.data);
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }*/

  Rx<ProjectProgressAndCostData> projectProgressAndCostData =
      ProjectProgressAndCostData().obs;

  Future<void> getProjectProgressAndCostData(String projectId) async {
    showLoadingDialog(isDismissible: true);
    await APIRepository().getProjectProgressAndCostData(projectId).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          projectProgressAndCostData.value =
              ProjectProgressAndCostData.fromJson(resp.data);
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      //Rokan Hide 23.02.2025
      /*hideLoadingDialog();
      showToast(err.toString());*/
    });
  }





  Rx<LandingProjectCountResponse> landingProjectCount = LandingProjectCountResponse().obs;
  Future <void> getLandingProjectCount() async {
    await APIRepository().getLandingProjectCount().then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {

          landingProjectCount.value = LandingProjectCountResponse.fromJson(resp.data);
          debugPrint("Aifaz_LandingProjectCountResponse: ${landingProjectCount.value.currentYearAllocatedAdpRadpProjects.toString()}");

        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      //showToast(err.toString());
    });
  }





//
// ///For load my project at a time
// void getMyProjectListItemsWithoutPagination() {
//   // isLoading = true;
//   myProjectsResponseList.clear();
//   APIRepository().myProjectsAllListDataRequest(0).then((resp) {
//     // isLoading = false;
//     if (resp.status == "success") {
//       listResponse.value = ListResponse.fromJson(resp.data);
//       var response = listResponse.value;
//       if (response.lists != null  && response.lists!.isNotEmpty) {
//         List<MyProjectsResponse> list = List<MyProjectsResponse>.from(response.lists!.map((x) => MyProjectsResponse.fromJson(x)));
//         myProjectsResponseList.addAll(list);
//         listResponse.value.paginationDto =  listResponse.value.paginationDto;
//       }
//     } else {
//       showToast(resp.message,isError: true);
//       myProjectsResponseList.clear();
//     }
//   }, onError: (err) {
//     // isLoading = false;
//     showToast(err.toString());
//     myProjectsResponseList.clear();
//   });
// }
// void getMyProjectListItemsWithoutPagination() {
//   isLoading = true;
//   allProjectsResponseList.clear();
//   APIRepository().myProjects(0).then((resp) {
//     isLoading = false;
//     if (resp.status == "success") {
//       listResponse.value = ListResponse.fromJson(resp.data);
//       var response = listResponse.value;
//       if (response.lists != null) {
//         List<AllProjectsResponse> list = List<AllProjectsResponse>.from(response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
//         allProjectsResponseList.addAll(list);
//       }
//     } else {
//       showToast(resp.message,isError: true);
//       allProjectsResponseList.value = <AllProjectsResponse>[];
//     }
//   }, onError: (err) {
//     isLoading = false;
//     showToast(err.toString());
//     allProjectsResponseList.value = <AllProjectsResponse>[];
//   });
// }
}
