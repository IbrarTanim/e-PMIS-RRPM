import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/EntryForm8ListResponse.dart';
import 'package:pmis_flutter/data/models/UserListResponse.dart';
import 'package:pmis_flutter/data/models/agency_list_response.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/district_list_response.dart';
import 'package:pmis_flutter/data/models/division_response_data.dart';
import 'package:pmis_flutter/data/models/ministry_list_response.dart';
import 'package:pmis_flutter/data/models/pending_task_list_response.dart';
import 'package:pmis_flutter/data/models/project_allocation_cost_response.dart';
import 'package:pmis_flutter/data/models/project_estimated_cost_response.dart';
import 'package:pmis_flutter/data/models/project_expenditure_cost_response.dart';
import 'package:pmis_flutter/data/models/project_user_list_response.dart';
import 'package:pmis_flutter/data/models/projects_list_response.dart';
import 'package:pmis_flutter/data/models/workflow_activity_history_response.dart';
import 'package:pmis_flutter/data/models/workflow_allocation_distribution_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_allocation_response.dart';
import 'package:pmis_flutter/data/models/workflow_allocation_return_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_demand_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_expenditure_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_fund_distribution_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_fund_release_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_node_data_response.dart';
import 'package:pmis_flutter/data/models/workflow_reappropriation_details_response.dart';
import 'package:pmis_flutter/ui/features/project/expenditure/entry_form_8_report_screen.dart';
import 'package:pmis_flutter/ui/features/project/project_details_bottom_bar.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pending_task/pending_task_controller.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pending_task/work_flow_details_screen.dart';
import 'package:pmis_flutter/ui/legacy/1old/entry_form_8_report_screen.dart';
import 'package:pmis_flutter/ui/legacy/1old/basic_project_details_screen.dart';
import 'package:pmis_flutter/ui/legacy/1old/project_estimated_cost_details_screen.dart';
import 'package:pmis_flutter/ui/legacy/1old/wishList_project_details_screen.dart';
import 'package:pmis_flutter/ui/features/root/root_controller.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/date_util.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'package:pmis_flutter/utils/pdf_viewer_screen.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_field_util.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../data/models/files_evidence_response_list.dart';
import '../data/models/project_inspection_response_list.dart';
import '../data/models/project_location_response_list.dart';
import '../ui/features/project/images/image_gallery_controller.dart';
import '../ui/features/drawer_menu/pd_directory/pd_details/pd_details_screen.dart';
import 'alert_util.dart';
import 'button_util.dart';
import 'common_utils.dart';
import 'decorations.dart';
import 'dimens.dart';
import 'map_utils.dart';

Widget viewTopLogoText({String? title, String? subTitle}) {
  return Container(
    height: 300,
    //decoration: boxDecorationRoundBorderBottom(),

    decoration: const BoxDecoration(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(dp30)),
      gradient: LinearGradient(
        begin: Alignment.topLeft, end: Alignment(0.8, 1),
        colors: <Color>[
          Color(0xFF4A90E2),
          Color(0xFF50E3C2)
        ], // Gradient from https://learnui.design/tools/gradient-generator.htmltileMode: TileMode.mirror,
      ),
    ),

    child: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          showImageAsset(
              imagePath: AssetConstants.appLogo, height: dp150, width: dp150),
          const VSpacer10(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: textAutoSize(
                text: title!,
                textAlign: TextAlign.center,
                color: Colors.white,
                fontSize: dp20,
                maxLines: 3),
          ),
        ],
      ),
    ),
  );
}

Widget carouselDot({Color? dotColor}) {
  return Container(
    width: 10.0,
    height: 10.0,
    margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
    decoration: BoxDecoration(shape: BoxShape.circle, color: dotColor),
  );
}

Widget twoSidedTextWithColon(
    {String? leftText, String? rightText, Color? leftTextColor}) {
  leftTextColor = leftTextColor ?? Get.theme.secondaryHeaderColor;
  return Row(
    children: [
      Expanded(
          flex: 4, child: textAutoSize(text: leftText!, color: leftTextColor)),
      /*Expanded(flex: 1, child: textAutoSize(text: ":", color: leftTextColor)),*/
      Expanded(flex: 8, child: textAutoSize(text: rightText!, maxLines: 100)),
    ],
  );
}

Widget twoSidedTextWithColon2(
    {String? leftText,
    String? rightText,
    Color? leftTextColor,
    FontWeight? rightTextFontWeight,
    int? maxLineForRightText}) {
  leftTextColor = leftTextColor ?? Get.theme.secondaryHeaderColor;
  maxLineForRightText = maxLineForRightText ?? 30;
  rightTextFontWeight = rightTextFontWeight ?? FontWeight.normal;
  return Row(
    children: [
      Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: textAutoSize(
                text: leftText!,
                color: leftTextColor,
                fontSize: dp14,
                maxLines: 2),
          )),
      /*Expanded(
          flex: 1,
          child: textAutoSize(text: ":", color: leftTextColor, fontSize: dp14)),*/
      Expanded(
          flex: 9,
          child: textAutoSize(
              text: rightText!,
              maxLines: maxLineForRightText,
              fontSize: dp14,
              fontWeight: rightTextFontWeight)),
    ],
  );
}

Widget twoSidedTextOnly(
    {String? leftText,
    String? rightText,
    Color? leftTextColor,
    FontWeight? rightTextFontWeight,
    int? maxLineForRightText}) {
  leftTextColor = leftTextColor ?? Get.theme.secondaryHeaderColor;
  maxLineForRightText = maxLineForRightText ?? 30;
  rightTextFontWeight = rightTextFontWeight ?? FontWeight.normal;
  return Row(
    children: [
      Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: textAutoSize(
                text: leftText!,
                color: leftTextColor,
                fontSize: dp14,
                maxLines: 2),
          )),
      Expanded(
          flex: 9,
          child: textAutoSize(
              text: rightText!,
              maxLines: maxLineForRightText,
              fontSize: dp14,
              fontWeight: rightTextFontWeight)),
    ],
  );
}

Widget projectTitle(
    {String? rightText,
    FontWeight? rightTextFontWeight,
    int? maxLineForRightText}) {
  maxLineForRightText = maxLineForRightText ?? 30;
  rightTextFontWeight = rightTextFontWeight ?? FontWeight.normal;
  return Row(
    children: [
      Expanded(
        child: textAutoSize(
            text: rightText!,
            maxLines: maxLineForRightText,
            fontSize: dp16,
            hMargin: dp10,
            fontWeight: rightTextFontWeight),
      ),
    ],
  );
}

Widget twoSidedTextWithColonNear(
    {String? leftText,
    String? rightText,
    Color? leftTextColor,
    FontWeight? rightTextFontWeight,
    int? maxLine}) {
  leftTextColor = leftTextColor ?? Get.theme.secondaryHeaderColor;
  maxLine = maxLine ?? 30;
  rightTextFontWeight = rightTextFontWeight ?? FontWeight.normal;
  return Row(
    children: [
      Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: textAutoSize(
                text: leftText!,
                color: leftTextColor,
                // fontSize: dp14,
                textAlign: TextAlign.end,
                maxLines: 2),
          )),
      Expanded(
          flex: 1,
          child: textAutoSize(
              text: ":",
              color: leftTextColor,
              textAlign: TextAlign.center,
              fontSize: dp14)),
      Expanded(
          flex: 5,
          child: textAutoSize(
              text: rightText!,
              maxLines: maxLine,
              textAlign: TextAlign.start,
              fontSize: dp14,
              fontWeight: rightTextFontWeight)),
    ],
  );
}

Widget twoSidedTextWithColonIntValue(
    {String? leftText,
    int? rightText,
    String? rightAmountText,
    Color? leftTextColor,
    FontWeight? rightTextFontWeight,
    int? maxLine}) {
  leftTextColor = leftTextColor ?? Get.theme.secondaryHeaderColor;
  maxLine = maxLine ?? 30;
  rightTextFontWeight = rightTextFontWeight ?? FontWeight.normal;
  return Row(
    children: [
      Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: textAutoSize(
                text: leftText!,
                color: leftTextColor,
                fontSize: dp14,
                maxLines: 2),
          )),
      Expanded(
          flex: 1,
          child: textAutoSize(text: ":", color: leftTextColor, fontSize: dp14)),
      Expanded(
          flex: 9,
          child: textSpanAutoSizeForProjectDetailsCost(
              title: rightText.toString(),
              subTitle: rightAmountText,
              colorTitle: Get.theme.primaryColorDark,
              colorSub: Get.theme.primaryColor)),
    ],
  );
}

Widget twoSidedTextWithColonFormatedValue(
    {String? leftText,
    String? rightText,
    String? rightAmountText,
    Color? leftTextColor,
    FontWeight? rightTextFontWeight,
    int? maxLine}) {
  leftTextColor = leftTextColor ?? Get.theme.secondaryHeaderColor;
  maxLine = maxLine ?? 30;
  rightTextFontWeight = rightTextFontWeight ?? FontWeight.normal;
  return Row(
    children: [
      Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: textAutoSize(
                text: leftText!,
                color: leftTextColor,
                fontSize: dp14,
                maxLines: 2),
          )),
      Expanded(
          flex: 1,
          child: textAutoSize(text: ":", color: leftTextColor, fontSize: dp14)),
      Expanded(
          flex: 9,
          child: textSpanAutoSizeForProjectDetailsCost(
              title: rightText.toString(),
              subTitle: rightAmountText,
              colorTitle: Get.theme.primaryColorDark,
              colorSub: Get.theme.primaryColor)),
    ],
  );
}

Widget twoSidedTextWithTextFieldWorkflowComment(
    {String? leftText,
    String? rightText,
    Color? leftTextColor,
    TextEditingController? controller,
    FontWeight? rightTextFontWeight}) {
  leftTextColor = leftTextColor ?? Get.theme.secondaryHeaderColor;
  rightTextFontWeight = rightTextFontWeight ?? FontWeight.normal;
  return Row(
    children: [
      Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: textAutoSize(
                text: leftText!,
                color: leftTextColor,
                fontSize: dp14,
                maxLines: 2),
          )),
      Expanded(
          flex: 1,
          child: textAutoSize(text: " ", color: leftTextColor, fontSize: dp14)),
      Expanded(
          flex: 9,
          child: textFieldBordered(
            controller: controller,
            maxLines: 3,
            hint: 'writeComments'.tr,
            inputType: TextInputType.text,
          )),
    ],
  );
}

Widget twoSidedTextWithTextField(
    {String? leftText,
    String? rightText,
    Color? leftTextColor,
    TextEditingController? controller,
    FontWeight? rightTextFontWeight}) {
  leftTextColor = leftTextColor ?? Get.theme.secondaryHeaderColor;
  rightTextFontWeight = rightTextFontWeight ?? FontWeight.normal;
  return Row(
    children: [
      Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: textAutoSize(
                text: leftText!,
                color: leftTextColor,
                fontSize: dp14,
                maxLines: 2),
          )),
      Expanded(
          flex: 1,
          child: textAutoSize(text: ":", color: leftTextColor, fontSize: dp14)),
      Expanded(
          flex: 9,
          child: textFieldBordered(
            controller: controller,
            maxLines: 3,
            hint: 'TypeImageCaption'.tr,
            inputType: TextInputType.text,
          )),
    ],
  );
}

Widget twoSidedTextWithDateField(BuildContext context,
    {String? leftText,
    String? rightText,
    Color? leftTextColor,
    TextEditingController? textEditingController,
    FontWeight? rightTextFontWeight}) {
  leftTextColor = leftTextColor ?? Get.theme.secondaryHeaderColor;
  rightTextFontWeight = rightTextFontWeight ?? FontWeight.normal;
  return Row(
    children: [
      Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: textAutoSize(
                text: leftText!,
                color: leftTextColor,
                fontSize: dp14,
                maxLines: 2),
          )),
      Expanded(
          flex: 1,
          child: textAutoSize(text: ":", color: leftTextColor, fontSize: dp14)),
      Expanded(
          flex: 9,
          child: textFormFieldDatePicker(
            context,
            controller: textEditingController,
            hint: 'SelectDate'.tr,
            type: TextInputType.datetime,
            iconPath: AssetConstants.icDate,

            // iconAction:
          )),
    ],
  );
}

Widget twoSidedTextWithColon3Data(
    {String? leftText,
    String? dateOfInspectionText,
    String? inspectorNameText,
    String? inspectionSummeryText,
    Color? leftTextColor,
    FontWeight? rightTextFontWeight}) {
  leftTextColor = leftTextColor ?? Get.theme.secondaryHeaderColor;
  rightTextFontWeight = rightTextFontWeight ?? FontWeight.normal;
  return Row(
    children: [
      Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: textAutoSize(
                text: leftText!,
                color: leftTextColor,
                fontSize: dp14,
                maxLines: 2),
          )),
      Expanded(
          flex: 1,
          child: textAutoSize(text: ":", color: leftTextColor, fontSize: dp14)),
      Expanded(
          flex: 9,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: textAutoSize(
                            text: 'DateOfInspection'.tr,
                            fontSize: dp14,
                            maxLines: 2),
                      )),
                  Expanded(
                      flex: 1,
                      child: textAutoSize(
                          text: ":", color: leftTextColor, fontSize: dp14)),
                  Expanded(
                    flex: 8,
                    child: textAutoSize(
                        text: dateOfInspectionText!,
                        maxLines: 10,
                        fontSize: dp14,
                        fontWeight: rightTextFontWeight),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: textAutoSize(
                            text: 'InspectorName'.tr,
                            fontSize: dp14,
                            maxLines: 2),
                      )),
                  Expanded(
                      flex: 1,
                      child: textAutoSize(
                          text: ":", color: leftTextColor, fontSize: dp14)),
                  Expanded(
                    flex: 8,
                    child: textAutoSize(
                        text: inspectorNameText!,
                        maxLines: 10,
                        fontSize: dp14,
                        fontWeight: rightTextFontWeight),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: textAutoSize(
                            text: 'InspectionSummery'.tr,
                            fontSize: dp14,
                            maxLines: 2),
                      )),
                  Expanded(
                      flex: 1,
                      child: textAutoSize(
                          text: ":", color: leftTextColor, fontSize: dp14)),
                  Expanded(
                    flex: 8,
                    child: textAutoSize(
                        text: inspectionSummeryText!,
                        maxLines: 10,
                        fontSize: dp14,
                        fontWeight: rightTextFontWeight),
                  ),
                ],
              ),
              // textAutoSize(
              //     text: rightText2!,
              //     maxLines: 10,
              //     fontSize: dp14,
              //     fontWeight: rightTextFontWeight),
              // textAutoSize(
              //     text: rightText3!,
              //     maxLines: 10,
              //     fontSize: dp14,
              //     fontWeight: rightTextFontWeight),
            ],
          )),
    ],
  );
}

