import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

bool gIsDarkMode = false;
String? token = GetStorage().read(PreferenceKey.accessToken);
String fullToken = token.toString();

class AssetConstants {
  /// For Temporary Image Upload
  static const pathTempImageFolder = "/tmpImages/";
  static const pathTempProjectImageName = "_projectImage.jpeg";
  static const pathTempProjectVideoName = "_projectVideo.mp4";

  ///For images
  static const imageBasePath = "assets/images/";

  static const appLogo = "${imageBasePath}ic_launcher.png";
  static const noImage = "${imageBasePath}noImage.png";
  static const avatar = "${imageBasePath}avatar.png";

  static const image_1 = "${imageBasePath}image_1.png";
  static const image_2 = "${imageBasePath}image_2.png";
  static const image_3 = "${imageBasePath}image_3.png";
  static const image_4 = "${imageBasePath}image_4.png";

  /*static const padma_bridge = "${imageBasePath}image_1.png";
  static const payra_see_port = "${imageBasePath}iimage_2.png";
  static const rampal_power_plant = "${imageBasePath}image_3.png";
  static const ruppur_nuclear_power = "${imageBasePath}image_4.png";
  static const singleline_duelgauge_rail = "${imageBasePath}image_1.png";*/

  ///For Icons
  static const basePathIcons = "assets/icons/";

  static const icMenu = "${basePathIcons}ic_menu.svg";
  static const icEmail = "${basePathIcons}ic_email.svg";
  static const icPasswordHide = "${basePathIcons}ic_password_hide.svg";
  static const icPasswordShow = "${basePathIcons}ic_password_show.svg";
  static const icCancel = "${imageBasePath}ic_cancel.svg";
  static const icCamera = "${basePathIcons}ic_camera.svg";
  static const icSettings = "${basePathIcons}ic_setting.svg";
  static const icLogout = "${basePathIcons}ic_logout.svg";
  static const icUser = "${basePathIcons}ic_user.svg";
  static const icUserFill = "${basePathIcons}ic_user_fill.svg";
  static const icArrowLeft = "${basePathIcons}ic_arrow_left.svg";
  static const icArrowRight = "${basePathIcons}ic_arrow_right.svg";
  static const icSearch = "${basePathIcons}ic_search.svg";
  static const icFavorite = "${basePathIcons}ic_favorite.svg";
  static const icFavoriteFilled = "${basePathIcons}ic_favorite_fill.svg";
  static const icCross = "${basePathIcons}ic_cross.svg";
  static const icProject = "${basePathIcons}ic_project.svg";
  static const icMonitor = "${basePathIcons}icon_monitor.svg";
  static const icTaka = "${basePathIcons}ic_taka.svg";
  static const icProgress = "${basePathIcons}ic_progress.svg";
  static const icFastTrack1 = "${basePathIcons}ic_fast_track1.svg";
  static const icPendingTask = "${basePathIcons}pending_task.svg";
  static const icFastTrack = "${basePathIcons}ic_fast_track.svg";
  static const icFastTrackFilled = "${basePathIcons}ic_fast_track_filled.svg";
  static const icAbout = "${basePathIcons}ic_about.svg";

  static const icMyProjects = "${basePathIcons}ic_my_projects.svg";
  static const icMinistry = "${basePathIcons}ic_ministry.svg";
  static const icAgency = "${basePathIcons}ic_agency.svg";
  static const icDistrict = "${basePathIcons}ic_district.svg";
  static const icPdDirectory = "${basePathIcons}ic_pd_directory.svg";
  static const icTheme = "${basePathIcons}ic_theme.svg";
  static const icUpload = "${basePathIcons}ic_upload.svg";
  static const icLocation = "${basePathIcons}icLocation.svg";

  static const icCall = "${basePathIcons}call.svg";
  static const icFacebook = "${basePathIcons}facebook.svg";
  static const icMessenger = "${basePathIcons}messenger.svg";
  static const icMessage = "${basePathIcons}message.svg";
  static const icPhone = "${basePathIcons}phone.svg";
  static const icWhatsapp = "${basePathIcons}whatsapp.svg";

  static const icReports = "${basePathIcons}ic_reports.svg";
  static const icSlowProjects = "${basePathIcons}ic_slow_projects.svg";
  static const icGallery = "${basePathIcons}ic_gallery.svg";
  static const icPendingPCR = "${basePathIcons}ic_pending_pcr.svg";
  static const icPCR = "${basePathIcons}ic_pcr.svg";
  static const icInspectionReport = "${basePathIcons}ic_inspection_report.svg";
  static const icImageUpload = "${basePathIcons}ic_image_upload.svg";
  static const icDelete = "${basePathIcons}ic_delete.svg";
  static const icMap = "${basePathIcons}ic_map.svg";
  static const icNoImage = "${basePathIcons}ic_no_image.svg";
  static const icDate = "${basePathIcons}ic_date.svg";
  static const icUpdateApp = "${basePathIcons}ic_update_app.svg";
}

