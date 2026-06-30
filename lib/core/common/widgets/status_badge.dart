import 'package:flutter/material.dart';
import '../../constant/app_color.dart';
enum BadgeType {
  pending,
  completed,
  active,
  inactive,
}
class StatusBadge extends StatelessWidget {
  final BadgeType type;
  const StatusBadge({
    super.key,
    required this.type,
  });
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color bgColor;
    Color textColor;
    String label;
    switch (type) {
      case BadgeType.pending:
        bgColor = isDark ? AppColor.pendingBgDark : AppColor.pendingBgLight;
        textColor = isDark ? AppColor.pendingTextDark : AppColor.pendingTextLight;
        label = 'Pending';
        break;
      case BadgeType.completed:
        bgColor = isDark ? AppColor.completedBgDark : AppColor.completedBgLight;
        textColor = isDark ? AppColor.completedTextDark : AppColor.completedTextLight;
        label = 'Completed';
        break;
      case BadgeType.active:
        bgColor = isDark ? AppColor.completedBgDark : AppColor.completedBgLight;
        textColor = isDark ? AppColor.completedTextDark : AppColor.completedTextLight;
        label = 'Active';
        break;
      case BadgeType.inactive:
        bgColor = isDark ? AppColor.surfaceDark : AppColor.borderLight;
        textColor = isDark ? AppColor.textSecondaryDark : AppColor.textSecondaryLight;
        label = 'Inactive';
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