Widget twoSidedTextWithTextActionAndIcon(
    {String? leftText,
    String? rightText,
    Color? leftTextColor,
    FontWeight? rightTextFontWeight,
    VoidCallback? iconAction,
    String? rightIcon}) {
  leftTextColor = leftTextColor ?? Get.theme.secondaryHeaderColor;
  rightTextFontWeight = rightTextFontWeight ?? FontWeight.normal;
  return Row(
    children: [
      Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: textAutoSize(
                text: leftText!,
                color: leftTextColor,
                fontSize: dp14,
                maxLines: 2),
          )),

      /*Expanded(
          flex: 1,
          child: textAutoSize(text: ":", color: leftTextColor, fontSize: dp14)),*/

      Expanded(
          flex: 9,
          child: InkWell(
            onTap: iconAction,
            child: Row(
              children: [
                Expanded(
                    flex: 6,
                    child: textAutoSize(
                        text: rightText!,
                        maxLines: 10,
                        fontSize: dp14,
                        fontWeight: rightTextFontWeight,
                        decoration: TextDecoration.underline)),
                const HSpacer2(),
                Expanded(
                    flex: 1,
                    child: showImageAsset(
                        imagePath: rightIcon!,
                        height: 20,
                        color: Colors.blueAccent)),
              ],
            ),
          )),
    ],
  );
}

Widget twoSidedTextWithTextActionAndIconMyProjectDetails(
    {String? leftText,
    String? rightText,
    Color? leftTextColor,
    FontWeight? rightTextFontWeight,
    VoidCallback? iconAction,
    String? rightIcon}) {
  leftTextColor = leftTextColor ?? Get.theme.secondaryHeaderColor;
  rightTextFontWeight = rightTextFontWeight ?? FontWeight.normal;
  return Row(
    children: [
      Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: textAutoSize(
                text: leftText!,
                color: leftTextColor,
                fontSize: dp14,
                maxLines: 2),
          )),

      /*Expanded(
          flex: 1,
          child: textAutoSize(text: ":", color: leftTextColor, fontSize: dp14)),*/

      Expanded(
          flex: 9,
          child: InkWell(
            onTap: iconAction,
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: textAutoSize(
                        text: rightText!,
                        maxLines: 10,
                        fontSize: dp14,
                        fontWeight: rightTextFontWeight,
                        decoration: TextDecoration.underline)),
                //const HSpacer2(),
                Expanded(
                    flex: 3,
                    child: showImageAsset(
                        imagePath: rightIcon!,
                        height: 20,
                        color: Colors.blueAccent)),
                const HSpacer10(),
              ],
            ),
          )),
    ],
  );
}

Widget twoSidedTextWithIconAndTextAction(
    {String? leftText,
    String? rightText,
    String? rightActionText,
    Color? leftTextColor,
    Color? rightTextColor,
    FontWeight? rightTextFontWeight,
    VoidCallback? rightTextAction,
    String? rightIcon}) {
  leftTextColor = leftTextColor ?? Get.theme.secondaryHeaderColor;
  rightTextFontWeight = rightTextFontWeight ?? FontWeight.normal;
  return Row(
    children: [
      Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: textAutoSize(
                text: leftText!,
                color: leftTextColor,
                fontSize: dp14,
                maxLines: 2),
          )),
      Expanded(
          flex: 1,
          child: textAutoSize(text: ":", color: leftTextColor, fontSize: dp14)),
      Expanded(
          flex: 9,
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: textAutoSize(
                      text: rightText!,
                      maxLines: 10,
                      fontSize: dp14,
                      color: rightTextColor,
                      fontWeight: rightTextFontWeight)),
              const HSpacer2(),
              Expanded(
                  flex: 4,
                  child: InkWell(
                    onTap: rightTextAction,
                    child: textAutoSize(
                        text: rightActionText!,
                        textAlign: TextAlign.end,
                        maxLines: 10,
                        fontSize: dp14,
                        fontWeight: rightTextFontWeight,
                        decoration: TextDecoration.underline),
                  )),
              const HSpacer2(),
              Expanded(
                  flex: 1,
                  child: showImageAsset(
                      imagePath: rightIcon!,
                      height: 20,
                      color: Colors.blueAccent)),
            ],
          )),
    ],
  );
}

Widget twoSidedTextWithColonIcon(
    {String? leftText,
    VoidCallback? onPressed,
    Color? leftTextColor,
    FontWeight? rightTextFontWeight}) {
  leftTextColor = leftTextColor ?? Get.theme.secondaryHeaderColor;
  return Row(
    children: [
      Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: textAutoSize(
                text: leftText!,
                color: leftTextColor,
                fontSize: dp14,
                maxLines: 2),
          )),
      Expanded(
          flex: 1,
          child: textAutoSize(text: ":", color: leftTextColor, fontSize: dp14)),
      Expanded(
        flex: 8,
        child: InkWell(
          onTap: onPressed,
          child: showImageAsset(
              imagePath: AssetConstants.icLocation, height: dp20, width: dp20),
        ),
      ),
    ],
  );
}

Widget profileView(
    {String? userName, String? userDesignation, Color? leftTextColor}) {
  return ListView(
    padding: EdgeInsets.zero,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*Expanded(
              flex: 2,
              child: showImageAsset(
                  imagePath: AssetConstants.appLogo,
                  height: Get.width / 6,
                  width: Get.width / 6)),
          const HSpacer20(),*/

          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                textAutoSize(
                    alignment: Alignment.centerLeft,
                    text: "App_name_short".tr,
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                const VSpacer5(),
                textAutoSize(
                    text: "App_name_without_short".tr,
                    textAlign: TextAlign.start,
                    fontSize: 14,
                    color: Get.theme.colorScheme.surface,
                    //color: Get.theme.backgroundColor,
                    fontWeight: FontWeight.normal,
                    maxLines: 3),
              ],
            ),
          ),
        ],
      ),
      const VSpacer10(),
      textAutoSize(
          alignment: Alignment.centerLeft,
          text: userName.toString(),
          textAlign: TextAlign.start,
          fontWeight: FontWeight.normal,
          fontSize: dp14),
      const VSpacer5(),
      textAutoSize(
          alignment: Alignment.centerLeft,
          text: userDesignation.toString(),
          textAlign: TextAlign.start,
          fontWeight: FontWeight.normal,
          fontSize: dp14),

      /*twoSidedTextWithColon(
          leftText: "user".tr,
          rightText: userName!,
          leftTextColor: leftTextColor),*/

      /*const VSpacer5(),
      twoSidedTextWithColon(
          leftText: "Designation".tr,
          rightText: userDesignation!,
          leftTextColor: leftTextColor),*/
    ],
  );
}

Widget bottomShapeWithVersionText(
    {String? appName, String? version, String? subTitle}) {
  return Container(
    height: dp50,
    padding: const EdgeInsets.symmetric(horizontal: dp16),
    decoration: boxDecorationRoundBorderTop(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: textSpanAutoSize(
              title: "App_Type".tr,
              subTitle: appName!,
              textAlign: TextAlign.start,
              maxLines: 1),
        ),
        Expanded(
          child: textSpanAutoSize(
              title: "version".tr,
              subTitle: version!,
              textAlign: TextAlign.end,
              maxLines: 1),
        ),
      ],
    ),
  );
}

// Zabir
Widget getTabView({
  List<String>? titles,
  TabController? controller,
  Function(int)? onTap,
  TabBarIndicatorSize indicatorSize = TabBarIndicatorSize.tab,
  List<String>? icons,
}) {
  return Container(
    height: 50,
    child: TabBar(
      controller: controller,
      labelColor: accentBlue,
      unselectedLabelColor: Colors.grey.shade600,
      labelStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w800,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      indicatorColor: accentBlue,
      indicatorWeight: 3,
      indicatorSize: indicatorSize,
      tabs: List.generate(
        titles != null ? titles.length : icons!.length,
        (index) {
          return Tab(
            text: (icons == null && titles != null) ? titles[index] : null,
            icon: (icons != null && titles == null)
                ? SvgPicture.asset(
                    icons[index],
                    colorFilter: ColorFilter.mode(
                      controller?.index == index
                          ? accentBlue
                          : Colors.grey.shade600,
                      BlendMode.srcIn,
                    ),
                  )
                : null,
            child: (icons != null && titles != null)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        icons[index],
                        colorFilter: ColorFilter.mode(
                          controller?.index == index
                              ? accentBlue
                              : Colors.grey.shade600,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(titles[index]),
                    ],
                  )
                : null,
          );
        },
      ),
      onTap: onTap,
    ),
  );
}

// Widget getTabView({
//   List<String>? titles,
//   TabController? controller,
//   Function(int)? onTap,
//   TabBarIndicatorSize indicatorSize = TabBarIndicatorSize.tab,
//   List<String>? icons,
// }) {
//   return Container(
//     height: 50,
//     decoration: BoxDecoration(
//         border: Border(
//             bottom: BorderSide(color: Get.theme.primaryColor, width: 0.5))),
//     child: TabBar(
//       controller: controller,
//       labelColor: Get.theme.primaryColor,
//       labelStyle:
//           Get.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
//       unselectedLabelStyle: Get.textTheme.titleLarge,
//       unselectedLabelColor: Get.theme.primaryColor,
//       labelPadding: const EdgeInsets.only(left: 0, right: 0),
//       indicatorColor: Get.theme.primaryColorDark,
//       indicatorSize: indicatorSize,
//       tabs: List.generate(titles != null ? titles.length : icons!.length,
//           (index) {
//         return Tab(
//             text: (icons == null && titles != null) ? titles[index] : null,
//             icon: (icons != null && titles == null)
//                 ? SvgPicture.asset(icons[index])
//                 : null,
//             child: (icons != null && titles != null)
//                 ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                     SvgPicture.asset(icons[index]),
//                     const SizedBox(width: 5),
//                     Text(titles[index])
//                   ])
//                 : null);
//       }),
//       onTap: (int x) {
//         if (onTap != null) onTap(x);
//       },
//     ),
//   );
// }

void showTopSnackBar(BuildContext context, String message, Color color) {
  showSimpleNotification(
    const Text('Internet Connectivity Update'),
    subtitle: Text(message),
    background: color,
  );
}

Widget buildSearchBox() {
  return Container(
      margin:
          const EdgeInsets.only(left: dp0, top: dp10, right: dp0, bottom: dp10),
      height: kToolbarHeight,
      child: InkWell(
        onTap: () {
          // Get.to(() => const SearchPage());
        },
        child: TextField(
          enabled: false,
          decoration: decorationSearchBox(),
        ),
      ));
}

// Widget listTitleWithArrow({String? title, String? leftIconPath, String? rightIconPath, VoidCallback? action}) {
//   return SizedBox(
//     height: dp45,
//     child: InkWell(
//       onTap: action,
//       child: Row(
//         children: [
//           if (leftIconPath.isValid) buttonOnlyIcon(onPressCallback: action, iconPath: leftIconPath!, size: dp20, iconColor: Get.theme.primaryColor),
//           Expanded(child: textAutoSize(text: title!, fontWeight: FontWeight.bold, fontSize: 14, alignment: Alignment.centerLeft, hMargin: 20)),
//           if (rightIconPath.isValid) buttonOnlyIcon(onPressCallback: action, iconPath: rightIconPath!, size: dp20, iconColor: Get.theme.primaryColor)
//         ],
//       ),
//     ),
//   );
// }

// Zabir
Widget listTitle({String? title, String? buttonTitle, VoidCallback? action}) {
  buttonTitle = buttonTitle ?? "";

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp4),
    padding: const EdgeInsets.all(dp8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(dp12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          spreadRadius: 0,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: dp4,
          height: dp24,
          decoration: BoxDecoration(
            color: accentGreen,
            borderRadius: BorderRadius.circular(dp2),
          ),
        ),
        const SizedBox(width: dp8),
        Expanded(
          flex: 5,
          child: Text(
            title!,
            style: TextStyle(
              fontSize: dp15,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2D3436),
              letterSpacing: 0.2,
            ),
          ),
        ),
        if (buttonTitle.isNotEmpty) ...[
          const SizedBox(width: dp6),
          InkWell(
            onTap: action,
            borderRadius: BorderRadius.circular(dp16),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: dp12,
                vertical: dp6,
              ),
              decoration: BoxDecoration(
                color: accentBlue.withOpacity(0.15),
                borderRadius: BorderRadius.circular(dp16),
              ),
              child: Text(
                buttonTitle,
                style: TextStyle(
                  fontSize: dp14,
                  fontWeight: FontWeight.w500,
                  color: accentBlue,
                ),
              ),
            ),
          ),
        ] else
          const SizedBox(width: dp30),
      ],
    ),
  );
}

// Widget listTitle({String? title, String? buttonTitle, VoidCallback? action}) {
//   buttonTitle = buttonTitle ?? "";
//   return Container(
//     margin: const EdgeInsets.only(left: dp15, right: dp2),
//     //color: Colors.green,
//     height: dp40,
//     child: Row(
//       children: [
//         Expanded(
//             flex: 5,
//             child: textAutoSize(
//                 text: title!,
//                 fontWeight: FontWeight.bold,
//                 color: Get.theme.primaryColor)),
//         buttonTitle.isNotEmpty
//             ? Expanded(
//                 flex: 2,
//                 child: buttonText(
//                     text: buttonTitle,
//                     action: action!,
//                     textAlign: TextAlign.end,
//                     color: Get.theme.primaryColor))
//             : const SizedBox(width: dp30)
//       ],
//     ),
//   );
// }

// Widget totalProjectsCommonTitle({String? title}) {
//   return Container(
//     margin: const EdgeInsets.only(left: dp15, right: dp2),
//     //color: Colors.green,
//     height: dp40,
//     child: Row(
//       children: [
//         Expanded(
//             flex: 5,
//             child: textAutoSize(
//                 text: title!,
//                 fontWeight: FontWeight.bold,
//                 color: Get.theme.primaryColor)),
//       ],
//     ),
//   );
// }

// Zabir
Widget totalProjectsCommonTitle({String? title}) {
  return Container(
    margin: const EdgeInsets.only(left: dp15, right: dp2),
    //color: Colors.green,
    height: dp25,
    child: Row(
      children: [
        Expanded(
            flex: 5,
            child: textAutoSize(
                text: title!, fontWeight: FontWeight.bold, color: darkText)),
      ],
    ),
  );
}

Widget listTitleWithLeftIcon(
    String title, String iconPath, Color color, VoidCallback action,
    {Color? iconColor}) {
  return InkWell(
    onTap: action,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buttonOnlyIcon2(
            onPressCallback: action,
            iconPath: iconPath,
            size: dp18,
            iconColor: iconColor),
        Expanded(child: textAutoSize(text: title, maxLines: 1)),
      ],
    ),
  );
}

