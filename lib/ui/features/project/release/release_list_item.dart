import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/project_expenditure_cost_response.dart';
import 'package:pmis_flutter/data/models/project_fund_release_summary_response.dart';
import 'package:pmis_flutter/ui/features/project/expenditure/entry_form_8_report_screen.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/image_util.dart';

class NewProjectFundReleaseSummeryDetailsItemView extends StatelessWidget {
  final ProjectFundReleaseSummaryResponse projectFundReleaseSummaryResponse;

  const NewProjectFundReleaseSummeryDetailsItemView({
    Key? key,
    required this.projectFundReleaseSummaryResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {



    int? amountGob = projectFundReleaseSummaryResponse.releaseDetails?.amountGob ?? 0;
    int? amountGobFe = projectFundReleaseSummaryResponse.releaseDetails?.amountGobFe ?? 0;
    int? amountRpa = projectFundReleaseSummaryResponse.releaseDetails?.amountRpa ?? 0;
    int? amountDpa = projectFundReleaseSummaryResponse.releaseDetails?.amountDpa ?? 0;
    int? amountOwnFund = projectFundReleaseSummaryResponse.releaseDetails?.amountOwnFund ?? 0;
    int? amountOwnFundFe = projectFundReleaseSummaryResponse.releaseDetails?.amountOwnFundFe ?? 0;

    int summaryAmountTotal = amountGob + amountGobFe + amountRpa + amountDpa + amountOwnFund + amountOwnFundFe;

    String _cleanQuarterName(String? name) {
      if (name == null) return '';
      return name
          .replaceAll(RegExp(r'\s*Quarter', caseSensitive: false), '') // Remove "Quarter"
          .trim();
    }

    String baseYearQuarterNames = projectFundReleaseSummaryResponse.releaseQuarters == null
        ? ''
        : projectFundReleaseSummaryResponse.releaseQuarters!
        .map((q) => _cleanQuarterName(q.baseYearQuarterName))
        .whereType<String>()
        .join(', ');


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
                      //stringNullCheck("${projectFundReleaseSummaryResponse.monthName} ${projectFundReleaseSummaryResponse.fiscalYearId}"),
                      stringNullCheck("${projectFundReleaseSummaryResponse.fiscalYearId}"),
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
                                text: formatter.format(amountGob),
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
                                text: formatter.format(amountGobFe),
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
                                text: formatter.format(amountRpa),
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
                                text: formatter.format(amountDpa),
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
                                text: formatter.format(amountOwnFund),
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
                                text: formatter.format(amountOwnFundFe),
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



                    const SizedBox(height: 3),


                    Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Release Quarter: ',
                                style: TextStyle(
                                  color: Color(0xFF9C9CA4),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: baseYearQuarterNames,
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),







                    /*Row(
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Release Quarter: ',
                                style: TextStyle(
                                  color: Color(0xFF9C9CA4),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              *//*TextSpan(
                                text: baseYearQuarterName,
                                style: TextStyle(
                                  color:Colors.green,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              )*//*



                              TextSpan(
                                text: projectFundReleaseSummaryResponse.releaseQuarters
                                    ?.map((q) => q.baseYearQuarterName)
                                    .where((name) => name != null)
                                    .join(', ') ??
                                    "N/A",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),



                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),*/

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
                  'Total: ${formatter.format(summaryAmountTotal)}',
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
