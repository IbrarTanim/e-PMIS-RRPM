import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/image_util.dart';

class ImageUploadForm extends StatelessWidget {
  final String imagePath;
  final String capturedBy;
  final String dateAndTime;
  final String latitude;
  final String longitude;
  final String location;
  final TextEditingController captionController;
  final VoidCallback onMapOpen;
  final VoidCallback onUpload;
  final VoidCallback onImageTap;

  const ImageUploadForm({
    Key? key,
    required this.imagePath,
    required this.capturedBy,
    required this.dateAndTime,
    required this.latitude,
    required this.longitude,
    required this.location,
    required this.captionController,
    required this.onMapOpen,
    required this.onUpload,
    required this.onImageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image Preview Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Image Preview
                  GestureDetector(
                    onTap: onImageTap,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.file(
                        File(imagePath),
                        width: double.infinity,
                        height: Get.height * 0.3,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Details Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _DetailItem(
                    label: "CapturedBy".tr,
                    value: capturedBy,
                  ),
                  const Divider(height: 16),
                  _DetailItem(
                    label: "ImageShootingDateAndTime".tr,
                    value: dateAndTime,
                  ),
                  const Divider(height: 16),
                  _DetailItem(
                    label: "Latitude".tr,
                    value: latitude,
                  ),
                  const Divider(height: 16),
                  _DetailItem(
                    label: "Longitude".tr,
                    value: longitude,
                  ),
                  const Divider(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _DetailItem(
                          label: "Location".tr,
                          value: location,
                          maxLines: 2,
                        ),
                      ),
                      IconButton(
                        onPressed: onMapOpen,
                        icon: showImageAsset(
                          imagePath: AssetConstants.icLocation,
                          color: accentGreenText,
                          height: 20,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: accentGreenText.withOpacity(0.1),
                          padding: const EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Caption Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Text(
                        "Caption",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF9098B1),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.star, color: Colors.redAccent, size: 10),
                    ],
                  ),

                  const SizedBox(height: 8),
                  TextField(
                    controller: captionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Enter Caption",
                      filled: true,
                      fillColor: const Color(0xFFF5F6F9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            
          ],
        ),
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  final String label;
  final String value;
  final int? maxLines;

  const _DetailItem({
    required this.label,
    required this.value,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: gray,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: newTextColor,
            ),
            maxLines: maxLines,
            overflow: maxLines != null ? TextOverflow.ellipsis : null,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
