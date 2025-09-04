import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/files_evidence_response_list.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'package:pmis_flutter/utils/map_utils.dart';

Widget UploadedImageView(
    BuildContext context, FilesEvidenceResponseList filesEvidenceResponseList,
    {String? imagePath, bool? isFavorite = true}) {
  String encodedToken = Uri.encodeComponent(fullToken);
  String? imageSrc =
      '${APIConstants.baseUrl.toString()}${APIConstants.projectImagePathEndUrl.toString()}${filesEvidenceResponseList.fileId}?t=$encodedToken';

  return GestureDetector(
    onTap: () {},
    child: Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.all(8),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Section
            GestureDetector(
              onTap: () {
                showModalSheetFullScreenForGalleryFinal(context,
                    item: filesEvidenceResponseList, imageSrc: imageSrc);
              },
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(12)),
                  color: Colors.grey[100],
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.horizontal(left: Radius.circular(12)),
                  child: showCachedNetworkImage(imageSrc.toString()),
                ),
              ),
            ),

            // Details Section
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildDetailRow(
                      "CapturedBy".tr,
                      stringNullCheck(filesEvidenceResponseList.userName
                          .toString()
                          .split(' ')[0]),
                    ),
                    const Divider(height: 12, thickness: 0.5),

                    _buildDetailRow(
                      "ImageShootingDateAndTime".tr,
                      stringNullCheck(
                          filesEvidenceResponseList.timestamp.toString()),
                    ),
                    const Divider(height: 12, thickness: 0.5),
                    // _buildDetailRow(
                    //   "Latitude".tr,
                    //   stringNullCheck(filesEvidenceResponseList.latitude.toString()),
                    // ),
                    // const Divider(height: 12, thickness: 0.5),
                    // _buildDetailRow(
                    //   "Longitude".tr,
                    //   stringNullCheck(filesEvidenceResponseList.longitude.toString()),
                    // ),
                    // const Divider(height: 12, thickness: 0.5),
                    _buildLocationRow(
                      context: context,
                      latitude: stringNullCheck(
                          filesEvidenceResponseList.latitude.toString()),
                      longitude: stringNullCheck(
                          filesEvidenceResponseList.longitude.toString()),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildDetailRow(String label, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          color: Color(0xFF2D3142),
          fontWeight: FontWeight.w500,
        ),
      ),
      const Text(
        ": ",
        style: TextStyle(
          fontSize: 13,
          color: Color(0xFF2D3142),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF4A4F67),
          ),
        ),
      ),
    ],
  );
}

Widget _buildLocationRow({
  required BuildContext context,
  required String latitude,
  required String longitude,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Location: ",
        style: TextStyle(
          fontSize: 13,
          color: Color(0xFF2D3142),
          fontWeight: FontWeight.w500,
        ),
      ),
      Expanded(
        child: GestureDetector(
          onTap: () async {
            openGoogleMap(latitude, longitude);
          },
          child: Text(
            'SeeLocationOnGoogleMap'.tr,
            style: const TextStyle(
              fontSize: 13,
              color: accentBlue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    ],
  );
}
