import 'package:get/get.dart';
import '../../../../data/models/list_response.dart';
import '../../../../data/models/project_inspection_response_list.dart';
import '../../../../data/remote/api_repository.dart';
import '../../../../utils/common_utils.dart';

class InspectionReportController extends GetxController {


  Rx<ListResponse> listResponse = ListResponse().obs;
  RxList<ProjectInspectionResponseList> projectInspectionResponseList = <ProjectInspectionResponseList>[].obs;


  bool isDataLoaded = false;

  int loadedPage = 0;
  bool hasMoreData = true;
  bool isLoading = true;

  void clearView(){
    loadedPage = 0;
    hasMoreData = true;
    projectInspectionResponseList.clear();
  }
  /// *** Project Inspection List Data ***///
  void getProjectInspectionList(String projectId,bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      projectInspectionResponseList.clear();
      isLoading = false;
    }
    isLoading = true;
    //showLoadingDialog();
    var allItems = projectInspectionResponseList.length;
    APIRepository().getProjectLocationsList(projectId, loadedPage).then((resp) {
      isLoading = false;
      hideLoadingDialog();
      if (resp.status == "success") {
        // loadedPage++;
        // ListResponse response = ListResponse.fromJson(resp.data);
        listResponse.value = ListResponse.fromJson(resp.data);
        var response = listResponse.value;
        if (response.lists != null && response.lists!.isNotEmpty) {
          List<ProjectInspectionResponseList> list = List<ProjectInspectionResponseList>.from(
              response.lists!.map((x) => ProjectInspectionResponseList.fromJson(x)));
          projectInspectionResponseList.addAll(list);
          listResponse.value.paginationDto =  listResponse.value.paginationDto;
        }
        loadedPage = response.paginationDto!.current ?? 0;
        hasMoreData = (allItems != response.paginationDto!.total);
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      isLoading = false;
      projectInspectionResponseList.clear();
      showToast(err.toString());
    });
  }
}
