import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/project_inspection_response_list.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/date_util.dart';
import '../../../../data/models/all_projects_list_response.dart';
import 'inspection_report_controller.dart';


class InspectionListItemView extends StatelessWidget {
  final ProjectInspectionResponseList data;
  final bool isFavorite;

  const InspectionListItemView({
    Key? key,
    required this.data,
    this.isFavorite = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      elevation: 2,
      margin: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: accentGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      formatDateToDDMMYYYY(data.inspectionDate.toString()),
                      style: const TextStyle(
                        color: accentGreenText,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                "InspectorName".tr,
                data.inspectorUserFullName.toString(),
              ),
              _buildDivider(),
              _buildInfoRow(
                "InspectorDesignation".tr,
                data.inspectorDesignation.toString(),
              ),
              _buildDivider(),
              _buildInfoRow(
                "InspectionLocation".tr,
                data.inspectionLocation.toString(),
              ),
              _buildDivider(),
              _buildInfoRow(
                "InspectionComments".tr,
                data.comments?.toString() ?? 'NoCommentsAdded'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: newTextColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(
            ": ",
            style: TextStyle(
              color: newTextColor,
              fontSize: 14,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              stringNullCheck(value),
              style: const TextStyle(
                color: newTextColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 0.5,
      color: Color(0xFFE0E0E0),
    );
  }
}