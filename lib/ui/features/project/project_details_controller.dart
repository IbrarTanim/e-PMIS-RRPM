import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/models/EntryForm8ListResponse.dart';
import 'package:pmis_flutter/data/models/data_entry_progress_response.dart';
import 'package:pmis_flutter/data/models/data_entry_progress_response.dart';
import 'package:pmis_flutter/data/models/project_allocation_cost_response.dart';
import 'package:pmis_flutter/data/models/project_estimated_cost_response.dart';
import 'package:pmis_flutter/data/models/project_expenditure_cost_response.dart';
import 'package:pmis_flutter/data/models/project_fund_release_summary_response.dart';
import 'package:pmis_flutter/data/models/wish_list_project_details_response.dart';

import '../../../data/remote/api_repository.dart';
import '../../../utils/common_utils.dart';

class WishListProjectDetailsController extends GetxController {
  Future<void> getData() async {
    // getList();
    Future.delayed(const Duration(seconds: 1), () {
      //Duration.zero
      // getItemList();
    });
  }

  Rx<WishListProjectDetailsResponse> wishListProjectDetailsResponse =
      WishListProjectDetailsResponse().obs;
  Future<void> getWishListProjectReport(String projectId) async {
    await APIRepository().getProjectReport(projectId).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          wishListProjectDetailsResponse.value =
              WishListProjectDetailsResponse.fromJson(resp.data);
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  //RxList<ProjectEstimatedCostResponse> projectEstimatedCostResponse = <ProjectEstimatedCostResponse>[].obs;
  /*Future<void> getProjectEstimatedCostData(String projectId) async {
    await APIRepository().getProjectEstimatedCost(projectId).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null && resp.data['project_financial_source_mode'] is List) {
          final listData = resp.data['project_financial_source_mode'] as List;

          List<ProjectEstimatedCostResponse> list = listData
              .map((x) => ProjectEstimatedCostResponse.fromJson(x))
              .toList();

          projectEstimatedCostResponse.value = list;
          debugPrint("RokanFarabi_ProjectEstimatedCostResponse: ${projectEstimatedCostResponse.value.length.toString()}");
        }
      } else {
        // showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
    });
  }*/

  RxList<ProjectEstimatedCostResponse> projectEstimatedCostResponse = <ProjectEstimatedCostResponse>[].obs;

  Future<void> getProjectEstimatedCostData(String projectId) async {
    await APIRepository().getProjectEstimatedCost(projectId).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          final parsed = ProjectEstimatedCostResponse.fromJson(resp.data);
          projectEstimatedCostResponse.value = [parsed];

          debugPrint("Parsed ProjectEstimatedCostResponse ✅");
          debugPrint("Has Revision: ${parsed.hasRevision}");
          debugPrint("Financial Modes Count: ${parsed.projectFinancialSourceMode?.length ?? 0}");
        }
      } else {
        // showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
    });
  }


  RxList<ProjectAllocationCostResponse> projectAllocationCostResponse =
      <ProjectAllocationCostResponse>[].obs;
  Future<void> getProjectAllocationCostData(String projectId) async {
    await APIRepository().getProjectAllocationCost(projectId).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          List<ProjectAllocationCostResponse> list =
              List<ProjectAllocationCostResponse>.from(resp.data!
                  .map((x) => ProjectAllocationCostResponse.fromJson(x)));
          projectAllocationCostResponse.value = list;
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
    });
  }

  Rx<DataEntryProgressResponse> dataEntryProgressResponse =
      DataEntryProgressResponse().obs;
  //RxList<DataEntryProgressResponse> dataEntryProgressResponse = <DataEntryProgressResponse>[].obs;

  Future<void> getDataEntryProgress(String projectId) async {
    await APIRepository().getProjectDataEntryProgress(projectId).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          //debugPrint("RokanFarabi_dataEntryProgressResponse: ${resp.data.toString()}");

          dataEntryProgressResponse.value =
              DataEntryProgressResponse.fromJson(resp.data);
          //debugPrint("RokanFarabi_dataEntryProgressResponse: ${dataEntryProgressResponse.value.dataSubmissionProgressPercentage.toString()}");
        }
      } else {
        showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
      showToast(err.toString());
    });
  }

  RxList<ProjectExpenditureCostResponse> projectExpenditureCostResponse =
      <ProjectExpenditureCostResponse>[].obs;
  Future<void> getProjectExpenditureCostData(String projectId) async {
    await APIRepository().getProjectExpenditureCost(projectId).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          List<ProjectExpenditureCostResponse> list =
              List<ProjectExpenditureCostResponse>.from(resp.data!
                  .map((x) => ProjectExpenditureCostResponse.fromJson(x)));
          projectExpenditureCostResponse.value = list;
          debugPrint(
              "Rokan_uddin project Data response Test: ${resp.data.toString()}");
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
    });
  }


  RxList<ProjectFundReleaseSummaryResponse> projectFundReleaseSummaryResponse = <ProjectFundReleaseSummaryResponse>[].obs;
  Future<void> getProjectFundReleaseSummaryData(String projectId) async {
    await APIRepository().getProjectFundReleaseSummary(projectId).then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          List<ProjectFundReleaseSummaryResponse> list =
          List<ProjectFundReleaseSummaryResponse>.from(resp.data!
              .map((x) => ProjectFundReleaseSummaryResponse.fromJson(x)));
          projectFundReleaseSummaryResponse.value = list;
          debugPrint(
              "Rokan_uddin ProjectFundReleaseSummaryResponse  Test: ${resp.data.toString()}");
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
    });
  }



  int calculateTotalFundReleaseSummary() {
    int total = 0;

    for (var item in projectFundReleaseSummaryResponse) {
      final details = item.releaseDetails;

      if (details != null) {
        total += (details.amountGob ?? 0) +
            (details.amountGobFe ?? 0) +
            (details.amountRpa ?? 0) +
            (details.amountDpa ?? 0) +
            (details.amountOwnFund ?? 0) +
            (details.amountOwnFundFe ?? 0);
      }
    }

    return total;
  }


  Rx<EntryForm8ListResponse> entryForm8ListResponse =
      EntryForm8ListResponse().obs;
  Future<void> getEntryForm8ReportData(String projectExpenditureSummaryId) async {
    await APIRepository()
        .getProjectEntryForm8ReportData(projectExpenditureSummaryId)
        .then((resp) {
      hideLoadingDialog();
      if (resp.status == "success") {
        if (resp.data != null) {
          entryForm8ListResponse.value =
              EntryForm8ListResponse.fromJson(resp.data);
          debugPrint(
              "Zabir EntryForm8ListResponse received: ${entryForm8ListResponse.value.toString()}");
        }
      } else {
        //showToast(resp.message, isError: true);
      }
    }, onError: (err) {
      hideLoadingDialog();
    });
  }
}
