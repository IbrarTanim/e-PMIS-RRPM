import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/models/pcr_attachment_view.dart';
import 'package:pmis_flutter/data/models/wish_list_project_details_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

import '../../../../data/models/upload_file_response.dart';
import '../../../data/models/project_details_by_id.dart';

class ProjectDetailsByIDController extends GetxController {
  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }

  void clearInputData() {
    dateTextEditController.text = "";
    imageShootingDate = "";
    imageShootingTime = "";
  }

  TextEditingController dateTextEditController = TextEditingController();
  String? imageShootingDate;
  String? imageShootingTime;

  Rx<ListResponse> listResponse = ListResponse().obs;
  RxList<AllProjectsResponse> allProjectsResponseList =
      <AllProjectsResponse>[].obs;

  bool isLoading = true;

  int loadedPage = 0;
  bool hasMoreData = true;

  bool isDataLoaded = false;

  void clearView() {
    loadedPage = 0;
    hasMoreData = true;
    allProjectsResponseList.clear();
    projectDetailsById == null;
    // pcrStatusResponseMessage = "";
  }

  /// *** Project Details by Project ID ***///
  /*Rx<ProjectDetailsById> projectDetailsById = ProjectDetailsById().obs;

  void getMyProjectListByID(String projectId) {
    showLoadingDialog(isDismissible: true);
    APIRepository().getProjectDetailsByID(projectId).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          projectDetailsById.value = ProjectDetailsById.fromJson(resp.data);
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }*/





  /// *** Project Details by Project ID ***///
  Rx<ProjectDetailsById> projectDetailsById = ProjectDetailsById().obs;

  Future <void> getMyProjectListByID(String projectId) async {
    //showLoadingDialog(isDismissible: true);
    await APIRepository().getProjectDetailsByID(projectId).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {

          projectDetailsById.value = ProjectDetailsById.fromJson(resp.data);
          //debugPrint("RokanFarabiprojectDetailsById: ${projectDetailsById.value.name.toString()}");

        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }









  /// *** PCR Attachment Evidence Data ***///
  // Rx<PcrAttachmentViewResponse> pcrAttachmentViewResponse = PcrAttachmentViewResponse().obs;
  /*RxList<PcrAttachmentViewResponse> pcrAttachmentViewListResponse =
      <PcrAttachmentViewResponse>[].obs;

  void getPCRAttachmentEvidenceData(String? projectId) {
    APIRepository().getPcrAttachmentViewData(projectId!).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          List<dynamic> data = resp.data;
          for (var element in data) {
            final event = PcrAttachmentViewResponse.fromJson(element);
            pcrAttachmentViewListResponse.add(event);
            *//*       if (event.roleName == 'pd') {
              pcrAttachmentViewListResponse.add(event);
            }*//*
          }
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      // pcrAttachmentViewResponse.clear();
      showToast(err.toString());
    });
  }*/


  RxList<PcrAttachmentViewResponse> pcrAttachmentViewListResponse = <PcrAttachmentViewResponse>[].obs;

  Future <void> getPCRAttachmentEvidenceData(String? projectId) async {
    await APIRepository().getPcrAttachmentViewData(projectId!).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          List<dynamic> data = resp.data;
          for (var element in data) {
            final event = PcrAttachmentViewResponse.fromJson(element);
            pcrAttachmentViewListResponse.add(event);
            /*       if (event.roleName == 'pd') {
              pcrAttachmentViewListResponse.add(event);
            }*/
          }
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      // pcrAttachmentViewResponse.clear();
      showToast(err.toString());
    });
  }







/*  String? pcrStatusResponseMessage = "";

  void getPcrOnlyReceivedStatus(String? projectId) {
    showLoadingDialog();
    APIRepository().pcrReceivedStatus(projectId!).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        // showToast(resp.message);

        pcrStatusResponseMessage = resp.message.toString();
      } else {
        showToast(resp.message);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }*/

  Rx<UploadFileResponse> uploadFileResponse = UploadFileResponse().obs;

  void uploadImageFile({String? projectId, File? imageFile}) {
    // if (imageFile!=null) {
    //   showToast("image_empty_message".tr);
    //   return;
    // }
// if (kDebugMode) {
//   print(projectImage.value.toString());
// }
    showLoadingDialog();
    showToast('Image Uploading....', isLong: true);
//     showLoadingDialogWithText();
    APIRepository().uploadFile(imageFile!).then((resp) {
      hideLoadingDialog();
      // showToast(resp.message);
      if (resp.status == "success") {
        // Get.back();
        // clearImageView();
        // final list = List.from(resp.data.map)
        List<UploadFileResponse> list = List<UploadFileResponse>.from(
            resp.data!.map((x) => UploadFileResponse.fromJson(x)));

        // uploadFileResponse.addAll(list);
        // uploadFileResponse.value = UploadFileResponse.fromJson(resp.data);
        uploadFileResponse.value = list.first;

        var fileName = uploadFileResponse.value.fileName.toString();
        var fileId = uploadFileResponse.value.fileId.toString();

        if (uploadFileResponse.value.fileId!.isNotEmpty) {
          // evidenceFileSync(projectId!, fileName, fileId);
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }
}
