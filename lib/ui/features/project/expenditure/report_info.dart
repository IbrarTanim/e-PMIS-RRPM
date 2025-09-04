import 'package:flutter/material.dart';
import 'package:pmis_flutter/data/models/EntryForm8ListResponse.dart';
import 'package:pmis_flutter/utils/colors.dart';

class EntryForm8ReportInfo extends StatelessWidget {
  final EconCodeTypeDetail econCodeDetail;

  const EntryForm8ReportInfo({Key? key, required this.econCodeDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Component Type Header
            Text(
              econCodeDetail.economicCodesTypeName ?? econCodeDetail.economicCodesTypeNameBangla ?? '',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            if (econCodeDetail.targetAchievementData?.isNotEmpty == true) ...[
              const SizedBox(height: 12),
              ...econCodeDetail.targetAchievementData!.map((achievement) => 
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Work Component Description
                      Text(
                        "${achievement.baseEconomicCode} - ${achievement.baseEconomicCodesDescription}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Progress Container
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Text(
                                    "Financial: ",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${achievement.financialProgressOfCurrentMonth ?? 0}",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: accentBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  const Text(
                                    "Physical %: ",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "${achievement.physicalProgressOfCurrentMonth ?? 0}",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: accentBlue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ).toList(),
            ],
          ],
        ),
      ),
    );
  }
}