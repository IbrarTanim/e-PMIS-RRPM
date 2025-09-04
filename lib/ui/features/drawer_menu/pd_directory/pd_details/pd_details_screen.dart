import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/project_user_list_response.dart';
import 'package:pmis_flutter/ui/features/project/basic_project_details_view.dart';
import 'package:pmis_flutter/ui/features/project/users/user_list_item_view.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import '../../../project/project_details_by_id_controller.dart';
import 'pd_details_controller.dart';

class PdDetailsScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;

  const PdDetailsScreen({Key? key, this.allProjectsResponse}) : super(key: key);

  @override
  _PdDetailsScreenState createState() => _PdDetailsScreenState();
}

class _PdDetailsScreenState extends State<PdDetailsScreen> {
  final _controller = Get.put(PdDetailsController());
  final _controllerForProjectDetailsByID =
      Get.put(ProjectDetailsByIDController());

  @override
  void initState() {
    super.initState();
    initCalls();
  }

  void initCalls() async {
    await _controller.getPdInfoTadData(
        stringNullCheck(widget.allProjectsResponse!.projectId));
    await _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(
        stringNullCheck(widget.allProjectsResponse!.projectId));
    await _controllerForProjectDetailsByID
        .getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBarWithBackAndActions(title: "PDDetails".tr),
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _controller.tabController,
              onTap: (selected) {
                _controller.tabSelectedIndex.value = selected;
              },
              labelColor: accentBlue,
              unselectedLabelColor: Colors.grey.shade600,
              indicatorColor: accentBlue,
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("ProjectInfo".tr),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("PDInfo".tr),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _controller.tabController,
                children: [
                  // Project Info Tab
                  BsicProjectDetailsView(
                    projectData: widget.allProjectsResponse!,
                    controller: _controllerForProjectDetailsByID,
                  ),
                  // PD Info Tab
                  _pdInfoTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pdInfoTab() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          return Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: _controller.pdInfoListResponse.isEmpty
                    ? showEmptyViewForPDInfo()
                    : NewUserListItemView(
                        context,
                        ProjectUserListResponse(
                          firstName: _controller
                                  .pdInfoListResponse.first.fullName
                                  ?.split(' ')
                                  .first ??
                              '',
                          lastName: _controller
                                  .pdInfoListResponse.first.fullName
                                  ?.split(' ')
                                  .last ??
                              '',
                          designationName: _controller
                              .pdInfoListResponse.first.designationName,
                          roleTitle:
                              _controller.pdInfoListResponse.first.roleTitle,
                          officeName:
                              _controller.pdInfoListResponse.first.officeName,
                          roleName:
                              _controller.pdInfoListResponse.first.roleName,
                          email: _controller.pdInfoListResponse.first.email,
                          mobile: _controller.pdInfoListResponse.first.mobile,
                        ),
                      ),
              ),
            ),
          );
        })
      ],
    );
  }
}
