import 'dart:io';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/project/inspection/inspection_report_screen.dart';
import 'package:pmis_flutter/ui/features/project/project_details_by_id_controller.dart';
import 'package:pmis_flutter/ui/features/project/locations/project_locations_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../data/local/constants.dart';
import '../../../utils/alert_util.dart';
import '../../../utils/date_util.dart';
import 'image_gallery/image_gallery_screen.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;

  final bool isMyProject = false;

  const ProjectDetailsScreen({Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  final _controllerForProjectDetailsByID =
      Get.put(ProjectDetailsByIDController());

  /*@override
  void initState() {
    super.initState();
    // _controller.getMyProjectListItemsWithoutPagination();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(stringNullCheck(widget.allProjectsResponse!.projectId));
    _controllerForProjectDetailsByID.getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());

    });
  }*/

  void initCalls() async {
    await _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(
        stringNullCheck(widget.allProjectsResponse!.projectId));
    await _controllerForProjectDetailsByID
        .getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  void initState() {
    initCalls();
    super.initState();
    // _controller.getMyProjectListItemsWithoutPagination();
    /*WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(stringNullCheck(widget.allProjectsResponse!.projectId));
      _controllerForProjectDetailsByID.getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());
    });*/
  }

  @override
  void dispose() {
    // _controller.clearView();
    super.dispose();
  }

  String? location;

  late String lat;
  late String long;
  String locationMessage = 'Location of project will show here!';

  String? address;

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getLocationAddressFromLatLong(Position position) async {
    List<Placemark> placeMark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print('$placeMark');
    Placemark place = placeMark[0];
    // address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
    setState(() {
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}';
    });
  }

  //listen to location update
  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();
      setState(() {
        locationMessage = 'Latitude: $lat, Longitude: $long';
      });
    });
  }

  /// open the location in Google Map
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
      backgroundColor: context.theme.colorScheme.surface,
      appBar: appBarWithBackAndActions(
          title: "ProjectDetails".tr,
          // actionIcons: [AssetConstants.icFavorite],
          onPress: (index) {
            //do active icon job
          }),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    // height: Platform.isAndroid
                    //     ? getContentHeight() - 60
                    //     : getContentHeight() - 130,
                    decoration: boxDecorationRoundShadowLight(),
                    padding: const EdgeInsets.all(dp16),
                    margin: const EdgeInsets.all(dp5),
                    child: SingleChildScrollView(
                      child: Scrollbar(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /*twoSidedTextWithColon2(
                                leftText: "Project_Name".tr,
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.name)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "code".tr,
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.code
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "MinistryName".tr,
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.ministryName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "DivisionName".tr,
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.divisionName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "AgencyName".tr,
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.agencyName)),*/

                            //twoSidedTextWithColon2(leftText: "Project_Name".tr, rightText: stringNullCheck(widget.allProjectsResponse!.name)),
                            projectTitle(
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.name)),

                            widget.allProjectsResponse!.code == null
                                ? const SizedBox(height: 0, width: 0)
                                : Column(
                                    children: [
                                      const Divider(),
                                      twoSidedTextWithColon2(
                                          leftText: "code".tr,
                                          rightText: stringNullCheck(
                                              _controllerForProjectDetailsByID
                                                  .projectDetailsById.value.code
                                                  .toString())),
                                    ],
                                  ),
                            _controllerForProjectDetailsByID.projectDetailsById
                                        .value.ministryName ==
                                    null
                                ? const SizedBox(height: 0, width: 0)
                                : Column(
                                    children: [
                                      const Divider(),
                                      twoSidedTextWithColon2(
                                          leftText: "MinistryName".tr,
                                          rightText: stringNullCheck(
                                              _controllerForProjectDetailsByID
                                                  .projectDetailsById
                                                  .value
                                                  .ministryName
                                                  .toString())),
                                    ],
                                  ),
                            _controllerForProjectDetailsByID.projectDetailsById
                                        .value.divisionName ==
                                    null
                                ? const SizedBox(height: 0, width: 0)
                                : Column(
                                    children: [
                                      const Divider(),
                                      twoSidedTextWithColon2(
                                          leftText: "DivisionName".tr,
                                          rightText: stringNullCheck(
                                              _controllerForProjectDetailsByID
                                                  .projectDetailsById
                                                  .value
                                                  .divisionName
                                                  .toString())),
                                    ],
                                  ),
                            _controllerForProjectDetailsByID
                                        .projectDetailsById.value.agencyName ==
                                    null
                                ? const SizedBox(height: 0, width: 0)
                                : Column(
                                    children: [
                                      const Divider(),
                                      twoSidedTextWithColon2(
                                          leftText: "AgencyName".tr,
                                          rightText: stringNullCheck(
                                              _controllerForProjectDetailsByID
                                                  .projectDetailsById
                                                  .value
                                                  .agencyName
                                                  .toString())),
                                    ],
                                  ),

                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "ProjectTimeline".tr,
                                rightText:
                                    "${formatDateToDDMMYYYY(widget.allProjectsResponse!.dateOfCommencement.toString())}  To  ${formatDateToDDMMYYYY(widget.allProjectsResponse!.dateOfCompletion.toString())}"),
                            const Divider(),
                            twoSidedTextWithTextActionAndIcon(
                                leftText: "InspectionDetail".tr,
                                rightText: 'SeeDetailsOfInspection'.tr,
                                rightIcon: AssetConstants.icInspectionReport,
                                iconAction: () {
                                  Get.to(() => InspectionReportScreen(
                                      allProjectsResponse:
                                          widget.allProjectsResponse));
                                }),
                            Obx(() {
                              return _controllerForProjectDetailsByID
                                          .projectDetailsById.value.pcrStatus
                                          .toString() ==
                                      "Received"
                                  ? Column(
                                      children: [
                                        const Divider(),
                                        twoSidedTextWithIconAndTextAction(
                                            leftText: "PCRStatus".tr,
                                            rightText: 'Received'.tr,
                                            rightTextColor:
                                                Get.theme.primaryColor,
                                            rightActionText: 'ViewEvidence'.tr,
                                            rightIcon:
                                                AssetConstants.icPasswordShow,
                                            rightTextAction: () {
                                              alertDialogViewForPCREvidence(
                                                context: context,
                                                title: 'PCREvidence'.tr,
                                                fileId: _controllerForProjectDetailsByID
                                                    .pcrAttachmentViewListResponse
                                                    .first
                                                    .fileId
                                                    .toString(),
                                                receivedDate:
                                                    _controllerForProjectDetailsByID
                                                        .pcrAttachmentViewListResponse
                                                        .first
                                                        .receivedDate
                                                        .toString(),
                                                remarks:
                                                    _controllerForProjectDetailsByID
                                                        .pcrAttachmentViewListResponse
                                                        .first
                                                        .remarks
                                                        .toString(),
                                              );
                                            }),
                                      ],
                                    )
                                  : const SizedBox();
                            }),
                            const Divider(),
                            widget.allProjectsResponse!.projectTypeId
                                        .toString() ==
                                    "ProjectType_DPP"
                                ? Column(
                                    children: [
                                      twoSidedTextWithTextActionAndIcon(
                                          leftText: "Location".tr,
                                          rightText: 'SeeLocations'.tr,
                                          rightIcon: AssetConstants.icLocation,
                                          iconAction: () {
                                            Get.to(() => ProjectLocationsScreen(
                                                allProjectsResponse: widget
                                                    .allProjectsResponse));
                                          }),
                                      const Divider(),
                                    ],
                                  )
                                : const SizedBox(),
                            twoSidedTextWithTextActionAndIcon(
                                leftText: "VisualEvidence".tr,
                                rightText: 'SeeProjectImages'.tr,
                                rightIcon: AssetConstants.icGallery,
                                iconAction: () {
                                  Get.to(() => ImageGalleryScreen(
                                      allProjectsResponse:
                                          widget.allProjectsResponse));
                                }),
