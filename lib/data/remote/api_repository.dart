import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/response.dart';
import 'package:pmis_flutter/data/remote/api_provider.dart';

class APIRepository {
  final provider = Get.find<APIProvider>();

  Map<String, String> authHeader() {
    String? token = GetStorage().read(PreferenceKey.accessToken);
    var mapObj = <String, String>{};
    mapObj[APIConstants.kAccept] = APIConstants.vAccept;
    if (token != null && token.isNotEmpty) {
      mapObj[APIConstants.kAuthorization] = "${APIConstants.vBearer} $token";
      // mapObj[APIConstants.kAuthorization] = "token";
    }
    //GetUtils.printFunction("authHeader", mapObj[APIConstants.kAuthorization], "kAuthorization");
    return mapObj;
  }

  Map<String, String> authHeaderForReNewToken() {
    String? token = GetStorage().read(PreferenceKey.accessToken);
    String? refreshToken = GetStorage().read(PreferenceKey.refreshToken);
    var mapObj = <String, String>{};
    mapObj[APIConstants.kAccept] = APIConstants.vAccept;
    if (token != null && token.isNotEmpty) {
      mapObj[APIConstants.kAuthorization] = "${APIConstants.vBearer} $token";
      // mapObj[APIConstants.kAuthorization] = "token";
    }
    if (refreshToken != null && refreshToken.isNotEmpty) {
      mapObj[APIConstants.kRefreshToken] = APIConstants.vBearer + refreshToken;
      // mapObj[APIConstants.kAuthorization] = "token";
    }
    //GetUtils.printFunction("authHeader", mapObj[APIConstants.kAuthorization], "kAuthorization");
    return mapObj;
  }

  /// *** POST requests *** ///

  Future<ServerResponse> loginUser(String email, String password) async {
    var mapObj = {};
    mapObj[APIConstants.kEmail] = email;
    mapObj[APIConstants.kPassword] = password;
    return provider.postRequest(APIConstants.signInUrl, mapObj, authHeader());
  }

