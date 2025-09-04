import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

/*class ProjectsController extends GetxController {
  List<int>? fastTrackItemList =
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17].obs;
  // RxList<ProjectList> searchedItemList = <ProjectList>[].obs;

  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }

  Rx<ListResponse> listResponse = ListResponse().obs;
  //RxList<ProjectsListResponse> projectsListResponse = <ProjectsListResponse>[].obs;
  RxList<AllProjectsResponse> projectsListResponse =
      <AllProjectsResponse>[].obs;
  //Rx<ProjectsListResponse> projectsListResponse = ProjectsListResponse().obs;

  bool isLoading = true;

  int loadedPage = 0;
  bool hasMoreData = true;

  bool isDataLoaded = false;

  void clearView() {
    loadedPage = 0;
    hasMoreData = true;
    projectsListResponse.clear();
  }

  Future<void> getProjectsList(String userId) async {
    await APIRepository().getUserProjects(userId).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          //debugPrint("Rokan project Data response Test: ${resp.data.toString()}");

          //List<ProjectsListResponse> list = List<ProjectsListResponse>.from(resp.data!.map((x) => ProjectsListResponse.fromJson(x)));
          List<AllProjectsResponse> list = List<AllProjectsResponse>.from(
              resp.data!.map((x) => AllProjectsResponse.fromJson(x)));
          projectsListResponse.value = list;

          debugPrint("Rokan May Total Project Test: ${projectsListResponse.value.length.toString()}");
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
    });
  }
}*/


class ProjectsController extends GetxController {
  RxList<AllProjectsResponse> projectsListResponse = <AllProjectsResponse>[].obs;

  bool isLoading = false;
  bool isDataLoaded = false;

  bool hasMoreData = false; //

  Future<void> getProjectsList(String userId) async {
    if (isDataLoaded) return;

    isLoading = true;
    update();

    await APIRepository().getUserProjects(userId).then((resp) {
      if (resp.status == "success" && resp.data != null) {
        projectsListResponse.value = List<AllProjectsResponse>.from(
            resp.data!.map((x) => AllProjectsResponse.fromJson(x)));

        isDataLoaded = true;
        hasMoreData = false; // or true if paginated
      }
    }).catchError((err) {
      debugPrint("Error: $err");
    }).whenComplete(() {
      isLoading = false;
      update();
    });
  }
}