Widget textWithLeftIcon(
    {String? title,
    String? iconPath,
    Color? color,
    VoidCallback? action,
    Color? iconColor,
    double? fontSize}) {
  return SizedBox(
    height: dp50,
    width: Get.width,
    child: InkWell(
      onTap: action,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (iconPath != null && iconPath.isNotEmpty)
            buttonOnlyIcon(
                onPressCallback: action,
                iconPath: iconPath,
                iconColor: iconColor),
          Expanded(
            child: AutoSizeText(
              title ?? "",
              maxLines: 1,
              minFontSize: dp10,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: Get.textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold, fontSize: fontSize),
            ),
          )
        ],
      ),
    ),
  );
}

Widget dividerHorizontal(
    {Color color = Colors.grey,
    double height = 30,
    double? indent,
    double? width}) {
  return SizedBox(
    width: width,
    child: Divider(
      height: height,
      color: color,
      thickness: 1,
      endIndent: indent,
      indent: indent,
    ),
  );
}

Widget dividerVertical(
    {Color color = Colors.grey,
    double width = 10,
    double? height,
    double? indent}) {
  return SizedBox(
    height: height,
    child: VerticalDivider(
      width: width,
      color: color,
      thickness: 2,
      endIndent: indent,
      indent: indent,
    ),
  );
}

Widget dropDownWithIndex(List<String> items, int selectedPre, String hint,
    Function(int selectedNew) onChange,
    {double? viewWidth,
    double height = 50,
    bool isEditable = true,
    Color? bgColor,
    double? hMargin}) {
  viewWidth = viewWidth ?? Get.width;
  var textWidth = viewWidth - 70;
  hMargin = hMargin ?? 10;
  return Container(
    margin: EdgeInsets.only(left: hMargin, top: 5, right: hMargin, bottom: 5),
    height: height,
    width: viewWidth,
    alignment: Alignment.center,
    decoration: boxDecorationRoundBorder(
        bgColor: Colors.white, borderColor: Colors.white),
    child: DropdownButton<String>(
      value: selectedPre == -1 ? null : items[selectedPre],
      hint: textAutoSize(
          text: hint,
          width: textWidth,
          alignment: Alignment.centerLeft,
          fontWeight: FontWeight.bold),
      icon: Icon(Icons.keyboard_arrow_down_outlined,
          color: isEditable ? Get.theme.primaryColor : Colors.transparent),
      elevation: 10,
      dropdownColor: Get.theme.secondaryHeaderColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      //style: Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
      underline: Container(height: 0, color: Colors.transparent),
      menuMaxHeight: Get.width,
      onChanged: isEditable ? (value) => onChange(items.indexOf(value!)) : null,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: textAutoSize(
              text: value,
              width: textWidth,
              alignment: Alignment.centerLeft,
              fontWeight: FontWeight.bold),
        );
      }).toList(),
    ),
  );
}

//though object
Widget dropDownAllProjectForMinistry(
    {List<MinistryListResponse>? items,
    MinistryListResponse? selectedValue,
    String? hint,
    double? hPadding,
    Function(MinistryListResponse value)? onChange,
    double? viewWidth,
    double? extraWidth,
    double height = kToolbarHeight - 5,
    bool isEditable = true,
    Color? bgColor}) {
  viewWidth = viewWidth ?? Get.width;
  var textWidth = viewWidth - extraWidth!;
  hPadding = hPadding ?? dp16;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: hPadding),
    height: height,
    width: Get.width,
    alignment: Alignment.center,
    decoration: boxDecorationRoundBorder(
        bgColor: Get.theme.colorScheme.surface,
        borderColor: Get.theme.primaryColor),
    child: DropdownButton<MinistryListResponse>(
      // value: selectedValue!.isEmpty ? null : selectedValue,
      value: selectedValue!.value!.isNotEmpty ? selectedValue : null,
      hint: textAutoSize(
          text: hint!,
          width: textWidth,
          maxLines: 1,
          alignment: Alignment.centerLeft,
          fontWeight: FontWeight.bold),
      icon: Icon(Icons.keyboard_arrow_down_outlined,
          color: isEditable ? Get.theme.primaryColorDark : Colors.transparent),
      elevation: 10,
      dropdownColor: Get.theme.primaryColorLight,
      focusColor: Get.theme.primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      //style: Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
      underline: Container(height: 0, color: Colors.transparent),
      menuMaxHeight: Get.width,
      onChanged: isEditable
          ? (value) {
              onChange!(value!);
            }
          : null,
      items: items!.map<DropdownMenuItem<MinistryListResponse>>(
          (MinistryListResponse value) {
        return DropdownMenuItem<MinistryListResponse>(
          value: value,
          child: textAutoSize(
              text: value.text.toString(),
              width: textWidth,
              maxLines: 1,
              alignment: Alignment.centerLeft,
              fontWeight: FontWeight.bold),
        );
      }).toList(),
    ),
  );
}

//all Projects dropdown for division
/*Widget dropDownAllProjectForDivision(
    {List<DivisionListResponse>? items,
    DivisionListResponse? selectedValue,
    String? hint,
    double? hPadding,
    Function(DivisionListResponse value)? onChange,
    double? viewWidth,
    double? extraWidth,
    double height = kToolbarHeight - 5,
    bool isEditable = true,
    Color? bgColor}) {
  viewWidth = viewWidth ?? Get.width;
  var textWidth = viewWidth - extraWidth!;
  hPadding = hPadding ?? dp16;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: hPadding),
    height: height,
    width: Get.width,
    alignment: Alignment.center,
    decoration: boxDecorationRoundBorder(
        bgColor: Get.theme.backgroundColor,
        borderColor: Get.theme.primaryColor),
    child: DropdownButton<DivisionListResponse>(
      // value: selectedValue!.isEmpty ? null : selectedValue,
      value: selectedValue!.value!.isNotEmpty ? selectedValue : null,
      hint: textAutoSize(
          text: hint!,
          width: textWidth,
          maxLines: 1,
          alignment: Alignment.centerLeft,
          fontWeight: FontWeight.bold),
      icon: Icon(Icons.keyboard_arrow_down_outlined,
          color: isEditable ? Get.theme.primaryColorDark : Colors.transparent),
      elevation: 10,
      dropdownColor: Get.theme.primaryColorLight,
      focusColor: Get.theme.primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      //style: Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
      underline: Container(height: 0, color: Colors.transparent),
      menuMaxHeight: Get.width,
      onChanged: isEditable
          ? (value) {
              onChange!(value!);
            }
          : null,
      items: items!.map<DropdownMenuItem<DivisionListResponse>>(
          (DivisionListResponse value) {
        return DropdownMenuItem<DivisionListResponse>(
          value: value,
          child: textAutoSize(
              text: value.text.toString(),
              width: textWidth,
              maxLines: 1,
              alignment: Alignment.centerLeft,
              fontWeight: FontWeight.bold),
        );
      }).toList(),
    ),
  );
}*/

Widget dropDownAllProjectForDivision(
    {List<ValueObject>? items,
    ValueObject? selectedValue,
    String? hint,
    double? hPadding,
    Function(ValueObject value)? onChange,
    double? viewWidth,
    double? extraWidth,
    double height = kToolbarHeight - 5,
    bool isEditable = true,
    Color? bgColor}) {
  viewWidth = viewWidth ?? Get.width;
  var textWidth = viewWidth - extraWidth!;
  hPadding = hPadding ?? dp16;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: hPadding),
    height: height,
    width: Get.width,
    alignment: Alignment.center,
    decoration: boxDecorationRoundBorder(
        bgColor: Get.theme.colorScheme.surface,
        borderColor: Get.theme.primaryColor),
    child: DropdownButton<ValueObject>(
      // value: selectedValue!.isEmpty ? null : selectedValue,
      value: selectedValue!.value!.isNotEmpty ? selectedValue : null,
      hint: textAutoSize(
          text: hint!,
          width: textWidth,
          maxLines: 1,
          alignment: Alignment.centerLeft,
          fontWeight: FontWeight.bold),
      icon: Icon(Icons.keyboard_arrow_down_outlined,
          color: isEditable ? Get.theme.primaryColorDark : Colors.transparent),
      elevation: 10,
      dropdownColor: Get.theme.primaryColorLight,
      focusColor: Get.theme.primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      //style: Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
      underline: Container(height: 0, color: Colors.transparent),
      menuMaxHeight: Get.width,
      onChanged: isEditable
          ? (value) {
              onChange!(value!);
            }
          : null,
      items: items!.map<DropdownMenuItem<ValueObject>>((ValueObject value) {
        return DropdownMenuItem<ValueObject>(
          value: value,
          child: textAutoSize(
              text: value.text.toString(),
              width: textWidth,
              maxLines: 1,
              alignment: Alignment.centerLeft,
              fontWeight: FontWeight.bold),
        );
      }).toList(),
    ),
  );
}

Widget dropDownAllProjectForAgency(
    {List<ValueObject>? items,
    ValueObject? selectedValue,
    String? hint,
    double? hPadding,
    Function(ValueObject value)? onChange,
    double? viewWidth,
    double? extraWidth,
    double height = kToolbarHeight - 5,
    bool isEditable = true,
    Color? bgColor}) {
  viewWidth = viewWidth ?? Get.width;
  var textWidth = viewWidth - extraWidth!;
  hPadding = hPadding ?? dp16;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: hPadding),
    height: height,
    width: Get.width,
    alignment: Alignment.center,
    decoration: boxDecorationRoundBorder(
        bgColor: Get.theme.colorScheme.surface,
        borderColor: Get.theme.primaryColor),
    child: DropdownButton<ValueObject>(
      // value: selectedValue!.isEmpty ? null : selectedValue,
      value: selectedValue!.value!.isNotEmpty ? selectedValue : null,
      hint: textAutoSize(
          text: hint!,
          width: textWidth,
          maxLines: 1,
          alignment: Alignment.centerLeft,
          fontWeight: FontWeight.bold),
      icon: Icon(Icons.keyboard_arrow_down_outlined,
          color: isEditable ? Get.theme.primaryColorDark : Colors.transparent),
      elevation: 10,
      dropdownColor: Get.theme.primaryColorLight,
      focusColor: Get.theme.primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      //style: Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
      underline: Container(height: 0, color: Colors.transparent),
      menuMaxHeight: Get.width,
      onChanged: isEditable
          ? (value) {
              onChange!(value!);
            }
          : null,
      items: items!.map<DropdownMenuItem<ValueObject>>((ValueObject value) {
        return DropdownMenuItem<ValueObject>(
          value: value,
          child: textAutoSize(
              text: value.text.toString(),
              width: textWidth,
              maxLines: 1,
              alignment: Alignment.centerLeft,
              fontWeight: FontWeight.bold),
        );
      }).toList(),
    ),
  );
}

Widget dropDownAllProjectForDistrict(
    {List<DistrictListResponse>? items,
    DistrictListResponse? selectedValue,
    String? hint,
    double? hPadding,
    Function(DistrictListResponse value)? onChange,
    double? viewWidth,
    double? extraWidth,
    double height = kToolbarHeight - 5,
    bool isEditable = true,
    Color? bgColor}) {
  viewWidth = viewWidth ?? Get.width;
  var textWidth = viewWidth - extraWidth!;
  hPadding = hPadding ?? dp16;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: hPadding),
    height: height,
    width: Get.width,
    alignment: Alignment.center,
    decoration: boxDecorationRoundBorder(
        bgColor: Get.theme.colorScheme.surface,
        borderColor: Get.theme.primaryColor),
    child: DropdownButton<DistrictListResponse>(
      // value: selectedValue!.isEmpty ? null : selectedValue,
      value: selectedValue!.baseLocationId!.isNotEmpty ? selectedValue : null,
      hint: textAutoSize(
          text: hint!,
          width: textWidth,
          maxLines: 1,
          alignment: Alignment.centerLeft,
          fontWeight: FontWeight.bold),
      icon: Icon(Icons.keyboard_arrow_down_outlined,
          color: isEditable ? Get.theme.primaryColorDark : Colors.transparent),
      elevation: 10,
      dropdownColor: Get.theme.primaryColorLight,
      focusColor: Get.theme.primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      //style: Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
      underline: Container(height: 0, color: Colors.transparent),
      menuMaxHeight: Get.width,
      onChanged: isEditable
          ? (value) {
              onChange!(value!);
            }
          : null,
      items: items!.map<DropdownMenuItem<DistrictListResponse>>(
          (DistrictListResponse value) {
        return DropdownMenuItem<DistrictListResponse>(
          value: value,
          child: textAutoSize(
              text: value.name.toString(),
              width: textWidth,
              maxLines: 1,
              alignment: Alignment.centerLeft,
              fontWeight: FontWeight.bold),
        );
      }).toList(),
    ),
  );
}

Widget dropDownListIndex(
    {List<String>? items,
    int? selectedValue,
    String? hint,
    double? hPadding,
    Function(int value)? onChange,
    double? viewWidth,
    double? extraWidth,
    double height = kToolbarHeight - 5,
    bool isEditable = true,
    Color? bgColor}) {
  viewWidth = viewWidth ?? Get.width;
  var textWidth = viewWidth - extraWidth!;
  hPadding = hPadding ?? dp16;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: hPadding),
    height: height,
    width: Get.width,
    alignment: Alignment.center,
    decoration: boxDecorationRoundBorder(
        bgColor: Get.theme.colorScheme.surface,
        borderColor: Get.theme.primaryColor),
    child: DropdownButton<String>(
      // value: selectedValue!.isEmpty ? null : selectedValue,
      value: selectedValue != -1 ? items![selectedValue!] : null,
      hint: textAutoSize(
          text: hint!,
          width: textWidth,
          maxLines: 1,
          alignment: Alignment.centerLeft,
          fontWeight: FontWeight.bold),
      icon: Icon(Icons.keyboard_arrow_down_outlined,
          color: isEditable ? Get.theme.primaryColorDark : Colors.transparent),
      elevation: 10,
      dropdownColor: Get.theme.primaryColorLight,
      focusColor: Get.theme.primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      //style: Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
      underline: Container(height: 0, color: Colors.transparent),
      menuMaxHeight: Get.width,
      onChanged: isEditable
          ? (value) {
              onChange!(items!.indexOf(value!));
            }
          : null,
      items: items!.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: textAutoSize(
              text: value,
              width: textWidth,
              maxLines: 1,
              alignment: Alignment.centerLeft,
              fontWeight: FontWeight.bold),
        );
      }).toList(),
    ),
  );
}