  /// Ministry wise used for PD directory
  Future<ServerResponse> getProjectsListForMinistry(
      String ministryValue, int page) async {
    var mapObj = //{};
    {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "ministry_id": ministryValue,
        "project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],
        //"fiscal_year_id": "2022-23",
      }
    };
    return provider.postRequest(
        APIConstants.allProjectsListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> getProjectsListForAgency(
      String agencyValue, int page) async {
    var mapObj = //{};
    {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "agency_id": agencyValue,
        "development_plan_type_id":
        GetStorage().read(PreferenceKey.developmentPlanTypeId),
        "fiscal_year_id": GetStorage().read(PreferenceKey.fiscalYearId),
        //August
        "project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],
      }
    };
    return provider.postRequest(
        APIConstants.allProjectsListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> getMyProjectsListForAgency(
      String agencyValue, int page) async {
    var mapObj = //{};
    {
      // "pagination_dto": {"current": 0, "pageSize": 70, "total": 0},
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "agency_id": agencyValue,
        "development_plan_type_id":
        GetStorage().read(PreferenceKey.developmentPlanTypeId),
        "fiscal_year_id": GetStorage().read(PreferenceKey.fiscalYearId),
        //August
        "project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],
      }
    };
    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> getMyProjectsListForPD(
      String agencyValue, int page) async {
    var mapObj = //{};
    {
      // "pagination_dto": {"current": 0, "pageSize": 70, "total": 0},
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "agency_id": agencyValue,
        "development_plan_type_id":
        GetStorage().read(PreferenceKey.developmentPlanTypeId),
        "fiscal_year_id": GetStorage().read(PreferenceKey.fiscalYearId),
        //August
        "project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],
      }
    };
    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> getProjectsListForDistrict(
      String districtValue, int page) async {
    var mapObj = {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "district_id": districtValue,
        "development_plan_type_id":
        GetStorage().read(PreferenceKey.developmentPlanTypeId),
        "fiscal_year_id": GetStorage().read(PreferenceKey.fiscalYearId),
        //August
        "project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],
      }
    };
    return provider.postRequest(
        APIConstants.allProjectsListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> getFilesEvidenceListForImageView(
      String projectId, int page) async {
    var mapObj = {
      "pagination_dto": {"current": page, "pageSize": 10},
      "files_evidence_search_dto": {
        "project_id": projectId,
        //"project_proforma_procurement_id": null,
        "file_type_id": "filetype_image"
      }
    };
    return provider.postRequest(
        APIConstants.evidenceFilesListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> getProjectLocationsList(
      String projectId, int page) async {
    var mapObj = {
      "pagination_dto": {"current": 0, "pageSize": 10, "total": 0},
      "search_dto": {"project_id": projectId}
    };
    return provider.postRequest(
        APIConstants.projectInspectionListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> getCurrentFiscalYearAndDevelopmentTypeData() async {
    return provider.getRequest(
        APIConstants.currentFiscalYearAndDevelopmentTypeUrl, authHeader());
  }

  /*Future<ServerResponse> getProjectsListForMyProjectsSearch(
      String searchValue, int page, bool isCode) async {
    // String valueName, valueCode;
    // valueName = searchValue;
    // valueCode = searchValue;
    var mapObj;
    isCode
        ? mapObj = {
            "pagination_dto": {"current": page, "pageSize": 10},
            "project_search_dto": {
              "code": searchValue,
            }
          }
        : mapObj = {
            "pagination_dto": {"current": page, "pageSize": 10},
            "project_search_dto": {
              "name": searchValue,
            }
          };
    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }*/

  // touhid
  Future<ServerResponse> getProjectsListForMyProjectsSearch(
      String searchValue, int page, int serchType) async {
    // String valueName, valueCode;
    // valueName = searchValue;
    // valueCode = searchValue;
    var mapObj;
    serchType == 0
        ? mapObj = {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "name": searchValue,
      }
    }
        : serchType == 1
        ? mapObj = {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "code": searchValue,
      }
    }
        : mapObj = {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        //"agency": searchValue,
        "agency_name": searchValue,
      }
    };
    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }

  // rokan
  Future<ServerResponse> getProjectsListForMyProjectsSearchByName(
      String searchValue, int page) async {
    var mapObj;
    mapObj = {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "name": searchValue,
        //"fiscal_year_id": "2022-23",
        "project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],
      }
    };

    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }

// rokan
  Future<ServerResponse> getProjectsListForMyProjectsSearchByCode(
      String searchValue, int page) async {
    var mapObj;
    mapObj = {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "code": searchValue,
        //"fiscal_year_id": "2022-23",
        "project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],
      }
    };

    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }

  // rokan
  Future<ServerResponse> getProjectsListForAllProjectsSearchByName(
      String searchValue, int page) async {
    var mapObj;
    mapObj = {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "name": searchValue,
        "project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],

        //"fiscal_year_id": "2022-23",
      }
    };

    return provider.postRequest(
        APIConstants.allProjectsListUrl, mapObj, authHeader());
  }

// rokan
  Future<ServerResponse> getProjectsListForAllProjectsSearchByCode(
      String searchValue, int page) async {
    var mapObj;
    mapObj = {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "code": searchValue,
        "project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],

        //"fiscal_year_id": "2022-23",
      }
    };

    return provider.postRequest(
        APIConstants.allProjectsListUrl, mapObj, authHeader());
  }

// rokan
  /* Future<ServerResponse> getProjectsListForMyProjectsSearchByAgency(
      String searchValue, int page) async {
    var mapObj;
     mapObj = {
            "pagination_dto": {"current": page, "pageSize": 10},
            "project_search_dto": {
              //"agencyName": searchValue,
              "agency_name": searchValue,
            }
          };

    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }*/

