import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'common_utils.dart';
import 'dimens.dart';

Widget textAutoSize(
    {required String text,
    VoidCallback? onTap,
    double hMargin = dp0,
    int maxLines = 1,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double? width,
    double? height,
    TextAlign? textAlign = TextAlign.start,
    Alignment? alignment,
    double? fontSize = dp16,
    TextDecoration? decoration}) {
  var colorL = color ?? Get.theme.primaryColorDark;
  var widthL = width ?? Get.width;
  return Container(
    width: widthL,
    height: height,
    alignment: alignment,
    margin: EdgeInsets.only(left: hMargin, right: hMargin),
    child: InkWell(
      onTap: onTap,
      child: Text(text,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
          textAlign: textAlign,
          style: GoogleFonts.merriweather(
              //textStyle: const TextStyle(fontSize: dp10),
              color: colorL,
              fontWeight: fontWeight,
              fontSize: fontSize,
              decoration: decoration)

          /*style: TextStyle(
            color: colorL,
            fontWeight: fontWeight,
            fontSize: fontSize,
            decoration: decoration),*/

          ),
    ),
  );
}

Widget textAutoSizeSubTitle(
    {required String text,
    VoidCallback? onTap,
    double hMargin = dp0,
    int maxLines = 1,
    Color? color,
    FontWeight fontWeight = FontWeight.normal,
    double? width,
    double? height,
    TextAlign? textAlign = TextAlign.start,
    Alignment? alignment,
    double? fontSize = dp14,
    TextDecoration? decoration}) {
  var colorL = color ?? Get.theme.secondaryHeaderColor;
  var widthL = width ?? Get.width;
  return Container(
    width: widthL,
    height: height,
    alignment: alignment,
    margin: EdgeInsets.only(left: hMargin, right: hMargin),
    child: InkWell(
      onTap: onTap,
      child: AutoSizeText(
        text,
        maxLines: maxLines,
        minFontSize: dp10,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        style: Get.textTheme.headlineSmall!.copyWith(
            //style: Get.textTheme.headline5!.copyWith(
            color: colorL,
            fontWeight: fontWeight,
            fontSize: fontSize,
            decoration: decoration),
      ),
    ),
  );
}

Widget textSpanAutoSize(
    {String? title,
    String? subTitle,
    int maxLines = 1,
    Color? colorTitle,
    Color? colorSub,
    TextAlign textAlign = TextAlign.start}) {
  colorTitle = colorTitle ?? Get.theme.colorScheme.surface;
  //colorTitle = colorTitle ?? Get.theme.backgroundColor;
  colorSub = colorSub ?? Get.theme.primaryColorDark;
  return AutoSizeText.rich(
    TextSpan(
      text: title,
      style: Get.textTheme.titleMedium!.copyWith(
          //style: Get.textTheme.subtitle1!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: colorTitle),
      children: <TextSpan>[
        TextSpan(
          text: subTitle,
          style: Get.textTheme.titleMedium!.copyWith(
              //style: Get.textTheme.subtitle1!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: colorSub),
        ),
      ],
    ),
    maxLines: maxLines,
    textAlign: textAlign,
  );
}

Widget textSpanAutoSizeForProjectDetailsCost(
    {String? title,
    String? subTitle,
    int maxLines = 1,
    Color? colorTitle,
    Color? colorSub,
    TextAlign textAlign = TextAlign.start}) {
  colorTitle = colorTitle ?? Get.theme.colorScheme.surface;
  //colorTitle = colorTitle ?? Get.theme.backgroundColor;
  colorSub = colorSub ?? Get.theme.primaryColorDark;
  return AutoSizeText.rich(
    TextSpan(
      text: title,
      //style: Get.textTheme.subtitle1!.copyWith(
      style: Get.textTheme.titleMedium!.copyWith(
          fontSize: 14, fontWeight: FontWeight.normal, color: colorTitle),
      children: <TextSpan>[
        TextSpan(
          text: subTitle,
          style: Get.textTheme.titleMedium!.copyWith(
              fontSize: 14, fontWeight: FontWeight.normal, color: colorSub),
        ),
      ],
    ),
    maxLines: maxLines,
    textAlign: textAlign,
  );
}

Widget textSpanWithAction(String main, String clickAble, VoidCallback onTap,
    {int maxLines = 1,
    double fontSize = 15,
    TextAlign textAlign = TextAlign.center,
    Color? colorSub,
    FontWeight? fontWeight}) {
  colorSub = colorSub ?? Get.theme.colorScheme.secondary;
  return AutoSizeText.rich(
    TextSpan(
      text: main,
      style: Get.textTheme.titleMedium!
          .copyWith(fontSize: fontSize, fontWeight: fontWeight),
      children: <TextSpan>[
        TextSpan(
            text: clickAble,
            style: Get.textTheme.titleMedium!
                .copyWith(fontSize: fontSize, color: colorSub),
            recognizer: TapGestureRecognizer()..onTap = onTap),
      ],
    ),
    maxLines: maxLines,
  );
}

Widget twoTextItem(String title, String? value,
    {Color? valueColor, int subMaxLine = 1}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AutoSizeText(title,
          style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
          maxLines: 1,
          minFontSize: 10,
          maxFontSize: 16),
      const SizedBox(width: 5),
      Expanded(
          child: AutoSizeText(stringNullCheck(value),
              maxLines: subMaxLine,
              maxFontSize: 16,
              minFontSize: 10,
              style: Get.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.normal, color: valueColor),
              overflow: TextOverflow.ellipsis)),
    ],
  );
}

Widget twoTextView(String title, String? value,
    {Color? valueColor,
    int subMaxLine = 1,
    double minFontSizeV = 10,
    VoidCallback? onValueTap,
    FontWeight? fontWeight,
    double horizontalPadding = 0}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: horizontalPadding),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            flex: 1,
            child: AutoSizeText(title,
                style:
                    Get.textTheme.bodyLarge!.copyWith(fontWeight: fontWeight),
                maxLines: 1,
                minFontSize: 10,
                maxFontSize: 16)),
        const SizedBox(width: 5),
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: onValueTap,
            child: AutoSizeText(value ?? "",
                maxLines: subMaxLine,
                maxFontSize: 16,
                minFontSize: minFontSizeV,
                textAlign: TextAlign.right,
                style: Get.textTheme.bodyLarge!.copyWith(color: valueColor),
                overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
    ),
  );
}
