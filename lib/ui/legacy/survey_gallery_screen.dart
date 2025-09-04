import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pmis_flutter/data/db/models/asset_collection.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:url_launcher/url_launcher.dart';
import '../features/project/images/image_gallery_controller.dart';
import '../features/project/images/add_image/add_image_screen.dart';
import '../features/project/images/survey_gallery_controller.dart';

class SurveyGalleryScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;

  const SurveyGalleryScreen({Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  _SurveyGalleryScreenState createState() => _SurveyGalleryScreenState();
}

class _SurveyGalleryScreenState extends State<SurveyGalleryScreen> {
  final _controller = Get.put(SurveyGalleryController());
  final _imageGalleryController = Get.put(ImageGalleryController());

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<void> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      const SurveyGalleryScreen();
    });

    return;
  }

  // VideoPlayerController? videoPlayerController;

  // bool _isSynchronized = false;
  //
  // void changeWidget() {
  //   setState(() {
  //     _isSynchronized = !_isSynchronized;
  //   });
  // }
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

    //
    // setState((){
    //    final message = _controller.successUploadMessage;
    // });

    // if this is the 1st time ever open the app, then create default data
    // if (_myBox.get("TODOLIST") == null) {
    //   db.createInitialData();
    // } else {
    //   // there already exists data
    //   db.loadData();
    // }

    // for video play
