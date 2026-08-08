import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../commons/app_colors.dart';

/// Shared Sleepwave night-sky background (gradient + twinkling stars + optional clouds).
/// Used by Splash and Login so both screens feel continuous.
class SleepwaveNightSky extends StatefulWidget {
  const SleepwaveNightSky({
    super.key,
    this.showClouds = true,
    this.starCount = 48,
  });

  final bool showClouds;
  final int starCount;

  @override
  State<SleepwaveNightSky> createState() => _SleepwaveNightSkyState();
}

class _SleepwaveNightSkyState extends State<SleepwaveNightSky>
    with SingleTickerProviderStateMixin {
  late final AnimationController _twinkleCtrl;

  @override
  void initState() {
    super.initState();
    _twinkleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();
  }

  @override
  void dispose() {
    _twinkleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _twinkleCtrl,
      builder: (context, _) {
        return Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    SplashColors.nightSkyMid,
                    SplashColors.nightSky,
                    SplashColors.nightSkyDeep,
                  ],
                  stops: [0.0, 0.45, 1.0],
                ),
              ),
            ),
            CustomPaint(
              painter: SleepwaveStarFieldPainter(
                twinkle: _twinkleCtrl.value,
                starCount: widget.starCount,
              ),
              size: Size.infinite,
            ),
            if (widget.showClouds)
              Positioned(
                left: -40,
                right: -40,
                bottom: -30,
                child: Opacity(
                  opacity: 0.9,
                  child: CustomPaint(
                    painter: SleepwaveCloudPainter(),
                    size: const Size(double.infinity, 160),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class SleepwaveStarFieldPainter extends CustomPainter {
  SleepwaveStarFieldPainter({
    required this.twinkle,
    this.starCount = 48,
  });

  final double twinkle;
  final int starCount;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final rnd = math.Random(42);

    for (var i = 0; i < starCount; i++) {
      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height * 0.85;
      final r = 0.6 + rnd.nextDouble() * 1.4;
      final pulse = 0.35 +
          0.65 *
              (0.5 +
                  0.5 * math.sin((twinkle + i * 0.07) * 2 * math.pi));
      paint.color = Colors.white.withOpacity(0.15 + pulse * 0.55);
      canvas.drawCircle(Offset(x, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(SleepwaveStarFieldPainter oldDelegate) =>
      oldDelegate.twinkle != twinkle || oldDelegate.starCount != starCount;
}

class SleepwaveCloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A2F55).withOpacity(0.95)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height)
      ..lineTo(0, size.height * 0.55)
      ..quadraticBezierTo(
        size.width * 0.18,
        size.height * 0.15,
        size.width * 0.38,
        size.height * 0.48,
      )
      ..quadraticBezierTo(
        size.width * 0.55,
        size.height * 0.78,
        size.width * 0.72,
        size.height * 0.42,
      )
      ..quadraticBezierTo(
        size.width * 0.9,
        size.height * 0.12,
        size.width,
        size.height * 0.5,
      )
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);

    final soft = Paint()
      ..color = SplashColors.accent.withOpacity(0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 24);
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.7),
      80,
      soft,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
