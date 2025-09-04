import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pmis_flutter/data/db/models/asset_collection.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/project/images/uploaded_gallery/uploaded_image_view.dart';
import 'package:pmis_flutter/ui/features/project/images/image_gallery_controller.dart';
import 'package:pmis_flutter/ui/features/project/images/survey_gallery_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'package:pmis_flutter/utils/spacers.dart';
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

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _imageGalleryController.getFilesEvidenceListForImageView(
          widget.allProjectsResponse!.projectId.toString(), false);
    });
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

//   Widget _imageTab() {
//     // String imageFile = image.imageUrl.toString();
//     return Scaffold(

//       body: ValueListenableBuilder(
//         valueListenable: Hive.box<AssetCollection>('image').listenable(),
//         builder: (context, Box<AssetCollection> box, _) {
//           return ListView.builder(
//             itemCount: box.length,
//             itemBuilder: (ctx, index) {
//               final image = box.getAt(index);
//               // final image.isSynchronized == false;
//               return Container(
//                 decoration: boxDecorationRoundShadowLight(borderRadius: 10),
//                 padding: const EdgeInsets.all(dp8),
//                 margin: const EdgeInsets.symmetric(
//                     horizontal: dp16, vertical: dp16),
//                 child: Stack(
//                   children: [
//                     Column(
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               flex: 2,
//                               child: Container(
//                                 decoration: boxDecorationRoundShadow(
//                                     color: Colors.transparent),
//                                 padding: const EdgeInsets.all(dp0),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     showModalSheetFullScreenForGallery(context,
//                                         item: stringNullCheck(
//                                             image.imageUrl.toString()));
//                                   },
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(7.0),
//                                     child: Image.file(
//                                       File(stringNullCheck(
//                                           image!.imageUrl.toString())),
//                                       width: 100,
//                                       // height: 70,
//                                       fit: BoxFit.contain,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             const HSpacer15(),
//                             Expanded(
//                               flex: 5,
//                               child: Column(
//                                 children: [
//                                   twoSidedTextWithColon2(
//                                       leftText: "CapturedBy".tr,
//                                       rightText: stringNullCheck(
//                                           image.imageName.toString())),
//                                   const Divider(height: 6),
//                                   twoSidedTextWithColon2(
//                                       leftText: "ImageShootingDateAndTime".tr,
//                                       rightText:
//                                       "${stringNullCheck(image.imageShootingDate.toString())}, ${stringNullCheck(image.imageShootingTime.toString())}"),

