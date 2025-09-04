import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'date_util.dart';
import 'dimens.dart';

Widget textFieldBorderedWithSuffixIcon(TextEditingController? controller, String hint, TextInputType type,
    {String? iconPath, VoidCallback? iconAction, bool isObscure = false, bool isEnable = true, int maxLines = 1, Function(String)? onTextChange}) {
  return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        keyboardType: type,
        maxLines: maxLines,
        cursorColor: Get.theme.colorScheme.secondary,
        obscureText: isObscure,
        enabled: isEnable,
        onChanged: (value) {
          if (onTextChange != null) {
            onTextChange(value);
          }
        },
        decoration: InputDecoration(
            filled: false,
            isDense: true,
            hintText: hint,
            labelText: hint,
            labelStyle: const TextStyle(color: Colors.grey),
            hintStyle: Get.textTheme.bodyLarge!.copyWith(color: Colors.grey, fontSize: dp16),
            enabledBorder: _textFieldBorder(),
            disabledBorder: _textFieldBorder(),
            focusedBorder: _textFieldBorder(isFocus: true),
            suffixIcon: iconPath == null ? null : _buildTextFieldIcon(iconPath, iconAction, Get.theme.primaryColorLight)),
      ));
}

Widget textFieldUnderlineWithSuffixIcon(
    {TextEditingController? controller,
    String? hint,
    TextInputType? type,
    String? iconPath,
    VoidCallback? iconAction,
    bool isObscure = false,
    bool isEnable = true,
    int maxLines = 1,
    Function(String)? onTextChange}) {
  return Container(
      height: dp50,
      padding: const EdgeInsets.only(left: 0, right: 0, top: 5),
      //color: Colors.red,
      child: TextField(
        controller: controller,
        keyboardType: type,
        maxLines: maxLines,
        cursorColor: Get.theme.colorScheme.secondary,
        obscureText: isObscure,
        enabled: isEnable,
        style: Get.textTheme.bodyLarge!.copyWith(color: Get.theme.primaryColor, fontSize: 15, fontWeight: FontWeight.w500),
        onChanged: (value) {
          if (onTextChange != null) {
            onTextChange(value);
          }
        },
        decoration: InputDecoration(
            filled: false,
            isDense: true,
            hintText: hint,
            hintStyle: Get.textTheme.bodyLarge!.copyWith(color: Get.theme.primaryColorDark, fontSize: 15, fontWeight: FontWeight.w500),
            enabledBorder: _textFieldBorderUnderline(),
            disabledBorder: _textFieldBorderUnderline(),
            focusedBorder: _textFieldBorderUnderline(isFocus: true),
            suffixIcon: iconPath == null ? null : _buildTextFieldIcon(iconPath, iconAction, Get.theme.primaryColor)),
      ));
}

Widget textFormFieldDatePicker(BuildContext context,
    {TextEditingController? controller, String? hint, TextInputType? type,
      String? iconPath, VoidCallback? iconAction}) {
  return Container(
      padding: const EdgeInsets.all(0),
      child: TextFormField(
        controller: controller,
        style: Get.theme.textTheme.headlineSmall!.copyWith(fontSize: dp15, fontWeight: FontWeight.normal),
        keyboardType: type,
        maxLines: 1,
        cursorColor: Get.theme.primaryColorDark,
        decoration: InputDecoration(
            filled: true,
            isDense: true,
            labelText: hint,
            //labelText: hint != null ? '$hint${true ? '*' : ''}' : null,
            labelStyle: Get.theme.textTheme.titleMedium!.copyWith(color: Colors.black),
            fillColor: Colors.transparent,
            hintText: hint,
            hintStyle: Get.theme.textTheme.titleMedium!.copyWith(color: Colors.grey),
            enabledBorder: _textFieldBorder(),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(dp7)),
                borderSide: BorderSide(color: Colors.grey)),
            suffixIcon: iconPath == null
                ? const SizedBox(
              width: dp0,
              height: dp0,
            )
                : _buildTextFieldIcon(
                iconPath, iconAction, Get.theme.primaryColorDark)),
        onTap: () async {
          DateTime? date = DateTime(1900);
          FocusScope.of(context).requestFocus(FocusNode());

          date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now());
          controller!.text = formatDateYYYYMMDD(date.toString());
        },
      ));
}

