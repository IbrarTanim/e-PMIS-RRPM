import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pmis_flutter/data/models/response.dart';
import 'package:pmis_flutter/ui/features/auth/sign_in_screen.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import '../../ui/features/root/root_screen.dart';
import '../local/constants.dart';
import 'api_repository.dart';

class APIProvider extends GetConnect {
  bool isRefreshing = false;

  @override
  void onInit() {
    allowAutoSignedCert = true;
    super.onInit();
    httpClient.baseUrl = APIConstants.baseUrl;
    httpClient.maxAuthRetries = 3;
    httpClient.timeout = const Duration(seconds: 45);
  }

  Future<ServerResponse> postRequest(
      String url, Map body, Map<String, String> headers) async {
    printFunction("postRequest body", body);
    printFunction("postRequest headers", headers);
    final response = await post(url, body, headers: headers);
    printFunction("postRequest url", response.request?.url);
    return handleResponse(response);
  }

  Future<ServerResponse> handleResponse(Response response) async {
    printFunction("handleResponse statusText", response.statusText);
    printFunction("handleResponse statusCode", response.statusCode);

    if (response.statusCode == 401) {
      // Check if we're on sign in screen to prevent loops
      if (!Get.currentRoute.contains("SignInScreen")) {
        // Clear all auth data
        GetStorage().remove(PreferenceKey.isLoggedIn);
        GetStorage().remove(PreferenceKey.accessToken);
        GetStorage().remove(PreferenceKey.refreshToken);

        // Navigate to sign in and prevent going back
        Get.offAll(() => const SignInScreen());

        return Future.error("Session expired. Please login again.".tr);
      }
    }

    if (response.status.hasError) {
      if (response.status.connectionError) {
        return Future.error(
            "Please verify your internet connection and try again".tr);
      }
      return Future.error(response.statusText ?? "An error occurred".tr);
    } else {
      printFunction("handleResponse body", response.body);
      return ServerResponse.fromJson(response.body);
    }
  }

  Future<ServerResponse> getRequest(String url, Map<String, String> headers,
      {Map<String, dynamic>? query}) async {
    GetUtils.printFunction("getRequest query", query, "");
    GetUtils.printFunction("getRequest headers", headers, "");
    final response = await get(url, headers: headers, query: query);
    GetUtils.printFunction("getRequest url ", response.request?.url, "");
    return handleResponse(response);
  }

  Future<ServerResponse> postRequestFormData(String url,
      Map<String, dynamic> body, Map<String, String> headers) async {
    final response = await post(url, FormData(body), headers: headers);
    GetUtils.printFunction("uploadFile", response.request?.url, "url");
    GetUtils.printFunction("uploadFile", body, "body");
    GetUtils.printFunction("uploadFile", headers, "headers");
    return handleResponse(response);
  }

  Future<ServerResponse> getReNewToken() async {
    return getRequest(APIConstants.reNewTokenUrl, authHeaderForReNewToken());
  }

  Map<String, String> authHeaderForReNewToken() {
    String? token = GetStorage().read(PreferenceKey.accessToken);
    String? refreshToken = GetStorage().read(PreferenceKey.refreshToken);
    var mapObj = <String, String>{};
    mapObj[APIConstants.kAccept] = APIConstants.vAccept;
    if (token != null && token.isNotEmpty) {
      mapObj[APIConstants.kAuthorization] = "${APIConstants.vBearer} $token";
      print("\n<<<token value >>>: $token\n");
      // mapObj[APIConstants.kAuthorization] = "token";
    }
    if (refreshToken != null && refreshToken.isNotEmpty) {
      mapObj[APIConstants.kRefreshToken] =
          "${APIConstants.vBearer} $refreshToken";
      print("\n<<<refreshToken value >>>: $refreshToken\n");

      // mapObj[APIConstants.kAuthorization] = "token";
    }
    //GetUtils.printFunction("authHeader", mapObj[APIConstants.kAuthorization], "kAuthorization");
    return mapObj;
  }

// Future<ServerResponse> handleResponse(Response response) async {
//   printFunction("handleResponse statusText", response.statusText);
//   printFunction("handleResponse statusCode", response.statusCode);
//   if (response.statusCode == 401) {
//     APIRepository().getReNewToken().then((resp) {
//       hideLoadingDialog();
//       if (resp.status == "success") {
//         GetStorage().write(PreferenceKey.accessToken, resp.data[APIConstants.kAccessToken] ?? "");
//         GetStorage().write(PreferenceKey.refreshToken, resp.data[APIConstants.kAccessToken] ?? "");
//         showToast(resp.message);
//         handleLoginSuccess(resp);
//       } else {
//         showToast(resp.message, isError: true);
//       }
//     }, onError: (err) {
//       showToast(err.toString());
//     });
//     // clearStorage();
//     // Get.back();
//     // Get.off(() => const SignInScreen());
//     // return Future.error(response.statusText as String);
//   }
//
//   if (response.status.hasError) {
//     if (response.status.connectionError) {
//       return Future.error(
//           "Please verify your internet connection and try again".tr);
//     }
//     return Future.error(response.statusText as String);
//   } else {
//     printFunction("handleResponse body", response.body);
//     return ServerResponse.fromJson(response.body);
//   }
// }
//
//
//
// void handleLoginSuccess(dynamic resp) {
//   // var userMap = resp.data[APIConstants.kUser];
//   // GetStorage().write(PreferenceKey.userObject, userMap);
//   GetStorage().write(PreferenceKey.isLoggedIn, true);
//   // Future.delayed(const Duration(milliseconds: 500), () {
//   //   Get.off(() => const RootScreen());
//   // });
// }
}
