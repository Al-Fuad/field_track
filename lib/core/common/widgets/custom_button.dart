import 'dart:ui';
import 'package:flutter/material.dart';
import '../../constant/app_color.dart';
enum CustomButtonStyle {
  filled,
  outlined,
  dashed,
  danger,
}
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CustomButtonStyle style;
  final IconData? icon;
  final bool isLoading;
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style = CustomButtonStyle.filled,
    this.icon,
    this.isLoading = false,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = isDark ? AppColor.primaryDark : AppColor.primaryLight;
    final textColor = style == CustomButtonStyle.filled
        ? (isDark ? AppColor.backgroundDark : Colors.white)
        : (style == CustomButtonStyle.danger
            ? (isDark ? AppColor.dangerTextDark : AppColor.dangerTextLight)
            : primaryColor);
    Widget childContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, color: textColor, size: 20),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
    if (isLoading) {
      childContent = SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }
    if (style == CustomButtonStyle.filled) {
      return ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          disabledBackgroundColor: primaryColor.withOpacity(0.6),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: childContent,
      );
    } else if (style == CustomButtonStyle.outlined) {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: primaryColor, width: 1),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: childContent,
      );
    } else if (style == CustomButtonStyle.danger) {
      final dangerColor = isDark ? AppColor.dangerTextDark : AppColor.dangerTextLight;
      final dangerBg = isDark ? AppColor.dangerBgDark : AppColor.dangerBgLight;
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: dangerColor, width: 1),
          backgroundColor: dangerBg.withOpacity(0.2),
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: childContent,
      );
    } else {
      // Dashed style
      return InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(12),
        child: CustomPaint(
          painter: _DashedBorderPainter(
            color: primaryColor,
            strokeWidth: 1.5,
            gap: 4,
            radius: 12,
          ),
          child: Container(
            height: 56,
            width: double.infinity,
            alignment: Alignment.center,
            child: childContent,
          ),
        ),
      );
    }
  }
}
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double radius;
  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
    required this.radius,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));
    final dashPath = Path();
    double distance = 0.0;
    for (final PathMetric measurePath in path.computeMetrics()) {
      while (distance < measurePath.length) {
        final double length = gap;
        dashPath.addPath(
          measurePath.extractPath(distance, distance + length),
          Offset.zero,
        );
        distance += length * 2;
      }
    }
    canvas.drawPath(dashPath, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