/*    if (_controller.projectVideo.value.path.isNotEmpty) {
      videoPlayerController =
          VideoPlayerController.file(_controller.projectVideo.value)
            ..initialize().then((_) {
              // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
              setState(() {});
            });
    }*/
    // videoPlayerController = VideoPlayerController.file(_controller.projectVideo.value)
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
  }

  @override
  void didUpdateWidget(covariant SurveyGalleryScreen oldWidget) {
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

/*
  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.imageUploadList[index][1] = !db.imageUploadList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    setState(() {
      // db.toDoList.add([_controllerForText.text, false]);
      // _controllerForText.clear();
      db.imageUploadList.add([_controller.projectImage.value, false]);
      // db.imageUploadList.add([_controller.projectImage.value.readAsBytesSync(), false]);
      // _controller.projectImage.value = File("");
      // _controller.projectImage.value = _controller.projectImage.value;
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create a new task
  void createNewTask() {
    alertDialogForImageUpload(
        saveAction: saveNewTask,
        cancelAction: () {
          Get.back();
        });
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return DialogBox(
    //       controller: _controllerForText,
    //       onSave: saveNewTask,
    //       onCancel: () => Navigator.of(context).pop(),
    //     );
    //   },
    // );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.imageUploadList.removeAt(index);
    });
    db.updateDataBase();
  }*/

  // void createNewTask() {
  //   alertDialogForImageUpload(
  //       // saveAction: saveNewTask,
  //       saveAction: submitData,
  //       cancelAction: () {
  //         Get.back();
  //       });
  // }
  //
  // submitData() async {
  //   // final isValid = _formKey.currentState!.validate();
  //
  //   if (widget.allProjectsResponse!.projectId != null) {
  //     Hive.box<ImageCollection>('image').add(ImageCollection(
  //         projectId: widget.allProjectsResponse!.projectId.toString(),
  //         imageUrl: _image!.path));
  //     Get.back();
  //   }
  // }
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
      appBar: appBarWithBack(title: "survey_gallery".tr),
      body: SafeArea(
        child: Column(
          children: [
            getTabView(
              titles: ["UploadImage".tr, "UploadedImage".tr],
              // titles: ["Image".tr, "Video".tr],
              controller: _controller.tabController,
              onTap: (selected) {
                _controller.tabSelectedIndex.value = selected;
                setState(() {
                  _imageGalleryController.getFilesEvidenceListForImageView(
                      widget.allProjectsResponse!.projectId.toString(), false);
                });
              },
            ),
            Expanded(
              child: TabBarView(
                  controller: _controller.tabController,
                  children: [_imageTab(), _uploadedImageTab()]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageTab() {
    // String imageFile = image.imageUrl.toString();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add, color: Colors.orangeAccent),
        backgroundColor: Get.theme.primaryColor,
        onPressed: () {
          Get.to(() => const AddImageScreen());
        },
        label: const Text(
          'Add Image',
          style: TextStyle(
            color: Colors.orangeAccent,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<AssetCollection>('image').listenable(),
        builder: (context, Box<AssetCollection> box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (ctx, index) {
              final image = box.getAt(index);
              // final image.isSynchronized == false;
              return Container(
                decoration: boxDecorationRoundShadowLight(borderRadius: 10),
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
                                    showModalSheetFullScreenForGallery(context,
                                        item: stringNullCheck(
                                            image.imageUrl.toString()));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(7.0),
                                    child: Image.file(
                                      File(stringNullCheck(
                                          image!.imageUrl.toString())),
                                      width: 100,
                                      // height: 70,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const HSpacer15(),
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: [
                                  twoSidedTextWithColon2(
                                      leftText: "CapturedBy".tr,
                                      rightText: stringNullCheck(
                                          image.imageName.toString())),
                                  const Divider(height: 6),
                                  twoSidedTextWithColon2(
                                      leftText: "ImageShootingDateAndTime".tr,
                                      rightText:
                                          "${stringNullCheck(image.imageShootingDate.toString())}, ${stringNullCheck(image.imageShootingTime.toString())}"),
                                  const Divider(height: 6),
                                  /*twoSidedTextWithColon2(
                                      leftText: "ImageShootingDate".tr,
                                      rightText: stringNullCheck(
                                          image.imageShootingDate.toString())),
                                  const Divider(),
                                  twoSidedTextWithColon2(
                                      leftText: "ImageShootingTime".tr,
                                      rightText: stringNullCheck(
                                          image.imageShootingTime.toString())),
                                  const Divider(),*/
                                  twoSidedTextWithColon2(
                                      leftText: "Latitude".tr,
                                      rightText: stringNullCheck(
                                          image.imageLatValue.toString())),
                                  const Divider(height: 6),
                                  twoSidedTextWithColon2(
                                      leftText: "Longitude".tr,
                                      rightText: stringNullCheck(
                                          image.imageLongValue.toString())),
                                  const Divider(height: 6),
                                  twoSidedTextWithColon2(
                                      leftText: "Location".tr,
                                      rightText: stringNullCheck(
                                          image.imagePickUpLocation.toString()),
                                      maxLineForRightText: 1),
                                  const Divider(height: 6),
                                  twoSidedTextWithColon2(
                                      leftText: "Caption".tr,
                                      maxLineForRightText: 1,
                                      rightText: stringNullCheck(
                                          image.imageCaption.toString())),
                                  const Divider(height: 6),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      showImageAsset(
                                          imagePath: AssetConstants.icMap,
                                          color: Colors.green,
                                          height: 25,
                                          onPressCallback: () {
                                            openMap(
                                                stringNullCheck(image
                                                    .imageLatValue
                                                    .toString()),
                                                stringNullCheck(image
                                                    .imageLongValue
                                                    .toString()));
                                          }),
                                      showImageAsset(
                                          imagePath:
                                              AssetConstants.icImageUpload,
                                          color: Colors.blue,
                                          height: 25,
                                          onPressCallback: () async {
                                            image.isImageSynchronized == null ||
                                                    image.isImageSynchronized ==
                                                        false
                                                ? _controller.uploadImageFile(
                                                    projectId: widget
                                                        .allProjectsResponse!
                                                        .projectId
                                                        .toString(),
                                                    imageFile: File(image
                                                        .imageUrl
                                                        .toString()),
                                                    latitude: image
                                                        .imageLatValue
                                                        .toString(),
                                                    longitude: image
                                                        .imageLongValue
                                                        .toString())
                                                // addSynchronized;
                                                // _isSynchronized = true;
                                                : IconButton(
                                                    onPressed: () {},
                                                    icon: const Icon(
                                                        Icons.check_box));
                                            await box.deleteAt(index);
                                          }),
                                      showImageAsset(
                                          imagePath: AssetConstants.icDelete,
                                          color: Colors.redAccent,
                                          height: 25,
                                          onPressCallback: () {
                                            box.deleteAt(index);
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
/*                        const Divider(),
                        twoSidedTextWithIcon(
                            leftText: "Map".tr,
                            rightText: 'SeeLocationOnGoogleMap'.tr,
                            rightIcon: AssetConstants.icLocation,
                            iconAction: () {
                              openMap(
                                  stringNullCheck(
                                      image.imageLatValue.toString()),
                                  stringNullCheck(
                                      image.imageLongValue.toString()));
                            }),
                        const Divider(),
                        twoSidedTextWithIcon(
                            leftText: "Upload".tr,
                            rightText: 'Upload Image',
                            rightIcon: AssetConstants.icImageUpload,
*/ /*                            iconAction: () async {
                              _controller.successUploadMessage == "Error" ?
                              showToast(
                                  "Please Check your Internet", isError: true)
                                  :
                              _controller.uploadImageFile(
                                  projectId: widget
                                      .allProjectsResponse!.projectId
                                      .toString(),
                                  imageFile: File(image.imageUrl.toString()));
                              box.deleteAt(index);
                            }),*/ /*
                            iconAction: () async {
                              image.isImageSynchronized == null ||
                                      image.isImageSynchronized == false
                                  ? _controller.uploadImageFile(
                                      projectId: widget
                                          .allProjectsResponse!.projectId
                                          .toString(),
                                      imageFile:
                                          File(image.imageUrl.toString()))
                                  // addSynchronized;
                                  // _isSynchronized = true;
                                  : IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.check_box),
                                    );
                            }),
                        const Divider(),*/
                        // const Divider(),
                      ],
                    ),
                    // Positioned(
                    //   top: -12,
                    //   right: -12,
                    //   child: IconButton(
                    //     onPressed: () {
                    //       box.deleteAt(index);
                    //     },
                    //     icon: const Icon(Icons.delete, color: Colors.redAccent),
                    //   ),
                    // ),
                  ],
                ),
              );
/*                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:

                    ListTile(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (ctx) => ViewNoteScreen(
                        //         title: note.title,
                        //         description: note.description,
                        //         imageUrl: note.imageUrl)));
                      },
                      leading: Image.file(
                        File(
                          image!.imageUrl.toString(),
                        ),
                      ),
                      // title: Text(image.projectId.toString()),
                      title: Text(widget.allProjectsResponse!.projectId.toString()),
                      trailing: IconButton(
                        onPressed: () {
                          box.deleteAt(index);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                ),
              );*/

              //   imageTileItem(
              //   imageFile: image.imageUrl,
              //   taskCompleted: db.imageUploadList[index][1],
              //   onChanged: (value) => checkBoxChanged(value, index),
              //   deleteFunction: (context) => deleteTask(index),
              // );
            },
          );
        },
      ),
    );
  }

  Widget _uploadedImageTab() {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Obx(() {
        //   return _showUploadVideo(_controller.projectVideo.value);
        // }),
        // buttonRoundedMain(
        //     text: "UploadVideo".tr,
        //     onPressCallback: () {
        //       _controller.uploadFileVideo(
        //           widget.allProjectsResponse!.projectId.toString());
        //     })
        // RefreshIndicator(
        //     onRefresh: getRefreshedData,
        //     child: _imageGalleryItemList(context)),
        _imageGalleryItemList(context)
        // RefreshIndicator(onRefresh: refreshList,
        //     key: refreshKey,child: _imageGalleryItemList(context))
      ],
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

                    return filesEvidenceListItemViewForImageView(
                        context,
                        _imageGalleryController
                            .filesEvidenceResponseList[index]);
                  },
                ),
              ),
            );
    });
  }