Widget dropDownList(
    {List<String>? items,
    String? selectedValue,
    String? hint,
    double? hPadding,
    Function(String value)? onChange,
    double? viewWidth,
    double? extraWidth,
    double height = kToolbarHeight - 1,
    bool isEditable = true,
    Color? bgColor}) {
  viewWidth = viewWidth ?? Get.width;
  var textWidth = viewWidth - extraWidth!;
  hPadding = hPadding ?? dp16;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: hPadding),
    height: height,
    width: Get.width,
    alignment: Alignment.center,
    decoration: boxDecorationRoundBorder(
        bgColor: Get.theme.colorScheme.surface,
        borderColor: Get.theme.primaryColor),
    child: DropdownButton<String>(
      value: selectedValue!.isEmpty ? null : selectedValue,
      hint: textAutoSize(
          text: hint!,
          width: textWidth,
          maxLines: 1,
          alignment: Alignment.centerLeft,
          fontWeight: FontWeight.bold),
      icon: Icon(Icons.keyboard_arrow_down_outlined,
          color: isEditable ? Get.theme.primaryColorDark : Colors.transparent),
      elevation: 10,
      dropdownColor: Get.theme.primaryColorLight,
      focusColor: Get.theme.primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      //style: Get.textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
      underline: Container(height: 0, color: Colors.transparent),
      menuMaxHeight: Get.width,
      onChanged: isEditable
          ? (value) {
              onChange!(value!);
            }
          : null,
      items: items!.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: textAutoSize(
              text: value,
              width: textWidth,
              maxLines: 1,
              alignment: Alignment.centerLeft,
              fontWeight: FontWeight.bold),
        );
      }).toList(),
    ),
  );
}

Widget toggleSwitch(bool selectedValue, Function(bool) onChange,
    {double height = 30,
    String activeText = "",
    String inactiveText = "",
    String text = "",
    TextStyle? textStyle,
    MainAxisAlignment? mainAxisAlignment}) {
  return Row(
    mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
    children: [
      if (text.isNotEmpty)
        Text(text, style: textStyle ?? Get.textTheme.titleSmall),
      const SizedBox(width: 5),
      FlutterSwitch(
        width: height * 2,
        height: height,
        valueFontSize: height / 2,
        toggleSize: height - 10,
        value: selectedValue,
        toggleColor: Get.theme.primaryColor,
        activeToggleColor: Get.theme.colorScheme.secondary,
        activeColor: Get.theme.primaryColorLight.withOpacity(0.25),
        inactiveColor: Get.theme.primaryColorLight.withOpacity(0.25),
        borderRadius: height / 2,
        switchBorder: Border.all(width: 2, color: Get.theme.primaryColor),
        padding: 3,
        showOnOff: true,
        activeText: activeText,
        inactiveText: inactiveText,
        onToggle: (val) {
          onChange(val);
        },
      ),
    ],
  );
}

Widget viewTitleWithSubTitleText(
    {String? title, String? subTitle, int? maxLines = 2}) {
  return SizedBox(
    height: dp180,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const VSpacer10(),
        textAutoSize(
            text: stringNullCheck(title),
            textAlign: TextAlign.center,
            fontSize: dp24,
            fontWeight: FontWeight.bold),
        const VSpacer10(),
        textAutoSize(
            text: stringNullCheck(subTitle),
            textAlign: TextAlign.center,
            fontSize: dp15,
            fontWeight: FontWeight.normal,
            color: Get.theme.primaryColorDark,
            maxLines: maxLines!),
      ],
    ),
  );
}

Widget showEmptyView({double? height}) {
  height = height ?? Get.width;
  return SizedBox(
    height: height,
    child: Container(
      alignment: Alignment.center,
      child: textAutoSize(
        text: "list_item_message".tr,
        maxLines: 2,
        color: Get.theme.primaryColor,
        fontWeight: FontWeight.normal,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget showEmptyViewForUserList({double? height}) {
  height = height ?? Get.width;
  return SizedBox(
    height: height,
    child: Container(
      alignment: Alignment.center,
      child: textAutoSize(
        text: "no_pd_info_message".tr,
        maxLines: 2,
        color: Get.theme.primaryColor,
        fontWeight: FontWeight.normal,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget showEmptyViewForPDInfo({double? height}) {
  height = height ?? Get.width;
  return SizedBox(
    height: height,
    child: Container(
      alignment: Alignment.center,
      child: textAutoSize(
        text: "no_pd_info_message".tr,
        maxLines: 2,
        color: Get.theme.primaryColor,
        fontWeight: FontWeight.normal,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget showEmptyImageView({double? height}) {
  height = height ?? Get.width;
  return SizedBox(
    height: height,
    child: Container(
      alignment: Alignment.center,
      child: textAutoSize(
        text: "empty_image_list_item_message".tr,
        maxLines: 2,
        color: Get.theme.primaryColor,
        fontWeight: FontWeight.normal,
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget handleEmptyViewWithLoading(bool isLoading,
    {double height = 50, String? message, Color? bgColor}) {
  String finalMessage = message ?? "data_not_found".tr;
  return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(20),
      height: height,
      color: bgColor,
      child: isLoading
          ? const CircularProgressIndicator()
          : textAutoSize(
              text: finalMessage,
              maxLines: 2,
              color: Get.theme.primaryColor,
              fontWeight: FontWeight.normal,
              textAlign: TextAlign.center,
            ));
}

Widget moreMenu(
    BuildContext context, List<String> menus, Function(String) onSelect,
    {bool isVertical = true}) {
  return PopupMenuButton<String>(
    onSelected: onSelect,
    itemBuilder: (BuildContext context) {
      return menus.map((String choice) {
        return PopupMenuItem<String>(
          value: choice,
          child: Text(choice, style: Get.textTheme.bodyLarge),
        );
      }).toList();
    },
    child: Icon(isVertical ? Icons.more_vert : Icons.more_horiz, size: 25),
  );
}

Widget reportsItemView({String? btnText, VoidCallback? action}) {
  return InkWell(
    onTap: action,
    child: Container(
      decoration: boxDecorationRoundShadowLight(borderRadius: 5),
      alignment: Alignment.center,
      //margin: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
      margin: const EdgeInsets.only(bottom: dp5),
      padding: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp16),
      height: dp60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 1,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: showImageAsset(
                      imagePath: AssetConstants.icReports, height: dp50))),
          const HSpacer20(),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textAutoSize(
                    // text: "ProjectFullName",
                    text: btnText!,
                    maxLines: 1,
                    fontSize: dp16,
                    fontWeight: FontWeight.bold),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget projectListItemView(
    BuildContext context, AllProjectsResponse allProjectsResponse,
    {bool? isFavorite = true}) {
  return InkWell(
    onLongPress: () {
      alertForInfo(
          context: context,
          title: 'ProjectFullName'.tr,
          message: allProjectsResponse.name.toString());
    },
    onTap: () {
      Get.to(
          () => ProjectDetailsScreen(allProjectsResponse: allProjectsResponse));
    },
    child: Container(
      decoration: boxDecorationRoundShadowLight(),
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: dp5, vertical: dp5),
      //padding: const EdgeInsets.symmetric(horizontal: dp2, vertical: dp2),
      height: dp70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: showImageAsset(
                        imagePath: AssetConstants.icProject, height: dp50)),
              )),
          const HSpacer5(),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textAutoSize(
                    // text: "ProjectFullName",
                    //text: allProjectsResponse.name.toString(),
                    text:
                        "${allProjectsResponse.code.toString()} ${": "} ${allProjectsResponse.name.toString()}",
                    maxLines: 1,
                    fontSize: dp14,
                    fontWeight: FontWeight.bold),
                const VSpacer10(),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: textAutoSize(
                            text: "${'ProjectTimeline'.tr} ",
                            maxLines: 1,
                            fontSize: dp12,
                            fontWeight: FontWeight.normal)),
                    Expanded(
                      flex: 4,
                      child: textAutoSizeSubTitle(
                          // text: "Project Subtitle",
                          text:
                              "${formatDateToDDMMYYYY(allProjectsResponse.dateOfCommencement.toString())}  To  ${formatDateToDDMMYYYY(allProjectsResponse.dateOfCompletion.toString())}",
                          maxLines: 1,
                          fontSize: dp12,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                // textAutoSizeSubTitle(
                //     // text: "Project Subtitle",
                //     text: allProjectsResponse.nameBangla.toString(),
                //     maxLines: 1,
                //     fontSize: dp12,
                //     fontWeight: FontWeight.bold),
              ],
            ),
          ),
          /* const HSpacer20(),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: textAutoSize(
                  text: allProjectsResponse.statusName.toString(),
                  alignment: Alignment.centerRight),
            ),
          ),
          const HSpacer20(),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: showImageAsset(
                  imagePath: isFavorite!
                      ? AssetConstants.icFavorite
                      : AssetConstants.icCross,
                  height: 30,
                  color: Get.theme.colorScheme.secondary),
            ),
          ), */
        ],
      ),
    ),
  );
}

Widget projectItemView(
    //BuildContext context, ProjectsListResponse projectsListResponse,
    BuildContext context,
    AllProjectsResponse projectsListResponse,
    {bool? isFavorite = true}) {
  return InkWell(
    onLongPress: () {
      alertForInfo(
          context: context,
          title: 'ProjectFullName'.tr,
          message: projectsListResponse.name.toString());
    },
    onTap: () {
      Get.to(() => WishListProjectDetailsScreen(
          projectsListResponse: projectsListResponse));
    },
    child: Container(
      decoration: boxDecorationRoundShadowLight(),
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: dp5, vertical: dp5),
      //padding: const EdgeInsets.symmetric(horizontal: dp2, vertical: dp2),
      height: dp70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: showImageAsset(
                        imagePath: AssetConstants.icProject, height: dp50)),
              )),
          const HSpacer5(),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textAutoSize(
                    // text: "ProjectFullName",
                    //text: allProjectsResponse.name.toString(),
                    text:
                        "${projectsListResponse.code.toString()} ${": "} ${projectsListResponse.name.toString()}",
                    maxLines: 1,
                    fontSize: dp14,
                    fontWeight: FontWeight.bold),
                const VSpacer10(),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: textAutoSize(
                            text: "${'ProjectTimeline'.tr} ",
                            maxLines: 1,
                            fontSize: dp12,
                            fontWeight: FontWeight.normal)),
                    Expanded(
                      flex: 4,
                      child: textAutoSizeSubTitle(
                          // text: "Project Subtitle",
                          text:
                              "${formatDateToDDMMYYYY(projectsListResponse.dateOfCommencement.toString())}  To  ${formatDateToDDMMYYYY(projectsListResponse.dateOfCompletion.toString())}",
                          maxLines: 1,
                          fontSize: dp12,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                // textAutoSizeSubTitle(
                //     // text: "Project Subtitle",
                //     text: allProjectsResponse.nameBangla.toString(),
                //     maxLines: 1,
                //     fontSize: dp12,
                //     fontWeight: FontWeight.bold),
              ],
            ),
          ),
          /* const HSpacer20(),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: textAutoSize(
                  text: allProjectsResponse.statusName.toString(),
                  alignment: Alignment.centerRight),
            ),
          ),
          const HSpacer20(),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: showImageAsset(
                  imagePath: isFavorite!
                      ? AssetConstants.icFavorite
                      : AssetConstants.icCross,
                  height: 30,
                  color: Get.theme.colorScheme.secondary),
            ),
          ), */
        ],
      ),
    ),
  );
}

Widget projectEstimatedCostDetailsItemView(BuildContext context,
    ProjectEstimatedCostResponse projectEstimatedCostResponse,
    {bool? isFavorite = true}) {
  /*int amountFe = 0;
  int amountLocal = 0;

  for (Source source in projectEstimatedCostResponse.sources!) {
    amountFe = amountFe + (source?.amountFe ?? 0).toInt();
    amountLocal = amountLocal + (source?.amountLocal ?? 0);
  }*/

  return Container(
      decoration: boxDecorationRoundShadowLight(),
      margin: const EdgeInsets.all(dp5),
      padding: const EdgeInsets.all(dp10),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Align(
                    alignment: Alignment.center,
                    child: showImageAsset(
                        imagePath: AssetConstants.icTaka, height: dp30)),
              )),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                textAutoSize(
                    color: Colors.black.withOpacity(.6),
                    //text: stringNullCheck(projectEstimatedCostResponse.parentFinancialSourceName.toString()),
                    text: "",
                    maxLines: 1,
                    fontSize: dp16,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.bold),
                textAutoSize(
                    color: Colors.black.withOpacity(.5),
                    text: stringNullCheck("Local : "),
                    maxLines: 1,
                    fontSize: dp14,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.bold),
                textAutoSize(
                    color: Colors.black.withOpacity(.5),
                    text: stringNullCheck("Special : "),
                    maxLines: 1,
                    fontSize: dp14,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.bold),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: textAutoSize(
                text: stringNullCheck("Total : "),
                maxLines: 1,
                fontSize: dp14,
                alignment: Alignment.center,
                fontWeight: FontWeight.bold),
          ),
        ],
      ));
}

Widget entryForm8ItemView(
    BuildContext context, EntryForm8ListResponse entryForm8ListResponse,
    {bool? isFavorite = true}) {
  /*String? amountFe;
  //int? amountLocal = 0;

  for (TargetAchievementDatum targetAchievementDatum in entryForm8ListResponse.econCodeTypeDetail![1].targetAchievementData!) {

    amountFe = targetAchievementDatum.financialProgressUptoCurrentMonth.toString();


  }*/

  return Container(
      decoration: boxDecorationRoundShadowLight(),
      margin: const EdgeInsets.all(dp5),
      padding: const EdgeInsets.all(dp10),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Align(
                    alignment: Alignment.center,
                    child: showImageAsset(
                        imagePath: AssetConstants.icTaka, height: dp30)),
              )),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                textAutoSize(
                    color: Colors.black.withOpacity(.6),
                    text: stringNullCheck(
                        entryForm8ListResponse.projectExpenditureSummaryId),
                    maxLines: 1,
                    fontSize: dp16,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.bold),
                textAutoSize(
                    color: Colors.black.withOpacity(.5),
                    text: stringNullCheck(entryForm8ListResponse.fiscalYearId),
                    maxLines: 1,
                    fontSize: dp14,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.bold),
                textAutoSize(
                    color: Colors.black.withOpacity(.5),
                    text: stringNullCheck(entryForm8ListResponse.projectId),
                    maxLines: 1,
                    fontSize: dp14,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.bold),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: textAutoSize(
                text: stringNullCheck(entryForm8ListResponse.fiscalYearId),
                maxLines: 1,
                fontSize: dp14,
                alignment: Alignment.center,
                fontWeight: FontWeight.bold),
          ),
        ],
      ));
}