/*                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "EstimatedCost".tr,
                                // rightText: "date Of Completion"
                                rightText: '12,2800 Lakh BDT'),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "ProgressFinancial".tr,
                                rightText: '500 Lakh BDT(30%)'),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "ProgressPhysical".tr,
                                rightText: '70%'),*/
/*                            twoSidedTextWithIcon(
                                leftText: "Location".tr,
                                rightText: 'SeeLocationOnGoogleMap'.tr,
                                rightIcon: AssetConstants.icLocation,
                                iconAction: () async {
                                  Position position = await _determinePosition();
                                  // print(
                                  //     'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
                                  // // location = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
                                  // getLocationAddressFromLatLong(position);
                                  // setState(() {
                                  //   location = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
                                  // });
                                  // _liveLocation();
                                  openMap(stringNullCheck(position.latitude.toString()),
                                      stringNullCheck(position.longitude.toString()));
                                }),
                            const Divider(),*/
                            /*
                            twoSidedTextWithColon2(
                                leftText: "InspectorName".tr,
                                rightText: 'Mr. Inspector'
                            ),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "DateOfInspection".tr,
                                // rightText: "date Of Completion"
                                rightText: formatDateToDDMMYYYY(stringNullCheck(
                                    widget.allProjectsResponse!.dateOfCompletion
                                        .toString()))
                            ),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "InspectionSummery".tr,
                                rightText: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'
                            ),
                            const Divider(),
                          twoSidedTextWithColon2(
                                leftText: "DateOfCommencement".tr,
                                rightText: formatDateToDDMMYYYY(stringNullCheck(
                                    widget
                                        .allProjectsResponse!.dateOfCommencement
                                        .toString()))),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "dateOfCompletion".tr,
                                rightText: formatDateToDDMMYYYY(stringNullCheck(
                                    widget.allProjectsResponse!.dateOfCompletion
                                        .toString()))),
                          const Divider(),
                            twoSidedTextWithColon3Data(
                                leftText: "LastInspectionData".tr,
                                // rightText: "date Of Completion"
                              dateOfInspectionText: formatDateToDDMMYYYY(stringNullCheck(
                                  widget.allProjectsResponse!.dateOfCompletion
                                      .toString())),
                              inspectorNameText: 'Mr. Inspector',
                              inspectionSummeryText: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                            ),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "InspectorName".tr,
                                // rightText: "date Of Completion"
                                rightText: 'Mr. Inspector'
                            ),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "DateOfInspection".tr,
                                // rightText: "date Of Completion"
                                rightText: formatDateToDDMMYYYY(stringNullCheck(
                                    widget.allProjectsResponse!.dateOfCompletion
                                        .toString()))
                            ),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "InspectionSummery".tr,
                                rightText: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry'
                            ),
                            twoSidedTextWithColon2(
                                leftText: "ProjectStatus".tr,
                                // rightText: "Status Name"
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.statusName),
                                rightTextFontWeight: FontWeight.bold),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "name_bangla".tr,
                                // rightText: "মাতারবাড়ী আল্ট্রা সুপার ক্রিটিক্যাল কোল ফায়ারড"),
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.nameBangla)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "short_name".tr,
                                // rightText: "project"
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.shortName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "short_name_bangla".tr,
                                // rightText: "মাতারবাড়ী"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.shortNameBangla)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "HasMultipleAgency".tr,
                                // rightText: "Yes"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.hasMultipleAgency
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "IsSelfFinanced".tr,
                                // rightText: "No"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.isSelfFinanced
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "AdpSectorName".tr,
                                // rightText: "Adp Sector Name"
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.adpSectorName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "AdpSubSectorName".tr,
                                // rightText: "Adp SubSector Name"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.adpSubSectorName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "FiscalYearId".tr,
                                // rightText: "Fiscal Year Id"
                                rightText: stringNullCheck(widget.allProjectsResponse!.)
                            ),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "HasForeignLocation".tr,
                                // rightText: "Has Foreign Location"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.hasForeignLocation
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "ProjectTypeName".tr,
                                // rightText: "ProjectTypeName"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.projectTypeName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "CurrentProjectRevisionNo".tr,
                                // rightText: "true"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!
                                    .currentProjectRevisionNo
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "ProjectNatureName".tr,
                                // rightText: "Project Nature Name"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.projectNatureName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "UmbrellaProjectName".tr,
                                // rightText: "Umbrella Project Name"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.umbrellaProjectName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "ProgramName".tr,
                                // rightText: "Program Name"
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.adpSectorName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "DevelopmentPlanTypeName".tr,
                                // rightText: "Development Plan Type Name"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!
                                    .developmentPlanTypeName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "IsOnlyForGobProject".tr,
                                // rightText: "Is Only For Gob Project"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.isOnlyForGobProject
                                    .toString())),
                            const Divider(),
                                   const Divider(),
                            twoSidedTextWithColonIcon(
                                leftText: "See Location".tr,
                                onPressed: () {
                                  _determinePosition;
                                }),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "IsFastTrack".tr,
                                // rightText: "No"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.isFastTrack
                                    .toString())),
                            const VSpacer20(),
                            buttonRoundedMain(
                                text: "SeeProjectLocation".tr,
                                onPressCallback: () async {
                                  Position position =
                                      await _determinePosition();
                                  print(
                                      'Latitude: ${position.latitude}, Longitude: ${position.longitude}');
                                  // location = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
                                  getLocationAddressFromLatLong(position);
                                  setState(() {
                                    location =
                                        'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
                                  });
                                  _liveLocation();
                                }),
                            const VSpacer20(),
                            // textAutoSize(text: location!.isEmpty ? '' :'$location'),
                            location == null
                                ? const SizedBox(width: 0)
                                : Column(
                              children: [
                                textAutoSize(
                                    text: stringNullCheck('$location'),
                                    textAlign: TextAlign.center),
                                textAutoSize(
                                    text: stringNullCheck('$address'),
                                    textAlign: TextAlign.center),
                                // textAutoSize(text: stringNullCheck('$locationMessage')),
                                const VSpacer20(),
                                buttonRoundedMain(
                                    text: "Open Google map".tr,
                                    onPressCallback: () {
                                      // _openMap(lat, long);
                                      openMap(lat, long);
                                    }),
                              ],
                            ),
                            const VSpacer20(), */
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /*Expanded(
              child: Column(
                children: [
                  Container(
                    height: Platform.isAndroid
                        ? getContentHeight() - 60
                        : getContentHeight() - 130,
                    // height: Platform.isAndroid
                    //     ? getContentHeight() - 145
                    //     : getContentHeight() - 215,
                    decoration: boxDecorationRoundShadowLight(),
                    padding: const EdgeInsets.all(dp16),
                    margin: const EdgeInsets.all(dp16),
                    child: SingleChildScrollView(
                      child: Scrollbar(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // twoSidedTextWithColon2(leftText: "Project_Name".tr, rightText: "Full Project Name"),
                            twoSidedTextWithColon2(
                                leftText: "Project_Name".tr,
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.name)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "ProjectStatus".tr,
                                // rightText: "Status Name"
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.statusName),rightTextFontWeight: FontWeight.bold),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "name_bangla".tr,
                                // rightText: "মাতারবাড়ী আল্ট্রা সুপার ক্রিটিক্যাল কোল ফায়ারড"),
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.nameBangla)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "short_name".tr,
                                // rightText: "project"
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.shortName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "short_name_bangla".tr,
                                // rightText: "মাতারবাড়ী"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.shortNameBangla)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "code".tr,
                                // rightText: "1234"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.code
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "MinistryName".tr,
                                // rightText: "Ministry Name"
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.ministryName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "DivisionName".tr,
                                // rightText: "Division Name"
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.divisionName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "AgencyName".tr,
                                // rightText: "Agency Name"
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.agencyName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "HasMultipleAgency".tr,
                                // rightText: "Yes"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.hasMultipleAgency
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "IsSelfFinanced".tr,
                                // rightText: "No"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.isSelfFinanced
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "AdpSectorName".tr,
                                // rightText: "Adp Sector Name"
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.adpSectorName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "AdpSubSectorName".tr,
                                // rightText: "Adp SubSector Name"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.adpSubSectorName)),
                            // const Divider(),
                            // twoSidedTextWithColon2(
                            //     leftText: "FiscalYearId".tr,
                            //     // rightText: "Fiscal Year Id"
                            //     rightText: stringNullCheck(widget.allProjectsResponse!.)
                            // ),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "HasForeignLocation".tr,
                                // rightText: "Has Foreign Location"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.hasForeignLocation
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "ProjectTypeName".tr,
                                // rightText: "ProjectTypeName"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.projectTypeName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "CurrentProjectRevisionNo".tr,
                                // rightText: "true"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!
                                    .currentProjectRevisionNo
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "ProjectNatureName".tr,
                                // rightText: "Project Nature Name"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.projectNatureName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "UmbrellaProjectName".tr,
                                // rightText: "Umbrella Project Name"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.umbrellaProjectName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "ProgramName".tr,
                                // rightText: "Program Name"
                                rightText: stringNullCheck(
                                    widget.allProjectsResponse!.adpSectorName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "DevelopmentPlanTypeName".tr,
                                // rightText: "Development Plan Type Name"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!
                                    .developmentPlanTypeName)),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "IsOnlyForGobProject".tr,
                                // rightText: "Is Only For Gob Project"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.isOnlyForGobProject
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "DateOfCommencement".tr,
                                // rightText: "Date Of Commencement"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.dateOfCommencement
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "dateOfCompletion".tr,
                                // rightText: "date Of Completion"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.dateOfCompletion
                                    .toString())),
                            const Divider(),
                            twoSidedTextWithColon2(
                                leftText: "IsFastTrack".tr,
                                // rightText: "No"
                                rightText: stringNullCheck(widget
                                    .allProjectsResponse!.isFastTrack
                                    .toString())),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // surveyGalleryButton(),

                  // widget.allProjectsResponse!.projectId!.toString().isNotEmpty
                  // widget.myProjectsResponse!.projectId.toString() == widget.allProjectsResponse!.projectId.toString()
                  //       ? surveyGalleryButton()
                  //       : const SizedBox(height: 0,width: 0),

                  // Obx(() {
                  //   return widget.allProjectsResponse!.projectId!.toString().isNotEmpty
                  //   // return widget.myProjectsResponse!.projectId == widget.allProjectsResponse!.projectId
                  //   // return myProjectsResponse!.projectId == widget.allProjectsResponse!.projectId
                  //       ? surveyGalleryButton()
                  //       : const SizedBox(height: 0,width: 0);
                  // }),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
