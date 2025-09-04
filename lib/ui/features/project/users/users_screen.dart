import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/all_projects_list_response.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/pending_task/pending_task_controller.dart';
import 'package:pmis_flutter/ui/features/project/users/user_list_item_view.dart';
import 'package:pmis_flutter/ui/features/project/users/users_controller.dart';
import 'package:pmis_flutter/ui/features/search/my_project_search/search_screen.dart';
import 'package:pmis_flutter/ui/features/root/root_controller.dart';
import 'package:pmis_flutter/utils/appbar_util.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:pmis_flutter/utils/spacers.dart';
import 'package:pmis_flutter/utils/text_util.dart';

class UsersScreen extends StatefulWidget {
  final AllProjectsResponse? allProjectsResponse;

  const UsersScreen({Key? key, this.allProjectsResponse}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<UsersScreen> {
  final _usersController = Get.put(UsersController());
  final _rootController = Get.put(RootController());

  bool isLoading = true;

  void initCalls() async {
    await _usersController
        .getUsersList(widget.allProjectsResponse!.projectId.toString());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    initCalls();
    super.initState();
  }

  @override
  void dispose() {
    _usersController.clearView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: appBarWithBackAndActions(title: "Users", onPress: (index) {}),
      body: SafeArea(
        child: Column(
          children: [
            const VSpacer10(),
            Obx(() {
              //return _usersController.userListResponseListForLength.isEmpty
              return _usersController.projectUserListResponse.isEmpty
                  ? const SizedBox(width: 0, height: 0)
                  : textSpanAutoSize(
                      title:
                          "Total Users : ${stringNullCheck(_usersController.projectUserListResponse.length.toString())}",
                      colorTitle: black);
            }),
            const VSpacer10(),
            Expanded(
              child: Obx(() {
                return _usersController.projectUserListResponse.isEmpty
                    ? showEmptyView()
                    : _usersItemList(context);
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _usersItemList(BuildContext context) {
    return Obx(() {
      return _usersController.projectUserListResponse.value.isEmpty
          ? handleEmptyViewWithLoading(_usersController.isDataLoaded)
          : SizedBox(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: _usersController.projectUserListResponse.length,
                itemBuilder: (BuildContext context, int index) {
                  // return userListItemView(context, _usersController.projectUserListResponse[index] );
                  // Zabir
                  return NewUserListItemView(
                      context, _usersController.projectUserListResponse[index]);
                },
              ),
            );

      /*SizedBox(
              child: ListView.builder(
                //physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: _usersController.projectUserListResponse.length,
                itemBuilder: (BuildContext context, int index) {
                  if (_usersController.projectUserListResponse.length ==
                      _usersController.listResponse.value.paginationDto!.total) {
                    //showToast('No more Data');
                  }
                  if (_usersController.hasMoreData && index == (_usersController.userListResponse.length - 1)) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      _usersController.getUsersList(true);
                    });
                  }
                  return userListItemView(context, _usersController.projectUserListResponse[index] );
                },
              ),
            );*/
    });
  }
}
