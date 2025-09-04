import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/auth/sign_in_screen.dart';
import 'package:pmis_flutter/ui/features/landing/landing_screen.dart';
import 'package:pmis_flutter/ui/features/root/root_screen.dart';
import 'package:pmis_flutter/utils/network_util.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';

class SplashController extends GetxController {
  @override
  void onReady() async {
    super.onReady();
    // gUserAgent = await getUserAgent();
    NetworkCheck.isOnline().then((value) {
      if (value) {
        Future.delayed(const Duration(seconds: 3), () async {
          var loggedIn = GetStorage().read(PreferenceKey.isLoggedIn);
          var token = GetStorage().read(PreferenceKey.accessToken);

          if (loggedIn && token != null) {
            //var roleName = GetStorage().read(PreferenceKey.TagRoleName);

            /*if (roleName == PreferenceKey.TagMinistryOfficer) {
              Get.off(() => const RootScreen());
              debugPrint("Rokan role name Ministry Splash Value : $roleName");
              return;
            } else if (roleName == PreferenceKey.TagDivisionOfficer) {
              Get.off(() => const RootScreen());
              debugPrint("Rokan role name Ministry Splash Value : $roleName");
              return;
            } else if (roleName == PreferenceKey.TagAgencyOfficer) {
              Get.off(() => const RootScreen());
              debugPrint("Rokan role name Ministry Splash Value : $roleName");
              return;
            } else {
              Get.off(() => const LandinScreen());
              debugPrint("Rokan role name LandinScreen Splash Value : $roleName");
            }*/

            //Get.offAll(() => const RootScreen());

            // Validate token by making an API call
            try {
              await APIRepository().getUserInfo();
              Get.offAll(() => const LandinScreen());
            } catch (e) {
              // Token invalid/expired - clear storage and redirect to login
              GetStorage().remove(PreferenceKey.isLoggedIn);
              GetStorage().remove(PreferenceKey.accessToken);
              Get.off(() => const SignInScreen());
            }
          } else {
            Get.off(() => const SignInScreen());
          }
        });
      }
    });
  }
}
