import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/my_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/my_project/my_project_controller.dart';
import 'package:pmis_flutter/ui/features/project/project_details_controller.dart';
import 'package:pmis_flutter/ui/features/project/allocation/allocation_details_screen.dart';
import 'package:pmis_flutter/ui/features/project/estimate/estimated_cost_details_screen.dart';
import 'package:pmis_flutter/ui/features/project/expenditure/expenditure_cost_details_screen.dart';
import 'package:pmis_flutter/ui/features/project/inspection/inspection_report_screen.dart';
import 'package:pmis_flutter/ui/features/project/project_details_by_id_controller.dart';
import 'package:pmis_flutter/ui/features/project/locations/project_locations_screen.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/date_util.dart';

import 'release/project_fund_release_summary_screen.dart';

class MyProjectDetailsScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;
  final bool isMyProject = false;

  const MyProjectDetailsScreen({Key? key, this.allProjectsResponse})
      : super(key: key);

  @override
  _MyProjectDetailsScreenState createState() => _MyProjectDetailsScreenState();
}

class _MyProjectDetailsScreenState extends State<MyProjectDetailsScreen> {
  MyProjectsResponse? myProjectsResponse;
  final _controller = Get.put(MyProjectController());
  final _controllerForProjectDetailsByID =
  Get.put(ProjectDetailsByIDController());

  final _wishListProjectDetailsController =
  Get.put(WishListProjectDetailsController());

  bool isLoading = true;
  void initCalls() async {
    await _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(stringNullCheck(widget.allProjectsResponse!.projectId));
    await _controllerForProjectDetailsByID.getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());
    await _controller.getProjectProgressAndCostData(widget.allProjectsResponse!.projectId.toString());

