// New file: custom_drawer.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pmis_flutter/data/local/constants.dart';
import 'package:pmis_flutter/ui/features/bottom_nav/my_project/my_project_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/district_wise/district_wise_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/about_app/about_app_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/all_projects/all_projects_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/fast_track/fast_track_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/pd_directory/pd_details/pd_details_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/pd_directory/pd_directory_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/profile/profile_screen.dart';
import 'package:pmis_flutter/ui/features/drawer_menu/projects/projects_screen.dart';
import 'package:pmis_flutter/utils/colors.dart';
import 'package:pmis_flutter/utils/dimens.dart';
import 'package:pmis_flutter/utils/image_util.dart';

// Zabir
class DrawerMenu extends StatelessWidget {
  final String userName;
  final String designation;
  final VoidCallback onLogout;

  const DrawerMenu({
    Key? key,
    required this.userName,
    required this.designation,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _buildMenuItem(
                      icon: Icons.person_outline,
                      title: 'Profile',
                      onTap: () => Get.to(() => const ProfileScreen()),
                      color: const Color(0xFF4A90E2),
                    ),
                    _buildMenuItem(
                      icon: Icons.group_outlined,
                      title: 'PD Directory',
                      onTap: () => Get.to(() => const PdDirectoryScreen()),
                      color: const Color(0xFF00D1A7),
                    ),
                    /*_buildMenuItem(
                      icon: Icons.location_on_outlined,
                      title: 'District Wise',
                      onTap: () => Get.to(() => const DistrictWiseScreen()),
                      color: const Color(0xFF9B59B6),
                    ),*/
                    _buildMenuItem(
                      icon: Icons.speed_outlined,
                      title: 'Fast Track',
                      onTap: () => Get.to(() => const FastTrackScreen()),
                      color: const Color(0xFFE67E22),
                    ),
                    _buildMenuItem(
                      icon: Icons.folder_special_outlined,
                      title: 'All Projects',
                      onTap: () => Get.to(() => const AllProjectsScreen()),
                      color: const Color(0xFF16A085),
                    ),
                    _buildMenuItem(
                      icon: Icons.work_outline,
                      title: 'My Assigned Projects',
                      //onTap: () => Get.to(() => const MyProjectScreen()),
                      onTap: () => Get.to(() => const ProjectsScreen()),
                      color: const Color(0xFF27AE60),
                    ),
                    /*_buildMenuItem(
                      icon: Icons.info_outline,
                      title: 'About App',
                      onTap: () => Get.to(() => const AboutAppScreen()),
                      color: const Color(0xFF34495E),
                    ),*/
                    _buildMenuItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      onTap: onLogout,
                      color: const Color(0xFFC0392B),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity, // This ensures full width
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentBlue,
            accentGreen,
          ],
        ),
      ),
      padding: const EdgeInsets.only(
        top: 40,
        bottom: 20,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white.withOpacity(0.9),
            child: showImageAsset(
              imagePath: AssetConstants.avatar,
              height: dp120,
              width: dp120,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            designation,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      dense: true,
      onTap: onTap,
    );
  }
}