Widget projectAllocationCostDetailsItemView(BuildContext context,
    ProjectAllocationCostResponse projectAllocationCostResponse,
    {bool? isFavorite = true}) {
  int amountGob = 0;
  int amountRpa = 0;
  int amountTotal = 0;

  for (AllocationDetail allocationDetail
      in projectAllocationCostResponse.allocationDetails!) {
    amountGob = amountGob + (allocationDetail?.amountGob ?? 0);
    amountRpa = amountRpa + (allocationDetail?.amountRpa ?? 0);
  }
  amountTotal = amountGob + amountRpa;

  return Container(
      decoration: boxDecorationRoundShadowLight(),
      margin: const EdgeInsets.all(dp5),
      padding: const EdgeInsets.all(dp10),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Align(
                    alignment: Alignment.center,
                    child: showImageAsset(
                        imagePath: AssetConstants.icTaka, height: dp30)),
              )),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                textAutoSize(
                    color: Colors.black.withOpacity(.6),
                    text: stringNullCheck(
                        "${projectAllocationCostResponse.developmentTypeName} ${projectAllocationCostResponse.fiscalYearId}"),
                    maxLines: 1,
                    fontSize: dp16,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.bold),
                textAutoSize(
                    color: Colors.black.withOpacity(.5),
                    text:
                        stringNullCheck("GoB : ${formatter.format(amountGob)}"),
                    maxLines: 1,
                    fontSize: dp14,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.bold),
                textAutoSize(
                    color: Colors.black.withOpacity(.5),
                    //text: stringNullCheck("RPA : $amountRpa"),
                    text:
                        stringNullCheck("RPA : ${formatter.format(amountRpa)}"),
                    maxLines: 1,
                    fontSize: dp14,
                    alignment: Alignment.centerLeft,
                    fontWeight: FontWeight.bold),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: textAutoSize(
                text:
                    stringNullCheck("Total : ${formatter.format(amountTotal)}"),
                maxLines: 1,
                fontSize: dp14,
                alignment: Alignment.center,
                fontWeight: FontWeight.bold),
          ),
        ],
      ));
}

Widget projectExpenditureCostDetailsItemView(BuildContext context,
    ProjectExpenditureCostResponse projectExpenditureCostResponse,
    {bool? isFavorite = true}) {
  int summaryAmountGob = 0;
  double detailAmountGob = 0;
  int summaryAmountRpa = 0;
  int summaryAmountTotal = 0;

  for (ExpenditureDetail expenditureDetail
      in projectExpenditureCostResponse.expenditureDetails!) {
    summaryAmountGob =
        summaryAmountGob + (expenditureDetail?.summaryAmountGob ?? 0).toInt();
    detailAmountGob =
        detailAmountGob + (expenditureDetail?.detailAmountGob ?? 0);
    summaryAmountRpa =
        summaryAmountRpa + (expenditureDetail?.summaryAmountRpa ?? 0);
  }

  summaryAmountTotal = summaryAmountRpa + summaryAmountGob.toInt();

  return Container(
      decoration: boxDecorationRoundShadowLight(),
      margin: const EdgeInsets.all(dp5),
      padding: const EdgeInsets.all(dp10),
      child: InkWell(
        onTap: () {
          Get.to(() => NewEntryForm8ReportScreen());
          // Get.to(() => EntryForm8ReportScreen());
          //Get.to(() => EntryForm8ReportScreen(projectExpenditureCostResponse: projectExpenditureCostResponse));
        },
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Align(
                      alignment: Alignment.center,
                      child: showImageAsset(
                          imagePath: AssetConstants.icTaka, height: dp30)),
                )),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  textAutoSize(
                      color: Colors.black.withOpacity(.6),
                      text: stringNullCheck(
                          "${projectExpenditureCostResponse.monthName} ${projectExpenditureCostResponse.fiscalYearId}"),
                      maxLines: 1,
                      fontSize: dp16,
                      alignment: Alignment.centerLeft,
                      fontWeight: FontWeight.bold),
                  textAutoSize(
                      color: Colors.black.withOpacity(.5),
                      text: stringNullCheck(
                          "GoB : ${formatter.format(summaryAmountGob)}"),
                      maxLines: 1,
                      fontSize: dp14,
                      alignment: Alignment.centerLeft,
                      fontWeight: FontWeight.bold),
                  textAutoSize(
                      color: Colors.black.withOpacity(.5),
                      text: stringNullCheck(
                          "RPA : ${formatter.format(summaryAmountRpa)}"),
                      maxLines: 1,
                      fontSize: dp14,
                      alignment: Alignment.centerLeft,
                      fontWeight: FontWeight.bold),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: textAutoSize(
                  text: stringNullCheck(
                      "total : ${formatter.format(summaryAmountTotal)}"),
                  maxLines: 1,
                  fontSize: dp14,
                  alignment: Alignment.center,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ));
}

Widget activityHistoryListItemView(
  BuildContext context,
  WorkflowActivityHistoryResponse workflowActivityHistoryResponse,
  WorkflowActivity allProjectsResponse, {
  String? imagePath,
  bool? isFavorite = true,
}) {
  String encodedToken = Uri.encodeComponent(fullToken);
  String? fileSrc;
  String? fileId;

  if (allProjectsResponse.workflowNodeFromAttachmentFileIds?.isNotEmpty ??
      false) {
    var firstAttachment =
        allProjectsResponse.workflowNodeFromAttachmentFileIds!.first;
    fileId = firstAttachment.fileId;
    fileSrc =
        '${APIConstants.baseUrl}${APIConstants.projectFilePathEndUrl}$fileId';
    debugPrint("PDF URL: $fileSrc");
  }

  void openAttachment() {
    if (fileId != null) {
      final fileUrl =
          '${APIConstants.baseUrl}${APIConstants.projectFilePathEndUrl}$fileId';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PDFViewerScreen(
            pdfUrl: fileUrl,
            token: fullToken, // Pass full token for header use
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No attachment found.")),
      );
    }
  }

  return SingleChildScrollView(
    child: Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: accentBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        stringNullCheck(
                            allProjectsResponse.workflowActionName.toString()),
                        style: TextStyle(
                          color: accentBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: accentGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: accentGreenText,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "${formatDateToDDMMYYYY(allProjectsResponse.timestamp.toString())}, ${formatDateToHHMMAPM(allProjectsResponse.timestamp.toString())}",
                            style: const TextStyle(
                              color: accentGreenText,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.man, size: 16, color: Color(0xFF23B3C2)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "From User:  ${stringNullCheck(allProjectsResponse.workflowNodeFromUsername.toString())}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.person,
                        size: 16, color: Color(0xFF23B3C2)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "To User:  ${stringNullCheck(allProjectsResponse.workflowNodeToUsername.toString())}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.comment,
                        size: 16, color: Color(0xFF12A3C2)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Comment:  ${stringNullCheck(allProjectsResponse.workflowNodeFromComment.toString().replaceAll(RegExp(r'<\/?p>'), ''))}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: dp20),
                if (fileSrc != null)
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: openAttachment,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF4A90E2)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.picture_as_pdf,
                                color: accentGreenText, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              "View PDF",
                              style: const TextStyle(
                                color: accentGreenText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  /*Container(
    decoration: boxDecorationRoundShadowLight(),
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
    padding: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textAutoSize(
          text:
          "${formatDateToDDMMYYYY(allProjectsResponse.timestamp.toString())}, ${formatDateToHHMMAPM(allProjectsResponse.timestamp.toString())}",
          maxLines: 1,
          fontSize: dp16,
          alignment: Alignment.center,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
          leftText: "Action Name",
          rightText: stringNullCheck(allProjectsResponse.workflowActionName.toString()),
        ),
        const SizedBox(height: dp5),
        twoSidedTextWithColon2(
          leftText: "From User",
          rightText: stringNullCheck(allProjectsResponse.workflowNodeFromUsername.toString()),
        ),
        const SizedBox(height: dp5),
        twoSidedTextWithColon2(
          leftText: "To User",
          rightText: stringNullCheck(allProjectsResponse.workflowNodeToUsername.toString()),
        ),
        const SizedBox(height: dp5),
        twoSidedTextWithColon2(
          leftText: "Comment",
          maxLineForRightText: 4,
          rightText: stringNullCheck(allProjectsResponse.workflowNodeFromComment.toString().replaceAll(RegExp(r'<\/?p>'), ''),
          ),
        ),
        const SizedBox(height: dp10),
        if (fileSrc != null)
          Row(
            children: [
              const Expanded(
                flex: 4,
                child: Text("File", style: TextStyle(color: Colors.black)),
              ),
              Expanded(
                flex: 6,
                child: ElevatedButton.icon(
                  onPressed: openAttachment,
                  icon: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  label: const Text("View PDF"),
                ),
              ),
            ],
          ),
      ],
    ),
  );*/
}

/*Widget activityHistoryListItemView(
    BuildContext context,
    WorkflowActivityHistoryResponse workflowActivityHistoryResponse,
    WorkflowActivity allProjectsResponse,
    {String? imagePath,
    bool? isFavorite = true}) {

  String encodedToken = Uri.encodeComponent(fullToken);
  String? fileSrc;

  if (allProjectsResponse.workflowNodeFromAttachmentFileIds?.isNotEmpty ?? false) {
    var firstAttachment = allProjectsResponse.workflowNodeFromAttachmentFileIds!.first;
    //fileSrc = '${APIConstants.baseUrl}${APIConstants.projectFilePathEndUrl}${firstAttachment.fileId}?t=$encodedToken';
    fileSrc = '${APIConstants.baseUrl}${APIConstants.projectFilePathEndUrl}${firstAttachment.fileId}';
    debugPrint("PDF URL Test_1: $fileSrc");


  }



  */ /*String? imageSrc;
  for (WorkflowNodeFromAttachmentFileId activityHistory
      in allProjectsResponse.workflowNodeFromAttachmentFileIds!) {
    imageSrc =
        '${APIConstants.baseUrl.toString()}${APIConstants.projectImagePathEndUrl.toString()}${activityHistory.fileId.toString()}?t=$encodedToken';
  }*/ /*

  return Container(
    decoration: boxDecorationRoundShadowLight(),
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
    padding: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
    //height: imageSrc != null ? dp300 : dp200,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        textAutoSize(
            text:
                " ${formatDateToDDMMYYYY(allProjectsResponse!.timestamp.toString())}, ${formatDateToHHMMAPM(allProjectsResponse!.timestamp.toString())} ",
            maxLines: 1,
            fontSize: dp16,
            alignment: Alignment.center,
            fontWeight: FontWeight.bold),
        SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Action Name",
            rightText: stringNullCheck(
                allProjectsResponse.workflowActionName.toString())),
        SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "From User",
            rightText: stringNullCheck(
                allProjectsResponse.workflowNodeFromUsername.toString())),
        SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "To User",
            rightText: stringNullCheck(
                allProjectsResponse.workflowNodeToUsername.toString())),

        SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "Comment",
            maxLineForRightText: 4,
            rightText: stringNullCheck(allProjectsResponse.workflowNodeFromComment.toString().replaceAll(RegExp(r'<\/?p>'), ''))),
            //rightText: stringNullCheck(allProjectsResponse.workflowNodeFromComment.toString())),
        SizedBox(height: dp10),




  */ /*fileSrc != null */ /**/ /*&& fileSrc.endsWith('.pdf')*/ /**/ /*
            ?*/ /*

  Row(children: [
                  Expanded(
                      flex: 4,
                      child: Text(
                        "File",
                        style: TextStyle(color: Colors.black),
                      )),
                  Expanded(
                      flex: 6,
                      child: ElevatedButton.icon(
                        onPressed: () {


                          void openAttachment(BuildContext context, String fileId, String token) {
                            final fileUrl = "http://staging.epmis.gov.bd:8443/api/file-service/api/download/$fileId";

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PDFViewerScreen(
                                  pdfUrl: fileUrl,
                                  token: token,
                                ),
                              ),
                            );
                          }


                          */ /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PDFViewerScreen(
                                pdfUrl: fileSrc,
                                token: token,
                              ),
                            ),
                          );*/ /*


                        },
                        icon: Icon(Icons.picture_as_pdf, color: Colors.red),
                        label: Text("View PDF"),
                      )

                  ),
                ],
              )





      */ /*: const SizedBox(),*/ /*
      ],
    ),
  );
}*/

Widget workflowDetailsListItemView(BuildContext context,
    WorkflowDetailsResponse workflowDetailsResponse, Detail details) {
  return Container(
    decoration: boxDecorationRoundShadowLight(),
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
    padding: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "First Name",
            rightText: stringNullCheck(details.firstName.toString())),
        SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "Last Name",
            rightText: stringNullCheck(details.lastName.toString())),
        SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "Email",
            rightText: stringNullCheck(details.email.toString())),
        SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "level",
            maxLineForRightText: 4,
            rightText: stringNullCheck(details.level.toString())),
        SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "Workflow Role",
            maxLineForRightText: 4,
            rightText: stringNullCheck(details.workflowRole.toString())),
        SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "User Type",
            maxLineForRightText: 4,
            rightText: stringNullCheck(details.userType.toString())),
        SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "File on hand",
            maxLineForRightText: 4,
            rightText: stringNullCheck(details.fileOnHand.toString())),
      ],
    ),
  );
}

Widget workflowExpenditureDetailsListItemView(BuildContext context,
    WorkflowExpenditureDetailsResponse workflowExpenditureDetailsResponse) {
  return Container(
    decoration: boxDecorationRoundShadowLight(),
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
    padding: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Bank Name",
            rightText: stringNullCheck(
                workflowExpenditureDetailsResponse.bankName.toString())),
        SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "Package",
            rightText: stringNullCheck(workflowExpenditureDetailsResponse
                .packageDescription
                .toString())),
        /*SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "Email",
            rightText: stringNullCheck(details.email.toString())),
        SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "level",
            maxLineForRightText: 4,
            rightText: stringNullCheck(details.level.toString())),
        SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "Workflow Role",
            maxLineForRightText: 4,
            rightText:
                stringNullCheck(details.workflowRole.toString())),
        SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "User Type",
            maxLineForRightText: 4,
            rightText:
                stringNullCheck(details.userType.toString())),
        SizedBox(height: dp5),
        twoSidedTextWithColon2(
            leftText: "File on hand",
            maxLineForRightText: 4,
            rightText:
                stringNullCheck(details.fileOnHand.toString())),*/
      ],
    ),
  );
}

