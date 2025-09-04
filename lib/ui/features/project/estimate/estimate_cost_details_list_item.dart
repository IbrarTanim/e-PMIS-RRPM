import 'package:flutter/material.dart';
import 'package:pmis_flutter/data/models/project_estimated_cost_response.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/image_util.dart';
import 'package:pmis_flutter/data/local/constants.dart';

class NewProjectEstimatedCostDetailsItemView extends StatelessWidget {
  final ProjectEstimatedCostResponse projectEstimatedCostResponse;

  const NewProjectEstimatedCostDetailsItemView({
    Key? key,
    required this.projectEstimatedCostResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ProjectFinancialSourceMode>? sourceModes =
        projectEstimatedCostResponse.projectFinancialSourceMode;

    double? govValue;
    if (sourceModes == null || sourceModes.isEmpty) {
      return const SizedBox.shrink(); // return empty view if no data
    }

    return Column(
      children: sourceModes.map((sourceMode) {
        govValue = (sourceMode.cashFe!.toDouble() + sourceMode.cashLocal!.toDouble());

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
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
                        "Mode: ${sourceMode.baseProjectFinancialModeName ?? 'N/A'}",
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D3142),
                        ),
                      ),

                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'GoB: ${formatter.format(govValue)}',
                            style: const TextStyle(
                              color: Color(0xFF9C9CA4),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'GoB FE: ${formatter.format(sourceMode.cashFe ?? 0)}',
                            style: const TextStyle(
                              color: Color(0xFF9C9CA4),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'RPA: ${formatter.format(sourceMode.inKind ?? 0)}',
                            style: const TextStyle(
                              color: Color(0xFF9C9CA4),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'DPA: ${formatter.format(sourceMode.inKind ?? 0)}',
                            style: const TextStyle(
                              color: Color(0xFF9C9CA4),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'Own Fund: ${formatter.format(sourceMode.inKind ?? 0)}',
                            style: const TextStyle(
                              color: Color(0xFF9C9CA4),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Own Fund FE: ${formatter.format(sourceMode.inKind ?? 0)}',
                            style: const TextStyle(
                              color: Color(0xFF9C9CA4),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      /*const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            'Others Fund: ${formatter.format(sourceMode.inKind ?? 0)}',
                            style: const TextStyle(
                              color: Color(0xFF9C9CA4),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Others Fund FE: ${formatter.format(sourceMode.inKind ?? 0)}',
                            style: const TextStyle(
                              color: Color(0xFF9C9CA4),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),*/


                     /* Text(
                        "Source: ${sourceMode.baseProjectFinancialSourceName ?? 'N/A'}",
                        style: const TextStyle(
                          color: Color(0xFF9C9CA4),
                          fontSize: 13,
                        ),
                      ),*/


                      /*if (sourceMode.baseProjectFinancialSourceParentName != null)
                        Text(
                          "Parent: ${sourceMode.baseProjectFinancialSourceParentName!}",
                          style: const TextStyle(
                            color: Color(0xFF9C9CA4),
                            fontSize: 13,
                          ),
                        ),*/



                    ],
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: accentBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    /*'Total: ${formatter.format(sourceMode.cashFe ?? 0)}',*/
                    '${sourceMode.baseProjectFinancialSourceParentName!}',
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
        );
      }).toList(),
    );
  }
}
