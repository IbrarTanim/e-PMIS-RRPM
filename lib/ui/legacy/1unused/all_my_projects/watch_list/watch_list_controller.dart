import 'package:get/get.dart';

class WatchListController extends GetxController {

  List<int>? watchItemList = <int>[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17].obs;
  // RxList<ProjectList> searchedItemList = <ProjectList>[].obs;


  int loadedPage = 0;
  bool hasMoreData = true;

  bool isDataLoaded = false;

  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {//Duration.zero
      // getItemList();
    });

  }
  void clearView(){
    loadedPage = 0;
    hasMoreData = true;
    watchItemList!.clear();
  }


}
