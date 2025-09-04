import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/user_info_response.dart';
import 'package:pmis_flutter/data/models/user_office_historyList_item_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/projects/projects_controller.dart';
import '../../../utils/common_utils.dart';

class RootController extends GetxController {
  @override
  void onInit() async {
    super.onInit();

/*    /// Update check with the NewVersionPlus package
    final newVersionPlus = NewVersionPlus(iOSId: "com.dohatec.pmis_flutter",
        androidId: "com.dohatec.pmis_flutter");
    newVersionPlus.showAlertIfNecessary(context: Get.context!);
    final versionStatus = await newVersionPlus.getVersionStatus();
    if (versionStatus != null) {
      newVersionPlus.showUpdateDialog(
        context: Get.context!,
        versionStatus: versionStatus,
        dialogTitle: 'Update Available',
        dialogText: 'Update the app to continue',
        updateButtonText: 'Update',
        dismissButtonText: 'Cancel',
        allowDismissal: true,
        dismissAction: () => (){},
      );
    }*/
  }

  var selectedIndex = 1.obs;
  var selectedDrawerItem = 0.obs;

  // void onItemTapped(int index) {
  //   selectedIndex.value = index;
  // }

  /*@override
  void onReady() {
    super.onReady();
    // var userMap = GetStorage().read(PreferenceKey.userObject) as Map<String, dynamic>?;
    // if (userMap != null) {
    //   var user = User.fromJson(userMap);
    //   if (user.walletAddress != null && user.walletAddress!.isNotEmpty) {
    //     gUserRx.value = user;
    //   }
    // }

    // var settingsData = GetStorage().read(PreferenceKey.settingsData) as List?;
    // if (settingsData != null) {
    //   gSettingsData = List<SettingsData>.from(settingsData.map((x) => SettingsData.fromJson(x)));
    // }

    Future.delayed(const Duration(seconds: 5), () {
      //getSettings();
    });
  }*/

  @override
  void onReady() {
    super.onReady();

    bool fromLanding = GetStorage().read('fromLanding') ?? false;

    if (fromLanding) {
      selectedIndex.value = 1; // Assuming Project Tab is index 2

      // Force trigger project data fetch
      Future.delayed(Duration(milliseconds: 300), () {
        try {

          final _controller = Get.put(ProjectsController());

          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            //_controller.getProjectsList(userInfo.value.id.toString()); // rokan June
          });
           //_controller.getProjectsList(userInfo.value.id.toString());

        } catch (e) {
          debugPrint("MyProjectController not found: $e");
        }
        GetStorage().remove('fromLanding');
      });
    }
  }







  Rx<UserInfoResponse> userInfo = UserInfoResponse().obs;

  /// *** User Data ***///
  void getUserInfo() {
    showLoadingDialog(isDismissible: true);
    APIRepository().getUserInfo().then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          userInfo.value = UserInfoResponse.fromJson(resp.data);
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  void logOut() {
    showLoadingDialog();
    // APIRepository().logoutUser().then((resp) {
    //   hideLoadingDialog();
    //   showToast(resp.message);
    //   if (resp.success) {
    //     GetStorage().erase();
    //     Get.off(() => const SignInScreen());
    //   }
    // }, onError: (err) {
    //   hideLoadingDialog();
    //   if (err.toString() == ErrorConstants.unauthorized){
    //     GetStorage().erase();
    //     Get.off(() => const SignInScreen());
    //   }else {
    //     showToast(err.toString());
    //   }
    // });
  }
}