    await _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(stringNullCheck(widget.allProjectsResponse!.projectId));
    await _controllerForProjectDetailsByID.getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());
    await _wishListProjectDetailsController.getWishListProjectReport(widget.allProjectsResponse!.projectId.toString());
    await _wishListProjectDetailsController.getProjectEstimatedCostData(widget.allProjectsResponse!.projectId.toString());
    await _wishListProjectDetailsController.getProjectAllocationCostData(widget.allProjectsResponse!.projectId.toString());
    await _wishListProjectDetailsController.getProjectExpenditureCostData(widget.allProjectsResponse!.projectId.toString());
    await _wishListProjectDetailsController.getProjectFundReleaseSummaryData(widget.allProjectsResponse!.projectId.toString());
    await _wishListProjectDetailsController.getDataEntryProgress(widget.allProjectsResponse!.projectId.toString());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    initCalls();
    super.initState();

    /*WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controllerForProjectDetailsByID.getPCRAttachmentEvidenceData(stringNullCheck(widget.allProjectsResponse!.projectId));
      _controllerForProjectDetailsByID.getMyProjectListByID(widget.allProjectsResponse!.projectId.toString());
      _controller.getProjectProgressAndCostData(widget.allProjectsResponse!.projectId.toString());
      debugPrint("RokanAifazFarabiBaba: ${_controllerForProjectDetailsByID.projectDetailsById.value.name.toString()}");

    });*/
  }

  @override
  void dispose() {
    // _controller.clearView();
    super.dispose();
  }

  String? location;
  String? latitude;
  String? longitude;

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

  // Zabir
  @override
  Widget build(BuildContext context) {
    final projectID = widget.allProjectsResponse!.projectId.toString();
    return Scaffold(
      backgroundColor: background,
      appBar: appBarWithBackAndActions(
          title: "ProjectDetails".tr, onPress: (index) {}),
      body: SafeArea(
        child: isLoading == true
            ? const Center(
            child: CircularProgressIndicator(color: Color(0xFF4A90E2)))
            :

        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Header Card with new design
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: accentBlue.withOpacity(0.1),
                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    stringNullCheck(
                                        _controllerForProjectDetailsByID
                                            .projectDetailsById.value.code
                                            .toString()),
                                    style: TextStyle(
                                      color: accentBlue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: accentGreen.withOpacity(0.1),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        color: accentGreenText,
                                        size: 14,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        "${formatDateToDDMMYYYY(widget.allProjectsResponse!.dateOfCommencement.toString())} - ${formatDateToDDMMYYYY(widget.allProjectsResponse!.dateOfCompletion.toString())}",
                                        style: const TextStyle(
                                          color: accentGreenText,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              stringNullCheck(
                                  _controllerForProjectDetailsByID
                                      .projectDetailsById.value.name
                                      .toString()),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Info Card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            if (_controllerForProjectDetailsByID
                                .projectDetailsById
                                .value
                                .agencyName !=
                                null)
                              Row(
                                children: [
                                  const Icon(Icons.business,
                                      size: 16, color: Color(0xFF4A90E2)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      stringNullCheck(
                                          _controllerForProjectDetailsByID
                                              .projectDetailsById
                                              .value
                                              .agencyName
                                              .toString()),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            if (_controllerForProjectDetailsByID
                                .projectDetailsById
                                .value
                                .projectDirector!
                                .firstName
                                .toString()
                                .isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  const Icon(Icons.person,
                                      size: 16, color: Color(0xFF50E3C2)),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      "PD: ${stringNullCheck(_controllerForProjectDetailsByID.projectDetailsById.value.projectDirector!.firstName.toString())} ${stringNullCheck(_controllerForProjectDetailsByID.projectDetailsById.value.projectDirector!.lastName.toString())}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              Row(
                                children: [
                                  const Icon(Icons.description,
                                      size: 16, color: Colors.purple),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(

                                      "${_wishListProjectDetailsController.dataEntryProgressResponse.value.dataSubmissionProgressPercentage}%" " "" Monthly Report Submitted to IMED",

                                      //"RokanUddin: ${stringNullCheck(_controllerForProjectDetailsByID.projectDetailsById.value.projectDirector!.firstName.toString())} ${stringNullCheck(_controllerForProjectDetailsByID.projectDetailsById.value.projectDirector!.lastName.toString())}",

                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Financial Overview Grid
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: [
                        _buildFinancialCard(
                          "Project Cost",
                          "${stringNullCheck(formatter.format(_wishListProjectDetailsController.wishListProjectDetailsResponse.value.projectTotalCost))} Lakh",
                          "GOB: ${stringNullCheck(formatter.format(_wishListProjectDetailsController.wishListProjectDetailsResponse.value.projectTotalCostGob))}",
                          accentBlue,
                              () => Get.to(
                            // () => ProjectEstimatedCostDetailsScreen()
                            // Zabir
                                  () =>
                                  NewProjectEstimatedCostDetailsScreen()),
                        ),
                        _buildFinancialCard(
                          "Allocation",
                          "${stringNullCheck(formatter.format(_wishListProjectDetailsController.wishListProjectDetailsResponse.value.totalAllocation))} Lakh",
                          "Current: ${stringNullCheck(formatter.format(_wishListProjectDetailsController.wishListProjectDetailsResponse.value.currentYearAllocation))}",
                          accentGreen,
                              () => Get.to(
                            // () => ProjectAllocationDetailsScreen()),

                            // Zabir
                              const NewProjectAllocationDetailsScreen()),
                        ),
                        _buildFinancialCard(
                          "Fund Release",
                          "${stringNullCheck(formatter.format(_wishListProjectDetailsController.calculateTotalFundReleaseSummary()))} Lakh",
                          "",
                          //"Current: ${stringNullCheck(formatter.format(_wishListProjectDetailsController.wishListProjectDetailsResponse.value.currentYearAllocation))}",
                          Colors.purple,
                              () => Get.to(() =>
                          const NewProjectFundReleaseSummeryDetailsScreen()),
                        ),

                        _buildFinancialCard(
                          "Expenditure",
                          "${stringNullCheck(formatter.format(_wishListProjectDetailsController.wishListProjectDetailsResponse.value.totalExpenditure))} Lakh",
                          "Current: ${stringNullCheck(formatter.format(_wishListProjectDetailsController.wishListProjectDetailsResponse.value.currentYearExpenditure))}",
                          Colors.orange,
                              () => Get.to(() =>
                          // ProjectExpenditureCostDetailsScreen()),

                          // Zabir
                          const NewProjectExpenditureCostDetailsScreen()),
                        ),

                        /*_buildFinancialCard(
                                "Progress",
                                "${_wishListProjectDetailsController.dataEntryProgressResponse.value.dataSubmissionProgressPercentage}%",
                                "Submitted to IMED",
                                Colors.purple,
                                () {},
                              ),*/
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Action Buttons
                    Row(
                      children: [

                        widget.allProjectsResponse!.projectTypeId.toString() == "ProjectType_TAPP" ? const SizedBox(height: 0, width: 0,) : Expanded(
                            child: _buildActionButton(
                              "Location".tr,
                              Icons.location_on,
                                  () => Get.to(() => ProjectLocationsScreen(
                                  allProjectsResponse:
                                  widget.allProjectsResponse)),
                            ),
                          ),




                        /*if (widget.allProjectsResponse!.projectTypeId.toString() == "ProjectType_TAPP") ...[
                          Expanded(
                            child: _buildActionButton(
                              "Location".tr,
                              Icons.location_on,
                                  () => Get.to(() => ProjectLocationsScreen(
                                  allProjectsResponse:
                                  widget.allProjectsResponse)),
                            ),
                          ),
                        ],*/



                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildActionButton(
                            "Inspection",
                            Icons.search,
                                () => Get.to(() => InspectionReportScreen(
                                allProjectsResponse:
                                widget.allProjectsResponse)),
                          ),
                        ),
                      ],
                    ),

                    /*if (widget.allProjectsResponse!.projectTypeId
                                  .toString() ==
                              "ProjectType_DPP") ...[
                            const SizedBox(height: 16),
                            _buildActionButton(
                              "Location".tr,
                              Icons.location_on,
                              () => Get.to(() => ProjectLocationsScreen(
                                  allProjectsResponse:
                                      widget.allProjectsResponse)),
                            ),
                          ],*/

                    if (widget.allProjectsResponse!.statusName
                        .toString() ==
                        "Closed") ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle,
                                color: Colors.green),
                            const SizedBox(width: 8),
                            Text(
                              "PCR Received",
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialCard(String title, String mainValue, String subValue,
      Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              mainValue,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subValue,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String title, IconData icon, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF4A90E2)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFF4A90E2), size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF4A90E2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
