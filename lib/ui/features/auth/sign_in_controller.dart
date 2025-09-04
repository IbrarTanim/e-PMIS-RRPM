import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/current_fiscal_year_and_development_type_response.dart';
import 'package:pmis_flutter/data/models/user_info_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/projects/projects_controller.dart';
import 'package:pmis_flutter/ui/features/landing/landing_screen.dart';
import 'package:pmis_flutter/ui/features/root/root_screen.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

class SignInController extends GetxController {
  TextEditingController emailEditController = TextEditingController();
  TextEditingController passEditController = TextEditingController();
  RxBool isShowPassword = false.obs;

  final _projectsController = Get.put(ProjectsController());

  void clearInputData() {
    emailEditController.text = "";
    passEditController.text = "";
    isShowPassword = false.obs;
  }

  void isInPutDataValid(BuildContext context) {
    if (emailEditController.text.trim().isNotEmpty &&
        passEditController.text.isNotEmpty) {
      if (!GetUtils.isEmail(emailEditController.text.trim())) {
        showToast("Please, Input a valid Email".tr, isError: true);
        return;
      }
      if (passEditController.text.length < DefaultValue.passwordLength) {
        showToast(
            "Password length must be"
                .trParams({"count": DefaultValue.passwordLength.toString()}),
            isError: true);
        return;
      }
      hideKeyboard(context);
      loginUser(context);
    } else {
      showToast("Fields can't be empty".tr, isError: true);
    }
  }

  Future<void> loginUser(BuildContext context) async {
    try {
      showLoadingDialog();
      final resp = await APIRepository().loginUser(
        emailEditController.text,
        passEditController.text,
      );

      if (resp.status == "success") {
        // Store tokens first
        GetStorage().write(PreferenceKey.accessToken,
            resp.data[APIConstants.kAccessToken] ?? "");
        GetStorage().write(PreferenceKey.refreshToken,
            resp.data[APIConstants.kRefreshToken] ?? "");

        // Now get required data
        await Future.wait(
            [getUserInfo(), getCurrentFiscalYearAndDevelopmentTypeData()]);

        // Mark as logged in and navigate only after all data is loaded
        GetStorage().write(PreferenceKey.isLoggedIn, true);
        DefaultValue.selectedBottomIndex = 1;

        showSuccessToast(resp.message);
        Get.offAll(() => const LandinScreen());
      } else {
        hideLoadingDialog();
        showToast("Please enter correct username and password".tr,
            isError: true);
      }
    } catch (err) {
      hideLoadingDialog();
      showToast("Please enter correct username and password".tr, isError: true);
    }
  }

  Rx<UserInfoResponse> userInfoData = UserInfoResponse().obs;

  Future<void> getUserInfo() async {
    try {
      final resp = await APIRepository().getUserInfo();
      if (resp.status == "success" && resp.data != null) {
        userInfoData.value = UserInfoResponse.fromJson(resp.data);

        //await _projectsController.getProjectsList(userInfoData.value.id.toString());

        GetStorage().write(PreferenceKey.currentUserId, userInfoData.value.id.toString());

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
           //_projectsController.getProjectsList(userInfoData.value.id.toString()); // rokan June


        });

      } else {
        showToast(resp.message, isError: true);
      }
    } catch (err) {
      rethrow;
    }
  }

  RxList<CurrentFiscalYearAndDevelopmentTypeResponse>
      currentFiscalYearAndDevelopmentTypeResponse =
      <CurrentFiscalYearAndDevelopmentTypeResponse>[].obs;

  Future<void> getCurrentFiscalYearAndDevelopmentTypeData() async {
    try {
      final resp =
          await APIRepository().getCurrentFiscalYearAndDevelopmentTypeData();
      if (resp.status == "success" && resp.data != null) {
        List<CurrentFiscalYearAndDevelopmentTypeResponse> list =
            List<CurrentFiscalYearAndDevelopmentTypeResponse>.from(resp.data!
                .map((x) =>
                    CurrentFiscalYearAndDevelopmentTypeResponse.fromJson(x)));
        currentFiscalYearAndDevelopmentTypeResponse.value = list;

        for (var element in currentFiscalYearAndDevelopmentTypeResponse.value) {
          GetStorage().write(PreferenceKey.fiscalYearId, element.fiscalYearId.toString());
          GetStorage().write(PreferenceKey.developmentPlanTypeId, element.developmentPlanTypeId.toString());
        }
      }
    } catch (err) {
      rethrow;
    }
  }
}
