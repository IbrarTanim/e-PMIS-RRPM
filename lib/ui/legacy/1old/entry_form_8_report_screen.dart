// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
// import 'package:pmis_flutter/ui/features/project_details/project_details_by_id_controller.dart';
// import 'package:pmis_flutter/ui/features/side_nav/projects/wishList_project_details_controller.dart';
// import 'package:pmis_flutter/utils/appbar_util.dart';
// import 'package:pmis_flutter/utils/common_utils.dart';
// import 'package:pmis_flutter/utils/common_widget.dart';
// import 'package:pmis_flutter/utils/decorations.dart';
// import 'package:pmis_flutter/utils/dimens.dart';
// import 'package:pmis_flutter/utils/text_util.dart';

// import '../../../../data/models/project_expenditure_cost_response.dart';

// class EntryForm8ReportScreen extends StatefulWidget {
//   final ProjectExpenditureCostResponse? projectExpenditureCostResponse;

//   final bool isMyProject = false;

//   const EntryForm8ReportScreen({Key? key, this.projectExpenditureCostResponse})
//       : super(key: key);

//   @override
//   _EntryForm8ReportScreenState createState() => _EntryForm8ReportScreenState();
// }

// class _EntryForm8ReportScreenState extends State<EntryForm8ReportScreen> {
//   final _wishListProjectDetailsController = Get.put(WishListProjectDetailsController());


//   void initCalls() async {

//     await _wishListProjectDetailsController.getEntryForm8ReportData(widget.projectExpenditureCostResponse!.projectExpenditureSummaryId.toString());

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       setState(() {});
//     });
//   }



//   @override
//   void initState() {

//     initCalls();
//     super.initState();

//   }

//   @override
//   void dispose() {
//     // _controller.clearView();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: context.theme.colorScheme.surface,
//       appBar: appBarWithBackAndActions(
//           title: "Progress",
//           onPress: (index) {
//             //do active icon job
//           }),
//       body: SafeArea(

//         child: Container(
//           child: Column(
//             children: [

//               Expanded(
//                 child: SizedBox(
//                   child: ListView.builder(
//                     //padding: EdgeInsets.zero,
//                     scrollDirection: Axis.vertical,

//                     itemCount: _wishListProjectDetailsController.entryForm8ListResponse.value.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return entryForm8ItemView(context,_wishListProjectDetailsController.entryForm8ListResponse[index]);
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),



//       ),
//     );
//   }
// }
