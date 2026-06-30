import 'package:flutter/material.dart';
import '../../constant/app_color.dart';
class MockMap extends StatelessWidget {
  final double radius; // in meters
  const MockMap({
    super.key,
    required this.radius,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = isDark ? AppColor.primaryDark : AppColor.primaryLight;
    final gridColor = isDark ? AppColor.borderDark.withOpacity(0.3) : AppColor.borderLight.withOpacity(0.5);
    final mapBgColor = isDark ? const Color(0xFF131C2E) : const Color(0xFFEBF0F5);
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: mapBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColor.borderDark : AppColor.borderLight,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Custom Paint for Grid & Geofence circle
            Positioned.fill(
              child: CustomPaint(
                painter: _MapPainter(
                  gridColor: gridColor,
                  circleColor: primaryColor.withOpacity(0.15),
                  circleBorderColor: primaryColor.withOpacity(0.6),
                  geofenceRadius: radius,
                ),
              ),
            ),
            // Pin Icon in the center
            Center(
              child: Container(
                padding: const EdgeInsets.only(bottom: 16), // offset to align bottom of pin to center
                child: Icon(
                  Icons.location_on,
                  color: primaryColor,
                  size: 38,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _MapPainter extends CustomPainter {
  final Color gridColor;
  final Color circleColor;
  final Color circleBorderColor;
  final double geofenceRadius;
  _MapPainter({
    required this.gridColor,
    required this.circleColor,
    required this.circleBorderColor,
    required this.geofenceRadius,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.5;
    // Draw Grid Lines (horizontal & vertical roads)
    // We will draw a few main streets to look like a map
    // Vertical road
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.35, 0, 32, size.height),
      gridPaint,
    );
    // Horizontal road
    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0.45, size.width, 32),
      gridPaint,
    );
    // Draw Geofence Circle in the center
    final center = Offset(size.width / 2, size.height / 2);
    // Map radius in pixels based on meters (arbitrary scaling)
    // 150m -> 45 pixels, 180m -> 54 pixels
    final pixelRadius = (geofenceRadius / 150.0) * 50.0;
    final circlePaint = Paint()
      ..color = circleColor
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..color = circleBorderColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, pixelRadius, circlePaint);
    canvas.drawCircle(center, pixelRadius, borderPaint);
  }
  @override
  bool shouldRepaint(covariant _MapPainter oldDelegate) {
    return oldDelegate.geofenceRadius != geofenceRadius ||
        oldDelegate.circleColor != circleColor ||
        oldDelegate.circleBorderColor != circleBorderColor;
  }
}