/*

  // Widget _imageTab() {
  //   return Scaffold(
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: createNewTask,
  //       child: const Icon(Icons.add),
  //     ),
  //     body: ValueListenableBuilder(
  //         valueListenable: Hive.box('TODOLIST').listenable(),
  //         builder: (context, value, child) {
  //           return ListView.builder(
  //             itemCount: db.toDoList.length,
  //             itemBuilder: (context, index) {
  //               return imageTileItem(
  //                 imageFile: db.toDoList[index][0],
  //                 taskCompleted: db.toDoList[index][1],
  //                 onChanged: (value) => checkBoxChanged(value, index),
  //                 deleteFunction: (context) => deleteTask(index),
  //               );
  //             },
  //           );
  //         }),
  //   );
  // }

/*  Widget _imageTabOld() {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: createNewTask,
        label: const Text('Add Image'),
      ),
      body: db.imageUploadList.isEmpty
          ? showEmptyImageView()
          : ListView.builder(
              itemCount: db.imageUploadList.length,
              itemBuilder: (context, index) {
                return imageTileItem(
                  imageFile: db.imageUploadList[index][0],
                  taskCompleted: db.imageUploadList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                );
              },
            ),
    );
  }*/

  // Widget _imageTab2() {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Obx(() {
  //         return _showUploadImage(_controller.projectImage.value);
  //       }),
  //       buttonRoundedMain(
  //           text: "UploadImage".tr,
  //           onPressCallback: () {
  //             _controller.uploadImageFile(
  //                 widget.allProjectsResponse!.projectId.toString());
  //           })
  //     ],
  //   );
  // }

  // Widget _showUploadImage(File file) {
  Widget _showUploadImage(File file) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(dp16),
        decoration: boxDecorationRoundShadow(color: Get.theme.primaryColor),
        width: Get.width,
        height: dp170,
        child: file.path.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonOnlyIconUpload(null,
                      iconPath: AssetConstants.icUpload,
                      iconColor: Colors.white),
                  const VSpacer10(),
                  textAutoSize(
                      text: "Tap to select photo".tr,
                      textAlign: TextAlign.center,
                      fontSize: dp14),
                ],
              )
            // : showImageLocal(file),
            : _image == null
                ? Container()
                : Image.file(File(_image!.path)),
      ),
      onTap: () {
        // checkPermission();
        showImageChooser2();
        // showImageChooser(context, (chooseFile, isGallery) {
        //   if (isGallery) {
        //     _controller.projectImage.value = chooseFile;
        //   } else {
        //     saveFileOnTempPath(chooseFile);
        //   }
        // });
      },
    );
  }
 */
