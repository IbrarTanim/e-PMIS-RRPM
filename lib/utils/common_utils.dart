import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import 'package:url_launcher/url_launcher_string.dart';

/*FToast? fToast;

Widget toastBuilder({String? text, bool? isError})=> Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        isError! ? const Icon(Icons.error) : const Icon(Icons.check),
        const SizedBox(width: 12.0),
        textAutoSize(text: text!,maxLines: 2),
      ],
    ),
  );


void showToast(String text, {bool isError = true, bool isLong = false}) =>
  fToast!.showToast(
    child: toastBuilder(text: text,isError: isError),
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
    // msg: text,
    // toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    // gravity: ToastGravity.BOTTOM,
    // timeInSecForIosWeb: 1,
    // backgroundColor: isError ? Colors.red : Colors.greenAccent,
    // textColor: Colors.white,
    // webBgColor: linear-gradient(to right, #00b09b, #96c93d)
    //fontSize: 16.0
  );*/

void showSuccessToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Get.theme.primaryColor,
      textColor: Colors.white,
      //textColor: Get.theme.primaryColorDark,
      fontSize: 16.0);
}

void showToast(String text, {bool isError = true, bool isLong = false}) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: isLong ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    //backgroundColor: Colors.red,
    backgroundColor: Get.theme.primaryColor,
    // backgroundColor: isError ? Colors.red : Colors.greenAccent,
    textColor: Colors.white,
    // webBgColor: linear-gradient(to right, #00b09b, #96c93d)
    //fontSize: 16.0
  );
}

void showLoadingDialog({bool isDismissible = false}) {
  if (Get.isDialogOpen == null || !Get.isDialogOpen!) {
    Get.dialog(const Center(child: CircularProgressIndicator()),
        barrierDismissible: isDismissible);
  }
}

void showLoadingDialogWithText({bool isDismissible = false}) {
  if (Get.isDialogOpen == null || !Get.isDialogOpen!) {
    Get.dialog(
        Stack(
          children: [
            const Center(child: CircularProgressIndicator()),
            Center(child: textAutoSize(text: 'Image Uploading....'))
          ],
        ),
        barrierDismissible: isDismissible);
  }
}

void hideLoadingDialog() {
  if (Get.isDialogOpen != null && Get.isDialogOpen!) {
    Get.back();
  }
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

String stringNullCheck(String? value) {
  return (value ?? "");
}

bool isEmptyOrNull(String? value) {
  return value == null || value.isEmpty;
}

void printFunction(String tag, dynamic data) {
  if (kDebugMode) GetUtils.printFunction("$tag => ", data, "");
  // if (kDebugMode) GetUtils.printFunction(tag + " => ", data, "");
}

void clearStorage() {
  var storage = GetStorage();
  storage.write(PreferenceKey.accessToken, "");
  storage.write(PreferenceKey.refreshToken, "");
  storage.write(PreferenceKey.isLoggedIn, false);
  storage.write(PreferenceKey.userObject, {});
}

void editTextFocusDisable(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

String getEnumString(dynamic enumValue) {
  String string = enumValue.toString();
  try {
    string = string.split(".").last;
    return string;
  } catch (_) {}
  return "";
}

void callToNumber(String number) async {
  if (number.isEmpty) {
    showToast("The phone number has not been available".tr, isError: true);
    return;
  }
  String url = "tel:$number";
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    showToast("The phone number is invalid".tr, isError: true);
  }
}

void smsToNumber(String number) async {
  if (number.isEmpty) {
    showToast("The phone number has not been available".tr, isError: true);
    return;
  }
  String url = "sms:$number";
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    showToast("The phone number is invalid".tr, isError: true);
  }
}

void mailTo(String email, {String? subject, String? body}) async {
  if (email.isEmpty) {
    showToast("The email has not been available".tr);
    return;
  }
  String url = "mailto:$email";
  if (subject != null && subject.isNotEmpty) {
    url = "$url?subject=$subject";
    if (body != null && body.isNotEmpty) {
      url = "$url&body=$body";
    }
  } else if (body != null && body.isNotEmpty) {
    url = "$url?body=$body";
  }

  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    showToast("The email is invalid".tr, isError: true);
  }
}

void copyToClipboard(String string) {
  Clipboard.setData(ClipboardData(text: string)).then((_) {
    showToast("Text copied to clipboard".tr);
  });
}

void openUrlInBrowser(String url) async {
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    showToast("The URL is invalid".tr, isError: true);
  }
}

bool isValidPassword(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~.]).{6,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

Future<String> htmlString(String path) async {
  String fileText = await rootBundle.loadString(path);
  String htmlStr = Uri.dataFromString(fileText,
          mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
      .toString();
  return htmlStr;
}

getFileSize(String filepath, int decimals) async {
  var file = File(filepath);
  int bytes = await file.length();
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

Future<bool> checkFileSizeAbove(File? file, int inMB) async {
  if (file != null && file.path.isNotEmpty) {
    int bytes = await file.length();
    double sizeInMb = bytes / (1024 * 1024);
    if (sizeInMb > inMB) {
      return true;
    }
  }
  return false;
}

bool isTextGreaterThanZero(String? string) {
  if (string != null) {
    var str = string.trim();
    if (str.isNum) {
      return (double.tryParse(str) ?? 0) > 0;
    }
  }
  return false;
}

double getContentHeight() {
  return Get.height - kToolbarHeight;
}

bool isImage(String path) {
  final mimeType = lookupMimeType(path) ?? "";
  return mimeType.startsWith('image/');
}

// ///fk_user_agent: ^2.1.0
// Future<String> getUserAgent() async {
//   try {
//     await FkUserAgent.init();
//     var platformVersion = FkUserAgent.userAgent!;
//     return platformVersion;
//   } on PlatformException {
//     printFunction("getUserAgent", 'Failed to get platform version.');
//     return "";
//   }
// }

// flutter_datetime_picker: ^1.5.1
// void showDateTimePicker(BuildContext context, Function(DateTime value) onDateSelect){
//   DatePicker.showDateTimePicker(context,
//     showTitleActions: true,
//     minTime: DateTime.now(),
//     maxTime:  DateTime.now().add(Duration(minutes: generalSettingsG.scheduleEndBookingMinute)),
//     onConfirm: (date) {
//       onDateSelect(date);
//     },
//   );
// }

// country_code_picker: ^2.0.2
// Widget showCountryCodePicker({double? width, Function(String? dialCode)? onChanged}) {
//   return Container(
//     decoration: boxDecorationRoundBorder(color: Get.theme.primaryColorDark.withOpacity(0.5)),
//     height: 50,
//     child: CountryCodePicker(
//       dialogBackgroundColor: Get.theme.primaryColorDark,
//       showFlag: false,
//       dialogSize: Size(Get.width / 1.5, Get.height - 100),
//       initialSelection: 'USA',
//       textStyle: Get.textTheme.bodyText1,
//       closeIcon: Icon(Icons.close, color: Get.theme.primaryColor),
//       padding: EdgeInsets.zero,
//       showDropDownButton: true,
//       hideSearch: true,
//       //showCountryOnly: true,
//       //showOnlyCountryWhenClosed: true,
//       onInit: (value) {},
//       onChanged: (value) {
//         if (onChanged != null) {
//           onChanged(value.dialCode);
//         }
//       },
//     ),
//   );
// }
