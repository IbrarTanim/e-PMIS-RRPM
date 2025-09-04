import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import '../../data/local/constants.dart';
import 'button_util.dart';
import 'dimens.dart';
import 'package:pmis_flutter/utils/colors.dart';

// Zabir 
AppBar appBarMain(BuildContext context,
    {String? title,
    List<String>? actionIcons,
    Color? iconColor,
    Function(int)? onPress}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: surfaceGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: buttonOnlyIcon(
          onPressCallback: () {
            Scaffold.of(context).openDrawer();
          },
          iconPath: AssetConstants.icMenu,
          size: 20,
          iconColor: accentBlue, 
        ),
      ),
    ),
    title: Text(
      title ?? '',
      style: TextStyle(
        color: accentGreenText,
        fontSize: 18,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.2,
      ),
    ),
    actions: (actionIcons == null || actionIcons.isEmpty)
        ? [const SizedBox(width: 16)]
        : List.generate(
            actionIcons.length,
            (index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: surfaceGray, 
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: buttonOnlyIcon(
                    viewSize: 24,
                    onPressCallback: () {
                      if (onPress != null) onPress(index);
                    },
                    iconPath: actionIcons[index],
                    size: 24,
                    iconColor: index == 0 ? accentGreenText.withOpacity(0.6) : accentBlue, 
                  ),
                ),
              ),
            ),
          ),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(
        height: 1,
        color: Colors.grey.withOpacity(0.2),
      ),
    ),
  );
}

// AppBar appBarMain(BuildContext context,
//     {String? title,
//     List<String>? actionIcons,
//     Color? iconColor,
//     Function(int)? onPress}) {
//   // var iconColor = Get.theme.backgroundColor;
//   return AppBar(
//       backgroundColor: Get.theme.primaryColor,
//       elevation: 2,
//       centerTitle: true,
//       leading: buttonOnlyIcon(
//           onPressCallback: () {
//             Scaffold.of(context).openDrawer();
//           },
//           iconPath: AssetConstants.icMenu,
//           size: dp25,
//           iconColor: Get.theme.colorScheme.surface),
//       //iconColor: Get.theme.backgroundColor),
//       title: textAutoSize(
//           text: title!,
//           maxLines: 1,
//           textAlign: TextAlign.center,
//           fontWeight: FontWeight.w600,
//           fontSize: 20),
//       actions: (actionIcons == null || actionIcons.isEmpty)
//           ? [const SizedBox(width: dp25)]
//           : List.generate(actionIcons.length, (index) {
//               return Padding(
//                 padding: const EdgeInsets.only(right: 15),
//                 child: buttonOnlyIcon(
//                   viewSize: dp25,
//                   onPressCallback: () {
//                     if (onPress != null) onPress(index);
//                   },
//                   iconPath: actionIcons[index],
//                   size: dp25,
//                   iconColor: Get.theme.colorScheme.surface,
//                   //iconColor: Get.theme.backgroundColor,
//                   //bgColor: Colors.green
//                 ),
//               );
//             }));
// }

AppBar appBarWithBack({String? title}) {
  return AppBar(
    backgroundColor: Get.theme.primaryColor,
    elevation: 2,
    centerTitle: true,
    leading: buttonOnlyIcon2(
        onPressCallback: () => Get.back(),
        iconPath: AssetConstants.icArrowLeft,
        size: dp22,
        iconColor: Get.theme.colorScheme.surface),
    //iconColor: Get.theme.backgroundColor),
    title: textAutoSize(
        text: title!,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w600,
        fontSize: 20),
    actions: [Container(width: dp55)],
  );
}

AppBar onlyAppBar({String? title}) {
  return AppBar(
    // backgroundColor: Get.theme.colorScheme.surface,
    backgroundColor: bgColor,
    elevation: 0,
    centerTitle: true,
    title: textAutoSize(
        text: title!,
        textAlign: TextAlign.center,
        color: accentBlue,
        fontWeight: FontWeight.w600,
        fontSize: 20),
  );
}

// AppBar appBarWithBackAndActions(
//     {String? title, List<String>? actionIcons, Function(int)? onPress}) {
//   return AppBar(
//       backgroundColor: Get.theme.primaryColor,
//       elevation: 2,
//       centerTitle: true,
//       leading: buttonOnlyIcon2(
//           onPressCallback: () => Get.back(),
//           iconPath: AssetConstants.icArrowLeft,
//           size: dp22,
//           iconColor: Get.theme.colorScheme.surface),
//       //iconColor: Get.theme.backgroundColor),
//       title: textAutoSize(
//           text: title!,
//           textAlign: TextAlign.center,
//           fontWeight: FontWeight.w600,
//           fontSize: 20),
//       actions: (actionIcons == null || actionIcons.isEmpty)
//           ? [const SizedBox(width: dp25)]
//           : List.generate(actionIcons.length, (index) {
//               return Padding(
//                 padding: const EdgeInsets.only(right: 15),
//                 child: buttonOnlyIcon(
//                   viewSize: dp25,
//                   onPressCallback: () {
//                     if (onPress != null) onPress(index);
//                   },
//                   iconPath: actionIcons[index],
//                   size: dp25,
//                   iconColor: Get.theme.colorScheme.surface,
//                   //iconColor: Get.theme.backgroundColor,
//                   //bgColor: Colors.green
//                 ),
//               );
//             }));
// }

