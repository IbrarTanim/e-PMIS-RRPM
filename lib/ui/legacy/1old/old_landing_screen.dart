// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:intl/intl.dart';
// import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
// import 'package:pmis_flutter/data/db/models/asset_collection.dart';
// import 'package:pmis_flutter/data/local/constants.dart';
// import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
// import 'package:pmis_flutter/data/models/my_projects_list_response.dart';
// import 'package:pmis_flutter/ui/features/bottom_navigation/agency_wise/agency_wise_screen.dart';
// import 'package:pmis_flutter/ui/features/bottom_navigation/my_project/my_project_controller.dart';
// import 'package:pmis_flutter/ui/features/bottom_navigation/my_project/my_project_screen.dart';
// import 'package:pmis_flutter/ui/features/bottom_navigation/my_project/project_common_details_screen.dart';
// import 'package:pmis_flutter/ui/features/bottom_navigation/pcr/pcr_screen.dart';
// import 'package:pmis_flutter/ui/features/bottom_navigation/pending_task/pending_task_screen.dart';
// import 'package:pmis_flutter/ui/features/bottom_navigation/reports/reports_screen.dart';
// import 'package:pmis_flutter/ui/features/landing/landing_controller.dart';
// import 'package:pmis_flutter/ui/features/project_details/image_gallery/image_gallery_controller.dart';
// import 'package:pmis_flutter/ui/features/project_details/project_locations/project_locations_screen.dart';
// import 'package:pmis_flutter/ui/features/project_details/survey_gallery/add_image_screen.dart';
// import 'package:pmis_flutter/ui/features/project_details/survey_gallery/survey_gallery_controller.dart';
// import 'package:pmis_flutter/ui/features/side_nav/projects/project_allocation_details_screen.dart';
// import 'package:pmis_flutter/ui/features/side_nav/projects/project_estimated_cost_details_screen.dart';
// import 'package:pmis_flutter/ui/features/side_nav/projects/wishList_project_details_controller.dart';
// import 'package:pmis_flutter/ui/root/root_screen.dart';
// import 'package:pmis_flutter/utils/appbar_util.dart';
// import 'package:pmis_flutter/utils/button_util.dart';
// import 'package:pmis_flutter/utils/common_utils.dart';
// import 'package:pmis_flutter/utils/common_widget.dart';
// import 'package:pmis_flutter/utils/decorations.dart';
// import 'package:pmis_flutter/utils/dimens.dart';
// import 'package:pmis_flutter/utils/image_util.dart';
// import 'package:pmis_flutter/utils/spacers.dart';
// import 'package:pmis_flutter/utils/text_util.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher_string.dart';
// import '../../../../utils/alert_util.dart';
// import '../../../../utils/date_util.dart';

// class LandinScreen extends StatefulWidget {
//   const LandinScreen({Key? key}) : super(key: key);

//   @override
//   _LandinScreenState createState() => _LandinScreenState();
// }

// class _LandinScreenState extends State<LandinScreen> {
//   final _controllerLandingProjectCount =
//       Get.put(LandingProjectCountController());

//   bool isLoading = true;

//   void initCalls() async {
//     await _controllerLandingProjectCount.getLandingProjectCount();

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }

//   @override
//   void initState() {
//     initCalls();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // _controller.clearView();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.theme.colorScheme.surface,
//       //appBar: appBarWithBackAndActions(
//       appBar: onlyAppBar(title: "Landing"),
//       body: SafeArea(
//         child: isLoading == true
//             ? const Center(
//                 child: CircularProgressIndicator(color: Colors.green))
//             : Container(
//                 //height: Platform.isAndroid ? getContentHeight() - 110 : getContentHeight() - 195,
//                 //decoration: boxDecorationRoundShadowLight(),
//                 //padding: const EdgeInsets.all(dp10),
//                 //margin: const EdgeInsets.all(dp10),
//                 //margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),

//                 child: SingleChildScrollView(
//                   child: Scrollbar(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               flex: 2,
//                               child: InkWell(
//                                 child: Container(
//                                   decoration: const BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                     gradient: LinearGradient(
//                                       begin: Alignment.topLeft,
//                                       end: Alignment(0.8, 1),
//                                       colors: <Color>[
//                                         Color(0xFF4A90E2),
//                                         Color(0xFF50E3C2)
//                                       ], // Gradient from https://learnui.design/tools/gradient-generator.htmltileMode: TileMode.mirror,
//                                     ),
//                                   ),