  Future<ServerResponse> getProjectsListForAllProjectsSearch(
      String searchValue, int page, int searchType) async {
    // String valueName, valueCode;
    // valueName = searchValue;
    // valueCode = searchValue;
    var mapObj;
    searchType == 0
        ? mapObj = {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "name": searchValue,
        //"fiscal_year_id": "2022-23",
      }
    }
        : searchType == 1
        ? mapObj = {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "code": searchValue,
        //"fiscal_year_id": "2022-23",
      }
    }
        : mapObj = {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        //"agency": searchValue,
        "agency_name": searchValue,
        "project_status_id": [
          "Projectstatus_Approved",
          "Projectstatus_draft"
        ],

        // "fiscal_year_id": "2022-23",
      }
    };

    return provider.postRequest(
        APIConstants.allProjectsListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> getFastTrackProjectsList(int page) async {
    var mapObj = {
      "project_search_dto": {
        "agency_id": null,
        "division_id": null,
        "ministry_id": null,
        //"fiscal_year_id": "2023-24",
        "district_id": null,
        "upazilla_id": null,
        "project_type_id": null,
        "project_status_id": null,
        "date_of_commencement": null,
        "date_of_completion": null,
        "is_fast_track": true
      },
      "pagination_dto": {"current": page, "pageSize": 10}
    };
    return provider.postRequest(
        APIConstants.allPublicProjectsListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> getPendingTaskProjectsList(
      int page, String userId) async {
    var mapObj = {
      "workflow_task_search_dto": {
        "agency_id": null,
        "division_id": null,
        "ministry_id": null,
        "district_id": null,
        "upazilla_id": null,
        "project_type_id": null,
        "project_status_id": null,
        "date_of_commencement": null,
        "date_of_completion": null,
        "user_id": userId,
        "status": "Pending"
        //"status": "Approved"
      },
      "pagination_dto": {"current": page, "pageSize": 10}
    };
    return provider.postRequest(
        APIConstants.pendingTaskProjectsListUrl, mapObj, authHeader());
  }


  Future<ServerResponse> getWorkflowExpenditureInformationData(
      int page, String projectExpenditureId
      ) async {
    var mapObj = {
      "expenditure_details_search_dto": {
        "project_expenditure_id": projectExpenditureId
      },
      "pagination_dto": {"current": page, "pageSize": 10}
    };
    return provider.postRequest(
        APIConstants.workflowExpenditureInformationUrl, mapObj, authHeader());
  }








  Future<ServerResponse> getUserList(int page) async {
    var mapObj = {
      "user_search_dto": {
        "name": null,
        "email": null,
        "nid": null,
        "mobile_number": null,
        "is_monitoring_officer": null
      },
      "pagination_dto": {"current": page, "pageSize": 100}
      //"pagination_dto": {"current": 0, "pageSize": 5000},
    };
    return provider.postRequest(APIConstants.userListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> getAllProjectsProjectsList(int page) async {
    var mapObj = {
      "project_search_dto": {
        "development_plan_type_id":
        GetStorage().read(PreferenceKey.developmentPlanTypeId),
        "fiscal_year_id": GetStorage().read(PreferenceKey.fiscalYearId),
        //August
        "project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],
      },
      "pagination_dto": {"current": page, "pageSize": 10}
    };
    return provider.postRequest(
        APIConstants.allProjectsListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> myProjects(int page) async {
    var mapObj = // {};
    {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "name": null,
        "code": null,
        "ministry_id": null,
        "division_id": null,
        "agency_id": null,
        "development_plan_type_id": GetStorage().read(PreferenceKey.developmentPlanTypeId),
        "fiscal_year_id": GetStorage().read(PreferenceKey.fiscalYearId),

        /*"project_type_id": GetStorage().read(PreferenceKey.TagComeFrom) == TotalOngoingDevelopmentProjects.toString() ? "ProjectType_DPP"
            : GetStorage().read(PreferenceKey.TagComeFrom) == TotalOngoingTAProjects.toString() ? "ProjectType_TAPP"
            : null,*/



        "project_type_id": GetStorage().read(PreferenceKey.TagComeFrom) == TotalOngoingDevelopmentProjects.toString() ? "ProjectType_DPP"
                         : GetStorage().read(PreferenceKey.TagComeFrom) == TotalOngoingTAProjects.toString() ? "ProjectType_TAPP"
                         : GetStorage().read(PreferenceKey.TagComeFrom) == TotalFeasibilityStudyProjects.toString() ? "3"
                         : null,







        "project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],
        "date_of_completion_start": null,
        "date_of_completion_end": null,
        "inspection_cutoff_date": null,
        "has_pending_pcr": null,
        "is_own_funded": GetStorage().read(PreferenceKey.TagComeFrom) == TotalOwnFundProjects.toString() ? true : null,
        //"is_own_funded": null
      }
    };
    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> myProjectsWithoutPagination() async {
    var mapObj = // {};
    {
      "pagination_dto": {"current": 0, "pageSize": 5000},
      "project_search_dto": {
        "name": null,
        "code": null,
        "ministry_id": null,
        "division_id": null,
        "agency_id": null,
        "development_plan_type_id":
        GetStorage().read(PreferenceKey.developmentPlanTypeId),
        "fiscal_year_id": GetStorage().read(PreferenceKey.fiscalYearId),
        //August

        "project_type_id": GetStorage().read(PreferenceKey.TagComeFrom) == TotalOngoingDevelopmentProjects.toString() ? "ProjectType_DPP"
            : GetStorage().read(PreferenceKey.TagComeFrom) == TotalOngoingTAProjects.toString() ? "ProjectType_TAPP"
            : GetStorage().read(PreferenceKey.TagComeFrom) == TotalFeasibilityStudyProjects.toString() ? "3"
            : null,

        //"project_type_id": null,

        "project_status_id": [],

        //"project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],
        "date_of_completion_start": null,
        "date_of_completion_end": null,
        "inspection_cutoff_date": null,
        "has_pending_pcr": null,
        "is_own_funded": GetStorage().read(PreferenceKey.TagComeFrom) ==
            TotalOwnFundProjects.toString()
            ? true
            : null,
        //"is_own_funded": null
      }
    };
    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }

  /*Future<ServerResponse> myProjectsCompletedWithPcrStatus(
      int page, bool status) async {
    var mapObj = // {};
        {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "project_status_id": "Projectstatus_Closed",
        "fiscal_year_id": "2022-23",
        "has_pending_pcr": status

      }
    };
    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }*/

  Future<ServerResponse> myProjectsCompletedWithPcrStatusReceived(
      int page, bool status) async {
    var mapObj = // {};
    {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "name": null,
        "code": null,
        "ministry_id": null,
        "division_id": null,
        "agency_id": null,
        "development_plan_type_id":
        GetStorage().read(PreferenceKey.developmentPlanTypeId),
        "fiscal_year_id": GetStorage().read(PreferenceKey.fiscalYearId),
        //August
        "project_type_id": null,
        "project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],
        "date_of_completion_start": null,
        "date_of_completion_end": null,
        "inspection_cutoff_date": null,
        "has_pending_pcr": status
      }
    };
    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> myProjectsCompletedWithPcrStatusNotReceived(
      int page, bool status) async {
    var mapObj = // {};
    {
      "pagination_dto": {"current": page, "pageSize": 10},
      "project_search_dto": {
        "name": null,
        "code": null,
        "ministry_id": null,
        "division_id": null,
        "agency_id": null,
        "development_plan_type_id":
        GetStorage().read(PreferenceKey.developmentPlanTypeId),
        "fiscal_year_id": GetStorage().read(PreferenceKey.fiscalYearId),
        //August
        "project_type_id": null,
        "project_status_id": ["Projectstatus_Closed"],
        "date_of_completion_start": null,
        "date_of_completion_end": null,
        "inspection_cutoff_date": null,
        "has_pending_pcr": status
      }
    };
    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> getSlowProgressProjectsList(int page) async {
    var mapObj = // {};
    {
      "project_search_dto": {
        "project_status_id": "Projectstatus_Approved",
        //"project_status_id": ["Projectstatus_Approved"],
        "timeline_passed": 0.5,
        "physical_progress": 0.5,
        //"fiscal_year_id": "2022-23",
        "financial_progress": null
      },
      "pagination_dto": {"current": page, "pageSize": 1}
    };
    return provider.postRequest(
        APIConstants.projectProgressUrl, mapObj, authHeader());
  }

  Future<ServerResponse> getSlowProjects50DoneList(int page) async {
    var mapObj = // {};
    {
      "project_search_dto": {
        "project_status_id": "Projectstatus_Approved",
        //"project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],
        "timeline_passed": 0.5,
        "physical_progress": null,
        //"fiscal_year_id": "2022-23",
        "financial_progress": 0.5
      },
      "pagination_dto": {"current": page, "pageSize": 10}
    };
    return provider.postRequest(
        APIConstants.projectProgressUrl, mapObj, authHeader());
  }

  // Future<ServerResponse> myCompletedProjects(int page) async {
  //   var mapObj = // {};
  //   {
  //     "pagination_dto":{
  //       "current": page, "pageSize": 10
  //     },
  //     "project_search_dto":{
  //       "project_status_id":"Projectstatus_Closed"
  //     }
  //   };
  //   return provider.postRequest(
  //       APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  // }

  Future<ServerResponse> myProjectClosingIn3To6List(
      int page, String todayDateTo90, String todayDateTo90To180Days) async {
    var mapObj = // {};
    {
      "project_search_dto": {
        "code": null,
        "name": null,
        "fiscal_year_id": null,
        "project_type_id": null,
        "project_status_id": ["Projectstatus_Approved"],
        //"project_status_id": null,
        //"fiscal_year_id": "2022-23",
        "ministry_id": null,
        "division_id": null,
        "agency_id": null,
        // "date_of_completion_start": "2023-02-16",
        "date_of_completion_start": todayDateTo90,
        // "date_of_completion_end": "2023-08-16"
        "date_of_completion_end": todayDateTo90To180Days
      },
      "pagination_dto": {"current": page, "pageSize": 10, "total": 0}
    };
    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> myProjectNotVisited3MonthsByIMEDList(
      int page, String todayDateToBefore90Days) async {
    var mapObj = // {};
    {
      "pagination_dto": {"current": page, "pageSize": 10, "total": 0},
      "project_search_dto": {
        "code": null,
        "name": null,
        "fiscal_year_id": null,
        "project_type_id": null,
        "project_status_id": ["Projectstatus_Approved"],
        // "project_status_id": null,
        // "fiscal_year_id": "2022-23",
        "ministry_id": null,
        "division_id": null,
        "agency_id": null,
        "date_of_completion_start": null,
        "date_of_completion_end": null,
        "inspection_cutoff_date": todayDateToBefore90Days
      }
    };
    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }

  Future<ServerResponse> myProjectsAllListDataRequest(int page) async {
    var mapObj = // {};
    {
      // "pagination_dto": {"current": 0, "pageSize": 70, "total": 0},
      "pagination_dto": {"current": page, "pageSize": 30000},
      "project_search_dto": {
        "development_plan_type_id":
        GetStorage().read(PreferenceKey.developmentPlanTypeId),
        "fiscal_year_id": GetStorage().read(PreferenceKey.fiscalYearId),
        //August
        "project_status_id": ["Projectstatus_Approved", "Projectstatus_draft"],
      }
    };
    return provider.postRequest(
        APIConstants.myAllProjectsListUrl, mapObj, authHeader());
  }

  Future<MultipartFile> makeMultipartFile(File file) async {
    List<int>? arrayData = await file.readAsBytes();
    // MultipartFile multipartFile = MultipartFile(arrayData, filename: file.path);
    MultipartFile multipartFile =
    MultipartFile(arrayData, filename: file.path.split('/').last);
    return multipartFile;
  }

  Future<ServerResponse> uploadFile(File file) async {
    var mapObj = <String, dynamic>{};
    mapObj[APIConstants.kFiles] = await makeMultipartFile(file);
    // mapObj[APIConstants.kFiles] = imageFile;
    // if (imageFile.path.isNotEmpty) {
    //   mapObj[APIConstants.kFiles] = await makeMultipartFile(imageFile);
    // }
    return provider.postRequestFormData(
        APIConstants.fileUploadUrl, mapObj, authHeader());
  }

  Future<ServerResponse> workFlowUploadFile(File file) async {
    var mapObj = <String, dynamic>{};
    mapObj[APIConstants.kFiles] = await makeMultipartFile(file);
    return provider.postRequestFormData(
        APIConstants.fileUploadUrl, mapObj, authHeader());
  }

  // Future<ServerResponse> uploadPcrImageFileAndRemarks(File file) async {
  //   var mapObj = <String, dynamic>{};
  //   mapObj[APIConstants.kFiles] = await makeMultipartFile(file);
  //   // mapObj[APIConstants.kFiles] = imageFile;
  //   // if (imageFile.path.isNotEmpty) {
  //   //   mapObj[APIConstants.kFiles] = await makeMultipartFile(imageFile);
  //   // }
  //   return provider.postRequestFormData(
  //       APIConstants.fileUploadUrl, mapObj, authHeader());
  // }

  // Future<ServerResponse> uploadFilePath(String imagePath) async {
  //   var mapObj = <String, dynamic>{};
  //   // mapObj[APIConstants.kFiles] = await makeMultipartFile(file);
  //   mapObj[APIConstants.kFiles] = imagePath;
  //   // mapObj[APIConstants.kFiles] = imageFile;
  //   // if (imageFile.path.isNotEmpty) {
  //   //   mapObj[APIConstants.kFiles] = await makeMultipartFile(imageFile);
  //   // }
  //   return provider.postRequestFormData(
  //       APIConstants.fileUploadUrl, mapObj, authHeader());
  // }

  Future<ServerResponse> myProjectsEvidenceFileSync(String projectId,
      String fileName, String fileId, String latitude, String longitude) async {
    // String projectId, String fileName, String fileId) async {
    var mapObj = // {};
    {
      "project_id": projectId,
      "file_name": fileName,
      "file_id": fileId,
      "file_type_id": "filetype_image", // should be same
      "latitude": latitude,
      "longitude": longitude,
      // "latitude": 37.4216572,
      // "longitude": -122.0842089,
      //"evidence_location": "string" // not mandatory
      "evidence_location": "--", // not mandatory
      "description": "--", // not mandatory
      "capture_timestamp": DateFormat('yyyy-MM-ddTHH:mm:ss.SSS')
          .format(DateTime.now()) // not mandatory
    };
    return provider.postRequest(
        APIConstants.evidenceFilesUrl, mapObj, authHeader());
  }

  Future<ServerResponse> pcrFileAttachment(
      String projectId, String remarks, String fileId, String fileName) async {
    // String projectId, String fileName, String fileId) async {
    var mapObj = // {};
    {
      "project_id": projectId,
      "remarks": remarks,
      "file_id": fileId,
      "file_name": fileName
    };
    return provider.postRequest(
        APIConstants.pcrAttachmentUrl, mapObj, authHeader());
  }

  Future<ServerResponse> workFlowFileAttachment(
      String comment,
      String? fileId,
      String? fileName,
      String? fileSize,
      String workflowId,
      String workflowActionId) async {
    var files = [];
    if (fileId != null) {
      files = [
        {"file_id": fileId, "file_name": fileName, "file_size": fileSize}
      ];
    }
    var mapObj = {
      "comment": comment,
      "workflow_action_id": workflowActionId,
      "workflow_activity_files": files,
      "workflow_id": workflowId
    };
    return provider.postRequest(
        APIConstants.workFlowFileAttachmentUrl, mapObj, authHeader());
  }

  Future<ServerResponse> pcrReceivedStatus(String projectId) async {
    // String projectId, String fileName, String fileId) async {
    var mapObj = // {};
    {"project_id": projectId, "received_date": null};
    return provider.postRequest(
        APIConstants.pcrReceivedStatusUrl, mapObj, authHeader());
  }

  Future<ServerResponse> pcrReceivedDateUploadAndReceivedStatus(
      String projectId, String receivedDate) async {
    // String projectId, String fileName, String fileId) async {
    var mapObj = // {};
    {"project_id": projectId, "received_date": receivedDate};
    return provider.postRequest(
        APIConstants.pcrReceivedStatusUrl, mapObj, authHeader());
  }

  // Future<ServerResponse> ministryWiseProjects(String ministryValue) async {
  //   var mapObj =
  //     {"pagination_dto":
  //     {"current":0,
  //       "pageSize":70,
  //       "total":0},
  //       "project_search_dto":
  //       {
  //         "ministry_id":"ministry41",
  //       }
  //     };
  //   // mapObj[APIConstants.kMinistryName] = ministryName;
  //   // mapObj[APIConstants.kMinistryId] = ministryValue;
  //   // mapObj['name'] = "Research";
  //   // mapObj['pagination_dto'] = "Research";
  //
  //   return provider.postRequest(APIConstants.allProjectsListUrl, mapObj, authHeader());
  // }

  /// *** GET requests *** ///

  Future<ServerResponse> getReNewToken() async {
    return provider.getRequest(
        APIConstants.reNewTokenUrl, authHeaderForReNewToken());
  }

  Future<ServerResponse> getMinistryDropDownList() async {
    return provider.getRequest(APIConstants.ministryListUrl, authHeader());
  }

  Future<ServerResponse> getMyProjectsMinistryDropDownList() async {
    return provider.getRequest(
        APIConstants.myProjectsMinistryListUrl, authHeader());
  }

  Future<ServerResponse> getDistrictDropDownList() async {
    return provider.getRequest(APIConstants.districtListUrl, authHeader());
  }

  Future<ServerResponse> getUserInfo() async {
    return provider.getRequest(APIConstants.userInfoUrl, authHeader());
  }

  Future<ServerResponse> getUserOfficeHistoryInfo(String userId) async {
    return provider.getRequest(
        APIConstants.userOfficeHistoryUrl.replaceAll("#user_id#", userId),
        authHeader());
  }

  Future<ServerResponse> getUserProjects(String userId) async {
    return provider.getRequest(
        APIConstants.projectsListUrl.replaceAll("#user_id#", userId),
        authHeader());
  }

  Future<ServerResponse> getProjectReport(String project_id) async {
    return provider.getRequest(
        APIConstants.projectReportListUrl
            .replaceAll("#project_id#", project_id),
        authHeader());
  }

  Future<ServerResponse> getProjectEstimatedCost(String project_id) async {
    return provider.getRequest(
        APIConstants.projectEstimatedCostUrl.replaceAll("#project_id#", project_id),
        authHeader());
  }

  Future<ServerResponse> getProjectAllocationCost(String project_id) async {
    return provider.getRequest(
        APIConstants.projectAllocationCostUrl
            .replaceAll("#project_id#", project_id),
        authHeader());
  }

  Future<ServerResponse> getProjectExpenditureCost(String project_id) async {
    return provider.getRequest(
        APIConstants.projectExpenditureCostUrl
            .replaceAll("#project_id#", project_id),
        authHeader());
  }

 Future<ServerResponse> getProjectFundReleaseSummary(String project_id) async {
    return provider.getRequest(
        APIConstants.projectFundReleaseSummaryUrl
            .replaceAll("#project_id#", project_id),
        authHeader());
  }

  Future<ServerResponse> getProjectEntryForm8ReportData(
      String project_expenditure_summary_id) async {
    return provider.getRequest(
        APIConstants.entryForm8ReportUrl.replaceAll(
            "#project_expenditure_summary_id#", project_expenditure_summary_id),
        authHeader());
  }

  Future<ServerResponse> getProjectDataEntryProgress(String project_id) async {
    return provider.getRequest(
        APIConstants.projectDataEntryProgressUrl
            .replaceAll("#project_id#", project_id),
        authHeader());
  }

  Future<ServerResponse> getWorkflowNodeData(String workflowId) async {
    return provider.getRequest(
        APIConstants.workFlowNodeDataUrl
            .replaceAll("#workflow_id#", workflowId),
        authHeader());
  }

  Future<ServerResponse> getWorkflowActivityHistoryData(
      String workflowId) async {
    return provider.getRequest(
        APIConstants.workFlowActivityHistoryDataUrl
            .replaceAll("#workflow_id#", workflowId),
        authHeader());
  }

  Future<ServerResponse> getWorkflowFinanceSourcesData(
      String workflowId) async {
    return provider.getRequest(
        APIConstants.workFlowFinanceSourcesDataUrl
            .replaceAll("#workflow_id#", workflowId),
        authHeader());
  }

  Future<ServerResponse> getWorkflowAllocationData(String associatedId) async {
    return provider.getRequest(
        APIConstants.workFlowAllocationDataUrl
            .replaceAll("#associated_id#", associatedId),
        authHeader());
  }

  Future<ServerResponse> getWorkflowExpenditureDetailsData(
      String associatedId) async {
    return provider.getRequest(
        APIConstants.workflowExpenditureDetailsDataUrl
            .replaceAll("#associated_id#", associatedId),
        authHeader());
  }

  Future<ServerResponse> getWorkflowDemandDetailsData(
      String associatedId) async {
    return provider.getRequest(
        APIConstants.workflowDemandDetailsDataUrl
            .replaceAll("#associated_id#", associatedId),
        authHeader());
  }

  Future<ServerResponse> getWorkflowFundDistributionDetailsData(
      String associatedId) async {
    return provider.getRequest(
        APIConstants.workflowFundDistributionDetailsDataUrl
            .replaceAll("#associated_id#", associatedId),
        authHeader());
  }

  Future<ServerResponse> getWorkflowAllocationDistributionDetailsData(
      String associatedId) async {
    return provider.getRequest(
        APIConstants.workflowAllocationDistributionDetailsDataUrl
            .replaceAll("#associated_id#", associatedId),
        authHeader());
  }

  Future<ServerResponse> getWorkflowFundReleaseDetailsData(
      String associatedId) async {
    return provider.getRequest(
        APIConstants.workflowFundReleaseDetailsDataUrl
            .replaceAll("#associated_id#", associatedId),
        authHeader());
  }

  Future<ServerResponse> getWorkflowAllocationReturnDetailsData(
      String associatedId) async {
    return provider.getRequest(
        APIConstants.workflowAllocationReturnDetailsDataUrl
            .replaceAll("#associated_id#", associatedId),
        authHeader());
  }

  Future<ServerResponse> getWorkflowReappropriationDetailsData(
      String associatedId) async {
    return provider.getRequest(
        APIConstants.workflowReappropriationDetailsDataUrl
            .replaceAll("#project_id#", associatedId),
        authHeader());
  }

  Future<ServerResponse> getWorkflowDetailsData(
      String workflowType, String associatedId) async {
    /*var mapValue = APIConstants.workFlowDetailsUrl.replaceAll( "#workflow_type#", workflowType);
    var secondMapValue = mapValue.replaceAll("#associated_id#", associatedId);*/

    return provider.getRequest(
        APIConstants.workFlowDetailsUrl
            .replaceAll("#workflow_type#", workflowType)
            .replaceAll("#associated_id#", associatedId),
        authHeader());

    /*var mapValueAll = APIConstants.workFlowDetailsUrl.replaceAll( "#workflow_type#", workflowType).replaceAll("#associated_id#", associatedId);
    return provider.getRequest(mapValueAll, authHeader());*/
  }

  Future<ServerResponse> getProjectUserList(String projectId) async {
    return provider.getRequest(
        APIConstants.projectUserListUrl.replaceAll("#project_id#", projectId),
        authHeader());
  }

  Future<ServerResponse> getProjectProgressAndCostData(String projectId) async {
    return provider.getRequest(
        APIConstants.projectProgressAndCostUrl
            .replaceAll("#project_id#", projectId),
        authHeader());
  }

  Future<ServerResponse> getProjectDetailsByID(String projectId) async {
    return provider.getRequest(
        APIConstants.projectDetailsByIdUrl
            .replaceAll("#project_id#", projectId),
        authHeader());
  }

  Future<ServerResponse> getLandingProjectCount() async {
    return provider.getRequest(
        APIConstants.landingProjectCountUrl, authHeader());
  }

  Future<ServerResponse> getProjectLocationList(String projectId) async {
    return provider.getRequest(
        APIConstants.projectLocationListUrl
            .replaceAll("#project_id#", projectId),
        authHeader());
  }

  Future<ServerResponse> getDivisionDropDownList(String ministryValue) async {
    return provider.getRequest(
        APIConstants.divisionListUrl.replaceAll("#ministry_id#", ministryValue),
        authHeader());
  }

  Future<ServerResponse> getMyProjectsDivisionDropDownList(
      String ministryValue) async {
    return provider.getRequest(
        APIConstants.myProjectsDivisionListUrl
            .replaceAll("#ministry_id#", ministryValue),
        authHeader());
  }

  Future<ServerResponse> getAgencyDropDownList(String divisionValue) async {
    return provider.getRequest(
        APIConstants.agencyListUrl.replaceAll("#ministry_id#", divisionValue),
        authHeader());
  }

  Future<ServerResponse> getMyProjectsAgencyDropDownList(
      String divisionValue) async {
    return provider.getRequest(
        APIConstants.myProjectsAgencyListUrl
            .replaceAll("#ministry_id#", divisionValue),
        authHeader());
  }

  /*Future<ServerResponse> getAgencyDropDownListDynamic({String? ministryValue, String? divisionValue, required bool isDivision}) async {

    if(isDivision){

    }

    return provider.getRequest(
        APIConstants.agencyListUrl.replaceAll("#ministry_id#", ministryValue),
        authHeader());
  }*/

  Future<ServerResponse> getPdInfoTadData(String projectId) async {
    return provider.getRequest(
        APIConstants.pdInfoUrl.replaceAll("#project_id#", projectId),
        authHeader());
  }

  Future<ServerResponse> getWorkflowActions(String workflowRoleId) async {
    return provider.getRequest(
        APIConstants.workFlowActionsDataUrl
            .replaceAll("#Workflow_role_id#", workflowRoleId),
        authHeader());
  }

  /*Future<ServerResponse> getWorkflowActions() async {
    return provider.getRequest(APIConstants.workFlowActionsDataUrl, authHeader());

  }*/

  Future<ServerResponse> getWorkflowRoles() async {
    return provider.getRequest(APIConstants.workFlowRolesDataUrl, authHeader());
  }

  Future<ServerResponse> getPcrAttachmentViewData(String projectId) async {
    return provider.getRequest(
        APIConstants.pcrAttachmentViewByIDUrl
            .replaceAll("#project_id#", projectId),
        authHeader());
  }
}
