import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/auth/sign_in_screen.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/notification/notification_screen.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pcr/pcr_screen.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pending_task/pending_task_screen.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/bottom_nav.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/drawer_menu.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/projects/projects_controller.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/projects/projects_screen.dart';
import 'package:pmis_flutter/utils/alert_util.dart';
import 'package:pmis_flutter/utils/button_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import '../bottom_nav/agency_wise/agency_wise_screen.dart';
import '../bottom_nav/my_project/my_project_screen.dart';
import '../bottom_nav/reports/reports_screen.dart';
import 'root_controller.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final _controller = Get.put(RootController());
  final _projectsController = Get.put(ProjectsController());


  void initCalls() async {
    //await _projectsController.getProjectsList(_controller.userInfo.value.id.toString());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      _controller.getUserInfo();
       //_projectsController.getProjectsList(_controller.userInfo.value.id.toString());
       //_projectsController.getProjectsList(GetStorage().read(PreferenceKey.currentUserId)); // rokan June

      setState(() {
        //isLoading = false;
      });
    });
  }


  @override
  void initState() {

    initCalls();

   /* super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getUserInfo();

    });*/
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
        backgroundColor: white, // sets status bar color
        body: SafeArea(
          child: _getBody(),
        ),
        drawer: _getDrawer(context),
        bottomNavigationBar: getBottomNavigationBar());
  }

  void _onItemTapped(int index) {
    setState(() {
      DefaultValue.selectedBottomIndex = index;
    });
  }

  /*Widget _getBody() {
    switch (DefaultValue.selectedBottomIndex) {
      case 0:
        return const PCRScreen();
      case 1:
        return const AgencyWiseScreen();
      case 2:
        return const ProjectsScreen();
        //return const MyProjectScreen();
      case 3:
        return const PendingTaskScreen();
      case 4:
        return const ReportsScreen();
      default:
        return Container();
    }
  }*/


  Widget _getBody() {
    switch (DefaultValue.selectedBottomIndex) {
      case 0:
        return const PendingTaskScreen();
      case 1:
        return GetStorage().read(PreferenceKey.TagComeFrom) == TotalMyAssignedProjects.toString() ? ProjectsScreen() : MyProjectScreen();
        //return const MyProjectScreen();
        //return const ProjectsScreen();
      case 2:
        return const NotificationScreen();
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
            alertForLogOutLanding(
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



  // Zabir
  Widget getBottomNavigationBar() {
    return RootBottomNav(
      currentIndex: DefaultValue.selectedBottomIndex,
      onTap: _onItemTapped,
      icons: const [
        Icons.pending_actions,
        Icons.folder_special,
        Icons.notifications,
      ],
      labels: const [
        'PendingTask',
        'Projects',
        'Notification',
      ],
    );
  }
}
