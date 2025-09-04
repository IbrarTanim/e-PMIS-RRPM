import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/ui/features/root/root_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/decorations.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import '../../../../utils/common_utils.dart';
import '../../../../utils/text_util.dart';
import 'about_app_controller.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({Key? key}) : super(key: key);

  @override
  _AboutAppScreenState createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  final _controller = Get.put(AboutAppController());
  final _rootController = Get.put(RootController());

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
      appBar: appBarWithBack(title: "AboutApp".tr),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              // flex: 10,
              child: Column(
                children: [
                  Container(
                    height: Platform.isAndroid
                        ? getContentHeight() - 117
                        : getContentHeight() - 177,
                    decoration: boxDecorationRoundShadowLight(),
                    padding: const EdgeInsets.all(dp16),
                    margin: const EdgeInsets.all(dp20),
                    child: SingleChildScrollView(
                        child: Scrollbar(
                      child: Column(
                        children: [
                          textAutoSize(
                              /*text: "AboutAppText".tr,*/
                              text: "",
                              maxLines: 500,
                              color: Get.theme.disabledColor,
                              textAlign: TextAlign.justify),
                        ],
                      ),
                    )),
                  ),
                ],
              ),
            ),
            Container(
              alignment: FractionalOffset.bottomCenter,
              child: Column(
                children: [
                  const VSpacer10(),
                  textAutoSize(
                      /*text: "AppCopyRightText".tr,*/
                      text: "",
                      alignment: Alignment.center,
                      textAlign: TextAlign.center,
                      maxLines: 10,
                      fontSize: 12),
                  const VSpacer10(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
