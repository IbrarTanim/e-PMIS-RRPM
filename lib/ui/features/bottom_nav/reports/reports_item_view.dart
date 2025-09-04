import 'package:flutter/material.dart';
import 'package:pmis_flutter/utils/colors.dart';

class ReportsItemView extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData icon;
  final Color? iconColor;

  const ReportsItemView({
    Key? key,
    required this.title,
    required this.onTap,
    this.icon = Icons.assessment,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(12),
        color: cardColor,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (iconColor ?? accentBlue).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? accentBlue,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: newTextColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: inactiveColor, // Light gray for the arrow
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}