class PreferenceKey {
  static const isLoggedIn = "is_logged_in";
  static const accessToken = "access_token";
  static const refreshToken = "refresh_token";
  static const tokenType = "token_type";
  static const expiresIn = "expires_in";
  static const userObject = "user_object";
  static const darkMode = "dark_mode";
  static const languageKey = "language_key";
  static const String kIsDark = 'is_dark';
  static const fiscalYearId = "fiscal_year_id";
  static const developmentPlanTypeId = "development_plan_type_id";
  static const TagComeFrom = "TagComeFrom";
  static const currentUserId = "user_id";


/*static const TagRoleName = "role_name";
  static const TagMinistryOfficer = "ministry_officer";
  static const TagDivisionOfficer = "division_officer";
  static const TagAgencyOfficer = "agency_officer";*/
}

class DefaultValue {
  static const int passwordLength = 6;
  static const int codeLength = 6;
  static const int listLimitLarge = 20;
  static const int listLimitMedium = 10;
  static const int listLimitShort = 5;
  static const int listLimitLess = 500;
  static const String languageKey = "en";

  //static int selectedBottomIndex = 2;
  static int selectedBottomIndex = 1;

  static const searchByName = "Name";
  static const searchByCode = "Code";
  static const searchByAgency = "Agency";
}


  //var formatter = NumberFormat('#,##,000');
  var formatter = NumberFormat('#,##0.00');


 const String TotalMyAssignedProjects = "Total My Assigned Ongoing Projects";
 const String TotalOngoingProjects = "Total Ongoing Projects";
 const String TotalOngoingDevelopmentProjects = "Total Ongoing Development Projects";
 const String TotalOngoingTAProjects = "Total Ongoing TA Projects";
 const String TotalOwnFundProjects = "Total Own Fund Projects";
 const String TotalFeasibilityStudyProjects = "Total Feasibility Study Projects";


class WorkflowType {
  static const String Allocation = "Allocation";
  static const String Expenditure = "Expenditure";
  static const String Demand = "Demand";
  static const String AllocationDistribution = "Allocation Distribution";
  static const String FundRelease = "Fund Release";
  static const String FundDistribution = "Fund Distribution";
  static const String AllocationReturn = "Allocation Return";
  static const String Reappropriation = "Reappropriation";
}

class APIConstants {

  static const baseUrl = "http://staging.epmis.gov.bd:8443/api/"; // for staging defaul url
  //static const baseUrl = "https://training.epmis.gov.bd:8443/api/"; // for training
  //static const baseUrl = "https://www.epmis.gov.bd:8443/api/"; // for production


  static const signInUrl = "user-service/api/auth/signin"; // API ID : US001
  static const reNewTokenUrl = "user-service/api/token/renew"; // API ID : US008
 
  static const districtListUrl = "project-service/api/base-locations/2"; // API ID : PS227
  static const userInfoUrl = "user-service/api/users/current_user_id"; // API ID : US007

  static const userListUrl = "user-service/api/search/users"; // API ID : US009

  static const ministryListUrl = "org-model-service/api/ministries"; // API ID : OMS001


  static const myProjectsMinistryListUrl = "project-service/api/my-projects/ministries"; // API ID : PS663


  static const divisionListUrl = "org-model-service/api/ministries/#ministry_id#/nodes"; // API ID : OMS002

  static const myProjectsDivisionListUrl = "project-service/api/my-projects/ministries/#ministry_id#/divisions"; // API ID : PS664


  static const agencyListUrl = "org-model-service/api/agencies/#ministry_id#"; // API ID : OMS003

  static const myProjectsAgencyListUrl = "project-service/api/my-projects/divisions/#ministry_id#/agencies"; // API ID : PS665

  static const currentFiscalYearAndDevelopmentTypeUrl = "project-service/api/projects/current-year-development-type"; // API ID : PS853


  static const agencyListUrlByDivision = "org-model-service/api/agencies/#division_id#"; // API ID : OMS003
  static const pcrAttachmentViewByIDUrl = "project-service/api/projects/completion-report-attachment/#project_id#"; // API ID : PS326
  static const pcrAttachmentUrl = "project-service/api/projects/completion-report-attachment"; // API ID : PS325


  static const landingProjectCountUrl = "project-service/api/projects/project-statistic/count"; // API ID : PS190
  static const projectDetailsByIdUrl = "project-service/api/project/#project_id#"; // API ID : PS025
  static const projectProgressAndCostUrl = "report-service/api/project-statistic/financial-cost/#project_id#/current_fiscal_year_id"; // API ID : RS029

  static const projectUserListUrl = "project-service/api/projects/#project_id#/users"; // API ID : RS029