//                                   //decoration: boxDecorationRoundShadowLight(),
//                                   margin: const EdgeInsets.fromLTRB(
//                                       dp5, dp5, dp5, 0),
//                                   child: Column(children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(dp5),
//                                       child: textAutoSize(
//                                           text: "Projects",
//                                           maxLines: 1,
//                                           fontSize: dp15,
//                                           alignment: Alignment.centerLeft,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     const Divider(),
//                                     Container(
//                                       padding: const EdgeInsets.all(dp15),
//                                       child: Stack(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Expanded(
//                                                 flex: 9,
//                                                 child: Column(
//                                                   children: [
//                                                     textAutoSize(
//                                                         color: Colors.white,
//                                                         text:
//                                                             "${stringNullCheck(_controllerLandingProjectCount.landingProjectCount.value.currentYearAllocatedAdpRadpProjects.toString())}",
//                                                         maxLines: 1,
//                                                         fontSize: dp18,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                     const SizedBox(
//                                                         height: dp10),
//                                                     textAutoSize(
//                                                         color: Colors.white,
//                                                         //text: "Report as submitted to IMED",
//                                                         text:
//                                                             "Total Ongoing Projects",
//                                                         maxLines: 1,
//                                                         fontSize: dp14,
//                                                         fontWeight:
//                                                             FontWeight.normal)
//                                                   ],
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   flex: 2,
//                                                   child: const SizedBox(
//                                                     width: dp5,
//                                                   )),
//                                             ],
//                                           ),
//                                           Container(
//                                             margin: const EdgeInsets.fromLTRB(
//                                                 0, 0, dp30, 0),
//                                             child: Align(
//                                               alignment: Alignment.topRight,
//                                               child: showImageAsset(
//                                                   imagePath:
//                                                       AssetConstants.icMonitor,
//                                                   height: dp50,
//                                                   width: dp50),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ]),
//                                 ),
//                                 onTap: () {
//                                   //Get.offAll(() => const RootScreen());
//                                   //Get.to(() => RootScreen(), arguments: TotalOngoingProjects);
//                                   Get.to(() => RootScreen());
//                                   GetStorage().write(PreferenceKey.TagComeFrom,
//                                       TotalOngoingProjects);
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),

//                         Row(
//                           children: [
//                             Expanded(
//                               flex: 2,
//                               child: InkWell(
//                                 child: Container(
//                                   //decoration: boxDecorationRoundShadowLight(),
//                                   decoration: const BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                     gradient: LinearGradient(
//                                       begin: Alignment.topLeft,
//                                       end: Alignment(0.8, 1),
//                                       colors: <Color>[
//                                         Color(0xFF4A90E2),
//                                         Color(0xFF50E3C2)
//                                       ],
//                                     ),
//                                   ),

//                                   margin: const EdgeInsets.fromLTRB(
//                                       dp5, dp5, dp5, 0),
//                                   child: Column(children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(dp5),
//                                       child: textAutoSize(
//                                           text: "Development Projects",
//                                           maxLines: 1,
//                                           fontSize: dp15,
//                                           alignment: Alignment.centerLeft,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     const Divider(),
//                                     Container(
//                                       padding: const EdgeInsets.all(dp15),
//                                       child: Stack(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Expanded(
//                                                 flex: 9,
//                                                 child: Column(
//                                                   children: [
//                                                     textAutoSize(
//                                                         //color: Colors.black87,
//                                                         color: Colors.white,
//                                                         text:
//                                                             "${stringNullCheck(_controllerLandingProjectCount.landingProjectCount.value.currentYearAllocatedInvestmentProjectsExcludingOwnFund.toString())}",
//                                                         maxLines: 1,
//                                                         fontSize: dp18,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                     const SizedBox(
//                                                         height: dp10),
//                                                     textAutoSize(
//                                                         color: Colors.white,
//                                                         //text: "Report as submitted to IMED",
//                                                         text:
//                                                             "Total Ongoing Development Projects",
//                                                         maxLines: 1,
//                                                         fontSize: dp14,
//                                                         fontWeight:
//                                                             FontWeight.normal)
//                                                   ],
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   flex: 2,
//                                                   child: const SizedBox(
//                                                     width: dp5,
//                                                   )),
//                                             ],
//                                           ),
//                                           Container(
//                                             margin: const EdgeInsets.fromLTRB(
//                                                 0, 0, dp30, 0),
//                                             child: Align(
//                                               alignment: Alignment.topRight,
//                                               child: showImageAsset(
//                                                   imagePath:
//                                                       AssetConstants.icMonitor,
//                                                   height: dp50,
//                                                   width: dp50),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ]),
//                                 ),
//                                 onTap: () {
//                                   //Get.offAll(() => const RootScreen());
//                                   //Get.to(() => RootScreen(), arguments: TotalOngoingDevelopmentProjects);
//                                   Get.to(() => RootScreen());
//                                   GetStorage().write(PreferenceKey.TagComeFrom,
//                                       TotalOngoingDevelopmentProjects);
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),

