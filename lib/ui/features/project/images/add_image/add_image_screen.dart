import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pmis_flutter/data/db/models/asset_collection.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/project/images/add_image/image_upload_form.dart';
import 'package:pmis_flutter/ui/features/project/images/pending_image/pending_image_screen.dart';
import 'package:pmis_flutter/ui/features/project/project_details_bottom_bar.dart';
import 'package:pmis_flutter/utils/alert_util.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:native_exif/native_exif.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../utils/common_widget.dart';
import '../../../../../utils/date_util.dart';
import '../../../root/root_controller.dart';
import '../survey_gallery_controller.dart';

class AddImageScreen extends StatefulWidget {
  final VoidCallback? onUploadComplete;

  const AddImageScreen({Key? key, this.onUploadComplete}) : super(key: key);

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  bool isLoading = false;
  final _controller = Get.put(SurveyGalleryController());
  final _rootController = Get.put(RootController());

  XFile? _image;
  String? projectId;
  Exif? exif;
  final now = DateTime.now();
  String? imageShootingDate;
  String? imageShootingTime;
  ExifLatLong? coordinates;
  String? location;
  String? latitude;
  String? longitude;
  String? address;
  String locationMessage = 'Location of project will show here!';

  @override
  void dispose() {
    _controller.captionTextEditController.clear();
    _image = null;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args != null && args['image'] != null) {
      _image = args['image'];
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _processImage();
      });
    }
  }

  Future<void> _processImage() async {
    setState(() {
      isLoading = true;
    });

    Position position = await _determinePosition();
    location =
        'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
    imageShootingDate = formatDateToDDMMYYYY(now.toString());
    imageShootingTime = formatDateToHHMMAPM(now.toString());
    await getLocationAddressFromLatLong(position);

    setState(() {
      isLoading = false;
    });
  }

  Future<void> getImageFromCamera() async {
    setState(() {
      isLoading = true;
    });
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.camera);
    if (image == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    _image = image;
    await _processImage();
  }

  Future<void> getImageFromGallery() async {
    final image =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<void> submitData() async {
    await Hive.box<AssetCollection>('image').add(
      AssetCollection(
        projectId: stringNullCheck(projectId),
        imageUrl: stringNullCheck(_image!.path),
        imageName:
            "${stringNullCheck(_rootController.userInfo.value.firstName)} ${stringNullCheck(_rootController.userInfo.value.lastName)}",
        imageShootingDate: stringNullCheck(imageShootingDate),
        imageShootingTime: stringNullCheck(imageShootingTime),
        imageLatValue: stringNullCheck(latitude),
        imageLongValue: stringNullCheck(longitude),
        imagePickUpLocation: stringNullCheck(address),
        imageCaption:
            _controller.captionTextEditController.value.text.toString() ?? "",
      ),
    );

    _controller.captionTextEditController.clear();
    Get.back();
    widget.onUploadComplete
        ?.call(); // Call the callback after successful upload
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      openAppSettings();
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getLocationAddressFromLatLong(Position position) async {
    List<Placemark> placeMark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placeMark[0];

    setState(() {
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
    });
  }

  Future<void> _openMap(String latitude, String longitude) async {
    String googleMapUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    await canLaunchUrlString(googleMapUrl)
        ? await launchUrlString(googleMapUrl)
        : throw 'Could not launch $googleMapUrl';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithBackAndActions(title: "Captured Image".tr),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : _image == null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textAutoSize(
                          text: "capture_image_message".tr,
                          alignment: Alignment.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: getImageFromCamera,
                          icon: const Icon(Icons.camera_alt),
                          label: Text('Camera'.tr),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Get.theme.primaryColor,
                            foregroundColor: cardColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ImageUploadForm(
                    imagePath: _image!.path,
                    capturedBy:
                        "${stringNullCheck(_rootController.userInfo.value.firstName)} ${stringNullCheck(_rootController.userInfo.value.lastName)}",
                    dateAndTime:
                        "${stringNullCheck(imageShootingDate)}, ${stringNullCheck(imageShootingTime)}",
                    latitude: stringNullCheck(latitude),
                    longitude: stringNullCheck(longitude),
                    location: stringNullCheck(address),
                    captionController: _controller.captionTextEditController,
                    onMapOpen: () => openMap(
                      stringNullCheck(latitude),
                      stringNullCheck(longitude),
                    ),
                    onUpload: () {
                      if (_controller
                          .captionTextEditController.value.text.isEmpty) {
                        showToast('Please write a caption text.');
                      } else {
                        submitData();
                      }
                    },
                    onImageTap: () => showModalSheetFullScreenForGallery(
                      context,
                      item: _image!.path,
                    ),
                  ),
      ),
      floatingActionButton: isLoading
          ? null
          : (_image == null
              ? FloatingActionButton.extended(
                  icon: Icon(Icons.camera_alt, color: cardColor),
                  onPressed: getImageFromCamera,
                  backgroundColor: Get.theme.primaryColor,
                  label: Text('Camera'.tr,
                      style: TextStyle(
                        color: cardColor,
                      )),
                )
              : FloatingActionButton.extended(
                  icon: Icon(Icons.save, color: cardColor),
                  onPressed: () {
                    if (_controller
                        .captionTextEditController.value.text.isEmpty) {
                      showToast('Please write a caption text.');
                    } else {
                      submitData();
                    }
                  },
                  backgroundColor: accentGreenText,
                  label: Text('Save'.tr,
                      style: TextStyle(
                        color: cardColor,
                      )),
                )),
    );
  }
}
