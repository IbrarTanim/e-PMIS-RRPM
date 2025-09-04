import 'package:get/get.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

class SettingsController extends GetxController {
  RxString selectedLanguage = "".obs;
  RxString selectedTheme = "".obs;

  RxBool isDark = false.obs;

  List<String> getLanguageList() {
    return ["Bengali", "English"];
  }

  void saveLanguage() {
    if (selectedLanguage.value.isEmpty) {
      showToast("Please select a language".tr);
      return;
    }/* else if(selectedLanguage.value == getLanguageList['Bengali']) {
      String usdKey = languages!.keys.firstWhere(
          (k) => settingsData!.languages![k] == selectedLanguage.value,
          orElse: () => DefaultValue.languageKey);
    }

    showLoadingDialog();*/
  }
}