Widget allocationListItemView(
    BuildContext context,
    WorkflowAllocationResponse workflowAllocationResponse,
    EconomicCodeGroup economicCodeGroup) {
  String? projectFinancialSourceName;
  double? localAmount;
  double? feeAmount;
  double? totalAmount;

  for (AllocationFinancialDetail allocationFinancialDetail
      in economicCodeGroup.allocationFinancialDetails!) {
    projectFinancialSourceName = allocationFinancialDetail.baseProjectFinancialSourceName.toString();
    localAmount = allocationFinancialDetail.amountLocal;
    feeAmount = allocationFinancialDetail.amountFe;
    totalAmount = allocationFinancialDetail.amountTotal;
  }

  return

      /*Container(
    decoration: boxDecorationRoundShadowLight(),
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
    padding: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        textAutoSize(
            text: "Demand Amount: (Lakh BDT)",
            maxLines: 1,
            fontSize: dp16,
            alignment: Alignment.center,
            fontWeight: FontWeight.bold),
        SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Development Type",
            rightText: stringNullCheck(
                workflowAllocationResponse.developmentTypeName.toString())),
        SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Status",
            rightText:
                stringNullCheck(workflowAllocationResponse.status.toString())),
        SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Fiscal Year",
            rightText: stringNullCheck(
                workflowAllocationResponse.fiscalYearId.toString())),
        SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Date and Time",
            rightText: stringNullCheck(
                "${formatDateToDDMMYYYY(workflowAllocationResponse.timestamp.toString())}, ${formatDateToHHMMAPM(workflowAllocationResponse.timestamp.toString())} ")),
        SizedBox(height: dp10),
        textAutoSize(
            text: "Economic Code Information: (Lakh BDT)",
            maxLines: 1,
            fontSize: dp16,
            alignment: Alignment.center,
            fontWeight: FontWeight.bold),
        SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Economic Code Type",
            rightText: stringNullCheck(
                economicCodeGroup.economicCodesTypeName.toString())),
        SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Project Financial Source Name",
            rightText: stringNullCheck(projectFinancialSourceName.toString())),
        SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Amount Local",
            rightText: stringNullCheck(localAmount.toString())),
        //rightText: stringNullCheck("${formatter.format(localAmount)}")),
        SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Amount Fee",
            rightText: stringNullCheck(feeAmount.toString())),
        SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Amount Total",
            rightText: stringNullCheck(totalAmount.toString())),

      ],
    ),
  );*/

      Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: accentBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        stringNullCheck(economicCodeGroup
                            .economicCodesTypeName
                            .toString()),
                        style: TextStyle(
                          color: accentBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    /*const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: accentGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: accentGreenText,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            " ${formatDateToDDMMYYYY(workflowAllocationResponse.timestamp.toString())}, ${formatDateToHHMMAPM(workflowAllocationResponse.timestamp.toString())} ",
                            style: const TextStyle(
                              color: accentGreenText,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),*/

                  ],
                ),

                /*const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.numbers,
                        size: 16, color: Color(0xFF50E3C2)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Fiscal Year:  ${stringNullCheck(workflowAllocationResponse.fiscalYearId.toString())}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),*/

                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.source,
                        size: 16, color: Color(0xFF22A1B2)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Financial Source:  ${stringNullCheck(projectFinancialSourceName.toString())}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.verified_user_sharp,
                        size: 16, color: Color(0xFF10A3C2)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "FE Amount:  ${formatter.format(feeAmount)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.verified_user_sharp,
                        size: 16, color: Color(0xFF10A3C2)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Local Amount:  ${formatter.format(localAmount)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.verified_user_sharp,
                        size: 16, color: Color(0xFF10A3C2)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Total Amount:  ${formatter.format(totalAmount)}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[800],
                        ),
                      ),
                    ),
                  ],
                ),


              ],
            ),
          ));
}

