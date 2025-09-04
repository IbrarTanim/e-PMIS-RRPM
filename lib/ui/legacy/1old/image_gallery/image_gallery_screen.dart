import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/legacy/1old/image_gallery/photo.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import '../../../../data/models/all_projects_list_response.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/dimens.dart';
import '../../../features/project/images/image_gallery_controller.dart';

class ImageGalleryScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;

  const ImageGalleryScreen({Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  _ImageGalleryScreenState createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  final _controller = Get.put(ImageGalleryController());
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getFilesEvidenceListForImageView(
          widget.allProjectsResponse!.projectId.toString(), false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      appBar: appBarWithBackAndActions(title: "VisualEvidence".tr),
      body: SafeArea(
        child: Column(
          children: [
            _imageGalleryItemList(context),
          ],
        ),
      ),
    );
  }

  Widget _imageGalleryItemList(BuildContext context) {
    return Obx(() {
      String message = "empty_gallery_message".tr;
      return _controller.filesEvidenceResponseList.isEmpty
          ? handleEmptyViewWithLoading(_controller.isDataLoaded,
              message: message)
          : Expanded(
              child: SizedBox(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: _controller.filesEvidenceResponseList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (_controller.hasMoreData &&
                        index ==
                            (_controller.filesEvidenceResponseList.length -
                                1)) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        _controller.getFilesEvidenceListForImageView(
                            widget.allProjectsResponse!.projectId.toString(),
                            true);
                      });
                    }
                    /*               ///  For file path

                    _imagePath =  _controller.getImagePath(_controller.filesEvidenceResponseList[index].fileId.toString());
                    return filesEvidenceListItemViewForImageView(context, _controller.filesEvidenceResponseList[index],imagePath: _imagePath); */
                    return filesEvidenceListItemViewForImageView(
                        context, _controller.filesEvidenceResponseList[index]);
                    /* GestureDetector(
                        onTap: () {
                          showModalSheetFullScreenForGallery(context,
                              item: _controller.photoItems[index]);
                        },
                        child: Container(
                          decoration:
                              boxDecorationRoundShadowLight(borderRadius: 10),
                          padding: const EdgeInsets.all(dp8),
                          margin: const EdgeInsets.symmetric(
                              horizontal: dp16, vertical: dp16),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: boxDecorationRoundShadow(
                                              color: Colors.transparent),
                                          padding: const EdgeInsets.all(dp0),
                                          child: GestureDetector(
                                              onTap: () {
                                                showModalSheetFullScreenForGallery(
                                                    context,
                                                    item: _controller
                                                        .photoItems[index]);
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(7.0),
                                                child: showCachedNetworkImage(
                                                    // _controller.photoItems[index].image.toString()
                                                    _controller.filesEvidenceResponseList.value.toString()
                                                ),
                                              )),
                                        ),
                                      ),
                                      const HSpacer15(),
                                      Expanded(
                                        flex: 5,
                                        child: Column(
                                          children: [
                                            twoSidedTextWithColon2(
                                                leftText: "CapturedBy".tr,
                                                // rightText: stringNullCheck(image.imageName.toString())),
                                                rightText: " "),
                                            const Divider(height: 6),
                                            twoSidedTextWithColon2(
                                                leftText:
                                                    "ImageShootingDateAndTime"
                                                        .tr,
                                                // rightText: "${stringNullCheck(image.imageShootingDate.toString())}, ${stringNullCheck(image.imageShootingTime.toString())}"),
                                                rightText: " "),
                                            const Divider(height: 6),
                                            twoSidedTextWithColon2(
                                                leftText: "Latitude".tr,
                                                rightText: " "),
                                            const Divider(height: 6),
                                            twoSidedTextWithColon2(
                                                leftText: "Longitude".tr,
                                                rightText: " "),
                                            const Divider(height: 6),
                                            twoSidedTextWithColon2(
                                                leftText: "Location".tr,
                                                rightText: " "),
                                            const Divider(height: 6),
                                            twoSidedTextWithColon2(
                                                leftText: "Caption".tr,
                                                maxLine: 1,
                                                rightText: " "),
                                            const Divider(height: 6),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));*/
                  },
                ),
              ),
            );
    });
  }

  void showModalSheetFullScreenForGallery(BuildContext context,
      {PhotoItem? item}) {
    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        backgroundColor: Colors.black.withOpacity(0.7),
        context: context,
        builder: (context) {
          return Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Stack(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Hero(
                    tag: 'imageHero',
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(dp7)),
                      child: PhotoView(
                        backgroundDecoration:
                            const BoxDecoration(color: Colors.transparent),
                        imageProvider: CachedNetworkImageProvider(
                          stringNullCheck(item!.image),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 100,
                    right: 30,
                    child: InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          width: dp50,
                          height: dp50,
                          child: SvgPicture.asset(
                            AssetConstants.icCross,
                            width: dp20,
                            height: dp20,
                            color: Colors.white,
                          ),
                        )))
              ]));
        });
  }
}
