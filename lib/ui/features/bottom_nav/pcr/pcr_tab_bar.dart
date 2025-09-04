import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/utils/colors.dart';

class PCRTabs extends StatelessWidget {
  final TabController? controller;
  final Function(int)? onTap;
  final int pcrReceivedCount;
  final int pcrNotReceivedCount;

  const PCRTabs({
    Key? key,
    required this.controller,
    this.onTap,
    this.pcrReceivedCount = 0,
    this.pcrNotReceivedCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return const SizedBox.shrink();
    }

    return Container(
      child: TabBar(
        controller: controller,
        onTap: onTap,
        labelColor: accentBlue,
        unselectedLabelColor: Colors.grey.shade600,
        indicatorColor: accentBlue,
        indicatorWeight: 3,
        labelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w800,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        tabs: [
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("PCRReceived".tr),
                const SizedBox(width: 4),
                Text(
                  "($pcrReceivedCount)",
                  style: TextStyle(
                    color: controller!.index == 0 ? accentBlue : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("PCRNotReceived".tr),
                const SizedBox(width: 4),
                Text(
                  "($pcrNotReceivedCount)",
                  style: TextStyle(
                    color: controller!.index == 1 ? accentBlue : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}