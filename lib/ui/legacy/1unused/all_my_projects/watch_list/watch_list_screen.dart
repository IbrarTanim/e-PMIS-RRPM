import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';

import 'watch_list_controller.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  _WatchListScreenState createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  final _controller = Get.put(WatchListController());

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     _controller.getData();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      appBar: appBarWithBack(title: "WatchList".tr),
      body: SafeArea(
        child: Column(
          children: [
            const VSpacer10(),
            textSpanAutoSize(
                title: "TotalProjects".tr,
                subTitle: "9",
                colorTitle: Get.theme.primaryColor),
            const VSpacer10(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _controller.getData,
                child: _watchItemList()
                // SingleChildScrollView(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       const VSpacer20(),
                //       SingleChildScrollView(
                //           padding: const EdgeInsets.symmetric(horizontal: 15.0),
                //           child: _watchItemList()
                //       ),
                //       const VSpacer10(),
                //     ],
                //   ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _watchItemList() {
    return Obx(() {
      // String message = "empty_message".tr;
      return _controller.watchItemList!.isEmpty
          ? handleEmptyViewWithLoading(_controller.isDataLoaded)
          : ListView.builder(
            ////physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: _controller.watchItemList!.length,
            itemBuilder: (BuildContext context, int index) {
              // return demoListItemView(_controller.searchedItemList![index]);
              // return demoListItemView(isFavorite: false);
              return Container();
            },
          );
    });
  }

}
