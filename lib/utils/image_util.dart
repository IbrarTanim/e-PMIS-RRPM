import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:images_picker/images_picker.dart';
import 'button_util.dart';
import 'common_utils.dart';
import 'common_widget.dart';
import 'decorations.dart';
import 'dimens.dart';

Widget showImageNetwork(String? imagePath,
    {double? width,
    double? height,
    VoidCallback? onPressCallback,
    BoxFit? boxFit = BoxFit.cover,
    bool noErrorImg = false}) {
  imagePath = imagePath ?? "";
  return InkWell(
    onTap: onPressCallback,
    child: imagePath.isNotEmpty
        ? imagePath.contains(".svg")
            ? SvgPicture.network(imagePath,
                fit: boxFit!, width: width, height: height
                //   placeholderBuilder: (BuildContext context) {
                //   return Image.asset(AssetConstants.noImage, width: width, height: height, fit: boxFit);
                // }
                )
            : Image.network(
                imagePath,
                fit: boxFit!,
                width: width,
                height: height,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return noErrorImg
                      ? Container(
                          color: Get.theme.primaryColorLight.withOpacity(0.25),
                          width: width,
                          height: height)
                      : Image.asset(AssetConstants.noImage,
                          width: width, height: height, fit: boxFit);
                },
              )
        : (noErrorImg
            ? Container(
                color: Get.theme.primaryColorLight.withOpacity(0.25),
                width: width,
                height: height)
            : Image.asset(AssetConstants.noImage,
                width: width, height: height, fit: boxFit)),
  );
}

Widget showImageFile(File file, {double? width, double? height}) {
  return Image.file(file, width: width, height: height, fit: BoxFit.cover);
}

Widget showImageAsset(
    {IconData? icon,
    String? imagePath = "",
    double? width,
    double? height,
    VoidCallback? onPressCallback,
    Color? color,
    BoxFit? boxFit = BoxFit.contain,
    double? iconSize}) {
  return InkWell(
    onTap: onPressCallback,
    child: imagePath!.isNotEmpty
        ? imagePath.contains(".svg")
            ? SvgPicture.asset(imagePath,
                fit: boxFit!, width: width, height: height, color: color)
            : Image.asset(imagePath,
                fit: boxFit!, width: width, height: height, color: color)
        : Icon(icon!, size: iconSize, color: color),
  );
}

Widget showCircleImageNetwork(String? url,
    {double size = 90, double borderSize = 2, Color? bgColor}) {
  url = url ?? "";
  bgColor = bgColor ?? Get.theme.primaryColorLight;
  return ClipOval(
    child: Container(
      width: size,
      height: size,
      decoration: boxDecorationRoundBorder(
          bgColor: bgColor,
          borderColor: Get.theme.primaryColor,
          borderWidth: borderSize,
          radius: size / 2),
      child: url.contains(".svg")
          ? SvgPicture.network(url, fit: BoxFit.contain)
          : Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset(AssetConstants.noImage, fit: BoxFit.cover);
              },
            ),
    ),
  );
}

Widget showCircleImageAsset(String path,
    {double size = 90, double borderSize = 2, Color? color, Color? bgColor}) {
  bgColor = bgColor ?? Get.theme.primaryColorLight;
  return ClipOval(
      child: Container(
          width: size,
          height: size,
          padding: EdgeInsets.all(borderSize),
          decoration: boxDecorationRoundBorder(
              bgColor: bgColor,
              borderColor: Get.theme.primaryColor,
              borderWidth: borderSize,
              radius: size / 2),
          child: path.contains(".svg")
              ? SvgPicture.asset(path, fit: BoxFit.contain, color: color)
              : Image.asset(path, fit: BoxFit.cover, color: color)));
}

Widget showCircleImageFile(File file, {double size = 90}) {
  return ClipOval(
      child: Image.file(file, width: size, height: size, fit: BoxFit.cover));
}

