import 'package:flutter/material.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/project_allocation_cost_response.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/image_util.dart';

class NewProjectAllocationCostDetailsItemView extends StatelessWidget {
  final ProjectAllocationCostResponse projectAllocationCostResponse;

  const NewProjectAllocationCostDetailsItemView({
    Key? key,
    required this.projectAllocationCostResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int amountGob = 0;
    double amountGobFe = 0;
    int amountRpa = 0;
    int amountDpa = 0;

    int amountOwnFund = 0;
    int amountOwnFundFe = 0;
    double amountTotal = 0;


    for (AllocationDetail allocationDetail in projectAllocationCostResponse.allocationDetails!) {
      amountGob = amountGob + (allocationDetail?.amountGob ?? 0);
      amountGobFe = amountGobFe + (allocationDetail?.amountGobFe ?? 0);
      amountRpa = amountRpa + (allocationDetail?.amountRpa ?? 0);
      amountDpa = amountDpa + (allocationDetail?.amountDpa ?? 0);
      amountOwnFund = amountOwnFund + (allocationDetail?.amountOwnFund ?? 0);
      amountOwnFundFe = amountOwnFundFe + (allocationDetail?.amountOwnFundFe ?? 0);
    }
    amountTotal = amountGob.toDouble() + amountGobFe + amountRpa.toDouble() + amountDpa.toDouble() + amountOwnFund.toDouble() + amountOwnFundFe.toDouble();

    return Container(
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
                        "${projectAllocationCostResponse.developmentTypeName} ${projectAllocationCostResponse.fiscalYearId}"),
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
                        'GoB: ${formatter.format(amountGob)}',
                        style: const TextStyle(
                          color: Color(0xFF9C9CA4),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'GoB FE: ${formatter.format(amountGobFe)}',
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
                        'RPA: ${formatter.format(amountRpa)}',
                        style: const TextStyle(
                          color: Color(0xFF9C9CA4),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'DPA: ${formatter.format(amountDpa)}',
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
                        'Own Fund: ${formatter.format(amountOwnFund)}',
                        style: const TextStyle(
                          color: Color(0xFF9C9CA4),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Own Fund FE: ${formatter.format(amountOwnFund)}',
                        style: const TextStyle(
                          color: Color(0xFF9C9CA4),
                          fontSize: 13,
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
                'Total: ${formatter.format(amountTotal)}',
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
  }
}