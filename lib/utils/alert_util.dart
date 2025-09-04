import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import '../data/models/pcr_attachment_view.dart';
import 'button_util.dart';
import 'common_utils.dart';
import 'decorations.dart';
import 'dimens.dart';
import 'image_util.dart';

void alertDialogViewForPCREvidence({
  BuildContext? context,
  String? title,
  String? imageSrc,
  String? fileId,
  String? receivedDate,
  String? remarks,
  Color? messageColor,
}) {
  String encodedToken = Uri.encodeComponent(fullToken);
  String? imageSrc =
      '${APIConstants.baseUrl.toString()}${APIConstants.projectImagePathEndUrl.toString()}$fileId?t=$encodedToken';

  // imageSrc = imageSrc ?? "https://images.pexels.com/photos/1772973/pexels-photo-1772973.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260";
  showModalSheet(
      context!,
      Column(
        children: [
          if (title != null && title.isNotEmpty)
            textAutoSize(
                text: title,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                maxLines: 2),
          dividerHorizontal(),
          // if (message != null && message.isNotEmpty) textAutoSize(text: message, maxLines: 10, color: messageColor),

          Container(
            height: Get.width / 2.5,
            width: Get.width / 2.5,
            decoration: boxDecorationRoundShadow(color: Colors.transparent),
            padding: const EdgeInsets.all(dp0),
            child: GestureDetector(
                onTap: () {
                  showModalSheetFullScreenForGalleryFinal(context,
                      // item: filesEvidenceResponseList,
                      imageSrc: imageSrc);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7.0),
                  child: showCachedNetworkImage(imageSrc.toString()),
                )),
          ),
          const Divider(),
          // twoSidedTextWithColon2(
          //     leftText: "PCRUploadedBy".tr,
          //     rightText: 'Mr. User'),
          // const Divider(),
          twoSidedTextWithColon2(
              leftText: "ReceivedDate".tr, rightText: receivedDate ?? ""),
          const SizedBox(height: 30),
          twoSidedTextWithColon2(
            leftText: "Remarks".tr,
            rightText: remarks ?? "",
            maxLineForRightText: 10,
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: buttonRoundedMain(
                text: "ok".tr,
                height: 40,
                width: Get.width / 4,
                onPressCallback: () {
                  // Get.back();
                  Navigator.pop(context);
                }),
          ),
          const SizedBox(height: 10),
        ],
      ));
}

void alertForInfo(
    {BuildContext? context,
    String? title,
    String? message,
    Color? messageColor}) {
  showModalSheet(
      context!,
      Column(
        children: [
          if (title != null && title.isNotEmpty)
            textAutoSize(
                text: title,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                maxLines: 2),
          dividerHorizontal(),
          if (message != null && message.isNotEmpty)
            textAutoSize(text: message, maxLines: 10, color: messageColor),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.centerRight,
            child: buttonRoundedMain(
                text: "ok".tr,
                height: 40,
                width: Get.width / 4,
                onPressCallback: () {
                  Get.back();
                }),
          ),
          const SizedBox(height: 10),
        ],
      ));
}

alertForLocationConfirm(BuildContext context,
    {String? title,
    String? message,
    Color? messageColor,
    String? buttonTitle,
    VoidCallback? onConfirm}) {
  showModalSheet(
      context,
      Column(
        children: [
          if (title != null && title.isNotEmpty)
            textAutoSize(
                text: title,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                maxLines: 2),
          dividerHorizontal(),
          if (message != null && message.isNotEmpty)
            textAutoSize(
                text: message,
                maxLines: 10,
                textAlign: TextAlign.center,
                color: messageColor),
          const SizedBox(height: 20),
          buttonRoundedMain(
              height: 40,
              text: buttonTitle ?? "Accept".tr,
              onPressCallback: onConfirm)
        ],
      ));
}

void alertForLogOut(VoidCallback okAction) {
  Get.defaultDialog(
    title: "",
    radius: dp10,
    backgroundColor: Get.theme.colorScheme.surface,
    content: SizedBox(
      height: dp150,
      width: Get.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          textAutoSize(text: "Logout".tr, fontWeight: FontWeight.bold),
          const VSpacer10(),
          textAutoSize(text: "LogoutText".tr),
          const VSpacer10(),
          buttonRoundedMain(
              height: 40,
              text: "Yes".tr,
              onPressCallback: okAction,
              width: Get.width / 2)
        ],
      ),
    ),
  );
}


void alertForLogOutLanding({VoidCallback? okAction, VoidCallback? noAction}) {
  Get.defaultDialog(
    title: "",
    radius: dp10,
    backgroundColor: Get.theme.colorScheme.surface,
    //backgroundColor: Get.theme.backgroundColor,
    content: SizedBox(
      height: dp150,
      width: Get.width,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              textAutoSize(
                  textAlign: TextAlign.center,
                  text: 'Logout'.tr,
                  fontSize: 22),
              const SizedBox(height: dp10),
              textAutoSize(
                  text: "LogoutText".tr,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  fontSize: dp15),
              const SizedBox(height: dp10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonRoundedMain(
                      text: "Yes".tr,
                      height: 40,
                      textColor: Colors.white,
                      onPressCallback: okAction,
                      width: Get.width / 3.5),
                  buttonRoundedMain(
                      text: "No".tr,
                      height: 40,
                      textColor: Colors.white,
                      onPressCallback: noAction,
                      width: Get.width / 3.5)
                ],
              )
            ],
          ),
          Positioned(
            // top: 40,
            // right: 16,
              child: showImageAsset(
                  onPressCallback: () {
                    Get.back();
                  },
                  imagePath: AssetConstants.icCross,
                  height: dp20,
                  color: Get.theme.colorScheme.surface))
          //color: Get.theme.backgroundColor))
        ],
      ),
    ),
  );
}




void showModalSheet(BuildContext context, Widget customView,
    {Function? onClose}) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Container(
            //       padding: const EdgeInsets.symmetric(horizontal: 20),
            //       child: buttonOnlyIcon(
            //           iconColor: Get.theme.backgroundColor,
            //           iconPath: AssetConstants.icCross,
            //           size: dp20,
            //           onPressCallback: () {
            //             Get.back();
            //             if (onClose != null) {
            //               onClose();
            //             }
            //           }),
            //     ),
            //     // const SizedBox(width: 20)
            //   ],
            // ),
            Container(
                width: Get.width,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(20),
                decoration: boxDecorationRoundCorner(),
                child: customView)
          ],
        );
      });
}