Widget showCachedNetworkImage(String? url,
    {double width = dp90, double height = dp90}) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    child: CachedNetworkImage(
      imageUrl: url ?? "",
      width: width,
      height: height,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          SvgPicture.asset(AssetConstants.icNoImage),
      errorWidget: (context, url, error) {
        return SvgPicture.asset(AssetConstants.icNoImage);
      },
    ),
  );
}

imageViewNetwork(
    {IconData? icon,
    String? imagePath,
    double? width,
    double? height,
    VoidCallback? onPressCallback,
    Color? iconColor,
    BoxFit? boxFit = BoxFit.contain,
    double? iconSize}) {
  return InkWell(
    onTap: onPressCallback,
    child: imagePath!.isNotEmpty
        ? imagePath.contains(".svg")
            ? SvgPicture.network(imagePath,
                fit: boxFit!, width: width, height: height, color: iconColor)
            : Image.network(imagePath,
                fit: boxFit!, width: width, height: height)
        : Icon(icon!, size: iconSize, color: iconColor),
  );
}


void showImageChooser(BuildContext context, Function(File, bool) onChoose) {
  hideKeyboard(context);
  changePhotoModalBottomSheet(
      onPressTakePicture: () {
        Get.back();
        getImage(false, onChoose);
      },
      onPressChoosePicture: () {
        Get.back();
        getImage(true, onChoose);
      },
      width: Get.width * 0.85);
      /*onPressTakePicture: () async {
        ///Multiple permission
        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
          Permission.camera,
          Permission.mediaLibrary,
          //add more permission to request here.
        ].request();
        if (statuses[Permission.camera] == PermissionStatus.granted &&
            statuses[Permission.storage] == PermissionStatus.granted &&
            statuses[Permission.mediaLibrary] == PermissionStatus.granted) {
          showToast("Thanks, permission granted.");
          Get.back();
          getImage(false, onChoose);
        } else if (statuses[Permission.camera] == PermissionStatus.denied &&
            statuses[Permission.storage] == PermissionStatus.denied &&
            statuses[Permission.mediaLibrary] == PermissionStatus.denied) {
          // showToast("This permission is recommended.");
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("This permission is recommended.")));
        } else if (statuses[Permission.camera] == PermissionStatus.permanentlyDenied &&
            statuses[Permission.storage] == PermissionStatus.permanentlyDenied &&
            statuses[Permission.mediaLibrary] == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }else if(statuses[Permission.camera] == PermissionStatus.restricted &&
            statuses[Permission.storage] == PermissionStatus.restricted &&
            statuses[Permission.mediaLibrary] == PermissionStatus.restricted){
          //permission is OS restricted.
          showToast("Permission is OS restricted.");
        }

        debugPrint(statuses.toString());

        ///Single permission
*//*        var cameraStatus = await Permission.camera.request();
        var storageStatus = await Permission.storage.request();

        if (cameraStatus == PermissionStatus.granted &&
            storageStatus == PermissionStatus.granted) {
          Get.back();
          getImage(false, onChoose);
        }
        if (cameraStatus == PermissionStatus.denied &&
            storageStatus == PermissionStatus.denied) {
          showToast("This permission is recommended.");
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("This permission is recommended.")));
        }
        if (cameraStatus == PermissionStatus.permanentlyDenied &&
            storageStatus == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
        debugPrint(cameraStatus.toString());
        debugPrint(storageStatus.toString());*//*

        ///Single permission one by one
*//*        var cameraStatus, storageStatus;
         cameraStatus = await Permission.camera.request();
        if (cameraStatus == PermissionStatus.granted) {
          storageStatus = await Permission.storage.request();
          if (storageStatus == PermissionStatus.granted) {
            Get.back();
            getImage(false, onChoose);
          }
        }
        if (cameraStatus == PermissionStatus.denied &&
            storageStatus == PermissionStatus.denied) {
          showToast("This permission is recommended.");
          // ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(content: Text("This permission is recommended.")));
        }
        if (cameraStatus == PermissionStatus.permanentlyDenied &&
            storageStatus == PermissionStatus.permanentlyDenied) {
          openAppSettings();
        }
        debugPrint("cameraStatus: $cameraStatus");
        debugPrint("storageStatus: $storageStatus");*//*


      },*/
}
// void showImageChooser(BuildContext context, Function(File, bool) onChoose) {
//   hideKeyboard(context);
//   changePhotoModalBottomSheet(
//       onPress: () async{
//
//         Get.back();
//         getImage(false, onChoose);
//       },
//       onPress2: () {
//         Get.back();
//         getImage(true, onChoose);
//       },
//       width: Get.width * 0.85);
// }

