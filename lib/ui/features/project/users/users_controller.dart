import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/UserListResponse.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/models/pending_task_list_response.dart';
import 'package:pmis_flutter/data/models/project_user_list_response.dart';
import 'package:pmis_flutter/data/models/workflow_node_data_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

class UsersController extends GetxController {


  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {//Duration.zero
      // getItemList();
    });

  }


  RxList<ProjectUserListResponse> projectUserListResponse = <ProjectUserListResponse>[].obs;

  var workflowRoleId;

  bool isLoading = true;

  int loadedPage = 0;
  bool hasMoreData = true;

  bool isDataLoaded = false;

  void clearView(){
    loadedPage = 0;
    hasMoreData = true;
    projectUserListResponse.clear();
  }






  Future <void> getUsersList(String? projectId) async{
    await APIRepository().getProjectUserList(projectId ?? "").then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {

          try{

            List<ProjectUserListResponse> list = List<ProjectUserListResponse>.from(resp.data!.map((x) => ProjectUserListResponse.fromJson(x)));
            projectUserListResponse.value = list;


          }catch(e){

          }

        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
    });
  }







  /*void getUsersList(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      userListResponse.clear();
      isLoading = false;
    }
    //showLoadingDialog();
    isLoading = true;
    var allItems = userListResponse.length;
    APIRepository().getUserList(loadedPage).then((resp) {
      isLoading = false;
      hideLoadingDialog();
      if (resp.status == "success") {
        listResponse.value = ListResponse.fromJson(resp.data);
        var response = listResponse.value;
        if (response.lists != null  && response.lists!.isNotEmpty) {
          List<UserListResponse> list = List<UserListResponse>.from(response.lists!.map((x) => UserListResponse.fromJson(x)));
          userListResponse.addAll(list);
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
      userListResponse.clear();
      showToast(err.toString());
    });
  }*/



}
