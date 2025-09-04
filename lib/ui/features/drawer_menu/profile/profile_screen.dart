import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/root/root_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = Get.put(ProfileController());
  final _rootController = Get.put(RootController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getUserOfficeHistoryInfo(
          _rootController.userInfo.value.id.toString());
    });
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            // padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              _getIconForTitle(title),
              color: accentBlue,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    color: Color(0xFF1F2937),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    switch (title.toLowerCase()) {
      case "fullname":
        return Icons.person_outline;
      case "designation":
        return Icons.work_outline;
      case "office":
        return Icons.business_outlined;
      case "email":
        return Icons.email_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar:
          appBarWithBackAndActions(title: "Profile".tr, onPress: (index) {}),
      body: RefreshIndicator(
        onRefresh: _controller.getData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      // padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: accentBlue, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: bgColor,
                        child: showImageAsset(
                          imagePath: AssetConstants.avatar,
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${stringNullCheck(_rootController.userInfo.value.firstName)} ${stringNullCheck(_rootController.userInfo.value.lastName)}",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                    // const SizedBox(height: 8),
                    // Text(
                    //   stringNullCheck(_rootController.userInfo.value.designationName),
                    //   style: const TextStyle(
                    //     fontSize: 16,
                    //     color: Color(0xFF6B7280),
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoCard(
                "Designation".tr,
                stringNullCheck(_rootController.userInfo.value.designationName),
              ),
              Obx(() {
                return _buildInfoCard(
                  "office".tr,
                  stringNullCheck(_controller
                      .userOfficeHistoryListItemInfo.value.officeName
                      .toString()),
                );
              }),
              _buildInfoCard(
                "email".tr,
                stringNullCheck(_rootController.userInfo.value.email),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   final _controller = Get.put(ProfileController());
//   final _rootController = Get.put(RootController());

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       _controller.getUserOfficeHistoryInfo(_rootController.userInfo.value.id.toString());
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.theme.colorScheme.surface,
//       appBar: appBarWithBackAndActions(title: "Profile".tr),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: RefreshIndicator(
//                 onRefresh: _controller.getData,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,

//                     children: [
//                       const VSpacer20(),
//                       Container(
//                         decoration: boxDecorationFullCircleShadow(),
//                         child: showImageAsset(
//                             imagePath: AssetConstants.avatar,
//                             height: dp120,
//                             width: dp120),
//                       ),
//                       const VSpacer20(),
//                       Container(
//                         decoration: boxDecorationRoundShadowLight(),
//                         padding: const EdgeInsets.all(dp10),
//                         margin: const EdgeInsets.all(dp5),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const VSpacer20(),
//                             twoSidedTextWithColon(leftText: "fullName".tr, rightText:
//                             "${stringNullCheck(_rootController.userInfo.value.firstName)} ${stringNullCheck(_rootController.userInfo.value.lastName)}"),
//                             const Divider(),
//                             twoSidedTextWithColon(
//                                 leftText: "Designation".tr,
//                                 rightText: stringNullCheck(_rootController.userInfo.value.designationName)),
//                             const Divider(),
//                             /*twoSidedTextWithColon(
//                                 leftText: "nid".tr, rightText: stringNullCheck(_rootController.userInfo.value.nid.toString())),
//                             const Divider(),*/
//                             // twoSidedTextWithColon(
//                             //     leftText: "office".tr,
//                             //     rightText: stringNullCheck(_rootController.userInfo.value.officeId.toString())),
//                             // const Divider(),
//                             Obx((){
//                               return twoSidedTextWithColon(
//                                   leftText: "office".tr,
//                                   rightText: stringNullCheck(_controller.userOfficeHistoryListItemInfo.value.officeName.toString()));
//                             }),
//                             const Divider(),
//                             twoSidedTextWithColon(
//                                 leftText: "email".tr,
//                                 rightText: stringNullCheck(_rootController.userInfo.value.email)),
//                             const VSpacer20(),
//                           ],
//                         ),
//                       ),
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

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Get.theme.backgroundColor,
// //       appBar: appBarWithBack(title: "Profile".tr),
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             Expanded(
// //               child: SizedBox(
// //                 height: Get.height,
// //                 child: SingleChildScrollView(
// //                   child: Column(
// //                     children: [
// //                       const VSpacer20(),
// //                       showImageAsset(
// //                           imagePath: AssetConstants.avatar,
// //                           height: dp120,
// //                           width: dp120),
// //                       const VSpacer20(),
// //                       Container(
// //                         decoration: boxDecorationRoundShadow(),
// //                         padding: const EdgeInsets.all(dp16),
// //                         margin: const EdgeInsets.all(dp20),
// //                         child: Column(
// //                           mainAxisAlignment: MainAxisAlignment.center,
// //                           children: [
// //                             const VSpacer20(),
// //                             Row(
// //                               children: [
// //                                 Expanded(flex: 2, child: textAutoSize(text: "Name")),
// //                                 Expanded(flex: 1, child: textAutoSize(text: ":")),
// //                                 Expanded(
// //                                     flex: 3,
// //                                     child: textAutoSize(text: "User Full Name")),
// //                               ],
// //                             ),
// //                             const Divider(),
// //                             const VSpacer20(),
// //                           ],
// //                         ),
// //                       ),
// //                       const Spacer(),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// // @override
// // Widget build(BuildContext context) {
// //   return Scaffold(
// //     backgroundColor: Get.theme.backgroundColor,
// //     appBar: appBarMain(context, title: "Profile".tr),
// //     body: SafeArea(
// //       child: Column(
// //         children: [
// //           Expanded(
// //             child: RefreshIndicator(
// //               onRefresh: _controller.getData,
// //               child: SingleChildScrollView(
// //                   child: Column(
// //                 children: [
// //                   textAutoSize(text: "Profile".tr, color: Get.theme.primaryColor),
// //                 ],
// //               )),
// //             ),
// //           ),
// //         ],
// //       ),
// //     ),
// //   );
// // }

// }
