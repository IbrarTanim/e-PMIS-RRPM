import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pmis_flutter/data/models/division_response_data.dart';
import 'package:pmis_flutter/data/models/ministry_list_response.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';


Widget NewDropDownAllProjectForMinistry(
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
    // height: height,
    width: Get.width,
    alignment: Alignment.center,
    decoration: boxDecorationRoundBorder(
        bgColor: cardColor,
        borderColor: borderColor),
    child: DropdownButton<MinistryListResponse>(
      value: selectedValue!.value!.isNotEmpty ? selectedValue : null,
      hint: Text(
        hint!,
        style: const TextStyle(fontSize: 14),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      icon: Icon(Icons.keyboard_arrow_down_outlined,
          color: isEditable ? accentBlue : Colors.transparent),
      elevation: 10,
      dropdownColor: cardColor,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      focusColor: Get.theme.primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      underline: Container(height: 0, color: Colors.transparent),
      menuMaxHeight: Get.width,
      isExpanded: true,
      onChanged: isEditable
          ? (value) {
              onChange!(value!);
            }
          : null,
      items: items!.map<DropdownMenuItem<MinistryListResponse>>(
          (MinistryListResponse value) {
        return DropdownMenuItem<MinistryListResponse>(
          value: value,
          child: Text(
            "New ${value.text}",
            style: const TextStyle(fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    ),
  );
}

Widget NewDropDownAllProjectForDivision(
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
    // height: height,
    width: Get.width,
    alignment: Alignment.center,
    decoration: boxDecorationRoundBorder(
        bgColor: cardColor,
        borderColor: borderColor),
    child: DropdownButton<ValueObject>(
      value: selectedValue!.value!.isNotEmpty ? selectedValue : null,
      hint: Text(
        hint!,
        style: const TextStyle(fontSize: 14),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      icon: Icon(Icons.keyboard_arrow_down_outlined,
          color: isEditable ? accentBlue : Colors.transparent),
      elevation: 10,
      dropdownColor: cardColor,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
      focusColor: Get.theme.primaryColor,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      underline: Container(height: 0, color: Colors.transparent),
      menuMaxHeight: Get.width,
      isExpanded: true,
      onChanged: isEditable
          ? (value) {
              onChange!(value!);
            }
          : null,
      items: items!.map<DropdownMenuItem<ValueObject>>((ValueObject value) {
        return DropdownMenuItem<ValueObject>(
          value: value,
          child: Text(
            value.text.toString(),
            style: const TextStyle(fontSize: 14),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    ),
  );
}

Widget NewDropDownAllProjectForAgency(
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
    // height: height,
    width: Get.width,
    alignment: Alignment.center,
    decoration: boxDecorationRoundBorder(
        bgColor: cardColor,
        borderColor: borderColor),
    child: Theme(
      data: Theme.of(Get.context!).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: borderColor),
          ),
        ),
      ),
      child: DropdownButton<ValueObject>(
        value: selectedValue!.value!.isNotEmpty ? selectedValue : null,
        hint: Text(
          hint!,
          style: const TextStyle(fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        icon: Icon(Icons.keyboard_arrow_down_outlined,
            color: isEditable ? accentBlue : Colors.transparent),
        elevation: 10,
        dropdownColor: cardColor,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        focusColor: Get.theme.primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        underline: Container(height: 0, color: Colors.transparent),
        menuMaxHeight: Get.width,
        isExpanded: true,
        onChanged: isEditable
            ? (value) {
                onChange!(value!);
              }
            : null,
        items: items!.map<DropdownMenuItem<ValueObject>>((ValueObject value) {
          return DropdownMenuItem<ValueObject>(
            value: value,
            child: Text(
              value.text.toString(),
              style: const TextStyle(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
      ),
    ),
  );
}