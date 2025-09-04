import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/models/pending_task_list_response.dart';
import 'package:pmis_flutter/data/models/workflow_expenditure_infprmation_response.dart';
import 'package:pmis_flutter/data/models/workflow_node_data_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

class WorkflowExpenditureInformationController extends GetxController {

  List<int>? pendingTaskItemList = <int>[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17].obs;
  // RxList<ProjectList> searchedItemList = <ProjectList>[].obs;


  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {//Duration.zero
      // getItemList();
    });

  }

  Rx<ListResponse> listResponse = ListResponse().obs;
  RxList<WorkflowExpenditureInformationResponse> allProjectsResponseList = <WorkflowExpenditureInformationResponse>[].obs;
  Rx<WorkflowNodeDataResponse> workflowNodeDataResponse = WorkflowNodeDataResponse().obs;

  var workflowRoleId;

  bool isLoading = true;

  int loadedPage = 0;
  bool hasMoreData = true;

  bool isDataLoaded = false;

  void clearView(){
    loadedPage = 0;
    hasMoreData = true;
    allProjectsResponseList.clear();
  }


  void getWorkflowExpenditureInformationList(bool isFromLoadMore, String? projectExpenditureId) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      allProjectsResponseList.clear();
      isLoading = false;
    }
    showLoadingDialog();
    isLoading = true;
    var allItems = allProjectsResponseList.length;
    APIRepository().getWorkflowExpenditureInformationData(loadedPage, projectExpenditureId ?? "").then((resp) {
      isLoading = false;
      hideLoadingDialog();
      if (resp.status == "success") {
        listResponse.value = ListResponse.fromJson(resp.data);

           debugPrint("Rokan workflow expenditure information: ${resp.data.toString()}");

        var response = listResponse.value;
        if (response.lists != null  && response.lists!.isNotEmpty) {
          List<WorkflowExpenditureInformationResponse> list = List<WorkflowExpenditureInformationResponse>.from(response.lists!.map((x) => WorkflowExpenditureInformationResponse.fromJson(x)));
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
      isLoading = false;
      allProjectsResponseList.clear();
      showToast(err.toString());
    });
  }





}