Widget textFieldBordered(
    {TextEditingController? controller,
    String? hint,
    double? width,
    String? text,
    bool enabled = true,
    int maxLines = 5,
    TextInputType inputType = TextInputType.text,
    List<TextInputFormatter>? inputFormatter,
    Function(String)? onTextChange}) {
  if (controller != null && text != null && text.isNotEmpty) {
    controller.text = text;
  }
  return SizedBox(
      height: maxLines > 1 ? null : dp50,
      width: width,
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: inputType,
        inputFormatters: inputFormatter,
        style: Get.theme.textTheme.headlineSmall!.copyWith(fontSize: dp15, fontWeight: FontWeight.normal),
        maxLines: maxLines,
        cursorColor: Get.theme.primaryColorDark,
        onChanged: onTextChange,
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: Get.theme.textTheme.titleMedium!.copyWith(fontSize:dp15,color: Colors.grey.withOpacity(0.8) ),
          disabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(dp7)), borderSide: BorderSide(color: Colors.white)),
          enabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(dp7)), borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(dp7)), borderSide: BorderSide(color: Get.theme.colorScheme.secondary.withOpacity(0.5))),
        ),
      ));
}

Widget textFieldNoDecoration(
    {TextEditingController? controller,
    String? hint,
    bool enabled = true,
    TextInputType? inputType,
    List<TextInputFormatter>? inputFormatter,
    Function(String)? onTextChange}) {
  return TextField(
    controller: controller,
    enabled: enabled,
    keyboardType: inputType,
    inputFormatters: inputFormatter,
    style: Get.textTheme.bodyLarge,
    cursorColor: Get.theme.primaryColor,
    onChanged: (value) {
      if (onTextChange != null) {
        onTextChange(value);
      }
    },
    decoration: InputDecoration(
      //border: InputBorder.none,
      focusedBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
      isDense: true,
      hintText: hint,
      hintStyle: Get.textTheme.bodyLarge!.copyWith(color: Colors.grey),
    ),
  );
}

_textFieldBorder({bool isFocus = false, double borderRadius = 7}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    borderSide: BorderSide(width: 0.75, color: isFocus ? Get.theme.primaryColor : Colors.grey),
  );
}

_textFieldBorderUnderline({bool isFocus = false}) {
  return UnderlineInputBorder(
    //borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
    borderSide: BorderSide(width: 0.25, color: isFocus ? Get.theme.colorScheme.secondary : Get.theme.secondaryHeaderColor),
  );
}

Widget _buildTextFieldIcon(String iconPath, VoidCallback? action, Color color) {
  return InkWell(
    onTap: action,
    child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SvgPicture.asset(
          iconPath,
          color: color,
        )),
  );
}

