import 'package:get/get.dart';
import '../../../../data/models/project_location_response_list.dart';
import '../../../../data/remote/api_repository.dart';
import '../../../../utils/common_utils.dart';

class ProjectLocationsController extends GetxController {


  bool isDataLoaded = false;

  RxList<ProjectLocationResponseList> projectLocationResponseList = <ProjectLocationResponseList>[].obs;

  int loadedPage = 0;
  bool hasMoreData = true;
  bool isLoading = true;

  void clearView(){
    loadedPage = 0;
    hasMoreData = true;
    projectLocationResponseList.clear();
  }

  /// *** Project Locations List Data ***///
  void getProjectLocationsList(String projectId) {
    showLoadingDialog();
    APIRepository().getProjectLocationList(projectId).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          List<ProjectLocationResponseList> list = List<ProjectLocationResponseList>.from(
              resp.data!.map((x) => ProjectLocationResponseList.fromJson(x)));
          // districtListResponse.addAll(list);
          projectLocationResponseList.value = list;
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      projectLocationResponseList.clear();
      showToast(err.toString());
    });
  }

}
