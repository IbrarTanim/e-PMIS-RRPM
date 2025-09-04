// To parse this JSON data, do
//
//     final landingProjectCountResponse = landingProjectCountResponseFromJson(jsonString);

import 'dart:convert';

LandingProjectCountResponse landingProjectCountResponseFromJson(String str) => LandingProjectCountResponse.fromJson(json.decode(str));

String landingProjectCountResponseToJson(LandingProjectCountResponse data) => json.encode(data.toJson());

class LandingProjectCountResponse {
  int? totalGobProjects;
  int? totalInvestmentProjects;
  int? totalTechnicalAssistantProjects;
  int? currentYearAllocatedInvestmentProjects;
  int? currentYearAllocatedTechnicalAssistantProjects;
  int? currentYearAllocatedAdpRadpProjects;
  int? currentYearAllocatedInvestmentProjectsExcludingOwnFund;
  int? currentYearAllocatedTechnicalAssistantProjectsExcludingOwnFund;
  int? feasibilityStudyProjects;
  int? totalAdpRadpProjects;
  int? totalFastTrackProjects;
  int? totalClosedProjects;
  int? totalOwnFundedProjects;
  int? pdAssignedInOngoingProjects;
  int? projectDirectorOfOngoingProjects;

  LandingProjectCountResponse({
    this.totalGobProjects,
    this.totalInvestmentProjects,
    this.totalTechnicalAssistantProjects,
    this.currentYearAllocatedInvestmentProjects,
    this.currentYearAllocatedTechnicalAssistantProjects,
    this.currentYearAllocatedAdpRadpProjects,
    this.currentYearAllocatedInvestmentProjectsExcludingOwnFund,
    this.currentYearAllocatedTechnicalAssistantProjectsExcludingOwnFund,
    this.feasibilityStudyProjects,
    this.totalAdpRadpProjects,
    this.totalFastTrackProjects,
    this.totalClosedProjects,
    this.totalOwnFundedProjects,
    this.pdAssignedInOngoingProjects,
    this.projectDirectorOfOngoingProjects,
  });

  factory LandingProjectCountResponse.fromJson(Map<String, dynamic> json) => LandingProjectCountResponse(
    totalGobProjects: json["total_gob_projects"]?.round(),
    totalInvestmentProjects: json["total_investment_projects"]?.round(),
    totalTechnicalAssistantProjects: json["total_technical_assistant_projects"]?.round(),
    currentYearAllocatedInvestmentProjects: json["current_year_allocated_investment_projects"]?.round(),
    currentYearAllocatedTechnicalAssistantProjects: json["current_year_allocated_technical_assistant_projects"]?.round(),
    currentYearAllocatedAdpRadpProjects: json["current_year_allocated_adp_radp_projects"]?.round(),
    currentYearAllocatedInvestmentProjectsExcludingOwnFund: json["current_year_allocated_investment_projects_excluding_own_fund_and_feasibility_study"]?.round(),
    currentYearAllocatedTechnicalAssistantProjectsExcludingOwnFund: json["current_year_allocated_technical_assistant_projects_excluding_own_fund_and_feasibility_study"]?.round(),
    feasibilityStudyProjects: json["feasibility_study_projects"]?.round(),
    totalAdpRadpProjects: json["total_adp_radp_projects"]?.round(),
    totalFastTrackProjects: json["total_fast_track_projects"]?.round(),
    totalClosedProjects: json["total_closed_projects"]?.round(),
    totalOwnFundedProjects: json["total_own_funded_projects"]?.round(),
    pdAssignedInOngoingProjects: json["pd_assigned_in_ongoing_projects"]?.round(),
    projectDirectorOfOngoingProjects: json["project_director_of_ongoing_projects"]?.round(),
  );

  Map<String, dynamic> toJson() => {
    "total_gob_projects": totalGobProjects,
    "total_investment_projects": totalInvestmentProjects,
    "total_technical_assistant_projects": totalTechnicalAssistantProjects,
    "current_year_allocated_investment_projects": currentYearAllocatedInvestmentProjects,
    "current_year_allocated_technical_assistant_projects": currentYearAllocatedTechnicalAssistantProjects,
    "current_year_allocated_adp_radp_projects": currentYearAllocatedAdpRadpProjects,
    "current_year_allocated_investment_projects_excluding_own_fund_and_feasibility_study": currentYearAllocatedInvestmentProjectsExcludingOwnFund,
    "current_year_allocated_technical_assistant_projects_excluding_own_fund_and_feasibility_study": currentYearAllocatedTechnicalAssistantProjectsExcludingOwnFund,
    "feasibility_study_projects": feasibilityStudyProjects,
    "total_adp_radp_projects": totalAdpRadpProjects,
    "total_fast_track_projects": totalFastTrackProjects,
    "total_closed_projects": totalClosedProjects,
    "total_own_funded_projects": totalOwnFundedProjects,
    "pd_assigned_in_ongoing_projects": pdAssignedInOngoingProjects,
    "project_director_of_ongoing_projects": projectDirectorOfOngoingProjects,
  };
}