/*
  void showImageChooser2() {
    changePhotoModalBottomSheet(
        onPressTakePicture: getImageFromCamera,
        onPressChoosePicture: getImageFromGallery,
        width: Get.width * 0.85);
  }

  getImageFromCamera() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  getImageFromGallery() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  // Future getImage(bool isGallery, Function(File, bool) onChoose) async {
  //   if (isGallery) {
  //     List<Media>? res = await ImagesPicker.pick(
  //       count: 1,
  //       pickType: PickType.image,
  //       language: Language.System,
  //       cropOpt: CropOption(
  //         aspectRatio: const CropAspectRatio(3, 2),
  //       ),
  //       quality: 0.5,
  //       // only for android
  //       maxSize: 2000, // only for ios (kb)
  //     );
  //     if (res != null) {
  //       var file = File(res[0].path);
  //       onChoose(file, isGallery);
  //     }
  //     // if (res != null) {
  //     //   var file = File(res[0].path);
  //     //   Uint8List imageFile = await file.readAsBytes();
  //     //   File(res[0].path).writeAsBytes(imageFile);
  //     // }
  //   } else {
  //     List<Media>? res = await ImagesPicker.openCamera(
  //       pickType: PickType.image,
  //       cropOpt: CropOption(
  //         aspectRatio: const CropAspectRatio(3, 2),
  //       ),
  //       quality: 0.5, // only for android
  //       maxSize: 2000, // only for ios (kb)
  //     );
  //     if (res != null) {
  //       var file = File(res.first.path);
  //       onChoose(file, isGallery);
  //       //save file to album
  //       // ImagesPicker.saveImageToAlbum(file, albumName: "Project Image");
  //     }
  //   }
  // }

  Widget showImageLocal(File file, {double size = dp90}) {
    return Container(
      decoration: boxDecorationRoundShadow(color: Colors.transparent),
      padding: const EdgeInsets.all(dp0),
      child: Image.file(
        file,
        width: 100,
        height: 70,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget showVideoLocal(File file, {double size = dp90}) {
    return Scaffold(
      body: Center(
        child: videoPlayerController!.value.isInitialized
            ? AspectRatio(
                aspectRatio: videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(videoPlayerController!),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            videoPlayerController!.value.isPlaying
                ? videoPlayerController!.pause()
                : videoPlayerController!.play();
          });
        },
        child: Icon(
          videoPlayerController!.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
    );
    // Container(
    //   decoration: boxDecorationRoundShadow(color: Colors.transparent),
    //   padding: const EdgeInsets.all(dp0),
    //   child: Image.file(
    //     file,
    //     width: size,
    //     height: size,
    //     fit: BoxFit.cover,
    //   ),
    // );
  }

  // Widget showVideoLocal(File file, {double size = dp90}) {
  //   return Container(
  //     decoration: boxDecorationRoundShadow(color: Colors.transparent),
  //     padding: const EdgeInsets.all(dp0),
  //     child: VideoItems(
  //       videoPlayerController: VideoPlayerController.asset(
  //         'assets/video_6.mp4',
  //       ),
  //       looping: true,
  //       autoplay: true,
  //     ),
  //   );
  // }

  // void saveFileOnTempPath(File chooseFile) async {
  //   getImageDirectoryPath(AssetConstants.pathTempProjectImageName)
  //       .then((tempPath) {
  //     if (_controller.projectImage.value.path
  //         .contains(AssetConstants.pathTempProjectImageName)) {
  //       _controller.projectImage.value.deleteSync();
  //     }
  //     File(tempPath).createSync(recursive: true);
  //     File newFile = chooseFile.copySync(tempPath);
  //     chooseFile.deleteSync();
  //     _controller.projectImage.value = newFile;
  //   });
  // }

  void saveVideoFileOnTempPath(File chooseFile) async {
    getImageDirectoryPath(AssetConstants.pathTempProjectVideoName)
        .then((tempPath) {
      if (_controller.projectVideo.value.path
          .contains(AssetConstants.pathTempProjectVideoName)) {
        _controller.projectVideo.value.deleteSync();
      }
      File(tempPath).createSync(recursive: true);
      File newFile = chooseFile.copySync(tempPath);
      chooseFile.deleteSync();
      _controller.projectVideo.value = newFile;
    });
  }

  // void imageFile(File chooseFile) async {
  //   getImageOnlyFile(AssetConstants.pathTempProjectImageName).then((tempPath) {
  //     if (_controller.projectImage.value.path
  //         .contains(AssetConstants.pathTempProjectImageName)) {
  //       _controller.projectImage.value.deleteSync();
  //     }
  //     File(tempPath).createSync(recursive: true);
  //     File newFile = chooseFile.copySync(tempPath);
  //     chooseFile.deleteSync();
  //     _controller.projectImage.value = newFile;
  //   });
  // }


  Widget _showUploadVideo(File file) {
    return InkWell(
      child: Container(
        // height: Get.width / 2,
        // width: Get.width,
        margin: const EdgeInsets.all(dp16),
        decoration: boxDecorationRoundShadow(color: Get.theme.primaryColor),
        width: Get.width,
        height: dp170,
        //decoration: getRoundTransparentBox(),
        child: file.path.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonOnlyIconUpload(null,
                      iconPath: AssetConstants.icUpload,
                      iconColor: Colors.white),
                  const VSpacer10(),
                  textAutoSize(
                      text: "Tap to select video".tr,
                      textAlign: TextAlign.center,
                      fontSize: dp14),
                ],
              )
            : showVideoLocal(file),
      ),
      onTap: () {
        showVideoChooser(context, (chooseFile, isGallery) {
          if (isGallery) {
            _controller.projectVideo.value = chooseFile;
          } else {
            saveVideoFileOnTempPath(chooseFile);
          }
        });
      },
    );
  }

  Widget imageTileItem(
      {File? imageFile,
      bool? taskCompleted,
      Function(bool?)? onChanged,
      Function(BuildContext)? deleteFunction}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          decoration: boxDecorationRoundShadowLight(),
          padding: const EdgeInsets.all(dp16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // checkbox
              // Expanded(
              //   flex: 1,
              //   child: Checkbox(
              //     value: taskCompleted,
              //     onChanged: onChanged,
              //     activeColor: Colors.black,
              //   ),
              // ),
              Expanded(flex: 3, child: showImageLocal(imageFile!)),
              const HSpacer20(),
              // Expanded(
              //       flex: 4,
              //       child: ProgressButton.icon(iconedButtons: {
              //         ButtonState.idle:
              //         IconedButton(
              //             text: "Send",
              //             icon: Icon(Icons.send,color: Colors.white),
              //             color: Colors.deepPurple.shade500),
              //         ButtonState.loading:
              //         IconedButton(
              //             text: "Loading",
              //             color: Colors.deepPurple.shade700),
              //         ButtonState.fail:
              //         IconedButton(
              //             text: "Failed",
              //             icon: Icon(Icons.cancel,color: Colors.white),
              //             color: Colors.red.shade300),
              //         ButtonState.success:
              //         IconedButton(
              //             text: "Success",
              //             icon: Icon(Icons.check_circle,color: Colors.white,),
              //             color: Colors.green.shade400)
              //       },
              //           onPressed: ((){
              //             onChanged;
              //             _controller.uploadImageFile(widget.allProjectsResponse!.projectId.toString());
              //           }),
              //           state: ButtonState.success),
              // ),

              Expanded(
                flex: 4,
                child: buttonRoundedMain(
                    text: "Upload".tr,
                    hasIcon: true,
                    onPressCallback: () {
                      // _controller.uploadImageFile(widget.allProjectsResponse!.projectId.toString());
                      onChanged;
                      taskCompleted;
                      // hideWidget();
                      // taskCompleted==true;
                    }),
              ),
              /* Expanded(
                flex: 4,
                child:
                Column(
                  children: [
                    taskCompleted!
                        ? textAutoSize(text: 'Image uploaded')
                        : Column(
                      children: [
                        textAutoSize(text: 'Image not uploaded'),
                        const VSpacer20(),
                        // buttonOnlyIcon(
                        //     iconPath: AssetConstants.icUpload,
                        //     iconColor: Colors.green,
                        //     onPressCallback: () {
                        //       _controller.uploadImageFile(
                        //           widget.allProjectsResponse!.projectId
                        //               .toString());
                        //       onChanged;
                        //       taskCompleted;
                        //     }),
                        buttonRoundedMain(
                            text: "Upload".tr,
                            hasIcon: true,
                            onPressCallback: () {
                              _controller.uploadImageFile(
                                  widget.allProjectsResponse!.projectId
                                      .toString());
                              onChanged;
                              taskCompleted;
                              // taskCompleted==true;
                            })
                      ],
                    ),
                  ],
                ),
              ),*/

              ///worked for single use
