import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pmis_flutter/data/db/models/asset_collection.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/project/images/pending_image/pending_image_list.dart';
import 'package:pmis_flutter/ui/features/project/images/image_gallery_controller.dart';
import 'package:pmis_flutter/ui/features/project/images/survey_gallery_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class PendingImageScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;
  final VoidCallback onUploadComplete;

  const PendingImageScreen(
      {Key? key, this.allProjectsResponse, required this.onUploadComplete})
      : super(key: key);

  @override
  _PendingImageScreenState createState() => _PendingImageScreenState();
}

class _PendingImageScreenState extends State<PendingImageScreen> {
  final _controller = Get.put(SurveyGalleryController());
  final _imageGalleryController = Get.put(ImageGalleryController());

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  /* Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      const PendingImageScreen();
    });

    return;
  }*/

  static Future<void> openMap(String latitude, String longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _imageGalleryController.getFilesEvidenceListForImageView(
          widget.allProjectsResponse!.projectId.toString(), false);
    });
  }

  @override
  void didUpdateWidget(covariant PendingImageScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_controller.tabSelectedIndex.value == 1) {
        _imageGalleryController.getFilesEvidenceListForImageView(
            widget.allProjectsResponse!.projectId.toString(), false);
      }
    });
  }

  Future<void> getRefreshedData() async {
    // getList();
    _imageGalleryController.getFilesEvidenceListForImageView(
        widget.allProjectsResponse!.projectId.toString(), false);
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }

  @override
  void dispose() {
    // _controller.clearView();
    // videoPlayerController!.dispose();
    super.dispose();
  }

  addSynchronized() async {
    Hive.box<AssetCollection>('image').add(
      AssetCollection(isImageSynchronized: true),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final projectId = widget.allProjectsResponse!.projectId.toString();
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      appBar: appBarWithBackAndActions(
          title: "Pending Image",
          onPress: (index) {
            //do active icon job

            //Get.to(() => const ProjectCommonDetailsScreen());
          }),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _imageTab(),
              /*TabBarView(
                  controller: _controller.tabController,
                  children: [_imageTab(), _uploadedImageTab()]),*/
            ),
          ],
        ),
      ),
    );
  }

  // Zabir
  Widget _imageTab() {
    return Scaffold(
      backgroundColor: bgColor,
      body: ValueListenableBuilder(
        valueListenable: Hive.box<AssetCollection>('image').listenable(),
        builder: (context, Box<AssetCollection> box, _) {
          return PendingImageList(
            box: box,
            projectId: widget.allProjectsResponse!.projectId.toString(),
            onMapOpen: openMap,
            onUpload: ({imageFile, latitude, longitude, projectId}) {
              _controller.uploadImageFile(
                  projectId: projectId,
                  longitude: longitude,
                  latitude: latitude,
                  imageFile: imageFile,
                  onUploadComplete: widget.onUploadComplete);
            },
            onDelete: (index) => box.deleteAt(index),
            onImageTap: (imageUrl) {
              showModalSheetFullScreenForGallery(
                context,
                item: stringNullCheck(imageUrl),
              );
            },
          );
        },
      ),
    );
  }
}