//                         Row(
//                           children: [
//                             Expanded(
//                               flex: 2,
//                               child: InkWell(
//                                 child: Container(
//                                   //decoration: boxDecorationRoundShadowLight(),
//                                   decoration: const BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                     gradient: LinearGradient(
//                                       begin: Alignment.topLeft,
//                                       end: Alignment(0.8, 1),
//                                       colors: <Color>[
//                                         Color(0xFF4A90E2),
//                                         Color(0xFF50E3C2)
//                                       ], // Gradient from https://learnui.design/tools/gradient-generator.htmltileMode: TileMode.mirror,
//                                     ),
//                                   ),

//                                   margin: const EdgeInsets.fromLTRB(
//                                       dp5, dp5, dp5, 0),
//                                   child: Column(children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(dp5),
//                                       child: textAutoSize(
//                                           text: "Technical Assistance Projects",
//                                           maxLines: 1,
//                                           fontSize: dp15,
//                                           alignment: Alignment.centerLeft,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     const Divider(),
//                                     Container(
//                                       padding: const EdgeInsets.all(dp15),
//                                       child: Stack(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Expanded(
//                                                 flex: 9,
//                                                 child: Column(
//                                                   children: [
//                                                     textAutoSize(
//                                                         color: Colors.white,
//                                                         text:
//                                                             "${stringNullCheck(_controllerLandingProjectCount.landingProjectCount.value.currentYearAllocatedTechnicalAssistantProjectsExcludingOwnFund.toString())}",
//                                                         maxLines: 1,
//                                                         fontSize: dp18,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                     const SizedBox(
//                                                         height: dp10),
//                                                     textAutoSize(
//                                                         color: Colors.white,
//                                                         //text: "Report as submitted to IMED",
//                                                         text:
//                                                             "Total Ongoing TA Projects",
//                                                         maxLines: 1,
//                                                         fontSize: dp14,
//                                                         fontWeight:
//                                                             FontWeight.normal)
//                                                   ],
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   flex: 2,
//                                                   child: const SizedBox(
//                                                     width: dp5,
//                                                   )),
//                                             ],
//                                           ),
//                                           Container(
//                                             margin: const EdgeInsets.fromLTRB(
//                                                 0, 0, dp30, 0),
//                                             child: Align(
//                                               alignment: Alignment.topRight,
//                                               child: showImageAsset(
//                                                   imagePath:
//                                                       AssetConstants.icMonitor,
//                                                   height: dp50,
//                                                   width: dp50),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ]),
//                                 ),
//                                 onTap: () {
//                                   //Get.offAll(() => const RootScreen());
//                                   //Get.to(() => RootScreen(), arguments: TotalOngoingTAProjects);

//                                   Get.to(() => RootScreen());
//                                   GetStorage().write(PreferenceKey.TagComeFrom,
//                                       TotalOngoingTAProjects);
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),

//                         Row(
//                           children: [
//                             Expanded(
//                               flex: 2,
//                               child: InkWell(
//                                 child: Container(
//                                   //decoration: boxDecorationRoundShadowLight(),
//                                   decoration: const BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                     gradient: LinearGradient(
//                                       begin: Alignment.topLeft,
//                                       end: Alignment(0.8, 1),
//                                       colors: <Color>[
//                                         Color(0xFF4A90E2),
//                                         Color(0xFF50E3C2)
//                                       ], // Gradient from https://learnui.design/tools/gradient-generator.htmltileMode: TileMode.mirror,
//                                     ),
//                                   ),