void showVideoChooser(BuildContext context, Function(File, bool) onChoose) {
  hideKeyboard(context);
  changeVideoModalBottomSheet(() {
    Get.back();
    getVideo(false, onChoose);
  }, () {
    Get.back();
    getVideo(true, onChoose);
  }, width: Get.width * 0.85);
}

Future getImage(bool isGallery, Function(File, bool) onChoose) async {
  if (isGallery) {
    List<Media>? res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.image,
      language: Language.System,
      cropOpt: CropOption(
        aspectRatio: const CropAspectRatio(3, 2),
      ),
      quality: 0.5,
      // only for android
      maxSize: 2000, // only for ios (kb)
    );
    if (res != null) {
      var file = File(res[0].path);
      onChoose(file, isGallery);
    }
    // if (res != null) {
    //   var file = File(res[0].path);
    //   Uint8List imageFile = await file.readAsBytes();
    //   File(res[0].path).writeAsBytes(imageFile);
    // }
  } else {
    List<Media>? res = await ImagesPicker.openCamera(
      pickType: PickType.image,
      cropOpt: CropOption(
        aspectRatio: const CropAspectRatio(3, 2),
      ),
      quality: 0.5, // only for android
      maxSize: 2000, // only for ios (kb)
    );
    if (res != null) {
      var file = File(res.first.path);
      onChoose(file, isGallery);
      //save file to album
      // ImagesPicker.saveImageToAlbum(file, albumName: "Project Image");
    }
  }
}

Future getVideo(bool isGallery, Function(File, bool) onChoose) async {
  if (isGallery) {
    List<Media>? res = await ImagesPicker.pick(
      count: 1,
      pickType: PickType.video,
      language: Language.System,
      // cropOpt: CropOption
      //   aspectRatio: const CropAspectRatio(3, 2),
      // ),
      // quality: 0.5, // only for android
      // maxSize: 20000, // only for ios (kb)
    );
    if (res != null) {
      var file = File(res[0].path);
      onChoose(file, isGallery);
    }
  } else {
    List<Media>? res = await ImagesPicker.openCamera(
      pickType: PickType.video,
      // cropOpt: CropOption(
      //   aspectRatio: const CropAspectRatio(3, 2),
      // ),
      quality: 0.5, // only for android
      // maxSize: 20000, // only for ios (kb)
    );
    if (res != null) {
      var file = File(res.first.path);
      onChoose(file, isGallery);
      //save file to album
      // ImagesPicker.saveVideoToAlbum(file, albumName: "Project Video");
    }
  }
}

