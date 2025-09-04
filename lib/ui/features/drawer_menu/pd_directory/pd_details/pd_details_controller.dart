import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/models/pc_info_list_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

class PdDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  final tabSelectedIndex = 0.obs;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
  }

  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }

  // RxList<PdInfoListResponse> pdInfoListResponse = <PdInfoListResponse>[].obs;
  // Rx<PdInfoListResponse> roleListResponse = PdInfoListResponse().obs;
  RxList<PdInfoListResponse> pdInfoListResponse = <PdInfoListResponse>[].obs;

  Rx<ListResponse> listResponse = ListResponse().obs;

  // Rx<PdInfoListResponse> selectedValueForAgency = PdInfoListResponse(value: "").obs;

  /// *** PD List Data ***///
  Future <void> getPdInfoTadData(String? projectId) async {
    await APIRepository().getPdInfoTadData(projectId ?? "").then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
/*          List<PdInfoListResponse> list = List<PdInfoListResponse>.from(
              resp.data!.map((x) => PdInfoListResponse.fromJson(x)));

          roleListResponse.value = list.first;*/

          List<dynamic> data = resp.data;
          for (var element in data) {
            final event = PdInfoListResponse.fromJson(element);
            if (event.roleName == 'pd') {
              pdInfoListResponse.add(event);
            }
          }
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      // pdInfoListResponse.clear();
      showToast(err.toString());
    });
  }








/*

  /// *** Ministry dropdown List Data ***/ /*
//
  void getMinistryDropDownList() {
    APIRepository().getMinistryDropDownList().then((resp) {
      if (resp.status == "success") {
        if (resp.data != null) {
          List<MinistryListResponse> list = List<MinistryListResponse>.from(
              resp.data!.map((x) => MinistryListResponse.fromJson(x)));
          // ministryListResponse.addAll(list);
          ministryListResponse.value = list;
          selectedValueForMinistry.value = selectedValueForMinistry.value;
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      ministryListResponse.clear();
      showToast(err.toString());
    });
  }
*/
}
