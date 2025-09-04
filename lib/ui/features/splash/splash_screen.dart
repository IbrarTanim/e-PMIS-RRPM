import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';
import 'splash_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void dispose() {
  //   hideKeyboard(context);
  //   super.dispose();
  // }
  // @override
  // void initState() {
  //   super.initState();
  //   hideKeyboard(context);
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //
  //   });
  // }

  // Zabir

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (splashController) {
            return Stack(
              children: [
                // Background gradient
                Container(
                  decoration: const BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        accentBlue,
                        accentGreen,
                      ],
                      center: Alignment.center,
                      radius: 1.5,
                    ),
                  ),
                ),

                // Floating circles
                Positioned(
                  left: -50,
                  top: -100,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(),
                    ),
                  ),
                ),

                Positioned(
                  right: -50,
                  bottom: -100,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                      child: Container(),
                    ),
                  ),
                ),

                // Decorative lines
                ...List.generate(8, (index) {
                  return Positioned(
                    left: (index * 50).toDouble() - 175,
                    top: 0,
                    bottom: 0,
                    child: Transform.rotate(
                      angle: 45 * 3.14159 / 180,
                      child: Container(
                        width: 1,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  );
                }),

                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      showImageAsset(
                        imagePath: AssetConstants.appLogo,
                        height: 160,
                        width: 160,
                      ),

                      const SizedBox(height: 30),

                      // Text content
                      Column(
                        children: [
                          Text(
                            "App_name_short".tr,
                            style: TextStyle(
                              fontSize: 46,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 2),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            "App_name".tr,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    if (!hasInternet) {
      showTopSnackBar(
          context,
          "Please Check Internet Connection and Run the App Again".tr,
          Colors.red);
    }
  }
}
