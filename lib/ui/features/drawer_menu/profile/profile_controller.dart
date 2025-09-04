import 'package:get/get.dart';

import '../../../../data/models/user_office_historyList_item_response.dart';
import '../../../../data/remote/api_repository.dart';
import '../../../../utils/common_utils.dart';

class ProfileController extends GetxController {
  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }

  Rx<UserOfficeHistoryListItemResponse> userOfficeHistoryListItemInfo = UserOfficeHistoryListItemResponse().obs;

  // RxList<UserOfficeHistoryListItemResponse> userOfficeHistoryListInfo = <UserOfficeHistoryListItemResponse>[].obs;

  /// *** User Office Data ***///
  void getUserOfficeHistoryInfo(String? userId) {
    showLoadingDialog(isDismissible: true);
    APIRepository().getUserOfficeHistoryInfo(userId ?? "").then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          // userOfficeHistoryInfo.value = UserOfficeHistoryListItemResponse.fromJson(resp.data);

          List<UserOfficeHistoryListItemResponse> list = List<UserOfficeHistoryListItemResponse>.from(resp.data!.map((x) => UserOfficeHistoryListItemResponse.fromJson(x)));

          userOfficeHistoryListItemInfo.value = list.first;
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }
}