// Zabir
AppBar appBarWithBackAndActions(
    {String? title, List<String>? actionIcons, Function(int)? onPress}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    leading: buttonOnlyIcon2(
        onPressCallback: () => Get.back(),
        iconPath: AssetConstants.icArrowLeft,
        size: dp22,
        iconColor: Colors.black87),
    title: Text(
        title ?? '',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Roboto', // Standard Material Design font
          fontWeight: FontWeight.w700,
          fontSize: 19,
          color: accentGreenText,
        ),
    ),
    actions: (actionIcons == null || actionIcons.isEmpty)
        ? [const SizedBox(width: dp25)]
        : List.generate(
            actionIcons.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 15),
              child: buttonOnlyIcon(
                viewSize: dp25,
                onPressCallback: () {
                  if (onPress != null) onPress(index);
                },
                iconPath: actionIcons[index],
                size: dp25,
                iconColor: Colors.black54,
              ),
            ),
          ),
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1),
      child: Container(
        height: 1,
        color: Colors.grey.withOpacity(0.2),
      ),
    ),
  );
}


AppBar appBarWithBackAndUpload(
    {String? title, String? iconPath, VoidCallback? onPress}) {
  return AppBar(
      backgroundColor: Get.theme.primaryColor,
      elevation: 2,
      centerTitle: true,
      leading: buttonOnlyIcon2(
          onPressCallback: () => Get.back(),
          iconPath: AssetConstants.icArrowLeft,
          size: dp22,
          iconColor: Get.theme.colorScheme.surface),
      //iconColor: Get.theme.backgroundColor),
      title: textAutoSize(
          text: title!,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
          fontSize: 20),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: buttonOnlyIcon(
            viewSize: dp25,
            onPressCallback: onPress,
            iconPath: iconPath!,
            size: dp25,
            iconColor: Get.theme.colorScheme.surface,
            //iconColor: Get.theme.backgroundColor,
            //bgColor: Colors.green
          ),
        ),
      ]);
}


AppBar appBarWithLogout(
    {String? title, String? iconPath, VoidCallback? onPress}) {
  return AppBar(
      backgroundColor: Get.theme.primaryColor,
      elevation: 2,
      centerTitle: true,
      /*leading: buttonOnlyIcon2(
          onPressCallback: () => Get.back(),
          iconPath: AssetConstants.icArrowLeft,
          size: dp22,
          iconColor: Get.theme.colorScheme.surface),*/
      //iconColor: Get.theme.backgroundColor),
      title: textAutoSize(
          text: title!,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 20),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          //child: buttonOnlyIcon(
          child: buttonOnlyIcon(
            viewSize: dp25,
            onPressCallback: onPress,
            iconPath: iconPath!,
            size: dp25,
            iconColor: Get.theme.colorScheme.surface,
            //iconColor: Get.theme.backgroundColor,
            //bgColor: Colors.green
          ),
        ),
      ]);
}



AppBar appBarMainMoreMenu(BuildContext context,
    {String? title, List<String>? menus, Function(String)? onSelect}) {
  return AppBar(
    //backgroundColor: Get.theme.backgroundColor,
    backgroundColor: Get.theme.colorScheme.surface,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Get.theme.primaryColor),
    leading: buttonOnlyIcon(
        onPressCallback: () {
          Scaffold.of(context).openDrawer();
        },
        iconPath: AssetConstants.icMenu,
        size: dp25),
    title: textAutoSize(
        text: title!,
        maxLines: 1,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w600,
        fontSize: 20),
    actions: [
      (menus != null && menus.isNotEmpty)
          ? PopupMenuButton<String>(
              onSelected: onSelect,
              itemBuilder: (BuildContext context) {
                return menus.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice, style: Get.textTheme.bodyLarge),
                    //child: Text(choice, style: Get.textTheme.bodyText1),
                  );
                }).toList();
              },
            )
          : const SizedBox(width: dp25),
    ],
  );
}

AppBar appBarBackWithActions(
    {String? title,
    List<String>? actionIcons,
    Function(int)? onPress,
    List<Key?>? keys}) {
  return AppBar(
      backgroundColor: Get.theme.colorScheme.surface,
      //backgroundColor: Get.theme.backgroundColor,
      elevation: 0,
      centerTitle: true,
      leading: buttonOnlyIcon2(
          onPressCallback: () => Get.back(),
          iconPath: AssetConstants.icArrowLeft,
          size: dp22,
          iconColor: Get.theme.primaryColorDark),
      title: textAutoSize(
          text: title!,
          maxLines: 1,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w600,
          fontSize: 20),
      actions: (actionIcons == null || actionIcons.isEmpty)
          ? [const SizedBox(width: dp25)]
          : List.generate(actionIcons.length, (index) {
              return Padding(
                key: keys?[index],
                padding: const EdgeInsets.only(right: 10),
                child: buttonOnlyIcon(
                  viewSize: 25,
                  onPressCallback: () =>
                      onPress != null ? onPress(index) : null,
                  iconPath: actionIcons[index],
                  size: dp25,
                  iconColor: Get.theme.primaryColorDark,
                  //bgColor: Colors.green
                ),
              );
            }));
}
