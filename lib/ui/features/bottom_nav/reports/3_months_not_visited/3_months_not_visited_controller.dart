import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

class Months3NotVisitedController extends GetxController {

  Rx<ListResponse> listResponse = ListResponse().obs;
  RxList<AllProjectsResponse> allProjectsResponseList = <AllProjectsResponse>[].obs;

  bool isLoading = true;

  int loadedPage = 0;
  bool hasMoreData = true;

  bool isDataLoaded = false;

  void clearView(){
    loadedPage = 0;
    hasMoreData = true;
    allProjectsResponseList.clear();
  }

  /// Load my project with pagination
 getMyProjectNotVisited3MonthsByIMEDList(bool isFromLoadMore,String todayDateToBefore90Days) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      allProjectsResponseList.clear();
      // isDataLoaded = false;
      isLoading = false;
    }
    isLoading = true;
    //showLoadingDialog();
    var allItems = allProjectsResponseList.length;
    APIRepository().myProjectNotVisited3MonthsByIMEDList(loadedPage,todayDateToBefore90Days).then((resp) {
      hideLoadingDialog();
      isLoading = false;
      if (resp.status == "success") {
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
      //showToast(err.toString());
    });
  }



}
