import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:pmis_flutter/data/db/models/asset_collection.dart';
import 'package:pmis_flutter/data/models/response.dart';
import 'package:pmis_flutter/data/models/workflow_actions_list_response.dart';
import 'package:pmis_flutter/data/models/workflow_activity_history_response.dart';
import 'package:pmis_flutter/data/models/workflow_allocation_distribution_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_allocation_response.dart';
import 'package:pmis_flutter/data/models/workflow_allocation_return_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_demand_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_expenditure_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_finance_sources_response.dart';
import 'package:pmis_flutter/data/models/workflow_fund_distribution_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_fund_release_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_node_data_response.dart';
import 'package:pmis_flutter/data/models/workflow_reappropriation_details_response.dart';
import 'package:pmis_flutter/data/models/workflow_roles_data_response.dart';
import 'package:pmis_flutter/data/remote/api_repository.dart';
import 'package:pmis_flutter/ui/features/root/root_screen.dart';
import 'package:pmis_flutter/utils/alert_util.dart';
import 'package:pmis_flutter/utils/common_utils.dart';

import '../../../../data/models/upload_file_response.dart';

class WorkFlowDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  final tabSelectedIndex = 0.obs;
  bool isDataLoaded = false;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 3);
    super.onInit();
  }

  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }

  void clearInputData() {
    dateTextEditController.text = "";
    remarksEditController.text = "";
    imageShootingTime = "";
  }

  Rx<WorkflowNodeDataResponse> workflowNodeDataResponseValue =
      WorkflowNodeDataResponse().obs;
  Rx<WorkflowActivityHistoryResponse> workflowActivityHistoryResponse =
      WorkflowActivityHistoryResponse().obs;
  Rx<WorkflowAllocationResponse> workflowAllocationResponse =
      WorkflowAllocationResponse().obs;
  Rx<WorkflowDetailsResponse> workflowDetailsResponse =
      WorkflowDetailsResponse().obs;
  Rx<WorkflowFinanceSourcesResponse> workflowFinanceSourcesResponse =
      WorkflowFinanceSourcesResponse().obs;
  Rx<WorkflowExpenditureDetailsResponse> workflowExpenditureDetailsResponse =
      WorkflowExpenditureDetailsResponse().obs;
  Rx<WorkflowDemandDetailsResponse> workflowDemandDetailsResponse =
      WorkflowDemandDetailsResponse().obs;

  Rx<WorkflowFundDistributionDetailsResponse>
      workflowFundDistributionDetailsResponse =
      WorkflowFundDistributionDetailsResponse().obs;
  Rx<WorkflowAllocationDistributionDetailsResponse>
      workflowAllocationDistributionDetailsResponse =
      WorkflowAllocationDistributionDetailsResponse().obs;
  Rx<WorkflowFundReleaseDetailsResponse> workflowFundReleaseDetailsResponse =
      WorkflowFundReleaseDetailsResponse().obs;
  Rx<WorkflowAllocationReturnDetailsResponse>
      workflowAllocationReturnDetailsResponse =
      WorkflowAllocationReturnDetailsResponse().obs;
  //Rx<WorkflowReappropriationDetailsResponse> workflowReappropriationDetailsResponse = WorkflowReappropriationDetailsResponse().obs;
  RxList<WorkflowReappropriationDetailsResponse>
      workflowReappropriationDetailsResponse =
      <WorkflowReappropriationDetailsResponse>[].obs;

  TextEditingController dateTextEditController = TextEditingController();
  TextEditingController remarksEditController = TextEditingController();

  Rx<String> workflowRoleId = "".obs;
  //Rx<String> workflowParentFinancialSourceName = "".obs;

  /*Rx<String> workflowReturnId = "".obs;
  Rx<String> workflowForwardId = "".obs;*/

  Rx<String> workflowReturnId = "-1".obs;
  Rx<String> workflowForwardId = "-1".obs;

  String? imageShootingTime;
  String? workflowParentFinancialSourceName;
  String? developmentTypeName;
  String? parentFinancialSourceName;

  void clearView() {}

  Rx<UploadFileResponse> uploadFileResponse = UploadFileResponse().obs;

  Future<void> uploadWorkFlowImageFile(
      {BuildContext? context,
      File? imageFile,
      required String remarks,
      required String workflowId,
      required String workflowActionId}) async {
    ServerResponse? fileUploadResponse;
    String? fileId;
    String? fileName;
    String? fileSize;

    if (imageFile != null) {
      fileUploadResponse = await APIRepository().workFlowUploadFile(imageFile);
      try {
        if (fileUploadResponse.status == "success") {
          List<UploadFileResponse> list = List<UploadFileResponse>.from(
              fileUploadResponse.data!
                  .map((x) => UploadFileResponse.fromJson(x)));
          uploadFileResponse.value = list.first;

          fileId = uploadFileResponse.value.fileId.toString();
          fileName = uploadFileResponse.value.fileName.toString();
          fileSize = uploadFileResponse.value.fileSize.toString();
        }
      } catch (err) {}
    }
    await workFlowEvidenceFileSync(
        remarks, fileId, fileName, fileSize, workflowId, workflowActionId);
  }

  String? successUploadMessage;

  addSynchronized() async {
    Hive.box<AssetCollection>('image').add(
      AssetCollection(isImageSynchronized: true),
    );
    Get.back();
  }

  Future<void> workFlowEvidenceFileSync(
      String comment,
      String? fileId,
      String? fileName,
      String? fileSize,
      String workflowId,
      String workflowActionId) async {
    showLoadingDialog();

    try {
      var resp = await APIRepository().workFlowFileAttachment(
          comment, fileId, fileName, fileSize, workflowId, workflowActionId);
      if (resp.status == "success") {
        //showToast(resp.message);
        successUploadMessage = resp.message;
      } else {
        //showToast(resp.message);
      }
      hideLoadingDialog();
    } catch (err) {
      hideLoadingDialog();
      //showToast("Forwarded file can't be returned!!");
    }
  }

  RxList<WorkflowActionsListResponse> workflowActionsListResponse =
      <WorkflowActionsListResponse>[].obs;
  RxList<WorkflowRolesDataResponse> workflowRolesDataResponse =
      <WorkflowRolesDataResponse>[].obs;

  void getWorkflowRolesData() {
    APIRepository().getWorkflowRoles().then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          /* workflowActionsValue.value = WorkflowActionsListResponse.fromJson(resp.data);
           debugPrint("Rokan workflow Actions Value: ${workflowActionsValue.value.actionType.toString()}");*/

          List<dynamic> data = resp.data;
          for (var element in data) {
            final event = WorkflowRolesDataResponse.fromJson(element);
            workflowRolesDataResponse.add(event);
            if (event.name == 'Initiator') {
              //getWorkflowActionsData("1");
              getWorkflowActionsData(event.id.toString());
            } else if (event.name == 'Approver') {
              getWorkflowActionsData(event.id.toString());
            } else {
              getWorkflowActionsData(event.id.toString());
            }

            /*if (event.id == '1') {
               getWorkflowActionsData(event.id.toString());

               workflowRolesDataResponse.add(event);
               debugPrint("Rokan workflow Roles Value: ${workflowRolesDataResponse.value.toString()}");
             }*/
          }
        }
      } else {
        // showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      // pdInfoListResponse.clear();
      //showToast(err.toString());
    });
  }

  void getWorkflowActionsData(String workflowRoleId) {
    APIRepository().getWorkflowActions(workflowRoleId).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          List<dynamic> data = resp.data;
          for (var element in data) {
            final event = WorkflowActionsListResponse.fromJson(element);

            /*String? workflowForwardId;
            String? workflowReturnId;*/
            //workflowActionsListResponse.add(event);

            if (event.id == "2") {
              workflowForwardId.value = "2";
            } else if (event.id == "3") {
              workflowReturnId.value = "3";
            } else if (event.id == "1") {
              workflowForwardId.value = "1";
            }
          }
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      // pdInfoListResponse.clear();
      // showToast(err.toString());
    });
  }

  void getWorkflowNodeData(String? workflowId) {
    //showLoadingDialog(isDismissible: true);
    APIRepository().getWorkflowNodeData(workflowId ?? "").then((resp) {
      //hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          workflowNodeDataResponseValue.value =
              WorkflowNodeDataResponse.fromJson(resp.data);
          for (WorkflowNode node
              in workflowNodeDataResponseValue.value.workflowNode!) {
            if (node.fileOnHand!) {
              workflowRoleId.value = node.workflowRoleId!;
              getWorkflowActionsData(workflowRoleId.value);
              return;
            }
          }

          //workflowRoleId = workflowNodeDataResponseValue.value.workflowRoleId.toString();

          //debugPrint("Rokann Data Test: ${workflowNodeDataResponseValue.value.workflowRoleId.toString()}");
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      //hideLoadingDialog();
      //showToast(err.toString());
    });
  }

  void getWorkflowActivityHistoryData(String? workflowId) {
    APIRepository().getWorkflowActivityHistoryData(workflowId ?? "").then(
        (resp) {
      //hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          workflowActivityHistoryResponse.value =
              WorkflowActivityHistoryResponse.fromJson(resp.data);
          for (WorkflowActivity activityHistory
              in workflowActivityHistoryResponse.value.workflowActivities!) {}
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      //hideLoadingDialog();
      //showToast(err.toString());
    });
  }

  void getWorkflowDetails(String? workflowType, String? associatedId) {
    APIRepository()
        .getWorkflowDetailsData(workflowType ?? "", associatedId ?? "")
        .then((resp) {
      if (resp.status == "success") {
        if (resp.data != null) {
          //debugPrint("Rokann sponse Test: ${resp.data.toString()}");

          workflowDetailsResponse.value =
              WorkflowDetailsResponse.fromJson(resp.data[0]);
          //debugPrint("Rokann sponse Test: ${workflowDetailsResponse.value.toJson().toString()}");

          /* List<dynamic> data = resp.data;
          for (var element in data) {
            final event = WorkflowDetailsResponse.fromJson(element);
            List<Detail>? details = event.details;
          }*/

          /*for (Detail detail in workflowDetailsResponse.value.details!) {

          }*/
          //debugPrint("Rokann workflowDetailsResponse Test: ${workflowDetailsResponse.value.workflowId.toString()}");
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      //hideLoadingDialog();
      //showToast(err.toString());
    });
  }

  void getWorkflowFinanceSourcesData(String? workflowId) {
    APIRepository().getWorkflowFinanceSourcesData(workflowId ?? "").then(
        (resp) {
      if (resp.status == "success") {
        if (resp.data != null) {
          workflowFinanceSourcesResponse.value =
              WorkflowFinanceSourcesResponse.fromJson(resp.data);
          List<dynamic> data = resp.data;
          for (var element in data) {
            final event = WorkflowFinanceSourcesResponse.fromJson(element);

            developmentTypeName = event.parentFinancialSourceName;
          }
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      //showToast(err.toString());
    });
  }

  void getWorkflowAllocationData(String? associatedId) {
    APIRepository().getWorkflowAllocationData(associatedId ?? "").then((resp) {
      if (resp.status == "success") {
        if (resp.data != null) {
          workflowAllocationResponse.value =
              WorkflowAllocationResponse.fromJson(resp.data);

          for (EconomicCodeGroup activityHistory
              in workflowAllocationResponse.value.economicCodeGroup!) {}
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      //hideLoadingDialog();
      //showToast(err.toString());
    });
  }

  Future<void> getWorkflowExpenditureDetailseData(String? associatedId) async {
    await APIRepository()
        .getWorkflowExpenditureDetailsData(associatedId ?? "")
        .then((resp) {
      if (resp.status == "success") {
        if (resp.data != null) {
          //debugPrint("Rokann dataaa Test: ${resp.data.toString()}");
          try {
            workflowExpenditureDetailsResponse.value =
                WorkflowExpenditureDetailsResponse.fromJson(resp.data);
            //debugPrint("Rokann workflowExpenditureDetails: ${workflowExpenditureDetailsResponse.value.bankName.toString()}");
          } catch (e) {
            //print ("Rokann workflowExpenditureDetailsResponse $e" );
          }
          //debugPrint("Rokann workflowExpenditureDetailsResponse: ${workflowExpenditureDetailsResponse.value.bankName.toString()}");
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      //hideLoadingDialog();
      //showToast(err.toString());
    });
  }

  Future<void> getWorkflowDemandDetailseData(String? associatedId) async {
    await APIRepository().getWorkflowDemandDetailsData(associatedId ?? "").then(
        (resp) {
      if (resp.status == "success") {
        if (resp.data != null) {
          //debugPrint("Rokann dataaa Test: ${resp.data.toString()}");
          try {
            workflowDemandDetailsResponse.value =
                WorkflowDemandDetailsResponse.fromJson(resp.data);
            debugPrint(
                "Rokann workflowDemandDetails: ${workflowDemandDetailsResponse.value.developmentTypeName.toString()}");
          } catch (e) {
            //print ("Rokann workflowDemandDetailsResponse $e" );
          }
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      //hideLoadingDialog();
      //showToast(err.toString());
    });
  }

  Future<void> getWorkflowFundDistributionDetailseData(
      String? associatedId) async {
    await APIRepository()
        .getWorkflowFundDistributionDetailsData(associatedId ?? "")
        .then((resp) {
      if (resp.status == "success") {
        if (resp.data != null) {
          //debugPrint("Rokann dataaa Test: ${resp.data.toString()}");
          try {
            workflowFundDistributionDetailsResponse.value =
                WorkflowFundDistributionDetailsResponse.fromJson(resp.data);
            debugPrint(
                "Rokann workflowFundDistributionDetails: ${workflowFundDistributionDetailsResponse.value.status.toString()}");
          } catch (e) {
            //print ("Rokann workflowDemandDetailsResponse $e" );
          }
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      //hideLoadingDialog();
      //showToast(err.toString());
    });
  }

  Future<void> getWorkflowAllocationDistributionDetailseData(
      String? associatedId) async {
    await APIRepository()
        .getWorkflowAllocationDistributionDetailsData(associatedId ?? "")
        .then((resp) {
      if (resp.status == "success") {
        if (resp.data != null) {
          //debugPrint("Rokann workflowAllocationDistributionDataValue Test: ${resp.data.toString()}");
          try {
            workflowAllocationDistributionDetailsResponse.value =
                WorkflowAllocationDistributionDetailsResponse.fromJson(
                    resp.data);
            //debugPrint("Rokann workflowAllocationDistributionDetails: ${workflowAllocationDistributionDetailsResponse.value.developmentTypeName.toString()}");
          } catch (e) {
            //print ("Rokann workflowDemandDetailsResponse $e" );
          }
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      //hideLoadingDialog();
      //showToast(err.toString());
    });
  }

  Future<void> getWorkflowFundReleaseDetailseData(String? associatedId) async {
    await APIRepository()
        .getWorkflowFundReleaseDetailsData(associatedId ?? "")
        .then((resp) {
      if (resp.status == "success") {
        if (resp.data != null) {
          //debugPrint("Rokan workflowFundReleaseDataValue Test: ${resp.data.toString()}");
          try {
            debugPrint("FarabiTanim workflowFundReleaseDetails: ${resp.data}");

            workflowFundReleaseDetailsResponse.value =
                WorkflowFundReleaseDetailsResponse.fromJson(resp.data);
            debugPrint(
                "Aifaz workflowFundReleaseDetails: ${workflowFundReleaseDetailsResponse.value.projectFundReleaseId.toString()}");
          } catch (e, t) {
            print("Dina workflowDemandDetailsResponse $e");
            print("Dina workflowDemandDetailsResponse $t");
          }
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      //hideLoadingDialog();
      //showToast(err.toString());
    });
  }

  Future<void> getWorkflowAllocationReturnDetailseData(
      String? associatedId) async {
    await APIRepository()
        .getWorkflowAllocationReturnDetailsData(associatedId ?? "")
        .then((resp) {
      if (resp.status == "success") {
        if (resp.data != null) {
          //debugPrint("Rokan workflowFundReleaseDataValue Test: ${resp.data.toString()}");
          try {
            debugPrint(
                "FarabiTanim workflowAllocationReturnDetails: ${resp.data}");

            workflowAllocationReturnDetailsResponse.value =
                WorkflowAllocationReturnDetailsResponse.fromJson(resp.data);
            debugPrint(
                "Aifaz workflowFundReleaseDetails: ${workflowAllocationReturnDetailsResponse.value.fiscalYearId.toString()}");
          } catch (e, t) {
            print("Dina workflowDemandDetailsResponse $e");
            print("Dina workflowDemandDetailsResponse $t");
          }
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      //hideLoadingDialog();
      //showToast(err.toString());
    });
  }

  Future<void> getWorkflowReappropriationDetailseData(
      String? associatedId) async {
    await APIRepository()
        .getWorkflowReappropriationDetailsData(associatedId ?? "")
        .then((resp) {
      if (resp.status == "success") {
        if (resp.data != null) {
          //debugPrint("Rokan workflowReappropriationDetails Test: ${resp.data.toString()}");

          /*List<WorkflowReappropriationDetailsResponse> list = List<WorkflowReappropriationDetailsResponse>.from(resp.data!.map((x) => WorkflowReappropriationDetailsResponse.fromJson(x)));
          workflowReappropriationDetailsResponse.value = list;*/

          /*workflowReappropriationDetailsResponse.value = WorkflowReappropriationDetailsResponse.fromJson(resp.data);
          List<dynamic> data = resp.data;
          for (var element in data) {
            final event = WorkflowFinanceSourcesResponse.fromJson(element);

            parentFinancialSourceName = event.parentFinancialSourceName;

            print ("Dina_31.01.2024 workflowReappropriationDetailsResponse: $parentFinancialSourceName" );


          }*/

          try {
            debugPrint(
                "FarabiTanim workflowReappropriationDetails: ${resp.data}");

            List<WorkflowReappropriationDetailsResponse> list =
                List<WorkflowReappropriationDetailsResponse>.from(resp.data!
                    .map((x) =>
                        WorkflowReappropriationDetailsResponse.fromJson(x)));
            workflowReappropriationDetailsResponse.value = list;

            //workflowReappropriationDetailsResponse.value = WorkflowReappropriationDetailsResponse.fromJson(resp.data[1]);
            //debugPrint("Aifaz workflowReappropriationDetails: ${workflowReappropriationDetailsResponse.value.parentFinancialSourceName.toString()}");
          } catch (e, t) {
            print("Dina workflowReappropriationDetailsResponse $e");
            print("Dina workflowReappropriationDetailsResponse $t");
          }
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      //hideLoadingDialog();
      //showToast(err.toString());
    });
  }
}
