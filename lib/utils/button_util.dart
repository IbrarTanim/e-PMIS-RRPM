import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import 'dimens.dart';

Widget buttonRoundedMain(
    {required String text,
    VoidCallback? onPressCallback,
    Color? textColor,
    Color? bgColor,
    Color? borderColor,
    double elevation = 10,
    double? width,
    double height = dp55,
    double? hMargin,
    double? vMargin,bool? hasIcon}) {
  width = width ?? Get.width / 2;
  bgColor = bgColor ?? Get.theme.primaryColor;
  borderColor = borderColor ?? bgColor;
  hasIcon == false;
  return Container(
      margin: EdgeInsets.symmetric(
          vertical: vMargin ?? 0, horizontal: hMargin ?? 16),
      height: height,
      width: width,
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(elevation),
              foregroundColor: MaterialStateProperty.all<Color>(bgColor),
              backgroundColor: MaterialStateProperty.all<Color>(bgColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      side: BorderSide(color: borderColor)))),
          onPressed: onPressCallback,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              hasIcon == true ? Row(
                children: [
                  showImageAsset(imagePath: AssetConstants.icUpload,height: 20,width: 20,color: Colors.white),
                  const HSpacer5(),
                ],
              ) : const SizedBox(width: 0,height: 0),
              AutoSizeText(text,
                  style: Get.theme.textTheme.labelLarge!.copyWith(color: textColor)),
            ],
          )));
}

Widget buttonRoundedWithPressed(
    {required String text,
      VoidCallback? onPressCallback,
      Color? textColor,
      Color? bgColor,
      Color? borderColor,
      double elevation = 10,
      double? width,
      double height = dp55,
      double? hMargin,
      double? vMargin,
      bool? hasIcon,
      bool? isPressed,
      String? pressedText}) {
  width = width ?? Get.width / 2;
  bgColor = bgColor ?? Get.theme.primaryColor;
  borderColor = borderColor ?? bgColor;
  hasIcon == false;
  isPressed == false;
  return Container(
      margin: EdgeInsets.symmetric(
          vertical: vMargin ?? 0, horizontal: hMargin ?? 16),
      height: height,
      width: width,
      child: isPressed!
          ? textAutoSize(text: pressedText!)
          : ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all<double>(elevation),
              foregroundColor: MaterialStateProperty.all<Color>(bgColor),
              backgroundColor: MaterialStateProperty.all<Color>(bgColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(7)),
                      side: BorderSide(color: borderColor)))),
          onPressed: onPressCallback,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              hasIcon == true
                  ? Row(
                children: [
                  showImageAsset(
                      imagePath: AssetConstants.icUpload,
                      height: 20,
                      width: 20,
                      color: Colors.white),
                  const HSpacer5(),
                ],
              )
                  : const SizedBox(width: 0, height: 0),
              AutoSizeText(text,
                  style: Get.theme.textTheme.labelLarge!
                      .copyWith(color: textColor)),
            ],
          )));
}

Widget buttonBordered(
    {String? text,
    String? iconPath,
    VoidCallback? onPressCallback,
    double width = 0,
    Color? textColor,
    Color? bgColor,
    Color? borderColor,
    double margin = 10}) {
  double buttonWidth = width == 0 ? Get.width : width;
  bgColor = bgColor ?? Get.theme.scaffoldBackgroundColor;
  borderColor = borderColor ?? bgColor;
  textColor = textColor ?? Get.theme.primaryColorDark;
  return Container(
      margin: EdgeInsets.all(margin),
      height: 55,
      width: buttonWidth,
      child: OutlinedButton(
        onPressed: onPressCallback,
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(bgColor),
            backgroundColor: MaterialStateProperty.all<Color>(bgColor),
            side: MaterialStateProperty.all(BorderSide(
                color: borderColor, width: 1.0, style: BorderStyle.solid)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(7))))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (iconPath != null && iconPath.isNotEmpty)
                ? SvgPicture.asset(iconPath, height: 25, color: textColor)
                : const SizedBox(),
            const SizedBox(width: 10),
            (text == null || text.isEmpty)
                ? const SizedBox()
                : AutoSizeText(text,
                    style: Get.textTheme.labelLarge!.copyWith(color: textColor),
                    maxLines: 1),
          ],
        ),
      ));
}

// Widget buttonBordered(
//     {String? text, String? iconPath, VoidCallback? onPressCallback, double width = 0, Color? textColor, Color? bgColor, Color? borderColor}) {
//   double buttonWidth = width == 0 ? Get.width : width;
//   bgColor = bgColor ?? Get.theme.scaffoldBackgroundColor;
//   borderColor = borderColor ?? bgColor;
//   textColor = textColor ?? Get.theme.primaryColorDark;
//   return Container(
//       margin: const EdgeInsets.all(7),
//       height: 55,
//       width: buttonWidth,
//       child: OutlinedButton.icon(
//         icon: (iconPath != null && iconPath.isNotEmpty) ? SvgPicture.asset(iconPath, height: 25, color: textColor) : const SizedBox(),
//         label: (text == null || text.isEmpty)
//             ? const SizedBox()
//             : AutoSizeText(text, style: Get.textTheme.button!.copyWith(color: textColor, fontSize: 14), maxLines: 1),
//         onPressed: onPressCallback,
//         style: ButtonStyle(
//             foregroundColor: MaterialStateProperty.all<Color>(bgColor),
//             backgroundColor: MaterialStateProperty.all<Color>(bgColor),
//             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(7)), side: BorderSide(color: borderColor)))),
//       ));
// }