//                                   //${stringNullCheck(image.imageShootingTime.toString())}
//                                   const Divider(height: 6),
//                                   /*twoSidedTextWithColon2(
//                                       leftText: "ImageShootingDate".tr,
//                                       rightText: stringNullCheck(
//                                           image.imageShootingDate.toString())),
//                                   const Divider(),
//                                   twoSidedTextWithColon2(
//                                       leftText: "ImageShootingTime".tr,
//                                       rightText: stringNullCheck(
//                                           image.imageShootingTime.toString())),
//                                   const Divider(),*/
//                                   twoSidedTextWithColon2(
//                                       leftText: "Latitude".tr,
//                                       rightText: stringNullCheck(
//                                           image.imageLatValue.toString())),
//                                   const Divider(height: 6),
//                                   twoSidedTextWithColon2(
//                                       leftText: "Longitude".tr,
//                                       rightText: stringNullCheck(
//                                           image.imageLongValue.toString())),
//                                   const Divider(height: 6),
//                                   twoSidedTextWithColon2(
//                                       leftText: "Location".tr,
//                                       rightText: stringNullCheck(
//                                           image.imagePickUpLocation.toString()),
//                                       maxLineForRightText: 1),
//                                   const Divider(height: 6),
//                                   twoSidedTextWithColon2(
//                                       leftText: "Caption".tr,
//                                       maxLineForRightText: 1,
//                                       rightText: stringNullCheck(
//                                           image.imageCaption.toString())),
//                                   const Divider(height: 6),
//                                   Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                     children: [
//                                       showImageAsset(
//                                           imagePath: AssetConstants.icMap,
//                                           color: Colors.green,
//                                           height: 25,
//                                           onPressCallback: () {
//                                             openMap(
//                                                 stringNullCheck(image
//                                                     .imageLatValue
//                                                     .toString()),
//                                                 stringNullCheck(image
//                                                     .imageLongValue
//                                                     .toString()));
//                                           }),
//                                       showImageAsset(
//                                           imagePath:
//                                           AssetConstants.icImageUpload,
//                                           color: Colors.blue,
//                                           height: 25,
//                                           onPressCallback: () async {
//                                             image.isImageSynchronized == null ||
//                                                 image.isImageSynchronized ==
//                                                     false
//                                                 ? _controller.uploadImageFile(
//                                                 projectId: widget
//                                                     .allProjectsResponse!
//                                                     .projectId
//                                                     .toString(),
//                                                 imageFile: File(image
//                                                     .imageUrl
//                                                     .toString()),
//                                                 latitude: image
//                                                     .imageLatValue
//                                                     .toString(),
//                                                 longitude: image
//                                                     .imageLongValue
//                                                     .toString())
//                                             // addSynchronized;
//                                             // _isSynchronized = true;
//                                                 : IconButton(
//                                                 onPressed: () {},
//                                                 icon: const Icon(
//                                                     Icons.check_box));
//                                             await box.deleteAt(index);
//                                           }),
//                                       showImageAsset(
//                                           imagePath: AssetConstants.icDelete,
//                                           color: Colors.redAccent,
//                                           height: 25,
//                                           onPressCallback: () {
//                                             box.deleteAt(index);
//                                           }),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
// /*                        const Divider(),
//                         twoSidedTextWithIcon(
//                             leftText: "Map".tr,
//                             rightText: 'SeeLocationOnGoogleMap'.tr,
//                             rightIcon: AssetConstants.icLocation,
//                             iconAction: () {
//                               openMap(
//                                   stringNullCheck(
//                                       image.imageLatValue.toString()),
//                                   stringNullCheck(
//                                       image.imageLongValue.toString()));
//                             }),
//                         const Divider(),
//                         twoSidedTextWithIcon(
//                             leftText: "Upload".tr,
//                             rightText: 'Upload Image',
//                             rightIcon: AssetConstants.icImageUpload,
// */ /*                            iconAction: () async {
//                               _controller.successUploadMessage == "Error" ?
//                               showToast(
//                                   "Please Check your Internet", isError: true)
//                                   :
//                               _controller.uploadImageFile(
//                                   projectId: widget
//                                       .allProjectsResponse!.projectId
//                                       .toString(),
//                                   imageFile: File(image.imageUrl.toString()));
//                               box.deleteAt(index);
//                             }),*/ /*
//                             iconAction: () async {
//                               image.isImageSynchronized == null ||
//                                       image.isImageSynchronized == false
//                                   ? _controller.uploadImageFile(
//                                       projectId: widget
//                                           .allProjectsResponse!.projectId
//                                           .toString(),
//                                       imageFile:
//                                           File(image.imageUrl.toString()))
//                                   // addSynchronized;
//                                   // _isSynchronized = true;
//                                   : IconButton(
//                                       onPressed: () {},
//                                       icon: const Icon(Icons.check_box),
//                                     );
//                             }),
//                         const Divider(),*/
//                         // const Divider(),
//                       ],
//                     ),
//                     // Positioned(
//                     //   top: -12,
//                     //   right: -12,
//                     //   child: IconButton(
//                     //     onPressed: () {
//                     //       box.deleteAt(index);
//                     //     },
//                     //     icon: const Icon(Icons.delete, color: Colors.redAccent),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               );
// /*                Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Card(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child:

//                     ListTile(
//                       onTap: () {
//                         // Navigator.of(context).push(MaterialPageRoute(
//                         //     builder: (ctx) => ViewNoteScreen(
//                         //         title: note.title,
//                         //         description: note.description,
//                         //         imageUrl: note.imageUrl)));
//                       },
//                       leading: Image.file(
//                         File(
//                           image!.imageUrl.toString(),
//                         ),
//                       ),
//                       // title: Text(image.projectId.toString()),
//                       title: Text(widget.allProjectsResponse!.projectId.toString()),
//                       trailing: IconButton(
//                         onPressed: () {
//                           box.deleteAt(index);
//                         },
//                         icon: const Icon(Icons.delete),
//                       ),
//                     ),
//                   ),
//                 ),
//               );*/

//               //   imageTileItem(
//               //   imageFile: image.imageUrl,
//               //   taskCompleted: db.imageUploadList[index][1],
//               //   onChanged: (value) => checkBoxChanged(value, index),
//               //   deleteFunction: (context) => deleteTask(index),
//               // );
//             },
//           );
//         },
//       ),
//     );
//   }

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
