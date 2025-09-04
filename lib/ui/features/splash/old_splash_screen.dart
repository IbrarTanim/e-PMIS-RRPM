// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pmis_flutter/data/local/constants.dart';
// import 'package:pmis_flutter/utils/common_widget.dart';
// import 'package:pmis_flutter/utils/dimens.dart';
// import 'package:pmis_flutter/utils/image_util.dart';
// import 'package:pmis_flutter/utils/spacers.dart';
// import 'package:pmis_flutter/utils/text_util.dart';
// import 'splash_controller.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   // @override
//   // void dispose() {
//   //   hideKeyboard(context);
//   //   super.dispose();
//   // }
//   // @override
//   // void initState() {
//   //   super.initState();
//   //   hideKeyboard(context);
//   //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//   //
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: GetBuilder<SplashController>(
//           init: SplashController(),
//           builder: (splashController) {
//             return Padding(
//               padding: const EdgeInsets.all(0),
//               child: Stack(children: [
//                 Container(
//                     //color: Get.theme.primaryColor,
//                   /*decoration:  const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment(0.8, 1), colors: <Color>[Color(0xff1f005c), Color(0xff5b0060), Color(0xff870160), Color(0xffac255e), Color(0xffca485c), Color(0xffe16b5c), Color(0xfff39060), Color(0xffffb56b),], // Gradient from https://learnui.design/tools/gradient-generator.htmltileMode: TileMode.mirror,
//               ),),*/

//               decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
//               ),),

//                     height: Get.height,
//                     width: Get.width,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         showImageAsset(
//                             imagePath: AssetConstants.appLogo,
//                             height: Get.width / 2,
//                             width: Get.width / 2),
//                         const VSpacer20(),
//                         textAutoSize(
//                             alignment: Alignment.center,
//                             text: "App_name_short".tr,
//                             textAlign: TextAlign.start,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontSize: 20),
//                         const VSpacer20(),
//                         Padding(
//                           padding: const EdgeInsets.all(30.0),
//                           child: textAutoSize(
//                               text: "App_name".tr,
//                               fontSize: dp25,
//                               textAlign: TextAlign.center,
//                               //color: Get.theme.primaryColorDark,
//                               color: Colors.white,
//                               maxLines: 3,
//                               alignment: Alignment.center),
//                         )
//                       ],
//                     )),
//               ]),
//             );
//           }),
//     );
//   }

//   void showConnectivitySnackBar(ConnectivityResult result) {
//     final hasInternet = result != ConnectivityResult.none;
//     if (!hasInternet) {
//       showTopSnackBar(
//           context,
//           "Please Check Internet Connection and Run the App Again".tr,
//           Colors.red);
//     }
//   }
// }
