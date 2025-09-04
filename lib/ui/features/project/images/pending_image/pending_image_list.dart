import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pmis_flutter/data/db/models/asset_collection.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'package:pmis_flutter/data/local/constants.dart';

class PendingImageList extends StatelessWidget {
  final Box<AssetCollection> box;
  final String projectId;
  final Function(String, String) onMapOpen;
  final Function({
    String? projectId,
    File? imageFile,
    String? latitude,
    String? longitude,
  }) onUpload;
  final Function(int) onDelete;
  final Function(String) onImageTap;

  const PendingImageList({
    Key? key,
    required this.box,
    required this.projectId,
    required this.onMapOpen,
    required this.onUpload,
    required this.onDelete,
    required this.onImageTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: box.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (ctx, index) {
        final image = box.getAt(index);
        if (image == null) return const SizedBox.shrink();

        return Container(
          margin: const EdgeInsets.only(bottom: 8),
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () => onImageTap(image.imageUrl.toString()),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    child: Image.file(
                      File(stringNullCheck(image.imageUrl.toString())),
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              
              // Details Section
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*_DetailItem(
                        label: "CapturedBy".tr,
                        value: stringNullCheck(image.imageName.toString()),
                      ),*/
                      _IconAndValue(icon: Icons.person, color: Colors.blueAccent, value: stringNullCheck(image.imageName.toString()),),
                      const Divider(height: 12),
                      _IconAndValue(icon: Icons.calendar_month, color: Colors.orangeAccent, value: "${stringNullCheck(image.imageShootingDate.toString())}, ${stringNullCheck(image.imageShootingTime.toString())}",),
                      const Divider(height: 12),
                      _IconAndValue(icon: Icons.closed_caption, color: Colors.deepPurpleAccent, value: stringNullCheck(image.imageCaption.toString()), maxLines: 1,),
                      const Divider(height: 12),

                      //showToast('Please write a remarks text.');

                      // Action Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _ActionButton(
                            icon: AssetConstants.icMap,
                            color: const Color(0xFF4CAF50),
                            label: "Map".tr,
                            onTap: () => onMapOpen(
                              stringNullCheck(image.imageLatValue.toString()),
                              stringNullCheck(image.imageLongValue.toString()),
                            ),
                          ),
                          _ActionButton(
                            icon: AssetConstants.icImageUpload,
                            color: const Color(0xFF2196F3),
                            label: "Upload".tr,
                            onTap: () async {
                              if (image.isImageSynchronized == null || 
                                  image.isImageSynchronized == false) {
                                await onUpload(
                                  projectId: projectId,
                                  imageFile: File(image.imageUrl.toString()),
                                  latitude: image.imageLatValue.toString(),
                                  longitude: image.imageLongValue.toString(),
                                );
                                onDelete(index);
                              }
                            },
                          ),
                          _ActionButton(
                            icon: AssetConstants.icDelete,
                            color: const Color(0xFFE53935),
                            label: "Delete".tr,
                            onTap: () => onDelete(index),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
              fontSize: 13,
              color: Color(0xFF9098B1),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF2D3142),
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

class _IconAndValue extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final int? maxLines;

  const _IconAndValue({
    required this.icon,
    required this.color,
    required this.value,
    this.maxLines,
  });

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Icon(icon, color: color, size: 20),
        ),
        Expanded(
          flex: 4,
          child: GestureDetector(
            onTap: () => _showToast(value),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF2D3142),
              ),
              maxLines: maxLines,
              overflow: maxLines != null ? TextOverflow.ellipsis : null,
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}




class _ActionButton extends StatelessWidget {
  final String icon;
  final Color color;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: showImageAsset(
              imagePath: icon,
              color: color,
              height: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}