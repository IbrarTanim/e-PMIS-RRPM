import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/my_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/my_project/my_project_controller.dart';
import 'package:pmis_flutter/ui/legacy/survey_gallery_screen.dart';
import 'package:pmis_flutter/ui/features/project/my_project_details_screen.dart';
import 'package:pmis_flutter/ui/features/project/images/pending_image/pending_image_screen.dart';
import 'package:pmis_flutter/ui/features/project/images/uploaded_gallery/uploaded_image_screen.dart';
import 'package:pmis_flutter/ui/features/project/users/users_screen.dart';
import 'package:pmis_flutter/ui/features/project/images/add_image/add_image_screen.dart';
import 'project_details_by_id_controller.dart';

class ProjectDetailsBottomBar extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;

  //final ProjectsListResponse? projectsListResponse;
  final bool isMyProject = false;

  const ProjectDetailsBottomBar({Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  _ProjectDetailsBottomBarState createState() =>
      _ProjectDetailsBottomBarState();
}

class _ProjectDetailsBottomBarState extends State<ProjectDetailsBottomBar> {
  MyProjectsResponse? myProjectsResponse;
  int _lastSelectedIndex = 0;
  final _controller = Get.put(MyProjectController());

  //final _controllerSurveyGallery = Get.put(SurveyGalleryController());
  final _controllerForProjectDetailsByID =
  Get.put(ProjectDetailsByIDController());

  //final _imageGalleryController = Get.put(ImageGalleryController());
  final _controllerBottomNav =
  Get.put(PersistentTabController(initialIndex: 0));

  // Controller to manage the state of Persistent Bottom Nav Bar
  final PersistentTabController persistentTabController =
  PersistentTabController(initialIndex: 0);

  void initCalls() async {
    //await _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(stringNullCheck(widget.allProjectsResponse!.projectId));
    await _controllerForProjectDetailsByID
        .getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());
    //await _controller.getProjectProgressAndCostData(widget.allProjectsResponse!.projectId.toString());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  void initState() {
    initCalls();
    super.initState();
  }

  @override
  void dispose() {
    // _controller.clearView();
    super.dispose();
  }

  // Screens for each bottom navigation tab
  Future<void> _handleAddImageTab(int currentIndex) async {
    final lastTab = _lastSelectedIndex;
    persistentTabController.jumpToTab(lastTab);

    // Open camera directly
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      // Navigate to AddImageScreen with the captured image and callback
      Get.to(
              () => AddImageScreen(onUploadComplete: () {
            // Switch to pending images tab (index 3)
            _lastSelectedIndex = 3;
            persistentTabController.jumpToTab(_lastSelectedIndex);
          }),
          arguments: {'image': image});
    }
  }

  List<Widget> _buildScreens() {
    return [
      MyProjectDetailsScreen(allProjectsResponse: widget.allProjectsResponse),
      UploadedImageScreen(allProjectsResponse: widget.allProjectsResponse),
      Container(),
      // Empty container for Add Image tab since we handle it in onItemSelected
      PendingImageScreen(
        allProjectsResponse: widget.allProjectsResponse,
        onUploadComplete: () {
          _lastSelectedIndex = 1;
          persistentTabController.jumpToTab(_lastSelectedIndex);
        },
      ),
      UsersScreen(allProjectsResponse: widget.allProjectsResponse),
    ];
  }

  // Bottom navigation bar items
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.description),
        title: ("Details"),
        activeColorPrimary: Colors.redAccent,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.save),
        //title: ("Uploaded "),
        title: ("Gallery"),
        activeColorPrimary: Colors.redAccent,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.camera_alt, color: Colors.white),
        title: ("Capture"),
        activeColorPrimary: Colors.redAccent,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.browse_gallery),
        title: ("Pending "),
        activeColorPrimary: Colors.redAccent,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Users"),
        activeColorPrimary: Colors.redAccent,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*backgroundColor: context.theme.colorScheme.surface,
      appBar: appBarWithBackAndActions(
          title: "ProjectDetails".tr,
          onPress: (index) {
            //do active icon job
          }),*/
      body: PersistentTabView(
        context,
        controller: persistentTabController,
        screens: _buildScreens(),
        items: _navBarsItems(),
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(1),
          colorBehindNavBar: Colors.white,
        ),
        navBarStyle: NavBarStyle.style15,
        onItemSelected: (index) {
          if (index == 2) {
            // Index 2 is the Add Image tab
            _handleAddImageTab(index);
          } else {
            setState(() {
              _lastSelectedIndex = index;
            });
          }
        },
      ),
    );
  }
}
