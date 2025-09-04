import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/data/models/project_user_list_response.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/common_utils.dart';
import 'package:pmis_flutter/utils/common_widget.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget NewUserListItemView(
    BuildContext context, ProjectUserListResponse userListResponse,
    {bool? isFavorite = true}) {
  return Container(
    decoration: BoxDecoration(
      color: cardColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 3,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    child: userListResponse.isNull
        ? showEmptyViewForUserList()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(
                "Full Name",
                "${userListResponse.firstName} ${userListResponse.lastName}",
              ),
              _divider(),
              _buildInfoRow(
                "Designation",
                userListResponse.designationName ?? "N/A",
              ),
              _divider(),
              // _buildInfoRow(
              //   "Role Name",
              //   userListResponse.roleName ?? "N/A",
              // ),
              // _divider(),
              _buildInfoRow(
                "Project Role",
                userListResponse.roleTitle ?? "N/A",
              ),
              // TODO: Maybe should not show this for PD info tab
              _buildInfoRow(
                "Office Name",
                userListResponse.officeName ?? "N/A",
              ),
              _divider(),
              _divider(),
              _buildInfoRow(
                "Email",
                userListResponse.email ?? "N/A",
              ),
              _divider(),
              _buildInfoRow(
                "Mobile",
                userListResponse.mobile ?? "N/A",
              ),
              const SizedBox(height: 7),
              _buildContactRow(userListResponse),
            ],
          ),
  );
}

Widget _buildInfoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13.5,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13.5,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}

Widget _divider() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 1),
    child: Divider(
      thickness: 0.8,
      color: bgColor,
    ),
  );
}

Widget _buildContactRow(ProjectUserListResponse userListResponse) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _contactItem(
        icon: AssetConstants.icCall,
        title: "Phone",
        onClick: () {
          launchUrlString("tel:${userListResponse.mobile}");
        },
      ),
      const SizedBox(width: 20),
      _contactItem(
        icon: AssetConstants.icMessage,
        title: "Message",
        onClick: () {
          launchUrlString("sms:${userListResponse.mobile}");
        },
      ),
      const SizedBox(width: 20),
      _contactItem(
        icon: AssetConstants.icEmail,
        title: "Email",
        onClick: () {
          launchUrlString("mailto:${userListResponse.email}");
        },
      ),
    ],
  );
}

Widget _contactItem(
    {required String icon,
    required String title,
    required Function() onClick}) {
  return InkWell(
    onTap: onClick,
    child: Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: accentBlue,
          child: SvgPicture.asset(
            icon,
            color: Colors.white,
            height: 13,
            width: 13,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black87,
          ),
        ),
      ],
    ),
  );
}