//                                   margin: const EdgeInsets.fromLTRB(
//                                       dp5, dp5, dp5, 0),
//                                   child: Column(children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(dp5),
//                                       child: textAutoSize(
//                                           text: "Own Fund Projects",
//                                           maxLines: 1,
//                                           fontSize: dp15,
//                                           alignment: Alignment.centerLeft,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     const Divider(),
//                                     Container(
//                                       padding: const EdgeInsets.all(dp15),
//                                       child: Stack(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Expanded(
//                                                 flex: 9,
//                                                 child: Column(
//                                                   children: [
//                                                     textAutoSize(
//                                                         color: Colors.white,
//                                                         text:
//                                                             "${stringNullCheck(_controllerLandingProjectCount.landingProjectCount.value.totalOwnFundedProjects.toString())}",
//                                                         maxLines: 1,
//                                                         fontSize: dp18,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                     const SizedBox(
//                                                         height: dp10),
//                                                     textAutoSize(
//                                                         color: Colors.white,
//                                                         //text: "Report as submitted to IMED",
//                                                         text:
//                                                             "Total Own Fund Projects",
//                                                         maxLines: 1,
//                                                         fontSize: dp14,
//                                                         fontWeight:
//                                                             FontWeight.normal)
//                                                   ],
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   flex: 2,
//                                                   child: const SizedBox(
//                                                     width: dp5,
//                                                   )),
//                                             ],
//                                           ),
//                                           Container(
//                                             margin: const EdgeInsets.fromLTRB(
//                                                 0, 0, dp30, 0),
//                                             child: Align(
//                                               alignment: Alignment.topRight,
//                                               child: showImageAsset(
//                                                   imagePath:
//                                                       AssetConstants.icMonitor,
//                                                   height: dp50,
//                                                   width: dp50),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ]),
//                                 ),
//                                 onTap: () {
//                                   //Get.offAll(() => const RootScreen());
//                                   //Get.to(() => RootScreen(), arguments: TotalOwnFundProjects);

//                                   Get.to(() => RootScreen());
//                                   GetStorage().write(PreferenceKey.TagComeFrom,
//                                       TotalOwnFundProjects);
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),

//                         Row(
//                           children: [
//                             Expanded(
//                               flex: 2,
//                               child: InkWell(
//                                 child: Container(
//                                   //decoration: boxDecorationRoundShadowLight(),
//                                   decoration: const BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                     gradient: LinearGradient(
//                                       begin: Alignment.topLeft,
//                                       end: Alignment(0.8, 1),
//                                       colors: <Color>[
//                                         Color(0xFF4A90E2),
//                                         Color(0xFF50E3C2)
//                                       ], // Gradient from https://learnui.design/tools/gradient-generator.htmltileMode: TileMode.mirror,
//                                     ),
//                                   ),
//                                   margin: const EdgeInsets.fromLTRB(
//                                       dp5, dp5, dp5, dp5),
//                                   child: Column(children: [
//                                     Container(
//                                       padding: const EdgeInsets.all(dp5),
//                                       child: textAutoSize(
//                                           text: "Feasibility Study Projects",
//                                           maxLines: 1,
//                                           fontSize: dp15,
//                                           alignment: Alignment.centerLeft,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     const Divider(),
//                                     Container(
//                                       padding: const EdgeInsets.all(dp15),
//                                       child: Stack(
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Expanded(
//                                                 flex: 9,
//                                                 child: Column(
//                                                   children: [
//                                                     textAutoSize(
//                                                         color: Colors.white,
//                                                         text:
//                                                             "${stringNullCheck(_controllerLandingProjectCount.landingProjectCount.value.feasibilityStudyProjects.toString())}",
//                                                         maxLines: 1,
//                                                         fontSize: dp18,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                     const SizedBox(
//                                                         height: dp10),
//                                                     textAutoSize(
//                                                         color: Colors.white,
//                                                         //text: "Report as submitted to IMED",
//                                                         text:
//                                                             "Total Feasibility Study Projects",
//                                                         maxLines: 1,
//                                                         fontSize: dp14,
//                                                         fontWeight:
//                                                             FontWeight.normal)
//                                                   ],
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                   flex: 2,
//                                                   child: const SizedBox(
//                                                     width: dp5,
//                                                   )),
//                                             ],
//                                           ),
//                                           Container(
//                                             margin: const EdgeInsets.fromLTRB(
//                                                 0, 0, dp30, 0),
//                                             child: Align(
//                                               alignment: Alignment.topRight,
//                                               child: showImageAsset(
//                                                   imagePath:
//                                                       AssetConstants.icMonitor,
//                                                   height: dp50,
//                                                   width: dp50),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ]),
//                                 ),
//                                 onTap: () {
//                                   //Get.to(() => ProjectAllocationDetailsScreen());
//                                   //Get.to(() => RootScreen(), arguments: TotalFeasibilityStudyProjects);

//                                   /*Get.to(() => RootScreen());
//                                   GetStorage().write(PreferenceKey.TagComeFrom, TotalFeasibilityStudyProjects);*/
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                         //surveyGalleryButton(),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }
