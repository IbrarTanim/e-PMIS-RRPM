import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pmis_flutter/data/db/models/asset_collection.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/my_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/auth/sign_in_screen.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/agency_wise/agency_wise_screen.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/my_project/my_project_controller.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/my_project/my_project_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/projects/projects_controller.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/projects/projects_screen.dart';
import 'package:pmis_flutter/ui/features/project/project_details_bottom_bar.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pcr/pcr_screen.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pending_task/pending_task_screen.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/reports/reports_screen.dart';
import 'package:pmis_flutter/ui/features/landing/landing_controller.dart';
import 'package:pmis_flutter/ui/features/landing/stacked_card_widget.dart';
import 'package:pmis_flutter/ui/features/project/images/image_gallery_controller.dart';
import 'package:pmis_flutter/ui/features/project/locations/project_locations_screen.dart';
import 'package:pmis_flutter/ui/features/project/images/add_image/add_image_screen.dart';
import 'package:pmis_flutter/ui/features/project/images/survey_gallery_controller.dart';
import 'package:pmis_flutter/ui/features/root/root_controller.dart';
import 'package:pmis_flutter/ui/legacy/1old/project_allocation_details_screen.dart';
import 'package:pmis_flutter/ui/legacy/1old/project_estimated_cost_details_screen.dart';
import 'package:pmis_flutter/ui/features/project/project_details_controller.dart';
import 'package:pmis_flutter/ui/features/root/root_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/button_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../utils/alert_util.dart';
import '../../../../utils/date_util.dart';

class LandinScreen extends StatefulWidget {
  const LandinScreen({Key? key}) : super(key: key);

  @override
  _LandinScreenState createState() => _LandinScreenState();
}

class _LandinScreenState extends State<LandinScreen> {
  final _controllerLandingProjectCount = Get.put(LandingProjectCountController());
  /*final _projectsController = Get.put(ProjectsController());
  final _rootController = Get.put(RootController());*/

  final ProjectsController _projectsController = Get.put(ProjectsController());
  final RootController _rootController = Get.put(RootController());


  bool isLoading = true;

  void initCalls() async {
    await _controllerLandingProjectCount.getLandingProjectCount();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
       //_projectsController.getProjectsList(GetStorage().read(PreferenceKey.currentUserId));

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    initCalls();

    super.initState();
    final userId = GetStorage().read(PreferenceKey.currentUserId);
    if (!_projectsController.isDataLoaded) {
      _projectsController.getProjectsList(userId);
    }

    super.initState();
  }

  @override
  void dispose() {
    // _controller.clearView();
    super.dispose();
  }

