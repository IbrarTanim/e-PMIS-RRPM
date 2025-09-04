import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/ui/features/project/locations/porject_location_list_item.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import '../../../../data/models/all_projects_list_response.dart';
import 'project_locations_controller.dart';

class ProjectLocationsScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;

  const ProjectLocationsScreen({Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  _ProjectLocationsScreenState createState() => _ProjectLocationsScreenState();
}

class _ProjectLocationsScreenState extends State<ProjectLocationsScreen> {
  final _controller = Get.put(ProjectLocationsController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getProjectLocationsList(
          widget.allProjectsResponse!.projectId.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.theme.colorScheme.surface,
      backgroundColor: bgColor,
      appBar: appBarWithBackAndActions(title: "ProjectLocations".tr),
      body: SafeArea(
        child: Column(
          children: [
            _projectLocationsItemList(context),
          ],
        ),
      ),
    );
  }

  Widget _projectLocationsItemList(BuildContext context) {
    return Obx(() {
      String message = "empty_locations_message".tr;
      return _controller.projectLocationResponseList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isDataLoaded,
              message: message)
          : Expanded(
              child: SizedBox(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: _controller.projectLocationResponseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    // return projectLocationsItemView(context, _controller.projectLocationResponseList[index]);
                    // Zabir
                    return NewProjectLocationsItemView(context,
                        _controller.projectLocationResponseList[index]);
                  },
                ),
              ),
            );
    });
  }
}
