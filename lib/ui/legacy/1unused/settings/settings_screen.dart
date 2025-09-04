import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/button_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import 'package:pmis_flutter/utils/theme_util.dart';
import 'settings_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _controller = Get.put(SettingsController());

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     _controller.getData();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      appBar: appBarWithBack(title: "Settings".tr),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            decoration: boxDecorationRoundShadowLight(),
            padding: const EdgeInsets.all(dp16),
            margin: const EdgeInsets.all(dp20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const VSpacer10(),
                textAutoSize(
                    text: "LanguageSettings".tr,
                    fontSize: dp16,
                    fontWeight: FontWeight.w100,
                    color: Get.theme.primaryColor,
                    maxLines: 1),
                const VSpacer10(),
                Obx(() {
                  return dropDownList(
                      items: ["English".tr, "Bengali".tr],
                      //_controller.getLanguageList(),
                      selectedValue: _controller.selectedLanguage.value,
                      hint: "SelectLanguage".tr,
                      onChange: (value) {
                        _controller.selectedLanguage.value = value;
                        _controller.getLanguageList;
                      },
                      extraWidth: 139);
                }),
                // Obx(() {
                //   return dropDownList(
                //       _controller.getLanguageList(),
                //       _controller.selectedLanguage.value,
                //       "Select Language".tr, (value) {
                //     _controller.selectedLanguage.value = value;
                //   });
                // }),
                const VSpacer20(),
                buttonRoundedMain(
                    text: "UpdateLanguage".tr,
                    onPressCallback: () {
                      _controller.saveLanguage();
                    }),
                horizontalDivider(height: 60, margin: 10),
                /*textAutoSize(
                    text: "ThemeSettings".tr,
                    fontSize: dp16,
                    fontWeight: FontWeight.w100,
                    color: Get.theme.primaryColor,
                    maxLines: 1),*/
                //const VSpacer10(),
                // Obx(() {
                //   return dropDownList(
                //       ["Dark".tr, "Light".tr],
                //       _controller.selectedTheme.value,
                //       "Select Theme".tr, (value) {
                //     _controller.selectedTheme.value = value;
                //     ThemeService().switchTheme();
                //   });
                // }),
                // Obx(() {
                //   return _settingsItemToggle(AssetConstants.icTheme, "DarkTheme".tr, _controller.isDark.value, () {
                //     currentTheme.switchTheme();
                //     _controller.isDark.value = !_controller.isDark.value;
                //     GetStorage().write(PreferenceKey.kIsDark,_controller.isDark.value);
                //     // SharedPrefUtil.writeBoolean(PrefKeyConstant.kIsDark, _controller.isDark.value);
                //     Get.back();
                //   });
                // }),
                /*Obx(() {
                  return dropDownList(
                      items: ["Dark".tr, "Light".tr],
                      selectedValue: _controller.selectedTheme.value,
                      hint: "SelectTheme".tr,
                      onChange: (value) {
                        _controller.selectedTheme.value = value;
                        // ThemeService().switchTheme();
                      },
                      extraWidth: 139);
                }),
                const VSpacer20(),
                buttonRoundedMain(
                    text: "UpdateTheme".tr,
                    onPressCallback: () {
                      // showLoadingDialog();
                      ThemeService().switchTheme();
                      // currentTheme.switchTheme();
                      // hideLoadingDialog();
                      Get.back();
                    }),
                const VSpacer10(),
                const VSpacer10(),*/
                // Obx(() {
                //   return _settingsItemToggle(AssetConstants.ic_time, "kDarkTheme".tr, isDark.value, () {
                //     ThemeService().switchTheme();
                //     Get.back();
                //   });
                // }),
                const VSpacer10(),
              ],
            ),
          ),
        ),
      ),
    );
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Get.theme.backgroundColor,
//       appBar: appBarWithBack(title: "Profile".tr),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: SizedBox(
//                 height: Get.height,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       const VSpacer20(),
//                       showImageAsset(
//                           imagePath: AssetConstants.avatar,
//                           height: dp120,
//                           width: dp120),
//                       const VSpacer20(),
//                       Container(
//                         decoration: boxDecorationRoundShadow(),
//                         padding: const EdgeInsets.all(dp16),
//                         margin: const EdgeInsets.all(dp20),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const VSpacer20(),
//                             Row(
//                               children: [
//                                 Expanded(flex: 2, child: textAutoSize(text: "Name")),
//                                 Expanded(flex: 1, child: textAutoSize(text: ":")),
//                                 Expanded(
//                                     flex: 3,
//                                     child: textAutoSize(text: "User Full Name")),
//                               ],
//                             ),
//                             const Divider(),
//                             const VSpacer20(),
//                           ],
//                         ),
//                       ),
//                       const Spacer(),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: Get.theme.backgroundColor,
//     appBar: appBarMain(context, title: "Profile".tr),
//     body: SafeArea(
//       child: Column(
//         children: [
//           Expanded(
//             child: RefreshIndicator(
//               onRefresh: _controller.getData,
//               child: SingleChildScrollView(
//                   child: Column(
//                 children: [
//                   textAutoSize(text: "Profile".tr, color: Get.theme.primaryColor),
//                 ],
//               )),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

  Widget _settingsItemToggle(
      String iconPath, String title, bool isSelect, VoidCallback onTap) {
    return Container(
      decoration: boxDecorationRoundShadowLight(),
      padding: const EdgeInsets.all(dp16),
      margin: const EdgeInsets.all(dp20),
      // padding: const EdgeInsets.symmetric(vertical: 20),
      height: menuHeightSettings,
      // width: Get.width,
      // color: Get.theme.primaryColorLight,
      child: Center(
        child: ListTile(
          // leading: SvgPicture.asset(iconPath, width: iconHeightMid, height: iconHeightMid),
          leading: showImageAsset(imagePath: iconPath, height: 40),
          title: textAutoSize(text: title),
          trailing: GestureDetector(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(paddingMin),
              height: iconHeightSmall,
              width: iconHeightMid,
              decoration: BoxDecoration(
                  color: isSelect ? Colors.blueAccent : Colors.grey,
                  borderRadius: BorderRadius.circular(dp90)),
              child: Align(
                  alignment: isSelect ? Alignment.topRight : Alignment.topLeft,
                  child: const CircleAvatar(
                      backgroundColor: primary, radius: paddingMin)),
            ),
          ),
        ),
      ),
    );
  }


}