Widget buttonOnlyIcon(
    {VoidCallback? onPressCallback,
    String iconPath = "",
    double size = dp25,
    double? viewSize,
    Color? iconColor,
    visualDensity = VisualDensity.compact,
    Color? bgColor}) {
  return Container(
    color: bgColor,
    height: viewSize,
    width: viewSize,
    child: IconButton(
      padding: EdgeInsets.zero,
      visualDensity: visualDensity,
      onPressed: onPressCallback,
      icon: iconPath.isNotEmpty
          ? iconPath.contains(".svg")
              ? SvgPicture.asset(
                  iconPath,
                  width: size,
                  height: size,
                  color: iconColor,
                )
              : Image.asset(
                  iconPath,
                  width: size,
                  height: size,
                  color: iconColor,
                )
          : const SizedBox(),
    ),
  );
}
Widget buttonOnlyIconUpload(VoidCallback? onPressCallback,
    {String iconPath = "", double size = 15, Color? iconColor, Color bgColor = Colors.transparent}) {
  return Material(
    color: Colors.transparent,
    child: IconButton(
      iconSize: size,
      padding: EdgeInsets.zero,
      onPressed: onPressCallback,
      icon: iconPath.isNotEmpty
          ? iconPath.contains(".svg")
          ? SvgPicture.asset(
        iconPath,
        //width: size,
        //height: size,
        color: iconColor,
      )
          : Image.asset(
        iconPath,
        //width: size,
        //height: size,
        color: iconColor,
      )
          : const SizedBox(),
    ),
  );
}

Widget buttonOnlyIcon2(
    {Icon? icon,
    VoidCallback? onPressCallback,
    String iconPath = "",
    double? size,
    Color? iconColor}) {
  return Material(
    color: Colors.transparent,
    child: IconButton(
      onPressed: onPressCallback,
      icon: iconPath.isNotEmpty
          ? iconPath.contains(".svg")
              ? SvgPicture.asset(
                  iconPath,
                  width: size,
                  height: size,
                  color: iconColor,
                )
              : Image.asset(
                  iconPath,
                  width: size,
                  height: size,
                  color: iconColor,
                )
          : Container(),
    ),
  );
}

Widget buttonText(
    {String? text,
    VoidCallback? action,
    double fontSize = dp15,
    TextAlign? textAlign,Color? color}) {
  return TextButton(
    onPressed: action,
    child: textAutoSize(
        text: text!, textAlign: textAlign!, fontWeight: FontWeight.bold,color: color!),
  );
}

Widget buttonIconWithRoundBg(String iconPath,
    {VoidCallback? onPress,
    Color? iconColor,
    Color? bgColor,
    double size = 25,
    double padding = 10}) {
  var bgColorL = bgColor ?? Get.theme.colorScheme.secondary;
  var iconColorL = iconColor ?? bgColorL;
  return RawMaterialButton(
    onPressed: onPress,
    fillColor: bgColorL.withOpacity(0.3),
    elevation: 0,
    padding: EdgeInsets.all(padding),
    shape: const CircleBorder(),
    child: SvgPicture.asset(
      iconPath,
      color: iconColorL,
      width: size,
      height: size,
    ),
  );
}

Widget buttonIconWithBorder(String iconPath, VoidCallback onPress,
    {Color? iconColor, double size = 50}) {
  return Container(
      height: size,
      width: size,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.white, width: 0.25)),
      child: buttonOnlyIcon(
          onPressCallback: onPress, iconPath: iconPath, iconColor: iconColor));
}

Widget buttonRoundedWithIconSmall(
    String text, String iconPath, VoidCallback onPressCallback,
    {double? margin}) {
  return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.all(dp10),
      height: dp20,
      width: dp65,
      child: ElevatedButton.icon(
        icon: showImageAsset(
          imagePath: iconPath,
          height: dp5,
          color: Get.theme.primaryColorLight,
        ),
        label: textAutoSize(text: text, color: Get.theme.primaryColorLight),
        onPressed: onPressCallback,
        style: ElevatedButton.styleFrom(
          backgroundColor: Get.theme.colorScheme.secondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(dp7),
          ),
        ),
      ));
}

Widget textButton(
    {required String text,
      VoidCallback? onPressCallback,
      Color? textColor,
      Color? bgColor,
      double width = dp0}) {
  double buttonWidth = width == 0 ? Get.width : width;
  Color textColor = Get.theme.primaryColor;
  return InkWell(
    onTap: onPressCallback,
    child: Container(
        margin: const EdgeInsets.only(left: 0, right: 5, bottom: 0),
        //height: dp60,
        padding: const EdgeInsets.symmetric(vertical: dp15),
        width: buttonWidth,
        child: Row(
          children: [
            Expanded(flex:1,child: showImageAsset(imagePath: AssetConstants.icArrowRight)),
            const HSpacer5(),
            Expanded(flex:30,child: textAutoSize(text: text, maxLines: 1,color: textColor)),
          ],
        )),
  );
}