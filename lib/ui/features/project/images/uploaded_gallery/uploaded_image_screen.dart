import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pmis_flutter/data/db/models/asset_collection.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/project/images/uploaded_gallery/uploaded_image_view.dart';
import 'package:pmis_flutter/ui/features/project/images/image_gallery_controller.dart';
import 'package:pmis_flutter/ui/features/project/images/survey_gallery_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class UploadedImageScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;

  const UploadedImageScreen({Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  _UploadedImageScreenState createState() => _UploadedImageScreenState();
}

class _UploadedImageScreenState extends State<UploadedImageScreen> {
  final _controller = Get.put(SurveyGalleryController());
  final _imageGalleryController = Get.put(ImageGalleryController());

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      const UploadedImageScreen();
    });

    return;
  }

  static Future<void> openMap(String latitude, String longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl) != null) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }




  /*@override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _imageGalleryController.getFilesEvidenceListForImageView(widget.allProjectsResponse!.projectId.toString(), false);
    });
  }*/




  void initCalls() async {
    //await _wishListProjectDetailsController.getEntryForm8ReportData(widget.projectExpenditureCostResponse!.projectExpenditureSummaryId.toString());

    await _imageGalleryController.getFilesEvidenceListForImageView(widget.allProjectsResponse!.projectId.toString(), false);

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
  void didUpdateWidget(covariant UploadedImageScreen oldWidget) {
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
    // return Scaffold(backgroundColor: context.theme.colorScheme.surface,
    return Scaffold(
      backgroundColor: bgColor,
      /*appBar: appBarWithBackAndActions(
          title: "Uploaded Image",
          onPress: (index) {
            //do active icon job
          }),*/

      appBar: appBarWithBackAndActions(
        title: "Image Gallery",
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _uploadedImageTab(),
              /*TabBarView(
                  controller: _controller.tabController,
                  children: [_imageTab(), _uploadedImageTab()]),*/
            ),
          ],
        ),
      ),
    );
  }

  Widget _uploadedImageTab() {
    return Column(
      children: [_imageGalleryItemList(context)],
    );
  }

  Widget _imageGalleryItemList(BuildContext context) {
    return Obx(() {
      String message = "empty_gallery_message".tr;
      return _imageGalleryController.filesEvidenceResponseList.isEmpty
          ? handleEmptyViewWithLoading(_imageGalleryController.isDataLoaded,
              message: message)
          : Expanded(
              child: SizedBox(
                // height: Get.height-(kToolbarHeight+78),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount:
                      _imageGalleryController.filesEvidenceResponseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (_imageGalleryController.hasMoreData &&
                        index ==
                            (_imageGalleryController
                                    .filesEvidenceResponseList.length -
                                1)) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        _imageGalleryController
                            .getFilesEvidenceListForImageView(
                                widget.allProjectsResponse!.projectId
                                    .toString(),
                                true);
                      });
                    }

                    // return filesEvidenceListItemViewForImageView(
                    // Zabir
                    return UploadedImageView(
                        context,
                        _imageGalleryController
                            .filesEvidenceResponseList[index]);
                  },
                ),
              ),
            );
    });
  }
}