/*              InkWell(
                  onTap: () {
                    setState(
                          () {
                        _isPressed = true;
                      },
                    );
                  },
                  child: _isPressed
                      ? textAutoSize(text: 'Image uploaded')
                      : Column(
                    children: [
                      textAutoSize(text: 'Image not uploaded'),
                      const VSpacer20(),
                      buttonRoundedMain(
                          text: "Upload".tr,
                          hasIcon: true,
                          onPressCallback: () {
                            _controller.uploadImageFile(widget.allProjectsResponse!.projectId.toString());
                            _isPressed = true;
                          }),
                    ],
                  )),*/
              // task name
              // Text(
              //   taskName,
              //   style: TextStyle(
              //     decoration: taskCompleted
              //         ? TextDecoration.lineThrough
              //         : TextDecoration.none,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

//   Widget imageTileItemOld(
//       {XFile? imageFile,
//       bool? taskCompleted,
//       Function(bool?)? onChanged,
//       Function(BuildContext)? deleteFunction}) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
//       child: Slidable(
//         endActionPane: ActionPane(
//           motion: const StretchMotion(),
//           children: [
//             SlidableAction(
//               onPressed: deleteFunction,
//               icon: Icons.delete,
//               backgroundColor: Colors.red.shade300,
//               borderRadius: BorderRadius.circular(12),
//             )
//           ],
//         ),
//         child: Container(
//           decoration: boxDecorationRoundShadowLight(),
//           padding: const EdgeInsets.all(dp16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // checkbox
//               // Expanded(
//               //   flex: 1,
//               //   child: Checkbox(
//               //     value: taskCompleted,
//               //     onChanged: onChanged,
//               //     activeColor: Colors.black,
//               //   ),
//               // ),
//               Expanded(flex: 3, child: showImageLocal(imageFile!)),
//               const HSpacer20(),
//               // Expanded(
//               //       flex: 4,
//               //       child: ProgressButton.icon(iconedButtons: {
//               //         ButtonState.idle:
//               //         IconedButton(
//               //             text: "Send",
//               //             icon: Icon(Icons.send,color: Colors.white),
//               //             color: Colors.deepPurple.shade500),
//               //         ButtonState.loading:
//               //         IconedButton(
//               //             text: "Loading",
//               //             color: Colors.deepPurple.shade700),
//               //         ButtonState.fail:
//               //         IconedButton(
//               //             text: "Failed",
//               //             icon: Icon(Icons.cancel,color: Colors.white),
//               //             color: Colors.red.shade300),
//               //         ButtonState.success:
//               //         IconedButton(
//               //             text: "Success",
//               //             icon: Icon(Icons.check_circle,color: Colors.white,),
//               //             color: Colors.green.shade400)
//               //       },
//               //           onPressed: ((){
//               //             onChanged;
//               //             _controller.uploadImageFile(widget.allProjectsResponse!.projectId.toString());
//               //           }),
//               //           state: ButtonState.success),
//               // ),
//
//               Expanded(
//                 flex: 4,
//                 child: buttonRoundedMain(
//                     text: "Upload".tr,
//                     hasIcon: true,
//                     onPressCallback: () {
//                       _controller.uploadImageFile(widget.allProjectsResponse!.projectId.toString());
//                       onChanged;
//                       taskCompleted;
//                       // hideWidget();
//                       // taskCompleted==true;
//                     }),
//               ),
//                 /* Expanded(
//                 flex: 4,
//                 child:
//                 Column(
//                   children: [
//                     taskCompleted!
//                         ? textAutoSize(text: 'Image uploaded')
//                         : Column(
//                       children: [
//                         textAutoSize(text: 'Image not uploaded'),
//                         const VSpacer20(),
//                         // buttonOnlyIcon(
//                         //     iconPath: AssetConstants.icUpload,
//                         //     iconColor: Colors.green,
//                         //     onPressCallback: () {
//                         //       _controller.uploadImageFile(
//                         //           widget.allProjectsResponse!.projectId
//                         //               .toString());
//                         //       onChanged;
//                         //       taskCompleted;
//                         //     }),
//                         buttonRoundedMain(
//                             text: "Upload".tr,
//                             hasIcon: true,
//                             onPressCallback: () {
//                               _controller.uploadImageFile(
//                                   widget.allProjectsResponse!.projectId
//                                       .toString());
//                               onChanged;
//                               taskCompleted;
//                               // taskCompleted==true;
//                             })
//                       ],
//                     ),
//                   ],
//                 ),
//               ),*/
//
//               ///worked for single use
// /*              InkWell(
//                   onTap: () {
//                     setState(
//                           () {
//                         _isPressed = true;
//                       },
//                     );
//                   },
//                   child: _isPressed
//                       ? textAutoSize(text: 'Image uploaded')
//                       : Column(
//                     children: [
//                       textAutoSize(text: 'Image not uploaded'),
//                       const VSpacer20(),
//                       buttonRoundedMain(
//                           text: "Upload".tr,
//                           hasIcon: true,
//                           onPressCallback: () {
//                             _controller.uploadImageFile(widget.allProjectsResponse!.projectId.toString());
//                             _isPressed = true;
//                           }),
//                     ],
//                   )),*/
//               // task name
//               // Text(
//               //   taskName,
//               //   style: TextStyle(
//               //     decoration: taskCompleted
//               //         ? TextDecoration.lineThrough
//               //         : TextDecoration.none,
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

  void alertDialogForImageUpload(
      {VoidCallback? saveAction, VoidCallback? cancelAction}) {
    Get.defaultDialog(
      title: "",
      radius: dp10,
      backgroundColor: Get.theme.backgroundColor,
      barrierDismissible: false,
      content: SizedBox(
        height: 320,
        width: Get.width,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                textAutoSize(
                    textAlign: TextAlign.center,
                    text: 'Select Image'.tr,
                    fontSize: 22),
                const SizedBox(height: dp10),
                _image == null ? Container() : Image.file(File(_image!.path)),
                // Obx(() {
                //   // return _showUploadImage(_controller.projectImage.value);
                // }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Obx(() {
                    //   // return _controller.projectImage.value.path.isEmpty
                    //   return _image!.path.isEmpty
                    //       ? const Expanded(
                    //           flex: 1,
                    //           child: SizedBox(width: 0),
                    //         )
                    //       : Expanded(
                    //           flex: 1,
                    //           child: buttonRoundedMain(
                    //               text: "Save".tr,
                    //               onPressCallback: saveAction,
                    //               width: Get.width / 3.5),
                    //         );
                    // }),
                    _image!.path.isEmpty
                        ? const Expanded(
                            flex: 1,
                            child: SizedBox(width: 0),
                          )
                        : Expanded(
                            flex: 1,
                            child: buttonRoundedMain(
                                text: "Save".tr,
                                onPressCallback: saveAction,
                                width: Get.width / 3.5),
                          ),
                    Expanded(
                      flex: 1,
                      child: buttonRoundedMain(
                          text: "Cancel".tr,
                          onPressCallback: cancelAction,
                          width: Get.width / 3.5),
                    )
                  ],
                )
              ],
            ),
            Positioned(
                // top: 40,
                // right: 16,
                child: showImageAsset(
                    onPressCallback: () {
                      Get.back();
                    },
                    imagePath: AssetConstants.icCross,
                    height: dp20,
                    color: Get.theme.backgroundColor))
          ],
        ),
      ),
    );
    // _controller.projectImage.value = File("");
  }
  */
}
