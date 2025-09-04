import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/project_expenditure_cost_response.dart';
import 'package:pmis_flutter/data/models/workflow_expenditure_infprmation_response.dart';
import 'package:pmis_flutter/ui/features/project/expenditure/entry_form_8_report_screen.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/image_util.dart';

class WorkflowExpenditureInformationListItem extends StatelessWidget {
  final WorkflowExpenditureInformationResponse projectExpenditureCostResponse;

  const WorkflowExpenditureInformationListItem({
    Key? key,
    required this.projectExpenditureCostResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    /*int summaryAmountGob = 0;
    int summaryAmountGobFe = 0;
    double detailAmountGob = 0;
    int summaryAmountRpa = 0;
    int summaryAmountDpa = 0;
    int summaryAmountOwnFund = 0;
    int summaryAmountOwnFundFe = 0;

    double summaryAmountTotal = 0;*/



    /*for (ExpenditureFinancialSource expenditureDetail in projectExpenditureCostResponse.expenditureFinancialSources!) {

      summaryAmountGob = summaryAmountGob + (expenditureDetail?.summaryAmountGob ?? 0).toInt();
      summaryAmountGobFe = summaryAmountGobFe + (expenditureDetail?.summaryAmountGobFe ?? 0).toInt();
      detailAmountGob = detailAmountGob + (expenditureDetail?.detailAmountGob ?? 0);
      summaryAmountRpa = summaryAmountRpa + (expenditureDetail?.summaryAmountRpa ?? 0);
      summaryAmountDpa = summaryAmountDpa + (expenditureDetail?.summaryAmountDpa ?? 0);
      summaryAmountOwnFund = summaryAmountOwnFund + (expenditureDetail?.summaryAmountOwnFund ?? 0);
      summaryAmountOwnFundFe = summaryAmountOwnFundFe + (expenditureDetail?.summaryAmountOwnFundFe ?? 0);

    }

    summaryAmountTotal = summaryAmountGob + summaryAmountGobFe + detailAmountGob + summaryAmountRpa + summaryAmountDpa + summaryAmountOwnFund + summaryAmountOwnFundFe;*/

    return InkWell(

      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              offset: const Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: accentGreen.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: showImageAsset(
                  imagePath: AssetConstants.icTaka,
                  height: 20,
                  width: 20,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stringNullCheck(
                          "${projectExpenditureCostResponse.description} ${projectExpenditureCostResponse.baseUnitName}"),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3142),
                      ),
                    ),


                    const SizedBox(height: 4),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'GoB: ',
                                style: TextStyle(
                                  color: Color(0xFF9C9CA4),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: projectExpenditureCostResponse.description,
                                style: const TextStyle(
                                  color: Color(0xFF9C9CA4),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'GoB FE: ',
                                style: TextStyle(
                                  color: Color(0xFF9C9CA4),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: projectExpenditureCostResponse.description,
                                style: const TextStyle(
                                  color: Color(0xFF9C9CA4),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'RPA: ',
                                style: TextStyle(
                                  color: Color(0xFF9C9CA4),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: projectExpenditureCostResponse.description,
                                style: const TextStyle(
                                  color: Color(0xFF9C9CA4),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'DPA: ',
                                style: TextStyle(
                                  color: Color(0xFF9C9CA4),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: projectExpenditureCostResponse.description,
                                style: const TextStyle(
                                  color: Color(0xFF9C9CA4),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Own Fund: ',
                                style: TextStyle(
                                  color: Color(0xFF9C9CA4),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: projectExpenditureCostResponse.description,
                                style: const TextStyle(
                                  color: Color(0xFF9C9CA4),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Own Fund FE: ',
                                style: TextStyle(
                                  color: Color(0xFF9C9CA4),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: projectExpenditureCostResponse.description,
                                style: const TextStyle(
                                  color: Color(0xFF9C9CA4),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: accentBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Total: ${projectExpenditureCostResponse.description}',
                  style: TextStyle(
                    color: accentBlue,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