Widget workflowDemandListItemView(
    BuildContext context,
    WorkflowDemandDetailsResponse workflowDemandDetailsResponse,
    EconomicCodeGroupDemand economicCodeGroupDemand) {
  String? baseEconomicCode;
  String? baseEconomicCodesDescription;
  String? baseEconomicParentCode;
  String? baseEconomicCodesParentDescription;
  String? description;
  int? total = 0;
  String? sequenceNo;

  for (ProjectDemandEconomicCode projectDemandEconomicCode
      in economicCodeGroupDemand.projectDemandEconomicCodes!) {
    baseEconomicCodesDescription =
        projectDemandEconomicCode.baseEconomicCodesDescription;
    baseEconomicCode = projectDemandEconomicCode.baseEconomicCode;
    baseEconomicParentCode = projectDemandEconomicCode.baseEconomicParentCode;
    baseEconomicCodesParentDescription =
        projectDemandEconomicCode.baseEconomicCodesParentDescription;
    description = projectDemandEconomicCode.description;
    total = projectDemandEconomicCode.total;
    sequenceNo = projectDemandEconomicCode.sequenceNo.toString();
  }

  return

      /*Container(
    decoration: boxDecorationRoundShadowLight(),
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp8),
    padding: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        twoSidedTextWithColon2(
            leftText: "Economic Codes Type ",
            rightText: stringNullCheck(
                economicCodeGroupDemand.economicCodesTypeName.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Base Economic Codes Description",
            rightText: stringNullCheck(baseEconomicCodesDescription.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Base Economic Code",
            rightText: stringNullCheck(baseEconomicCode.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Base Economic Parent Code",
            rightText: stringNullCheck(baseEconomicParentCode.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Base Economic Codes Parent Description",
            rightText:
                stringNullCheck(baseEconomicCodesParentDescription.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Description",
            rightText: stringNullCheck(description.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Total", rightText: stringNullCheck(total.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "SequenceNo",
            rightText: stringNullCheck(sequenceNo.toString())),
        const SizedBox(height: dp10),
      ],
    ),
  );*/

    Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.type_specimen, size: 16, color: Color(0xFF4A90E2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Codes Type: ${stringNullCheck(economicCodeGroupDemand.economicCodesTypeName.toString())}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.confirmation_num,
                  size: 16, color: Color(0xFF50E3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Economic Code:  ${stringNullCheck(baseEconomicCode.toString())}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.details,
                  size: 16, color: Color(0xFF50E3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Description:  ${stringNullCheck(description.toString())}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),



          /*const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.details, size: 16, color: Color(0xFF50E3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Base Economic Code Description:  ${stringNullCheck(baseEconomicCodesDescription.toString())}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),*/

           /*const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.confirmation_num,
                  size: 16, color: Color(0xFF50E3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Base Economic Parent Code:  ${stringNullCheck(baseEconomicParentCode.toString())}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),*/

          /*const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.details,
                  size: 16, color: Color(0xFF50E3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Base Economic Parent Code Description:  ${stringNullCheck(baseEconomicCodesParentDescription.toString())}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),*/

         /* const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.numbers,
                  size: 16, color: Color(0xFF50E3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Sequence No:  ${stringNullCheck(sequenceNo.toString())}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),*/

          const SizedBox(height: 12),
          /*Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Total Amount: ${stringNullCheck(total.toString())} ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),*/

          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Amount:  ${formatter.format(total)}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget workflowFundDistributionListItemView(
    BuildContext context,
    WorkflowFundDistributionDetailsResponse
        workflowFundDistributionDetailsResponse,
    EconomicCodeGroupFundDistribution economicCodeGroupFundDistribution) {
  String? baseEconomicCode;
  String? baseEconomicCodesDescription;
  String? baseEconomicParentCode;
  String? baseEconomicCodesParentDescription;
  String? description;
  int? total = 0;
  String? sequenceNo;

  for (FundDistributionEconomicCode fundDistributionEconomicCode
      in economicCodeGroupFundDistribution.fundDistributionEconomicCodes!) {
    baseEconomicCodesDescription =
        fundDistributionEconomicCode.baseEconomicCodesDescription;
    baseEconomicCode = fundDistributionEconomicCode.baseEconomicCode;
    baseEconomicParentCode =
        fundDistributionEconomicCode.baseEconomicParentCode;
    baseEconomicCodesParentDescription =
        fundDistributionEconomicCode.baseEconomicCodesParentDescription;
    description = fundDistributionEconomicCode.description;
    total = fundDistributionEconomicCode.total;
    sequenceNo = fundDistributionEconomicCode.sequenceNo.toString();
  }

  return
      /*Container(
    decoration: boxDecorationRoundShadowLight(),
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp8),
    padding: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        twoSidedTextWithColon2(
            leftText: "Economic Codes Type ",
            rightText: stringNullCheck(economicCodeGroupFundDistribution.economicCodesTypeName.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Base Economic Codes Description",
            rightText:
                stringNullCheck(baseEconomicCodesDescription.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Base Economic Code",
            rightText: stringNullCheck(baseEconomicCode.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Base Economic Parent Code",
            rightText: stringNullCheck(baseEconomicParentCode.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Base Economic Codes Parent Description",
            rightText:
                stringNullCheck(baseEconomicCodesParentDescription.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Description",
            rightText: stringNullCheck(description.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Total", rightText: stringNullCheck(total.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Sequence No",
            rightText: stringNullCheck(sequenceNo.toString())),
        const SizedBox(height: dp10),
      ],
    ),
  );*/

      Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.home, size: 16, color: Color(0xFF4A90E2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Economic Codes Type : ${stringNullCheck(economicCodeGroupFundDistribution.economicCodesTypeName.toString())}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Base Economic Codes Description: ${stringNullCheck(baseEconomicCodesDescription.toString())} ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Base Economic Code: ${stringNullCheck(baseEconomicCode.toString())} ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Base Economic Parent Code: ${stringNullCheck(baseEconomicParentCode.toString())} ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Base Economic Codes Parent Description: ${stringNullCheck(baseEconomicCodesParentDescription.toString())} ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Description: ${stringNullCheck(description.toString())} ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  //"Total: ${stringNullCheck(total.toString())} ",
                  stringNullCheck("Total : ${formatter.format(total)}"),

                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Sequence No: ${stringNullCheck(sequenceNo.toString())} ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget workflowAllocationDistributionListItemView(
    BuildContext context,
    WorkflowAllocationDistributionDetailsResponse
        workflowAllocationDistributionDetailsResponse,
    EconomicCodeGroupAllocationDistribution
        economicCodeGroupAllocationDistribution) {
  String? baseEconomicCode;
  String? baseEconomicCodesDescription;
  String? baseEconomicParentCode;
  String? baseEconomicCodesParentDescription;
  String? description;
  String? total;
  String? sequenceNo;

  for (ProjectRatificationEconomicCode projectRatificationEconomicCode
      in economicCodeGroupAllocationDistribution
          .projectRatificationEconomicCodes!) {
    baseEconomicCodesDescription =
        projectRatificationEconomicCode.baseEconomicCodesDescription;
    baseEconomicCode = projectRatificationEconomicCode.baseEconomicCode;
    baseEconomicParentCode =
        projectRatificationEconomicCode.baseEconomicParentCode;
    baseEconomicCodesParentDescription =
        projectRatificationEconomicCode.baseEconomicCodesParentDescription;
    description = projectRatificationEconomicCode.description;
    total = projectRatificationEconomicCode.total.toString();
    sequenceNo = projectRatificationEconomicCode.sequenceNo.toString();
  }

  return Container(
    decoration: boxDecorationRoundShadowLight(),
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp8),
    padding: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        /*textAutoSize(
            text: "Demand Amount: (Lakh BDT)",
            maxLines: 1,
            fontSize: dp16,
            alignment: Alignment.center,
            fontWeight: FontWeight.bold),
        SizedBox(height: dp10),*/
        twoSidedTextWithColon2(
            leftText: "Economic Codes Type ",
            rightText: stringNullCheck(economicCodeGroupAllocationDistribution
                .economicCodesTypeName
                .toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Base Economic Codes Description",
            rightText:
                stringNullCheck(baseEconomicCodesDescription.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Base Economic Code",
            rightText: stringNullCheck(baseEconomicCode.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Base Economic Parent Code",
            rightText: stringNullCheck(baseEconomicParentCode.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Base Economic Codes Parent Description",
            rightText:
                stringNullCheck(baseEconomicCodesParentDescription.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Description",
            rightText: stringNullCheck(description.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Total", rightText: stringNullCheck(total.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "SequenceNo",
            rightText: stringNullCheck(sequenceNo.toString())),
        const SizedBox(height: dp10),
      ],
    ),
  );
}

Widget workflowFundReleaseListItemView(BuildContext context,
    FundReleaseFinancialSourceDetail fundReleaseFinancialSourceDetail) {
  return
      /*Container(
    decoration: boxDecorationRoundShadowLight(),
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp8),
    padding: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        twoSidedTextWithColon2(
            leftText: "Base Project Financial SourceName",
            rightText: stringNullCheck(fundReleaseFinancialSourceDetail.baseProjectFinancialSourceName.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Amount Local",
            rightText: stringNullCheck(fundReleaseFinancialSourceDetail.amountLocal.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Amount Fe",
            rightText: stringNullCheck(
                fundReleaseFinancialSourceDetail.amountFe.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Amount Total",
            rightText: stringNullCheck(
                fundReleaseFinancialSourceDetail.amountTotal.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Allocation Amount Local",
            rightText: stringNullCheck(fundReleaseFinancialSourceDetail
                .allocationAmountLocal
                .toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Allocation Amount Fe",
            rightText: stringNullCheck(fundReleaseFinancialSourceDetail
                .allocationAmountFe
                .toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Released Amount Local",
            rightText: stringNullCheck(fundReleaseFinancialSourceDetail
                .releasedAmountLocal
                .toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Released Amount Fe",
            rightText: stringNullCheck(
                fundReleaseFinancialSourceDetail.releasedAmountFe.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "SequenceNo",
            rightText: stringNullCheck(
                fundReleaseFinancialSourceDetail.sequenceNo.toString())),
        const SizedBox(height: dp10),
      ],
    ),
  );*/

      Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.home, size: 16, color: Color(0xFF4A90E2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Base Project Financial SourceName: ${stringNullCheck(fundReleaseFinancialSourceDetail.baseProjectFinancialSourceName.toString())}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  //"Amount Local: ${stringNullCheck(fundReleaseFinancialSourceDetail.amountLocal.toString())} ",
                  stringNullCheck("Amount Local : ${formatter.format(fundReleaseFinancialSourceDetail.amountLocal)}"),

                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  //"Amount FE: ${stringNullCheck(fundReleaseFinancialSourceDetail.amountFe.toString())} ",
                  stringNullCheck("Amount FE : ${formatter.format(fundReleaseFinancialSourceDetail.amountFe)}"),

                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  //"Amount Total: ${stringNullCheck(fundReleaseFinancialSourceDetail.amountTotal.toString())} ",
                  stringNullCheck("Amount Total : ${formatter.format(fundReleaseFinancialSourceDetail.amountTotal)}"),

                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  //"Allocation Amount Local: ${stringNullCheck(fundReleaseFinancialSourceDetail.allocationAmountLocal.toString())} ",
                  stringNullCheck("Allocation Amount Local: ${formatter.format(fundReleaseFinancialSourceDetail.allocationAmountLocal)}"),

                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  //"Allocation Amount Fe: ${stringNullCheck(fundReleaseFinancialSourceDetail.allocationAmountFe.toString())} ",
                  stringNullCheck("Allocation Amount FE: ${formatter.format(fundReleaseFinancialSourceDetail.allocationAmountFe)}"),

                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  //"Released Amount Local: ${stringNullCheck(fundReleaseFinancialSourceDetail.releasedAmountLocal.toString())} ",
                  stringNullCheck("Released Amount Local: ${formatter.format(fundReleaseFinancialSourceDetail.releasedAmountLocal)}"),

                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  //"Released Amount Fe: ${stringNullCheck(fundReleaseFinancialSourceDetail.releasedAmountFe.toString())} ",
                  stringNullCheck("Released Amount FE: ${formatter.format(fundReleaseFinancialSourceDetail.releasedAmountFe)}"),

                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "SequenceNo: ${stringNullCheck(fundReleaseFinancialSourceDetail.sequenceNo.toString())} ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget workflowAllocationReturnListItemView(
    BuildContext context, FinancialDetail allocationFinancialDetails) {
  return

      /*Container(
    decoration: boxDecorationRoundShadowLight(),
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp8),
    padding: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        twoSidedTextWithColon2(
            leftText: "Base Project Financial SourceName",
            rightText: stringNullCheck(allocationFinancialDetails
                .baseProjectFinancialSourceName
                .toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Amount Local",
            rightText: stringNullCheck(
                allocationFinancialDetails.amountLocal.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Amount Fe",
            rightText: stringNullCheck(
                allocationFinancialDetails.amountFe.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Amount Total",
            rightText: stringNullCheck(
                allocationFinancialDetails.amountTotal.toString())),
        const SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Sequence No",
            rightText: stringNullCheck(
                allocationFinancialDetails.sequenceNo.toString())),
        const SizedBox(height: dp10),
      ],
    ),
  );*/

      Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.home, size: 16, color: Color(0xFF4A90E2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Base Project Financial SourceName: ${stringNullCheck(allocationFinancialDetails.baseProjectFinancialSourceName.toString())}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  //"Amount Local: ${stringNullCheck(allocationFinancialDetails.amountLocal.toString())} ",
                  stringNullCheck("Amount Local: ${formatter.format(allocationFinancialDetails.amountLocal)}"),

                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  //"Amount FE: ${stringNullCheck(allocationFinancialDetails.amountFe.toString())} ",
                  stringNullCheck("Amount FE: ${formatter.format(allocationFinancialDetails.amountFe)}"),

                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  //"Amount Total: ${stringNullCheck(allocationFinancialDetails.amountTotal.toString())} ",
                  stringNullCheck("Amount Total: ${formatter.format(allocationFinancialDetails.amountTotal)}"),

                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Sequence No: ${stringNullCheck(allocationFinancialDetails.sequenceNo.toString())} ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

/*Widget workflowReappropriationListItemView(
    BuildContext context,
    FinancialSourceSubGroup financialSourceSubGroup) {
  return Container(
    decoration: boxDecorationRoundShadowLight(),
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp8),
    padding: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        twoSidedTextWithColon2(
            leftText: "Sub Financial SourceName",
            rightText: stringNullCheck(financialSourceSubGroup.subFinancialSourceName.toString())),
        const SizedBox(height: dp10),

        twoSidedTextWithColon2(
            leftText: "SequenceNo",
            rightText: stringNullCheck(financialSourceSubGroup.sequenceNo.toString())),
        const SizedBox(height: dp10),

      ],
    ),
  );
}*/

Widget workflowReappropriationListItemView(
  BuildContext context,
  WorkflowReappropriationDetailsResponse workflowReappropriationDetailsResponse,
) {
  /*String? projectFinancialSourceName;
  String? localAmount;

  for (AllocationFinancialDetail allocationFinancialDetail
  in economicCodeGroup.allocationFinancialDetails!) {
    projectFinancialSourceName =
        allocationFinancialDetail.baseProjectFinancialSourceName.toString();
    localAmount = allocationFinancialDetail.amountLocal.toString();
    feeAmount = allocationFinancialDetail.amountFe.toString();
    totalAmount = allocationFinancialDetail.amountTotal.toString();
  }*/

  return

      /*Container(
    decoration: boxDecorationRoundShadowLight(),
    alignment: Alignment.center,
    margin: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp8),
    padding: const EdgeInsets.symmetric(horizontal: dp8, vertical: dp8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        twoSidedTextWithColon2(
            leftText: "Parent Financial Source Id",
            rightText: stringNullCheck(workflowReappropriationDetailsResponse
                .parentFinancialSourceId
                .toString())),
        SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Parent Financial Source Name",
            rightText: stringNullCheck(workflowReappropriationDetailsResponse
                .parentFinancialSourceName
                .toString())),
        SizedBox(height: dp10),
        twoSidedTextWithColon2(
            leftText: "Sequence No",
            rightText: stringNullCheck(
                workflowReappropriationDetailsResponse.sequenceNo.toString())),
      ],
    ),
  );*/

      Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 0,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.home, size: 16, color: Color(0xFF4A90E2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Parent Financial Source Name: ${stringNullCheck(workflowReappropriationDetailsResponse.parentFinancialSourceName.toString())}",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.verified_user_sharp,
                  size: 16, color: Color(0xFF10A3C2)),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Sequence No: ${stringNullCheck(workflowReappropriationDetailsResponse.sequenceNo.toString())} ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget pendingTaskListItemView(
    BuildContext context,
    PendingTaskResponse allProjectsResponse,
    PendingTaskController _controller,
    RootController _rootController,
    {bool? isFavorite = true}) {
  return InkWell(
    onLongPress: () {
      alertForInfo(
          context: context,
          title: 'ProjectFullName'.tr,
          message: allProjectsResponse.projectName.toString());
    },
    onTap: () {
      Get.to(() =>
              WorkFlowDetailsScreen(allProjectsResponse: allProjectsResponse))
          ?.then((value) {
        _controller.getPendingTaskList(
            false, _rootController.userInfo.value.id.toString());
      });
    },
    child: Container(
      decoration: boxDecorationRoundShadowLight(),
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
      padding: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp8),
      height: dp70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: showImageAsset(
                        imagePath: AssetConstants.icProject, height: dp50)),
              )),
          // CircleAvatar(
          //   radius: 40,
          //   backgroundImage: AssetImage(AssetConstants.icProject),
          // ),
          const HSpacer20(),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textAutoSize(
                    // text: "ProjectFullName",
                    text: allProjectsResponse.projectName.toString(),
                    maxLines: 1,
                    fontSize: dp16,
                    fontWeight: FontWeight.bold),
                const VSpacer10(),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: textAutoSize(
                            text: 'Date Time:',
                            maxLines: 1,
                            fontSize: dp15,
                            fontWeight: FontWeight.normal)),
                    Expanded(
                      flex: 4,
                      child: textAutoSizeSubTitle(
                          text:
                              "${formatDateToDDMMYYYY(allProjectsResponse.timestamp.toString())}, ${formatDateToHHMMAPM(allProjectsResponse.timestamp.toString())} ",
                          maxLines: 1,
                          fontSize: dp14,
                          fontWeight: FontWeight.normal),
                    ),

                    /*Expanded(
                      flex: 4,
                      child: textAutoSizeSubTitle(
                          // text: "Project Subtitle",
                          text:
                              "(${formatDateToDDMMYYYY(allProjectsResponse.dateOfCommencement.toString())}) - (${formatDateToDDMMYYYY(allProjectsResponse.dateOfCompletion.toString())})",
                          maxLines: 1,
                          fontSize: dp14,
                          fontWeight: FontWeight.normal),
                    ),*/
                  ],
                ),

                /*const VSpacer10(),
                textAutoSize(
                  // text: "ProjectFullName",
                    text: allProjectsResponse.workflowStatus.toString(),
                    maxLines: 1,
                    fontSize: dp16,
                    fontWeight: FontWeight.bold)*/
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget userListItemView(
    BuildContext context, ProjectUserListResponse userListResponse,
    {bool? isFavorite = true}) {
  return Expanded(
    child: Container(
      decoration: boxDecorationRoundShadowLight(),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(dp16),
      margin: const EdgeInsets.all(dp5),
      child: userListResponse.isNull
          ? showEmptyViewForUserList()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                twoSidedTextWithColon2(
                    leftText: "FullName".tr,
                    rightText: stringNullCheck(
                        userListResponse.firstName.toString() +
                            " " +
                            userListResponse.lastName.toString())),

                const Divider(),
                twoSidedTextWithColon2(
                    leftText: "Designation".tr,
                    rightText: stringNullCheck(
                        userListResponse.designationName.toString())),

                const Divider(),
                twoSidedTextWithColon2(
                    leftText: "Project Role",
                    rightText:
                        stringNullCheck(userListResponse.roleTitle.toString())),

                const Divider(),
                twoSidedTextWithColon2(
                    leftText: "email".tr,
                    rightText:
                        stringNullCheck(userListResponse.email.toString())),

                const Divider(),
                twoSidedTextWithColon2(
                    leftText: "Mobile".tr,
                    rightText:
                        stringNullCheck(userListResponse.mobile.toString())),

                /*const Divider(),
          userListResponse.role!.length == 2 ? Container(
            height: dp40,
            child: Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: textAutoSize(
                        text: "Role Title",
                        color: Get.theme.secondaryHeaderColor,
                        fontSize: dp14,
                        maxLines: 2),
                  ),

                  Expanded(
                    flex: 3,
                    child: Container(margin: const EdgeInsets.only(left: dp40),
                      child: ListView.builder(
                        itemCount: userListResponse.role!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return textAutoSize(
                              text: stringNullCheck(userListResponse.role![index].title),
                              //color: Get.theme.secondaryHeaderColor,
                              fontSize: dp14,
                              maxLines: 2);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ) :
          Container(
            height: dp20,
            child: Expanded(
              child: ListView.builder(
                itemCount: userListResponse.role!.length,
                itemBuilder: (BuildContext context, int index) {
                  return twoSidedTextWithColon2(
                      leftText: "RoleTitle".tr, rightText: stringNullCheck(userListResponse.role![index].title)
                  );
                },
              ),
            ),
          ),


          const Divider(),
          twoSidedTextWithColon2(
              leftText: "OfficeName".tr,
              rightText: stringNullCheck(userListResponse.adminHierarchyName.toString())),*/

                // Spacer(),
                const Divider(),
                const VSpacer20(),

                Center(
                  child: Row(
                    children: [
                      contactItem(AssetConstants.icCall, "Phone", () {
                        launchUrlString(
                            "tel:${stringNullCheck(userListResponse.mobile.toString())}");
                      }),
                      contactItem(AssetConstants.icMessage, "Message", () {
                        launchUrlString(
                            "tel:${stringNullCheck(userListResponse.mobile.toString())}");
                      }),
                      contactItem(AssetConstants.icEmail, "Email", () {
                        launchUrlString(
                            "mailto:${stringNullCheck(userListResponse.email.toString())}");
                      }),
                    ],
                  ),
                ),

                const VSpacer20(),
              ],
            ),
    ),
  );
}

Widget roleTitle(Role role) {
  return Row(
    children: [
      twoSidedTextWithColon2(
          leftText: "RoleTitle".tr,
          rightText: stringNullCheck(role.title.toString())),
    ],
  );
}

Widget contactItem(String icon, String title, Function() onClick) {
  return InkWell(
    onTap: onClick,
    child: SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
              radius: 22,
              backgroundColor: Get.theme.primaryColor,
              // child: SvgPicture.asset("assets/icons/$icon.svg")),
              child: SvgPicture.asset(
                icon,
                color: Colors.white,
              )),
          const SizedBox(height: 5),
          textAutoSize(text: title, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

Widget projectListItemViewForMyProject(
    BuildContext context, AllProjectsResponse allProjectsResponse,
    {bool? isFavorite = true}) {
  return InkWell(
    onLongPress: () {
      alertForInfo(
          context: context,
          title: 'ProjectFullName'.tr,
          message: allProjectsResponse.name.toString());
    },
    onTap: () {
      Get.to(() =>
          ProjectDetailsBottomBar(allProjectsResponse: allProjectsResponse));
      //MyProjectDetailsScreen(allProjectsResponse: allProjectsResponse));
    },
    child: Container(
      decoration: boxDecorationRoundShadowLight(),
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: dp5, vertical: dp5),
      //padding: const EdgeInsets.symmetric(horizontal: dp2, vertical: dp2),
      height: dp70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: showImageAsset(
                        imagePath: AssetConstants.icProject, height: dp50)),
              )),
          const HSpacer5(),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textAutoSize(
                    // text: "ProjectFullName",
                    //text: allProjectsResponse.name.toString(),
                    text:
                        "${allProjectsResponse.code.toString()} ${": "} ${allProjectsResponse.name.toString()}",
                    maxLines: 1,
                    fontSize: dp14,
                    fontWeight: FontWeight.bold),
                const VSpacer10(),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: textAutoSize(
                            text: "${'ProjectTimeline'.tr} ",
                            maxLines: 1,
                            fontSize: dp12,
                            fontWeight: FontWeight.normal)),
                    Expanded(
                      flex: 4,
                      child: textAutoSizeSubTitle(
                          // text: "Project Subtitle",
                          text:
                              "${formatDateToDDMMYYYY(allProjectsResponse.dateOfCommencement.toString())}  To  ${formatDateToDDMMYYYY(allProjectsResponse.dateOfCompletion.toString())}",
                          maxLines: 1,
                          fontSize: dp12,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                // textAutoSizeSubTitle(
                //     // text: "Project Subtitle",
                //     text: allProjectsResponse.nameBangla.toString(),
                //     maxLines: 1,
                //     fontSize: dp12,
                //     fontWeight: FontWeight.bold),
              ],
            ),
          ),
          /* const HSpacer20(),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: textAutoSize(
                  text: allProjectsResponse.statusName.toString(),
                  alignment: Alignment.centerRight),
            ),
          ),
          const HSpacer20(),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: showImageAsset(
                  imagePath: isFavorite!
                      ? AssetConstants.icFavorite
                      : AssetConstants.icCross,
                  height: 30,
                  color: Get.theme.colorScheme.secondary),
            ),
          ), */
        ],
      ),
    ),
  );
}

final imagePathController = ImageGalleryController();

