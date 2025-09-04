import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/ui/features/root/root_screen.dart';
import 'package:pmis_flutter/utils/alert_util.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

import '../../../../data/models/upload_file_response.dart';

class AddPCRController extends GetxController {
  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }

  void clearInputData() {
    dateTextEditController.text = "";
    remarksEditController.text = "";
    imageShootingDate = "";
    imageShootingTime = "";
  }

  TextEditingController dateTextEditController = TextEditingController();
  TextEditingController remarksEditController = TextEditingController();
  String? imageShootingDate;
  String? imageShootingTime;

  void clearView() {}

  Rx<UploadFileResponse> uploadFileResponse = UploadFileResponse().obs;

  void uploadPcrImageFile(
      {BuildContext? context,
      String? projectId,
      File? imageFile,
      String? remarks,
      String? receivedDate}) {
    showLoadingDialog();
    // showToast('Image Uploading....',isLong: true);
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
          pcrFileAttachment(
              projectId!, remarks!, fileId, fileName, receivedDate!);
        }

/*        alertForInfo(
            context: context,
            title: 'PCR Evidence'.tr,
            message: 'Please wait! PCR evidence uploading......');
        showLoadingDialog();*/
        showToast('PCRUploadingText'.tr, isLong: true);
        showLoadingDialog();
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  String? successUploadMessage;

  void pcrFileAttachment(String projectId, String remarks, String fileId,
      String fileName, String receivedDate) {
    showLoadingDialog();
    APIRepository()
        .pcrFileAttachment(projectId, remarks, fileId, fileName)
        .then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        // showToast(resp.message);
        successUploadMessage = resp.message;

        if (receivedDate.isNotEmpty) {
          pcrReceivedDateUpload(projectId, receivedDate);
        }

        // setState(() {
        //   address =
        //   '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
        // });
        // clearImageView();
        // Get.find<MyProjectController>().allProjectsResponseList.value. = allProjectsResponseList!;
      } else {
        showToast(resp.message);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  void pcrReceivedDateUpload(String projectId, String receivedDate) {
    showLoadingDialog();
    APIRepository()
        .pcrReceivedDateUploadAndReceivedStatus(projectId, receivedDate)
        .then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        clearInputData();
        showToast(resp.message);
        successUploadMessage = resp.message;

        Get.to(() => const RootScreen());

        // setState(() {
        //   address =
        //   '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
        // });
        // clearImageView();
        // Get.find<MyProjectController>().allProjectsResponseList.value. = allProjectsResponseList!;
      } else {
        showToast(resp.message);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }
}
