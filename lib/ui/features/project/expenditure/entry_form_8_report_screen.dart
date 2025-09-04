import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/ui/features/project/project_details_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/data/models/project_expenditure_cost_response.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/ui/features/project/expenditure/report_info.dart';

class NewEntryForm8ReportScreen extends StatefulWidget {
  final ProjectExpenditureCostResponse? projectExpenditureCostResponse;
  final bool isMyProject = false;

  const NewEntryForm8ReportScreen(
      {Key? key, this.projectExpenditureCostResponse})
      : super(key: key);

  @override
  _EntryForm8ReportScreenState createState() => _EntryForm8ReportScreenState();
}

class _EntryForm8ReportScreenState extends State<NewEntryForm8ReportScreen> {
  final _wishListProjectDetailsController =
      Get.put(WishListProjectDetailsController());

  void initCalls() async {
    await _wishListProjectDetailsController.getEntryForm8ReportData(widget
        .projectExpenditureCostResponse!.projectExpenditureSummaryId
        .toString());

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBarWithBackAndActions(title: "Economic Codewise Expenditure", onPress: (index) {}),
      body: SafeArea(
        child: Obx(() {
          final response =
              _wishListProjectDetailsController.entryForm8ListResponse.value;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: response.econCodeTypeDetail
                      ?.map((detail) => EntryForm8ReportInfo(
                            econCodeDetail: detail,
                          ))
                      .toList() ??
                  [],
            ),
          );
        }),
      ),
    );
  }
}