// void showImageChooser(BuildContext context, Function(File, bool) onChoose, {ImageRatio? imageRatio}) {
//   hideKeyboard(context);
//   changePhotoModalBottomSheet(() {
//     Get.back();
//     getImage(false, onChoose, imageRatio);
//   }, () {
//     Get.back();
//     getImage(true, onChoose, imageRatio);
//   }, width: Get.width * 0.85);
// }
//
// Future getImage(bool isGallery, Function(File, bool) onChoose, ImageRatio? imageRatio) async {
//   if (isGallery) {
//     List<Media>? res = await ImagesPicker.pick(
//       count: 1,
//       pickType: PickType.image,
//       language: Language.System,
//       cropOpt: imageRatio == null
//           ? CropOption(aspectRatio: const CropAspectRatio(2, 2))
//           : CropOption(aspectRatio: CropAspectRatio(imageRatio.x, imageRatio.y)),
//     );
//     if (res != null) {
//       var file = File(res[0].path);
//       onChoose(file, isGallery);
//     }
//   } else {
//     List<Media>? res = await ImagesPicker.openCamera(
//       pickType: PickType.image,
//       cropOpt: imageRatio == null
//           ? CropOption(aspectRatio: const CropAspectRatio(2, 2))
//           : CropOption(aspectRatio: CropAspectRatio(imageRatio.x, imageRatio.y)),
//       quality: 0.5,
//     );
//     if (res != null) {
//       var file = File(res.first.path);
//       onChoose(file, isGallery);
//     }
//   }
// }
changePhotoModalBottomSheet(
    {VoidCallback? onPressTakePicture,
    VoidCallback? onPressChoosePicture,
    double width = 0}) {
  var indent = (Get.width - width) / 2;
  return Get.bottomSheet(
    Container(
        alignment: Alignment.bottomCenter,
        //height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buttonRoundedMain(
                text: "Take a picture".tr,
                onPressCallback: onPressTakePicture,
                width: width),
            dividerHorizontal(height: 5, indent: indent),
            buttonRoundedMain(
                text: "Choose a picture".tr,
                onPressCallback: onPressChoosePicture,
                width: width),
            dividerHorizontal(height: 5, indent: indent),
            buttonRoundedMain(
                text: "Cancel".tr,
                onPressCallback: () {
                  Get.back();
                },
                width: width,
                bgColor: Get.theme.primaryColor),
            const SizedBox(height: 5)
          ],
        )),
    isDismissible: true,
  );
}

changeVideoModalBottomSheet(VoidCallback onPress, VoidCallback onPress2,
    {double width = 0}) {
  var indent = (Get.width - width) / 2;
  return Get.bottomSheet(
    Container(
        alignment: Alignment.bottomCenter,
        //height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buttonRoundedMain(
                text: "Take a video".tr,
                onPressCallback: onPress,
                width: width),
            dividerHorizontal(height: 5, indent: indent),
            buttonRoundedMain(
                text: "Choose a video".tr,
                onPressCallback: onPress2,
                width: width),
            dividerHorizontal(height: 5, indent: indent),
            buttonRoundedMain(
                text: "Cancel".tr,
                onPressCallback: () {
                  Get.back();
                },
                width: width,
                bgColor: Get.theme.primaryColor),
            const SizedBox(height: 5)
          ],
        )),
    isDismissible: true,
  );
}

// void saveFileOnTempPath(File chooseFile) async {
//   getImageDirectoryPath(AssetConstants.pathTempImageFolder).then((tempPath) {
//     // if(_controller.profileImage.value.path.contains(AssetConstants.pathTempProfileImageName)){
//     //   _controller.profileImage.value.deleteSync();
//     // }
//     // File(tempPath).createSync(recursive: true);
//     // File newFile = chooseFile.copySync(tempPath);
//     // chooseFile.deleteSync();
//     // _controller.profileImage.value = newFile;
//   });
// }

Future<String> getImageDirectoryPath(String path) async {
  Directory appDocDir = await getApplicationDocumentsDirectory();
  return "${appDocDir.path}${AssetConstants.pathTempImageFolder}${DateTime.now().millisecondsSinceEpoch}$path";
}

Future<String> getImageOnlyFile(String image) async {
  // Directory appDocDir = await getApplicationDocumentsDirectory();
  return image;
}

class ImageRatio {
  int x;
  int y;

  ImageRatio(this.x, this.y);
}

Future<MultipartFile> makeMultipartFileFromImage(File file) async {
  List<int>? arrayData = await file.readAsBytes();
  // MultipartFile multipartFile = MultipartFile(arrayData, filename: file.path);
  MultipartFile multipartFile = MultipartFile(arrayData, filename: file.path.split('/').last);
  return multipartFile;
}
