import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/date_util.dart';

class Closing3To6MonthsController extends GetxController {

  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {//Duration.zero
      // getItemList();
    });

  }

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


  // final now = DateTime.now();
  // String? todayDate;
  //
  // todayDate = formatDateToYYYYMMDDString(now.toString());


  /// Load my project with pagination
 void getMyProjectClosingIn3To6List(bool isFromLoadMore,String todayDateTo90, String todayDateTo90To180Days) {
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
    APIRepository().myProjectClosingIn3To6List(loadedPage,todayDateTo90,todayDateTo90To180Days).then((resp) {
      hideLoadingDialog();
      isLoading = false;
      if (resp.status == "success") {
        // hideLoadingDialog();
        listResponse.value = ListResponse.fromJson(resp.data);
        var response = listResponse.value;
        if (response.lists != null  && response.lists!.isNotEmpty) {
          List<AllProjectsResponse> list = List<AllProjectsResponse>.from(response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
          allProjectsResponseList.addAll(list);
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
  }




}