Widget filesEvidenceListItemViewForImageView(
    BuildContext context, FilesEvidenceResponseList filesEvidenceResponseList,
    {String? imagePath, bool? isFavorite = true}) {
  String encodedToken = Uri.encodeComponent(fullToken);
  // String? imageSrc = '${APIConstants.baseUrl.toString()}${APIConstants.projectImagePathEndUrl.toString()}${filesEvidenceResponseList.fileId}?t=${Uri.encodeComponent(token.toString())}';
  String? imageSrc =
      '${APIConstants.baseUrl.toString()}${APIConstants.projectImagePathEndUrl.toString()}${filesEvidenceResponseList.fileId}?t=$encodedToken';
  return GestureDetector(
      onTap: () {
        // showModalSheetFullScreenForGalleryFinal(context,
        //     item: filesEvidenceResponseList);
      },
      child: Container(
        decoration: boxDecorationRoundShadowLight(borderRadius: 10),
        padding: const EdgeInsets.all(dp8),
        //margin: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp16),
        margin: const EdgeInsets.all(dp5),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration:
                            boxDecorationRoundShadow(color: Colors.transparent),
                        padding: const EdgeInsets.all(dp0),
                        child: GestureDetector(
                            onTap: () {
                              showModalSheetFullScreenForGalleryFinal(context,
                                  item: filesEvidenceResponseList,
                                  imageSrc: imageSrc);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7.0),
/*                              child: Image.network(
                                  // imagePath.toString() ///For image path from server
                                  // filesEvidenceResponseList.fileName.toString()
                                  imageSrc.toString()
                                //   imagePathController.getImagePath(filesEvidenceResponseList.fileId.toString())
                              ),*/
                              child: showCachedNetworkImage(
                                  // imagePath.toString() ///For image path from server
                                  // filesEvidenceResponseList.fileName.toString()
                                  imageSrc.toString()
                                  //   imagePathController.getImagePath(filesEvidenceResponseList.fileId.toString())
                                  ),
                            )),
                      ),
                    ),
                    const HSpacer15(),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          twoSidedTextWithColon2(
                              leftText: "CapturedBy".tr,
                              // rightText: stringNullCheck(image.imageName.toString())),
                              rightText: stringNullCheck(
                                  filesEvidenceResponseList.userName
                                      .toString())),
                          const Divider(height: 6),
                          twoSidedTextWithColon2(
                              leftText: "ImageShootingDateAndTime".tr,
                              //rightText: "${stringNullCheck(image.imageShootingDate.toString())}, ${stringNullCheck(image.imageShootingTime.toString())}"),
                              rightText: stringNullCheck(
                                  filesEvidenceResponseList.timestamp
                                      .toString())),
                          const Divider(height: 6),
                          twoSidedTextWithColon2(
                              leftText: "Latitude".tr,
                              rightText: stringNullCheck(
                                  filesEvidenceResponseList.latitude
                                      .toString())),
                          const Divider(height: 6),
                          twoSidedTextWithColon2(
                              leftText: "Longitude".tr,
                              rightText: stringNullCheck(
                                  filesEvidenceResponseList.longitude
                                      .toString())),
                          const Divider(height: 6),
                          twoSidedTextWithTextActionAndIcon(
                              leftText: "Location".tr,
                              rightText: 'SeeLocationOnGoogleMap'.tr,
                              rightIcon: AssetConstants.icLocation,
                              iconAction: () async {
                                openGoogleMap(
                                    stringNullCheck(filesEvidenceResponseList
                                        .latitude
                                        .toString()),
                                    stringNullCheck(filesEvidenceResponseList
                                        .longitude
                                        .toString()));
                              }),
                          /*   twoSidedTextWithColon2(
                              leftText: "Location".tr,
                              rightText: " "),*/
                          //const Divider(height: 6),
                          /*
                          twoSidedTextWithColon2(
                              leftText: "Caption".tr,
                              maxLineForRightText: 1,
                              rightText: "Image Caption Not added"),
                          const Divider(height: 6),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ));
}

Widget projectInspectionListItemView(BuildContext context,
    ProjectInspectionResponseList projectInspectionResponseList,
    {bool? isFavorite = true}) {
  return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: boxDecorationRoundShadowLight(borderRadius: 10),
        padding: const EdgeInsets.all(dp8),
        //margin: const EdgeInsets.symmetric(horizontal: dp16, vertical: dp16),
        margin: const EdgeInsets.all(dp5),
        child: Column(
          children: [
            twoSidedTextWithColon2(
                leftText: "DateOfInspection".tr,
                // rightText: stringNullCheck(projectInspectionResponseList.inspectionDate.toString())),
                rightText: stringNullCheck(formatDateToDDMMYYYY(
                    projectInspectionResponseList.inspectionDate.toString()))),
            const Divider(),
            twoSidedTextWithColon2(
                leftText: "InspectorName".tr,
                rightText: stringNullCheck(projectInspectionResponseList
                    .inspectorUserFullName
                    .toString())),
            const Divider(),
            twoSidedTextWithColon2(
                leftText: "InspectorDesignation".tr,
                rightText: stringNullCheck(projectInspectionResponseList
                    .inspectorDesignation
                    .toString())),
            const Divider(),
            twoSidedTextWithColon2(
                leftText: "InspectionLocation".tr,
                rightText: stringNullCheck(projectInspectionResponseList
                    .inspectionLocation
                    .toString())),
            const Divider(),
            twoSidedTextWithColon2(
                leftText: "InspectionComments".tr,
                rightText: stringNullCheck(projectInspectionResponseList
                            .comments
                            .toString()) ==
                        'null'
                    ? 'NoCommentsAdded'.tr
                    : stringNullCheck(
                        projectInspectionResponseList.comments.toString())),
          ],
        ),
      ));
}

Widget projectLocationsItemView(BuildContext context,
    ProjectLocationResponseList projectLocationResponseList,
    {bool? isFavorite = true}) {
  return Container(
    decoration: boxDecorationRoundShadowLight(borderRadius: 10),
    padding: const EdgeInsets.all(dp8),
    margin: const EdgeInsets.all(dp5),
    child: Column(
      children: [
        Column(
          children: [
            twoSidedTextWithColon2(
                leftText: "DivisionName".tr,
                // rightText: stringNullCheck(image.imageName.toString())),
                rightText: stringNullCheck(projectLocationResponseList
                    .divisionLocationName
                    .toString())),
            const Divider(height: 6),
            twoSidedTextWithColon2(
                leftText: "DistrictName".tr,
                // rightText: stringNullCheck(image.imageName.toString())),
                rightText: stringNullCheck(projectLocationResponseList
                    .districtLocationName
                    .toString())),
            const Divider(height: 6),
            twoSidedTextWithColon2(
                leftText: "Location".tr,
                // rightText: stringNullCheck(image.imageName.toString())),
                rightText: stringNullCheck(
                    projectLocationResponseList.locations.toString())),
          ],
        ),
      ],
    ),
  );
}

void showModalSheetFullScreenForWorkflowHistoryActivityImage(
    BuildContext context,
    {String? imageSrc}) {
  showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(0.7),
      context: context,
      builder: (context) {
        return Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Hero(
                  tag: 'imageHero',
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(dp7)),
                    child: PhotoView(
                      backgroundDecoration:
                          const BoxDecoration(color: Colors.transparent),
                      imageProvider: CachedNetworkImageProvider(
                        // stringNullCheck(item!.fileName),
                        imageSrc.toString(),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 100,
                  right: 20,
                  child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: dp50,
                        height: dp50,
                        child: SvgPicture.asset(
                          AssetConstants.icCross,
                          width: dp20,
                          height: dp20,
                          color: Colors.white,
                        ),
                      )))
            ]));
      });
}

void showModalSheetFullScreenForGalleryFinal(BuildContext context,
    {String? imageSrc, FilesEvidenceResponseList? item}) {
  showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(0.7),
      context: context,
      builder: (context) {
        return Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Hero(
                  tag: 'imageHero',
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(dp7)),
                    child: PhotoView(
                      backgroundDecoration:
                          const BoxDecoration(color: Colors.transparent),
                      imageProvider: CachedNetworkImageProvider(
                        // stringNullCheck(item!.fileName),
                        imageSrc.toString(),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 100,
                  right: 20,
                  child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: dp50,
                        height: dp50,
                        child: SvgPicture.asset(
                          AssetConstants.icCross,
                          width: dp20,
                          height: dp20,
                          color: Colors.white,
                        ),
                      )))
            ]));
      });
}

Widget listItemViewForPD(
    BuildContext context, AllProjectsResponse allProjectsResponse,
    {bool? isFavorite = true}) {
  return InkWell(
    onLongPress: () {
      alertForInfo(
          context: context,
          title: 'ProjectFullName'.tr,
          message: allProjectsResponse.name.toString());
    },
    onTap: () {
      Get.to(() => PdDetailsScreen(allProjectsResponse: allProjectsResponse));
    },
    child: Container(
      decoration: boxDecorationRoundShadowLight(),
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: dp5, vertical: dp5),
      //padding: const EdgeInsets.symmetric(horizontal: dp2, vertical: dp2),
      height: dp70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: showImageAsset(
                        imagePath: AssetConstants.icProject, height: dp50)),
              )),
          const HSpacer5(),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textAutoSize(
                    // text: "ProjectFullName",
                    //text: allProjectsResponse.name.toString(),
                    text:
                        "${allProjectsResponse.code.toString()} ${": "} ${allProjectsResponse.name.toString()}",
                    maxLines: 1,
                    fontSize: dp14,
                    fontWeight: FontWeight.bold),
                const VSpacer10(),
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: textAutoSize(
                            text: "${'ProjectTimeline'.tr} ",
                            maxLines: 1,
                            fontSize: dp12,
                            fontWeight: FontWeight.normal)),
                    Expanded(
                      flex: 4,
                      child: textAutoSizeSubTitle(
                          // text: "Project Subtitle",
                          text:
                              "${formatDateToDDMMYYYY(allProjectsResponse.dateOfCommencement.toString())}  To  ${formatDateToDDMMYYYY(allProjectsResponse.dateOfCompletion.toString())}",
                          maxLines: 1,
                          fontSize: dp12,
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
                // textAutoSizeSubTitle(
                //     // text: "Project Subtitle",
                //     text: allProjectsResponse.nameBangla.toString(),
                //     maxLines: 1,
                //     fontSize: dp12,
                //     fontWeight: FontWeight.bold),
              ],
            ),
          ),
          /* const HSpacer20(),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: textAutoSize(
                  text: allProjectsResponse.statusName.toString(),
                  alignment: Alignment.centerRight),
            ),
          ),
          const HSpacer20(),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: showImageAsset(
                  imagePath: isFavorite!
                      ? AssetConstants.icFavorite
                      : AssetConstants.icCross,
                  height: 30,
                  color: Get.theme.colorScheme.secondary),
            ),
          ), */
        ],
      ),
    ),
  );
}

Widget carouselItemView(
    {double bottomPadding = 0, String? imagePath, String? carouselText}) {
  return InkWell(
    onTap: () {
      // Get.to(() => ProjectDetailsPage(
      //   auction: auction,
      // ));
    },
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(dp20)),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: showImageAsset(
                    imagePath: imagePath!,
                    boxFit: BoxFit.cover,
                    width: Get.height,
                    height: Get.height),
              ),
              Positioned(
                  // left: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.all(5),
                      color: Colors.black.withOpacity(.4),
                      child: textAutoSize(
                          width: Get.width,
                          fontSize: 10,
                          text: carouselText!,
                          maxLines: 5,
                          color: Get.theme.colorScheme.surface,
                          hMargin: 12)))
            ],
          ),
        ),
        Positioned(
            top: 20,
            right: 16,
            // alignment: Alignment.centerRight,
            child:
                showImageAsset(imagePath: AssetConstants.appLogo, height: dp40))
      ],
    ),
  );
}

Widget horizontalDivider(
    {Color? color, double margin = 0, double padding = 0, double height = 1}) {
  color = color ?? Get.theme.primaryColor;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: margin),
    padding: EdgeInsets.symmetric(vertical: padding),
    child: Divider(
      height: height,
      color: color,
      thickness: 1,
    ),
  );
}

Widget listTitleWithLeftIconExpansionTile({
  String? title,
  String? menu1,
  String? menu2,
  String? menu3,
  String? menu4,
  String? menu5,
  String? iconPath,
  VoidCallback? actionMenu1,
  VoidCallback? actionMenu2,
  VoidCallback? actionMenu3,
  VoidCallback? actionMenu4,
  VoidCallback? actionMenu5,
}) {
  return ExpansionTile(
    title: Row(
      children: [
        showImageAsset(imagePath: iconPath!, width: dp18),
        const HSpacer15(),
        textAutoSize(text: title!, maxLines: 1, width: Get.width / 4),
      ],
    ),
    collapsedIconColor: Get.theme.primaryColor,
    iconColor: Get.theme.disabledColor,
    childrenPadding: const EdgeInsets.symmetric(horizontal: dp0),
    children: <Widget>[
      Container(
        padding: const EdgeInsets.only(left: dp60),
        child: Column(
          children: [
            textButton(text: menu1!, onPressCallback: actionMenu1!),
            const Divider(),
            textButton(text: menu2!, onPressCallback: actionMenu2!),
            const Divider(),
            textButton(text: menu3!, onPressCallback: actionMenu3!),
            const Divider(),
            textButton(text: menu4!, onPressCallback: actionMenu4!),
            // const VSpacer10(),
            // textButton(text: menu5!, onPressCallback: actionMenu5!),
          ],
        ),
      ),
    ],
  );
}

void showModalSheetFullScreenForGallery(BuildContext context, {String? item}) {
  showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(0.7),
      context: context,
      builder: (context) {
        return Container(
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Stack(children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Hero(
                  tag: 'imageHero',
                  child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(dp7)),
                      child: PinchZoom(
                        resetDuration: const Duration(milliseconds: 7000),
                        maxScale: 2.5,
                        onZoomStart: () {
                          print('Start zooming');
                        },
                        onZoomEnd: () {
                          print('Stop zooming');
                        },
                        child: Image.asset(stringNullCheck(item)),
                      )
                      // PhotoView(
                      //   backgroundDecoration:
                      //   const BoxDecoration(color: Colors.transparent),
                      //   imageProvider: AssetImage(
                      //     stringNullCheck(item),
                      //   ),
                      // ),
                      ),
                ),
              ),
              Positioned(
                  top: 100,
                  right: 30,
                  child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        width: dp50,
                        height: dp50,
                        child: SvgPicture.asset(
                          AssetConstants.icCross,
                          width: dp20,
                          height: dp20,
                          color: Colors.white,
                        ),
                      )))
            ]));
      });
}
