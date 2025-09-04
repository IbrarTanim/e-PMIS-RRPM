import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/ui/features/project/inspection/inspection_list_item.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import '../../../../data/models/all_projects_list_response.dart';
import 'inspection_report_controller.dart';

class InspectionReportScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;

  const InspectionReportScreen({Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  _InspectionReportScreenState createState() => _InspectionReportScreenState();
}

class _InspectionReportScreenState extends State<InspectionReportScreen> {
  final _controller = Get.put(InspectionReportController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getProjectInspectionList(
          widget.allProjectsResponse!.projectId.toString(), false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: context.theme.colorScheme.surface,
      backgroundColor: bgColor,
      appBar: appBarWithBackAndActions(title: "InspectionDetail".tr),
      body: SafeArea(
        child: Column(
          children: [
            _projectInspectionItemList(context),
          ],
        ),
      ),
    );
  }

  Widget _projectInspectionItemList(BuildContext context) {
    return Obx(() {
      String message = "empty_inspection_message".tr;
      return _controller.projectInspectionResponseList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isDataLoaded,
              message: message)
          : Expanded(
              child: SizedBox(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: _controller.projectInspectionResponseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (_controller.hasMoreData &&
                        index ==
                            (_controller.projectInspectionResponseList.length -
                                1)) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        _controller.getProjectInspectionList(
                            widget.allProjectsResponse!.projectId.toString(),
                            true);
                      });
                    }
                    // return projectInspectionListItemView(context, _controller.projectInspectionResponseList[index]);
                    return InspectionListItemView(
                      data: _controller.projectInspectionResponseList[index],
                    );
                  },
                ),
              ),
            );
    });
  }
}