  // Zabir

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.theme.colorScheme.surface,
      // Zabir
      backgroundColor: bgColor,
      //appBar: appBarWithBackAndActions(
      //appBar: onlyAppBar(title: "Landing"),
      //appBar: onlyAppBar(title: "e-PMIS"),
      appBar: appBarWithLogout(
          title: 'e-PMIS',
          iconPath: AssetConstants.icLogout,
          onPress: () {
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
          },),



      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.green))
            : SingleChildScrollView(
                child: Column(
                  children: [

                    // Total Projects Card
                    Obx(() =>  StackedCardWidget(
                      /*title: "My Assigned Projects",
                      //count: stringNullCheck(_controllerLandingProjectCount.landingProjectCount.value.currentYearAllocatedAdpRadpProjects.toString()),
                      count: stringNullCheck(_projectsController.projectsListResponse.value.length.toString()),


                      description: "Total My Assigned Projects",
                      // iconPath: AssetConstants.icMonitor,
                      onTap: () {
                        *//*_controllerLandingProjectCount.landingProjectCount.value.currentYearAllocatedAdpRadpProjects == 0 ? showToast("There has no project") :*//*
                        Get.to(() => RootScreen());
                        //_controllerLandingProjectCount.landingProjectCount.value.currentYearAllocatedAdpRadpProjects == 0 ? showToast("There has no project") : Get.to(() => RootScreen());
                        GetStorage().write(
                            PreferenceKey.TagComeFrom, TotalMyAssignedProjects);
                        GetStorage().write('fromLanding', true);*/

                      title: "My Assigned Projects",
                      count: stringNullCheck(_projectsController.projectsListResponse.length.toString()),
                      description: "Total My Assigned Projects",
                      onTap: () {
                        GetStorage().write(PreferenceKey.TagComeFrom, TotalMyAssignedProjects);
                        GetStorage().write('fromLanding', true);
                        Get.to(() => const RootScreen());

                      },
                    )),

                    // Total Projects Card
                    StackedCardWidget(
                      title: "Projects",
                      count: stringNullCheck(_controllerLandingProjectCount
                          .landingProjectCount
                          .value
                          .currentYearAllocatedAdpRadpProjects
                          .toString()),
                      description: "Total Ongoing Projects",
                      // iconPath: AssetConstants.icMonitor,
                      onTap: () {
                        _controllerLandingProjectCount.landingProjectCount.value.currentYearAllocatedAdpRadpProjects == 0 ? showToast("There has no project") : Get.to(() => RootScreen());
                        GetStorage().write(PreferenceKey.TagComeFrom, TotalOngoingProjects);
                        GetStorage().write('fromLanding', true);
                      },
                    ),

                    // Development Projects Card
                    StackedCardWidget(
                      title: "Development Projects",
                      count: stringNullCheck(_controllerLandingProjectCount
                          .landingProjectCount
                          .value
                          .currentYearAllocatedInvestmentProjectsExcludingOwnFund
                          .toString()),
                      description: "Total Ongoing Development Projects",
                      // iconPath: AssetConstants.icMonitor,
                      onTap: () {
                        _controllerLandingProjectCount.landingProjectCount.value.currentYearAllocatedInvestmentProjectsExcludingOwnFund == 0 ? showToast("There has no project") : Get.to(() => RootScreen());
                        GetStorage().write(PreferenceKey.TagComeFrom, TotalOngoingDevelopmentProjects);
                        GetStorage().write('fromLanding', true);
                      },
                    ),

                    // Technical Assistance Projects Card
                    StackedCardWidget(
                      title: "Technical Assistance Projects",
                      count: stringNullCheck(_controllerLandingProjectCount
                          .landingProjectCount
                          .value
                          .currentYearAllocatedTechnicalAssistantProjectsExcludingOwnFund
                          .toString()),
                      description: "Total Ongoing TA Projects",
                      // iconPath: AssetConstants.icMonitor,
                      onTap: () {
                        _controllerLandingProjectCount.landingProjectCount.value.currentYearAllocatedTechnicalAssistantProjectsExcludingOwnFund == 0 ? showToast("There has no project") : Get.to(() => RootScreen());
                        //Get.to(() => RootScreen());
                        GetStorage().write(
                            PreferenceKey.TagComeFrom, TotalOngoingTAProjects);
                        GetStorage().write('fromLanding', true);
                      },
                    ),

                    // Own Fund Projects Card
                    StackedCardWidget(
                      title: "Own Fund Projects",
                      count: stringNullCheck(_controllerLandingProjectCount
                          .landingProjectCount.value.totalOwnFundedProjects
                          .toString()),
                      description: "Total Own Fund Projects",
                      // iconPath: AssetConstants.icMonitor,
                      onTap: () {
                        _controllerLandingProjectCount.landingProjectCount.value.totalOwnFundedProjects == 0 ? showToast("There has no project") : Get.to(() => RootScreen());
                        //Get.to(() => RootScreen());
                        GetStorage().write(
                            PreferenceKey.TagComeFrom, TotalOwnFundProjects);
                        GetStorage().write('fromLanding', true);
                      },
                    ),

                    // Feasibility Study Projects Card
                    StackedCardWidget(
                      title: "Feasibility Study Projects",
                      count: stringNullCheck(_controllerLandingProjectCount
                          .landingProjectCount.value.feasibilityStudyProjects
                          .toString()),
                      description: "Total Feasibility Study Projects",
                      // iconPath: AssetConstants.icMonitor,
                      onTap: () {
                        _controllerLandingProjectCount.landingProjectCount.value.feasibilityStudyProjects == 0 ? showToast("There has no project") : Get.to(() => RootScreen());
                        //Get.to(() => RootScreen());
                    GetStorage().write(PreferenceKey.TagComeFrom, 
                        TotalFeasibilityStudyProjects);
                        GetStorage().write('fromLanding', true);
                      },
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
