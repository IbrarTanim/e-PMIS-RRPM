import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/project/allocation/allocation_details_screen.dart';
import 'package:pmis_flutter/ui/features/project/common/project_header_card.dart';
import 'package:pmis_flutter/ui/features/project/estimate/estimated_cost_details_screen.dart';
import 'package:pmis_flutter/ui/features/project/inspection/inspection_report_screen.dart';
import 'package:pmis_flutter/ui/features/project/project_details_by_id_controller.dart';
import 'package:pmis_flutter/ui/features/project/locations/project_locations_screen.dart';
import 'package:pmis_flutter/ui/features/project/images/uploaded_gallery/uploaded_image_screen.dart';
import 'package:pmis_flutter/utils/alert_util.dart';
import 'package:pmis_flutter/utils/colors.dart';

class BsicProjectDetailsView extends StatelessWidget {
  final AllProjectsResponse projectData;
  final ProjectDetailsByIDController controller;

  const BsicProjectDetailsView({
    Key? key,
    required this.projectData,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProjectHeaderCard(projectData: projectData),
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                // Quick Actions Card
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                         /* _buildActionButton(
                            icon: Icons.assignment_outlined,
                            label: "Inspection",
                            onTap: () => Get.to(() => InspectionReportScreen(
                                allProjectsResponse: projectData)),
                          ),*/

                          _buildActionButton(
                            icon: Icons.assignment_outlined,
                            label: "Project Cost",
                            onTap: () => Get.to(() => NewProjectEstimatedCostDetailsScreen()),
                          ),


                         /* _buildActionButton(
                            icon: Icons.photo_library_outlined,
                            label: "Gallery",
                            onTap: () => Get.to(() => UploadedImageScreen(
                                allProjectsResponse: projectData)),
                          ),*/


                          _buildActionButton(
                            icon: Icons.work_outline,
                            label: "Allocation",
                            onTap: () => Get.to(() => NewProjectAllocationDetailsScreen()),),


                          if (projectData.projectTypeId.toString() ==
                              "ProjectType_DPP")
                            _buildActionButton(
                              icon: Icons.location_on_outlined,
                              label: "Locations",
                              onTap: () => Get.to(() => ProjectLocationsScreen(
                                  allProjectsResponse: projectData)),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Project Details Card
                _buildCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("Project Information"),
                      _buildDetailItem(
                        icon: Icons.business_outlined,
                        label: "MinistryName".tr,
                        value: controller.projectDetailsById.value.ministryName,
                      ),
                      _buildDetailItem(
                        icon: Icons.account_balance_outlined,
                        label: "DivisionName".tr,
                        value: controller.projectDetailsById.value.divisionName,
                      ),
                      _buildDetailItem(
                        icon: Icons.apartment_outlined,
                        label: "AgencyName".tr,
                        value: controller.projectDetailsById.value.agencyName,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // PCR Status Card
                Obx(() {
                  if (controller.projectDetailsById.value.pcrStatus
                          .toString() ==
                      "Received") {
                    return _buildPCRStatusCard(context);
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: accentBlue, size: 24),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: newTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: newTextColor,
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    String? value,
  }) {
    if (value == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: accentBlue.withOpacity(0.7)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: newTextColor.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: newTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPCRStatusCard(BuildContext context) {
    return _buildCard(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: accentGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_circle_outline, color: accentGreen),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "PCR Status: Received".tr,
                    style: const TextStyle(
                      color: newTextColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () => alertDialogViewForPCREvidence(
                      context: context,
                      title: 'PCREvidence'.tr,
                      fileId: controller
                          .pcrAttachmentViewListResponse.first.fileId
                          .toString(),
                      receivedDate: controller
                          .pcrAttachmentViewListResponse.first.receivedDate
                          .toString(),
                      remarks: controller
                          .pcrAttachmentViewListResponse.first.remarks
                          .toString(),
                    ),
                    child: Text(
                      "View Evidence".tr,
                      style: TextStyle(
                        color: accentBlue,
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                        decorationColor: accentBlue.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
