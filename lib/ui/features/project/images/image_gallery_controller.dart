import 'package:get/get.dart';
import '../../../../data/models/files_evidence_response_list.dart';
import '../../../../data/models/list_response.dart';
import '../../../../data/remote/api_repository.dart';
import '../../../../utils/common_utils.dart';

class ImageGalleryController extends GetxController {
/*
  final List<PhotoItem> photoItems = [
    PhotoItem(
        "https://images.pexels.com/photos/1772973/pexels-photo-1772973.png?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Stephan Seeber"),
    PhotoItem(
        "https://images.pexels.com/photos/1758531/pexels-photo-1758531.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Liam Gant"),
    PhotoItem(
        "https://images.pexels.com/photos/1130847/pexels-photo-1130847.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Stephan Seeber"),
    PhotoItem(
        "https://images.pexels.com/photos/45900/landscape-scotland-isle-of-skye-old-man-of-storr-45900.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Pixabay"),
    PhotoItem(
        "https://images.pexels.com/photos/165779/pexels-photo-165779.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Scott Webb"),
    PhotoItem(
        "https://images.pexels.com/photos/548264/pexels-photo-548264.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Krivec Ales"),
    PhotoItem(
        "https://images.pexels.com/photos/188973/matterhorn-alpine-zermatt-mountains-188973.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Pixabay"),
    PhotoItem(
        "https://images.pexels.com/photos/795188/pexels-photo-795188.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Melanie Wupper"),
    PhotoItem(
        "https://images.pexels.com/photos/5222/snow-mountains-forest-winter.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Jaymantri"),
    PhotoItem(
        "https://images.pexels.com/photos/789381/pexels-photo-789381.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Riciardus"),
    PhotoItem(
        "https://images.pexels.com/photos/326119/pexels-photo-326119.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Pixabay"),
    PhotoItem(
        "https://images.pexels.com/photos/707344/pexels-photo-707344.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Eberhard"),
    PhotoItem(
        "https://images.pexels.com/photos/691034/pexels-photo-691034.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Mirsad Mujanovic"),
    PhotoItem(
        "https://images.pexels.com/photos/655676/pexels-photo-655676.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Vittorio Staffolani"),
    PhotoItem(
        "https://images.pexels.com/photos/592941/pexels-photo-592941.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Tobi"),
  ].obs;*/

  Rx<ListResponse> listResponse = ListResponse().obs;
  RxList<FilesEvidenceResponseList> filesEvidenceResponseList =
      <FilesEvidenceResponseList>[].obs;

  bool isDataLoaded = false;

  int loadedPage = 0;
  bool hasMoreData = true;
  bool isLoading = true;

  void clearView() {
    loadedPage = 0;
    hasMoreData = true;
    filesEvidenceResponseList.clear();
  }

  /// *** Files Evidence Image List Data ***///
  Future<void> getFilesEvidenceListForImageView(String projectId, bool isFromLoadMore) async{
    if (!isFromLoadMore) {
      loadedPage = 0;
      hasMoreData = true;
      filesEvidenceResponseList.clear();
      isLoading = false;
    }
    isLoading = true;
    //showLoadingDialog();
    var allItems = filesEvidenceResponseList.length;
    await APIRepository()
        .getFilesEvidenceListForImageView(projectId, loadedPage)
        .then((resp) {
      isLoading = false;
      hideLoadingDialog();
      if (resp.status == "success") {
        // loadedPage++;
        // ListResponse response = ListResponse.fromJson(resp.data);
        listResponse.value = ListResponse.fromJson(resp.data);
        var response = listResponse.value;
        if (response.lists != null && response.lists!.isNotEmpty) {
          List<FilesEvidenceResponseList> list =
              List<FilesEvidenceResponseList>.from(response.lists!
                  .map((x) => FilesEvidenceResponseList.fromJson(x)));
          filesEvidenceResponseList.addAll(list);
          listResponse.value.paginationDto = listResponse.value.paginationDto;
        }
        loadedPage = response.paginationDto!.current ?? 0;
        hasMoreData = (allItems != response.paginationDto!.total);
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      isLoading = false;
      filesEvidenceResponseList.clear();
      showToast(err.toString());
    });
  }

  //
  // Rx<UserInfoResponse> userInfo = UserInfoResponse().obs;
}