// Widget textFieldBottomLine(TextEditingController controller, String hint,
//     {double width, bool enabled = true, TextInputType inputType = TextInputType.text,
//       TextAlign textAlign: TextAlign.left, Color cursorColor, Color borderColor = dividerColor3, bool autoFocus = true }) {
//   var _cursorColor = cursorColor;
//   if (_cursorColor == null) {
//     _cursorColor = Get.theme.accentColor;
//   }
//   return Container(
//       height: dp50,
//       width: width,
//       child: TextField(
//         controller: controller,
//         enabled: enabled,
//         style: Get.theme.textTheme.headline2,
//         cursorColor: _cursorColor,
//         textAlign: textAlign,
//         maxLines: 1,
//         keyboardType: inputType,
//         autofocus: autoFocus,
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: Get.theme.textTheme.headline2
//               .copyWith(color: subText),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: borderColor),
//           ),
//           focusedBorder: UnderlineInputBorder(
//             borderSide: BorderSide(color: Get.theme.accentColor),
//           ),
//           border: UnderlineInputBorder(
//             borderSide: BorderSide(color: borderColor),
//           ),
//         ),
//       ));
// }
//
// Widget textFieldBordered(TextEditingController controller, String hint,
//     {double width, bool enabled = true, Color borderColor = greyBorder}) {
//   return Container(
//       height: dp50,
//       margin: EdgeInsets.all(10),
//       width: width,
//       child: TextField(
//         controller: controller,
//         enabled: enabled,
//         style: Get.theme.textTheme.headline3,
//         maxLines: 1,
//         cursorColor: Get.theme.primaryColorDark,
//         decoration: InputDecoration(
//           filled: true,
//           isDense: true,
//           fillColor: textFieldColor,
//           hintText: hint,
//           hintStyle: Get.theme.textTheme.subtitle1
//               .copyWith(color: black, fontSize: 18),
//           enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: borderColor),
//               borderRadius: BorderRadius.all(Radius.circular(dp7))),
//           border: OutlineInputBorder(
//               borderSide: BorderSide(color: borderColor),
//               borderRadius: BorderRadius.all(Radius.circular(dp7))),
//           focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.all(Radius.circular(dp7)),
//               borderSide: BorderSide(color: accentBlue)),
//         ),
//       ));
// }
//
// Widget textFieldBorderedWithPrefixIcon(
//     TextEditingController controller, String hint,
//     {String iconPath, VoidCallback iconAction, bool isObscure = false}) {
//   return Container(
//     //height: 44,
//       margin: EdgeInsets.all(10),
//       child: TextField(
//         controller: controller,
//         obscureText: isObscure,
//         style: Get.theme.textTheme.headline3,
//         maxLines: 1,
//         cursorColor: Get.theme.primaryColorDark,
//         decoration: InputDecoration(
//             filled: true,
//             isDense: true,
//             fillColor: Get.theme.primaryColor,
//             hintText: hint,
//             hintStyle: Get.theme.textTheme.subtitle1,
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(dp7))),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(
//                   dp10,
//                 )),
//                 borderSide: BorderSide(color: Get.theme.accentColor)),
//             prefixIcon: iconPath == null
//                 ? Container(
//               width: dp0,
//               height: dp0,
//             )
//                 : buildTextFieldIcon(
//                 iconPath, iconAction, Get.theme.primaryColorDark)),
//       ));
// }
//

// Widget textFieldBorderedWithPrefixAndSuffixIcon(TextEditingController controller, String hint,
//     String prefixIcon, VoidCallback prefixAction, String suffixIcon,
//     VoidCallback suffixAction, {TextInputType type, bool enable = true}) {
//   return Container(
//       padding: EdgeInsets.all(dp10),
//       child: TextField(
//           controller: controller,
//           style: Get.theme.textTheme.headline4,
//           keyboardType: type,
//           maxLines: 1,
//           enabled: enable,
//           cursorColor: Get.theme.primaryColorDark,
//           decoration: InputDecoration(
//             filled: true,
//             isDense: true,
//             labelText: hint,
//             labelStyle: Get.theme.textTheme.subtitle1.copyWith(
//                 color: black, fontSize: 20, fontWeight: FontWeight.w500),
//             fillColor: textFieldColor,
//             hintText: hint,
//             hintStyle: Get.theme.textTheme.subtitle1.copyWith(
//                 color: subText,
//                 fontSize: 20,
//                 fontWeight: FontWeight.normal),
//             enabledBorder: textFieldBorderSearch(),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(dp7)),
//                 borderSide: BorderSide(color: accentBlue)),
//             prefixIcon: buttonOnlyIcon(null, prefixAction, iconPath: prefixIcon),
//             suffixIcon: buttonOnlyIcon(null, suffixAction, iconPath: suffixIcon)
//           )));
// }
//
// /// *** Helper Methods *** ///
// textFieldBorder({bool isError = false}) {
//   return OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(dp7)),
//     borderSide: BorderSide(
//         width: 1, color: isError ? Colors.red : Get.theme.accentColor),
//   );
// }
//
// textFieldBorderSearch({bool isError = false}) {
//   return OutlineInputBorder(
//     borderRadius: BorderRadius.all(Radius.circular(dp7)),
//     borderSide: BorderSide(width: 1, color: isError ? Colors.red : greyBorder),
//   );
// }
//
// Widget buildTextFieldIcon(String iconPath, VoidCallback action, Color color) {
//   return InkWell(
//     onTap: action,
//     child: Padding(
//         padding: EdgeInsets.all(dp15),
//         child: SvgPicture.asset(
//           iconPath,
//           color: color,
//         )),
//   );
// }
//
// Widget buildTextFieldIconLeftDot(String iconPath, Color color) {
//   return Padding(
//       padding: EdgeInsets.all(dp3),
//       child: SvgPicture.asset(
//         iconPath,
//         color: color,
//       ));
// }
