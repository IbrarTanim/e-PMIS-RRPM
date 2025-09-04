import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pmis_flutter/data/db/models/asset_collection.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/upload_file_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

import '../../../../data/models/files_evidence_response_list.dart';
import '../../../../data/models/list_response.dart';
import 'image_gallery_controller.dart';

class SurveyGalleryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  final tabSelectedIndex = 0.obs;
  String? successUploadMessage;

  TextEditingController captionTextEditController = TextEditingController();

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 2);
    super.onInit();
  }

  final _imageGalleryController = Get.put(ImageGalleryController());

/*  final _imageGalleryController = Get.put(ImageGalleryController());

  Future<void> getData() async {
    // getList();
    _imageGalleryController.getFilesEvidenceListForImageView(allProjectsResponse.projectId.toString(), false);
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }*/

  // Rx<File> projectImage = File("").obs;
  Rx<File> projectVideo = File("").obs;

  Rx<UploadFileResponse> uploadFileResponse = UploadFileResponse().obs;

  // void uploadFile() {
  //   showLoadingDialog();
  //   APIRepository().uploadFile(projectImage.value).then((resp) {
  //     hideLoadingDialog();
  //     showToast(resp.message);
  //     if (resp.success) {
  //       Get.back();
  //     }
  //   }, onError: (err) {
  //     hideLoadingDialog();
  //     showToast(err.toString());
  //   });
  // }

  // void clearImageView() {
  //   if (projectImage.value.path
  //       .contains(AssetConstants.pathTempProjectImageName)) {
  //     projectImage.value.delete();
  //   }
  //   projectImage.value = File("");
  // }

  void clearVideoView() {
    if (projectVideo.value.path
        .contains(AssetConstants.pathTempProjectVideoName)) {
      projectVideo.value.delete();
    }
    projectVideo.value = File("");
  }

  void uploadImageFile(
      {String? projectId,
        File? imageFile,
        String? latitude,
        String? longitude,
        VoidCallback? onUploadComplete}) {
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
          evidenceFileSync(projectId!, fileName, fileId, latitude!, longitude!,
              onUploadComplete);
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  addSynchronized() async {
    Hive.box<AssetCollection>('image').add(
      AssetCollection(isImageSynchronized: true),
    );
    Get.back();
  }

  void evidenceFileSync(
      String projectId,
      String fileName,
      String fileId,
      String latitude,
      String longitude,
      VoidCallback? onUploadComplete,
      ) {
    showLoadingDialog();
    APIRepository()
        .myProjectsEvidenceFileSync(
        projectId, fileName, fileId, latitude, longitude)
        .then((resp) {
      if (resp.status == "success") {
        //addSynchronized;
        //addSynchronized();
        showToast(resp.message);
        successUploadMessage = resp.message;
        //await _imageGalleryController.getFilesEvidenceListForImageView(widget.allProjectsResponse!.projectId.toString(), false);

        // setState(() {
        //   address =
        //   '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
        // });
        // clearImageView();
        // Get.find<MyProjectController>().allProjectsResponseList.value. = allProjectsResponseList!;
      } else {
        showToast(resp.message);
      }
      _imageGalleryController.getFilesEvidenceListForImageView(
          projectId, false);
      onUploadComplete?.call();
      //hideLoadingDialog();
    }, onError: (err, s) {
      _imageGalleryController.getFilesEvidenceListForImageView(
          projectId, false);
      onUploadComplete?.call();
      //hideLoadingDialog();
      //showToast(err.toString());
    });
  }

/*  void uploadImageFileOld(String projectId) {
    if (projectImage.value.path.isEmpty) {
      showToast("image_empty_message".tr);
      return;
    }
// if (kDebugMode) {
//   print(projectImage.value.toString());
// }
    showLoadingDialog();
    APIRepository().uploadFile(projectImage.value).then((resp) {
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
          // evidenceFileSync(projectId,fileName,fileId);
          evidenceFileSync(projectId, fileName, fileId);
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }*/

  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  getFileSize2(String filepath) async {
    final file = File(filepath.split('/').last);
    int sizeInBytes = file.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    if (sizeInMb > 20000) {
      showToast("video_file_size_alert_message".tr);
    }
  }

/*  void uploadFileVideo(String projectId) {
    //   print("FileSize: "+getFileSize(projectVideo.value.path, 1));
    //
    // if(
    // getFileSize(projectVideo.value.path, 1) > 20000){
    //   showToast("video_file_size_alert_message".tr);
    //   return;
    // }
    // getFileSize2(projectVideo.value.path);
    if (projectVideo.value.path.isEmpty) {
      showToast("video_empty_message".tr);
      return;
    }
// if (kDebugMode) {
//   print(projectImage.value.toString());
// }
    showLoadingDialog();
    APIRepository().uploadFile(projectVideo.value).then((resp) {
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
          evidenceFileSync(projectId, fileName, fileId);
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }*/

  // Rx<ListResponse> listResponse = ListResponse().obs;
  // RxList<FilesEvidenceResponseList> filesEvidenceResponseList = <FilesEvidenceResponseList>[].obs;
  //
  // bool isDataLoaded = false;
  //
  // int loadedPage = 0;
  // bool hasMoreData = true;
  // bool isLoading = true;

  void clearView() {
    captionTextEditController.text = "";
    // loadedPage = 0;
    // hasMoreData = true;
    // filesEvidenceResponseList.clear();
  }
/*  /// *** Files Evidence Image List Data ***/ /*//
  void getFilesEvidenceListForImageView(String projectId,bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      filesEvidenceResponseList.clear();
      isLoading = false;
    }
    isLoading = true;
    showLoadingDialog();
    var allItems = filesEvidenceResponseList.length;
    APIRepository().getFilesEvidenceListForImageView(projectId, loadedPage).then((resp) {
      isLoading = false;
      hideLoadingDialog();
      if (resp.status == "success") {
        // loadedPage++;
        // ListResponse response = ListResponse.fromJson(resp.data);
        listResponse.value = ListResponse.fromJson(resp.data);
        var response = listResponse.value;
        if (response.lists != null && response.lists!.isNotEmpty) {
          List<FilesEvidenceResponseList> list = List<FilesEvidenceResponseList>.from(
              response.lists!.map((x) => FilesEvidenceResponseList.fromJson(x)));
          filesEvidenceResponseList.addAll(list);
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
      filesEvidenceResponseList.clear();
      showToast(err.toString());
    });
  }*/
}