  static const userOfficeHistoryUrl = "org-model-service/api/user-office-history/#user_id#"; // API ID : OMS014
  static const projectLocationListUrl = "project-service/api/projects/#project_id#/locations"; // API ID : PS104
  static const pdInfoUrl = "project-service/api/projects/#project_id#/users"; // API ID : PS002
  static const allProjectsListUrl = "project-service/api/search/projects"; // API ID : PS017
  static const allPublicProjectsListUrl = "project-service/api/search/public-projects"; // API ID : PS193
  static const myAllProjectsListUrl = "project-service/api/search/my-projects"; // API ID : PS036
  static const projectsListUrl = "project-service/api/project-users/#user_id#/projects"; // API ID : PS090
  static const projectReportListUrl = "report-service/api/project-statistic/financial-cost/#project_id#/current_fiscal_year_id"; // API ID : RS029
  //static const projectEstimatedCostUrl = "project-service/api/projects/financing/#project_id#/estimated-cost-of-project"; // API ID : PS070
  static const projectEstimatedCostUrl = "project-service/api/projects/tapp/financing/source-mode/#project_id#"; // API ID : PS057

  static const projectAllocationCostUrl = "report-service/api/projects/#project_id#/finance/allocation"; // API ID : RS022
  static const projectExpenditureCostUrl = "report-service/api/projects/#project_id#/finance/expenditure"; // API ID : RS028
  static const projectFundReleaseSummaryUrl = "report-service/api/projects/#project_id#/finance/release"; // API ID : RS025
  static const entryForm8ReportUrl = "report-service/api/reports/projects/target-achievement-of-component/#project_expenditure_summary_id#"; // API ID : RS064
  static const projectDataEntryProgressUrl = "report-service/api/projects/#project_id#/data-entry-progress"; // API ID : RS077

  static const fileUploadUrl = "file-service/api/upload"; // API ID : FS002
  static const evidenceFilesUrl = "project-service/api/projects/evidence-files"; // API ID : PS255
  static const evidenceFilesListUrl = "project-service/api/search/projects/files-evidence"; // API ID : PS272
  static const projectInspectionListUrl = "project-service/api/search/project-inspections"; // API ID : PS396
  static const projectImagePathEndUrl = "file-service/api/view/media/"; // API ID : FS008
  static const projectFilePathEndUrl = "file-service/api/download/"; // API ID : FS001

  static const projectProgressUrl = "report-service/api/search/projects/progress"; // API ID : RS040
  static const pcrReceivedStatusUrl = "project-service/api/projects/pcr-received"; // API ID : PS676



  static const workFlowNodeDataUrl = "workflow-service/api/workflows/#workflow_id#/nodes"; // API ID : WFS012
  static const workFlowActivityHistoryDataUrl = "workflow-service/api/workflows/#workflow_id#/history"; // API ID : WFS016
  static const workFlowFinanceSourcesDataUrl = "project-service/api/projects/financing/#workflow_id#/finance-sources"; // API ID : PS217
  static const workFlowAllocationDataUrl = "project-service/api/projects/allocation/#associated_id#"; // API ID : PS239
  static const workflowExpenditureDetailsDataUrl = "project-service/api/projects/financing/expenditures/#associated_id#"; // API ID : PS198
  static const workflowDemandDetailsDataUrl = "project-service/api/projects/financing/demands/#associated_id#"; // API ID : PS229
  static const workflowFundDistributionDetailsDataUrl = "project-service/api/projects/financing/fund-distributions/#associated_id#"; // API ID : PS229
  static const workflowAllocationDistributionDetailsDataUrl = "project-service/api/projects/financing/ratifications/#associated_id#"; // API ID : PS229
  static const workflowFundReleaseDetailsDataUrl = "project-service/api/projects/fund-releases/#associated_id#"; // API ID : PS260
  static const workflowAllocationReturnDetailsDataUrl = "project-service/api/projects/allocation-returns/#associated_id#"; // API ID : PS260
  static const workflowReappropriationDetailsDataUrl = "project-service/api/projects/financing/#project_id#/finance-sources"; // API ID : PS217
  static const workFlowDetailsUrl = "workflow-service/api/projects/workflows/#workflow_type#/#associated_id#"; // API ID : WFS018
  static const workFlowActionsDataUrl = "workflow-service/api/workflow-roles/#Workflow_role_id#/workflow-actions"; // API ID : WFS011
  static const workFlowRolesDataUrl = "workflow-service/api/workflow-roles"; // API ID : WFS005
  static const pendingTaskProjectsListUrl = "workflow-service/api/search/workflow-tasks"; // API ID : WFS017
  static const workflowExpenditureInformationUrl = "project-service/api/projects/search/financing/expenditures/details"; // API ID : PS222
  static const workFlowFileAttachmentUrl = "workflow-service/api/workflow-activity"; // API ID : WFS013


  //response parameter
  static const kEmail = "email";
  static const kPassword = "password";
  static const kMinistryId = "ministry_id";
  static const kPageSize = "pageSize";
  static const kCurrentPage = "current";
  static const kMinistryName = "text";
  static const kMinistryValue = "value";
  static const kTotal = "total";

  static const kFiles = "files";

  static const kUser = "user";

  static const kAccept = "Accept";
  static const kAuthorization = "Authorization";
  static const kAccessToken = "access_token";
  static const kRefreshToken = "refresh_token";

  static const vAccept = "application/json";
  static const vBearer = "Bearer";
}

class ErrorConstants {
  static const unauthorized = "Unauthorized";
}
