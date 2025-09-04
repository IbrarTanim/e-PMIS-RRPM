import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/data/models/list_response.dart';
import 'package:pmis_flutter/data/models/ministry_list_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

class MinistryWiseController extends GetxController {
  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {
      // getAllMinistryListFromAllProjects(false);
      //Duration.zero
      // getItemList();
    });
  }

  List<String> getMinistryWiseList() {
    return [
      "Ministry of Foreign Affairs",
      "Ministry of Education",
      "Ministry of Land",
      "Ministry of Social Welfare",
      "Ministry of Home Affairs",
      "Ministry of Prime Minister's Office",
    ];
  }

  RxList<MinistryListResponse> ministryListResponse = <MinistryListResponse>[].obs;

  // RxString selectedValueForMinistry = "".obs;
  // RxInt selectedValueForMinistry = 0.obs;
  Rx<MinistryListResponse> selectedValueForMinistry = MinistryListResponse(value: "").obs;
  // RxString selectedValueForMinistryId = "".obs;

  Rx<ListResponse> listResponse = ListResponse().obs;
  RxList<AllProjectsResponse> allProjectsResponseList = <AllProjectsResponse>[].obs;

  List<int>? ministryWiseItemList =
      <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17].obs;

  bool isDataLoading = false;
  int loadedPage = 0;
  bool hasMoreData = true;
  bool isDataLoaded = false;
  bool isLoading = true;

  void clearView() {
    loadedPage = 0;
    hasMoreData = true;
    // ministryWiseItemList!.clear();
    allProjectsResponseList.clear();
    // selectedValueForMinistry.value = "";
    // selectedValueForMinistry.value = -1;
    selectedValueForMinistry.value = MinistryListResponse(value: "");
    // selectedValueForMinistryId.value = "";

  }

  // List<String> getMinistryNames() {
  //   return ministryListResponse.map((e) {
  //     return (stringNullCheck(e.text));
  //   }).toList();
  // }
  //
  // List<String> getMinistryId() {
  //   return ministryListResponse.map((e) {
  //     return (stringNullCheck(e.value));
  //   }).toList();
  // }

  /// *** Ministry dropdown List Data ***///
  void getMinistryDropDownList() {
    APIRepository().getMinistryDropDownList().then((resp) {
      if (resp.status == "success") {
        if (resp.data != null) {
          List<MinistryListResponse> list = List<MinistryListResponse>.from(
              resp.data!.map((x) => MinistryListResponse.fromJson(x)));
          // ministryListResponse.addAll(list);
          ministryListResponse.value = list;
          selectedValueForMinistry.value = selectedValueForMinistry.value;
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      ministryListResponse.clear();
      showToast(err.toString());
    });
  }

  /// *** Ministry List Data ***///
  void getAllMinistryListFromAllProjects(bool isFromLoadMore) {
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      allProjectsResponseList.clear();
      isLoading = false;
    }
    isLoading = true;
    //showLoadingDialog();
    var allItems = allProjectsResponseList.length;
    APIRepository().getProjectsListForMinistry(selectedValueForMinistry.value.value ?? "", loadedPage).then((resp) {
      hideLoadingDialog();
      isLoading = false;
      if (resp.status == "success") {
        // loadedPage++;
        // ListResponse response = ListResponse.fromJson(resp.data);
        listResponse.value = ListResponse.fromJson(resp.data);
        var response = listResponse.value;
        if (response.lists != null && response.lists!.isNotEmpty) {
          List<AllProjectsResponse> list = List<AllProjectsResponse>.from(
              response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
          allProjectsResponseList.addAll(list);
          listResponse.value.paginationDto =  listResponse.value.paginationDto;
        }
        loadedPage = response.paginationDto!.current ?? 0;
        hasMoreData = (allItems != response.paginationDto!.total);
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      isLoading = false;
      allProjectsResponseList.clear();
      showToast(err.toString());
    });
  }

// void getAllMinistryListFromAllProjects() {
//   var selectedMinistry = selectedValueForMinistry;
//   final ministry = ministryListResponse[selectedMinistry.value];
//   APIRepository().ministryWiseProjects(ministry.value ?? "").then((resp) {
//     if (resp.status == "success") {
//       ListResponse response = ListResponse.fromJson(resp.data);
//       if (response.lists != null) {
//         List<AllProjectsResponse> list = List<AllProjectsResponse>.from(
//             response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
//         allProjectsResponse.addAll(list);
//       }
//     } else {
//       showToast(resp.message, isError: true);
//     }
//   }, onError: (err) {
//     showToast(err.toString());
//     // allProjectsResponse.clear();
//   });
// }

// void getAllMinistryListFromAllProjects(bool isFromLoadMore) {
//   if (!isFromLoadMore) {
//     loadedPage = 0;
//     hasMoreData = true;
//     allProjectsResponse.clear();
//     isLoading = false;
//   }
//   isLoading = true;
//   loadedPage++;
//   var selectedMinistry = selectedValueForMinistry.value;
//   APIRepository().ministryWiseProjects(selectedMinistry,loadedPage).then((resp) {
//     isLoading = false;
//     if (resp.status == "success") {
//       ListResponse response = ListResponse.fromJson(resp.data.lists);
//       if (response.lists != null) {
//         List<AllProjectsResponse> list = List<AllProjectsResponse>.from(response.lists!.map((x) => AllProjectsResponse.fromJson(x)));
//         allProjectsResponse.addAll(list);
//       }
//       // totalProjects = response.paginationDto!.total.toString();
//       // allPages = response.paginationDto!.pageSize.toString() as int;
//       loadedPage = response.paginationDto!.current ?? 0;
//       hasMoreData = response.paginationDto!.current.toString() != null;
//     } else {
//       showToast(resp.message,isError: true);
//     }
//   }, onError: (err) {
//     isLoading = false;
//     showToast(err.toString());
//   });
// }

// void getRankingList() {
//   isDataLoading = true;
//   allProjectsResponse.clear();
//   var selectedMinistry = selectedValueForMinistry.value;
//   APIRepository().ministryWiseProjects(selectedMinistry).then((resp) {
//     isDataLoading = false;
//     if (resp == null) return;
//     if (resp.status == "success") {
//       if (resp.data != null) {
//
//         ListResponse response = ListResponse.fromJson(resp.data['lists']);
//         var list = resp.data[APIURLConst.queryGetRankingList] as List? ?? [];
//         List<Rank> items = List<Rank>.from(list.map((x) => Rank.fromJson(x)));
//         rankingList.addAll(items);
//       } else {
//         showToast(resp.message);
//       }
//     } else {
//       showToast(resp.message);
//     }
//   });
// }

// void ministryWiseProject() {
//   showLoadingDialog();
//   APIRepository().ministryWiseProjects()
//       .then((resp) {
//     hideLoadingDialog();
//     if (resp.status == "success") {
//       showToast(resp.message);
//     } else {
//       showToast(resp.message);
//     }
//   }, onError: (err) {
//     hideLoadingDialog();
//     showToast(err.toString());
//   });
// }

}
