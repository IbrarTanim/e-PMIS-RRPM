import 'package:flutter/material.dart';
import 'package:pmis_flutter/data/models/pending_task_list_response.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/date_util.dart';


class ProjectHeaderCardWorkflow extends StatelessWidget {
  final PendingTaskResponse projectData;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? child;

  const ProjectHeaderCardWorkflow({
    Key? key,
    required this.projectData,
    this.onTap,
    this.onLongPress,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onLongPress: onLongPress,
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    projectData.projectId != null ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: accentBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(projectData.projectId != null ? projectData.fromUserName.toString() : "",
                        style: const TextStyle(
                          color: accentBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ) : SizedBox(),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: accentGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: accentGreenText,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text("${formatDateToDDMMYYYY(projectData.timestamp.toString())}, ${formatDateToHHMMAPM(projectData.timestamp.toString())} ",
                            //text: "${formatDateToDDMMYYYY(allProjectsResponse.timestamp.toString())}, ${formatDateToHHMMAPM(allProjectsResponse.timestamp.toString())} ",
                            style: const TextStyle(
                              color: accentGreenText,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(projectData.projectName.toString(),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Row(
                  children: [
                    Text("Initiator :"+ " " + projectData.initiatorName.toString(),
                      style: const TextStyle(
                        color: accentGreenText,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 30),
                    Text(projectData.workflowStatus.toString(),
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                if (child != null) ...[
                  const SizedBox(height: 12),
                  child!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
