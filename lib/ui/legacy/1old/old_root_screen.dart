import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/auth/sign_in_screen.dart';
import 'package:pmis_flutter/ui/legacy/1unused/all_my_projects/all_my_projects_screen.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pcr/pcr_screen.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pending_task/pending_task_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/all_projects/all_projects_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/projects/projects_screen.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/bottom_nav.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/drawer_menu.dart';
import 'package:pmis_flutter/utils/button_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import '../../features/bottom_nav/agency_wise/agency_wise_screen.dart';
import '../../features/drawer_menu/district_wise/district_wise_screen.dart';
import '../../features/bottom_nav/my_project/my_project_screen.dart';
import '../../features/bottom_nav/reports/reports_screen.dart';
import '../../features/drawer_menu/about_app/about_app_screen.dart';
import '../../features/drawer_menu/fast_track/fast_track_screen.dart';
import '../../features/drawer_menu/pd_directory/pd_directory_screen.dart';
import '../../features/drawer_menu/profile/profile_screen.dart';
import '../1unused/settings/settings_screen.dart';
import '../../features/root/root_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final _controller = Get.put(RootController());

  // final ProjectDetailsController _projectDetailsController = Get.put(ProjectDetailsController());

  //var Tag = Get.arguments;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getUserInfo();
      // _controller.getUserOfficeHistoryInfo();
      // _projectDetailsController.getMyProjectListItemsWithoutPagination();
    });
  }

  @override
  void dispose() {
    hideKeyboard(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Zabir
        backgroundColor: white, // sets statsu bar color
        body: SafeArea(
          child: _getBody(),
        ),
        drawer: _getDrawer(context),
        bottomNavigationBar: getBottomNavigationBar());
  }

  /// Returns color of the selected item
  Color? _getItemColor(int index) {
    return DefaultValue.selectedBottomIndex == index
        ? Get.theme.primaryColorDark
        : Get.theme.primaryColorLight;
  }

  void _onItemTapped(int index) {
    setState(() {
      DefaultValue.selectedBottomIndex = index;
      // _controller.selectedIndex.value = index;
    });
  }

  Widget _getBody() {
    switch (DefaultValue.selectedBottomIndex) {
      case 0:
        return const PCRScreen();
      // return const PendingPCRScreen();
      // return const MinistryWiseScreen();
      case 1:
        return const AgencyWiseScreen();
      case 2:
        return const MyProjectScreen();
      case 3:
        //return const DistrictWiseScreen();
        //return const FastTrackScreen();
        return const PendingTaskScreen();
      case 4:
        // return const PdDirectoryScreen();
        return const ReportsScreen();
      default:
        return Container();
    }
  }

  // Zabir
  _getDrawer(context) {
    return Obx(() => DrawerMenu(
          userName:
              "${stringNullCheck(_controller.userInfo.value.firstName)} ${stringNullCheck(_controller.userInfo.value.lastName)}",
          designation:
              stringNullCheck(_controller.userInfo.value.designationName),
          onLogout: () {
            alertForLogOut(
              okAction: () {
                clearStorage();
                Get.back();
                Get.offAll(const SignInScreen());
              },
              noAction: () {
                Get.back();
              },
            );
          },
        ));
  }

  // _getDrawer(context) {
  //   return Theme(
  //     data: Theme.of(context).copyWith(
  //       canvasColor: Get.theme.colorScheme.surface,
  //       //canvasColor: Get.theme.backgroundColor,
  //     ),
  //     child: Drawer(
  //       elevation: 5,
  //       child: ListView(
  //         padding: EdgeInsets.zero,
  //         children: [
  //           Stack(
  //             children: [
  //               DrawerHeader(
  //                 decoration: BoxDecoration(
  //                   color: Get.theme.primaryColor,
  //                 ),
  //                 child: Obx(() {
  //                   //GetStorage().write(PreferenceKey.TagComeFrom, Get.arguments);
  //                   return profileView(
  //                       userName:
  //                           "${stringNullCheck(_controller.userInfo.value.firstName)} ${stringNullCheck(_controller.userInfo.value.lastName)}",
  //                       //userName: Get.arguments,
  //                       userDesignation: stringNullCheck(
  //                           _controller.userInfo.value.designationName),
  //                       // userName: "Mr. User",
  //                       // userEmail: "user@gmail.com",
  //                       leftTextColor: Get.theme.colorScheme.surface);
  //                   //leftTextColor: Get.theme.backgroundColor);
  //                 }),
  //               ),
  //               // Positioned(
  //               //     top: 10,
  //               //     right: 10,
  //               //     // alignment: Alignment.centerRight,
  //               //     child: SafeArea(
  //               //       child: showImageAsset(
  //               //           onPressCallback: () {
  //               //             Get.back();
  //               //           },
  //               //           imagePath: AssetConstants.icCross,
  //               //           height: dp20,
  //               //           color: Get.theme.backgroundColor),
  //               //     ))
  //             ],
  //           ),
  //           const VSpacer5(),
  //           _sideMenuView(),
  //           const VSpacer20(),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _sideMenuView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: dp5, vertical: dp15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            listTitleWithLeftIcon(
                "Profile".tr, AssetConstants.avatar, Get.theme.primaryColorDark,
                () {
              Get.to(() => const ProfileScreen());
            }),
            const Divider(),
            listTitleWithLeftIcon("PD_directory".tr,
                AssetConstants.icPdDirectory, Get.theme.primaryColorDark, () {
              Get.to(() => const PdDirectoryScreen());
            }),
            const Divider(),
            listTitleWithLeftIcon(
                //"FastTrack".tr, AssetConstants.icFastTrack1, Get.theme.primaryColorDark,
                "District_wise".tr,
                AssetConstants.icDistrict,
                Get.theme.primaryColorDark, () {
              //Get.to(() => const FastTrackScreen());
              Get.to(() => const DistrictWiseScreen());
            }),
            const Divider(),
            listTitleWithLeftIcon("FastTrack".tr, AssetConstants.icFastTrack1,
                Get.theme.primaryColorDark, () {
              Get.to(() => const FastTrackScreen());
            }),
            const Divider(),
            listTitleWithLeftIcon("AllProjects".tr, AssetConstants.icProject,
                Get.theme.primaryColorDark, () {
              Get.to(() => const AllProjectsScreen());
            }),
            const Divider(),
            listTitleWithLeftIcon("Projects".tr, AssetConstants.icTaka,
                Get.theme.primaryColorDark, () {
              Get.to(() => const ProjectsScreen());
            }),
            const Divider(),
            listTitleWithLeftIcon("AboutApp".tr, AssetConstants.icAbout,
                Get.theme.primaryColorDark, () {
              Get.to(() => const AboutAppScreen());
            }),

            /*const Divider(),
            listTitleWithLeftIcon("Settings".tr, AssetConstants.icSettings,
                Get.theme.primaryColorDark, () {
              Get.to(() => const SettingsScreen());
            }),*/

            const Divider(),
            listTitleWithLeftIcon("Logout".tr, AssetConstants.icLogout,
                Get.theme.primaryColorDark, () {
              //_logoutConfirmationDialog();
              alertForLogOut(okAction: () {
                clearStorage();
                Get.back();
                Get.offAll(const SignInScreen());
                // _controller.logOut();
              }, noAction: () {
                Get.back();
              });
            }),

            /*const Divider(),
            textSpanAutoSize(appName: "AppType_Production".tr, version: "App_version".tr)*/
          ],
        ),
      ),
    );
  }

  void alertForLogOut({VoidCallback? okAction, VoidCallback? noAction}) {
    Get.defaultDialog(
      title: "",
      radius: dp10,
      backgroundColor: Get.theme.colorScheme.surface,
      //backgroundColor: Get.theme.backgroundColor,
      content: SizedBox(
        height: dp150,
        width: Get.width,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                textAutoSize(
                    textAlign: TextAlign.center,
                    text: 'Logout'.tr,
                    fontSize: 22),
                const SizedBox(height: dp10),
                textAutoSize(
                    text: "LogoutText".tr,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    fontSize: dp15),
                const SizedBox(height: dp10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buttonRoundedMain(
                        text: "Yes".tr,
                        height: 40,
                        onPressCallback: okAction,
                        width: Get.width / 3.5),
                    buttonRoundedMain(
                        text: "No".tr,
                        height: 40,
                        onPressCallback: noAction,
                        width: Get.width / 3.5)
                  ],
                )
              ],
            ),
            Positioned(
                // top: 40,
                // right: 16,
                child: showImageAsset(
                    onPressCallback: () {
                      Get.back();
                    },
                    imagePath: AssetConstants.icCross,
                    height: dp20,
                    color: Get.theme.colorScheme.surface))
            //color: Get.theme.backgroundColor))
          ],
        ),
      ),
    );
  }

  // Zabir
  Widget getBottomNavigationBar() {
    return RootBottomNav(
      currentIndex: DefaultValue.selectedBottomIndex,
      onTap: _onItemTapped,
      icons: const [
        Icons
            .assessment, // or Icons.analytics - for PCR since it seems like some kind of report/analysis
        Icons.business, // for Agency-wise
        Icons.folder_special, // for My Projects
        Icons.pending_actions, // for Pending Tasks
        Icons.summarize, // for Reports
      ],
      labels: const [
        'PCR',
        'Agency_wise',
        'My_projects',
        'PendingTask',
        'Reports',
      ],
    );
  }

  // Widget getBottomNavigationBar() {
  //   return BottomNavigationBar(
  //     elevation: 0.0,
  //     type: BottomNavigationBarType.fixed,
  //     //backgroundColor: Get.theme.primaryColor,
  //     backgroundColor: Get.theme.primaryColor,

  //     items: <BottomNavigationBarItem>[

  //       BottomNavigationBarItem(
  //         icon: SvgPicture.asset(
  //           AssetConstants.icPCR,
  //           // AssetConstants.icMyProjects,
  //           color: _getItemColor(0),
  //           height: 30,
  //         ),
  //         label: 'PCR'.tr,
  //         // label: 'PendingPCR'.tr,
  //         // label: 'Ministry Wise',
  //       ),

  //       BottomNavigationBarItem(
  //         icon: SvgPicture.asset(
  //           AssetConstants.icAgency,
  //           color: _getItemColor(1),
  //           height: 30,
  //         ),
  //         label: 'Agency_wise'.tr,
  //       ),
  //       BottomNavigationBarItem(
  //         icon: SvgPicture.asset(
  //           AssetConstants.icMyProjects,
  //           color: _getItemColor(2),
  //           height: 30,
  //         ),
  //         label: 'My_projects'.tr,
  //       ),
  //       BottomNavigationBarItem(
  //         icon: SvgPicture.asset(
  //           //AssetConstants.icDistrict,
  //           AssetConstants.icPendingTask,
  //           color: _getItemColor(3),
  //           height: 30,
  //         ),
  //         //label: 'District_wise'.tr,
  //         label: 'PendingTask'.tr,
  //       ),
  //       BottomNavigationBarItem(
  //         icon: SvgPicture.asset(AssetConstants.icReports,
  //             color: _getItemColor(4), height: 30),
  //         label: 'Reports'.tr,
  //       ),
  //     ],
  //     currentIndex: DefaultValue.selectedBottomIndex,
  //     onTap: _onItemTapped,
  //     unselectedFontSize: 11,
  //     selectedFontSize: 12,
  //     selectedItemColor: Get.theme.primaryColorDark,
  //     unselectedItemColor: Get.theme.primaryColorLight,
  //   );
  // }

  /*decoration: const BoxDecoration(
  gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment(0.8, 1),
  colors: <Color>[
  Color(0xff1f005c),
  Color(0xff5b0060),
  Color(0xff870160),
  Color(0xffac255e),
  Color(0xffca485c),
  Color(0xffe16b5c),
  Color(0xfff39060),
  Color(0xffffb56b),
  ], // Gradient from https://learnui.design/tools/gradient-generator.html
  tileMode: TileMode.mirror,
  ),
  ),*/

  /*gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment(0.8, 1),
  colors: <Color>[
  Color(0xff1f005c),
  Color(0xff5b0060),
  Color(0xff870160),
  Color(0xffac255e),
  Color(0xffca485c),
  Color(0xffe16b5c),
  Color(0xfff39060),
  Color(0xffffb56b),
  ], // Gradient from https://learnui.design/tools/gradient-generator.html
  tileMode: TileMode.mirror,
  ),*/

  Widget getBottomNavigationBarConvex() {
    return StyleProvider(
      style: Style(),
      child: ConvexAppBar(
        backgroundColor: Get.theme.primaryColor,
        activeColor: Get.theme.primaryColorDark,
        color: Get.theme.primaryColorLight,
        elevation: 5.0,
        initialActiveIndex: 2,
        height: 55,
        top: -15,
        curveSize: 100,
        style: TabStyle.reactCircle,
        //style: TabStyle.flip,
        onTap: _onItemTapped,
        items: [
          TabItem(
            icon: SvgPicture.asset(
              AssetConstants.icMinistry,
              color: _getItemColor(0),
              height: 30,
            ),
            title: 'Ministry_wise'.tr,
          ),
          TabItem(
            icon: SvgPicture.asset(
              AssetConstants.icAgency,
              color: _getItemColor(1),
              height: 30,
            ),
            title: 'Agency_wise'.tr,
          ),
          TabItem(
            icon: SvgPicture.asset(
              AssetConstants.icMyProjects,
              color: _getItemColor(2),
              height: 30,
            ),
            title: 'My_projects'.tr,
          ),
          TabItem(
            icon: SvgPicture.asset(
              AssetConstants.icDistrict,
              color: _getItemColor(3),
              height: 30,
            ),
            title: 'District_wise'.tr,
          ),
          TabItem(
            icon: SvgPicture.asset(AssetConstants.icReports,
                color: _getItemColor(4), height: 30),
            // title: 'Pd\'s Directory',
            title: 'Reports'.tr,
          ),
        ],
        // onTap: (int i) => print('click index=$i'),
      ),
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 0;

  @override
  double get iconSize => 30;

  @override
  TextStyle textStyle(Color? color, String? fontFamily) {
    return TextStyle(fontSize: 12, color: color);
  }
}
