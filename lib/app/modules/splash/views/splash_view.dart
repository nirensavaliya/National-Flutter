import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../commons/app_colors.dart';
import '../../../commons/app_images.dart';
import '../../../commons/app_string.dart';
import '../../../commons/font_family.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _floatCtrl;
  late AnimationController _entranceCtrl;
  late AnimationController _progressCtrl;

  late Animation<double> _topOpacity;
  late Animation<double> _topSlide;
  late Animation<double> _mattressScale;
  late Animation<double> _mattressOpacity;
  late Animation<double> _bottomOpacity;
  late Animation<double> _bottomSlide;

  @override
  void initState() {
    super.initState();
    Get.put(SplashController());

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat();

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    )..forward();

    _progressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _topOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOut),
      ),
    );

    _topSlide = Tween<double>(begin: -24, end: 0).animate(
      CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.0, 0.45, curve: Curves.easeOutCubic),
      ),
    );

    _mattressScale = Tween<double>(begin: 0.62, end: 1.0).animate(
      CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.1, 0.65, curve: Curves.easeOutBack),
      ),
    );

    _mattressOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.08, 0.5, curve: Curves.easeOut),
      ),
    );

    _bottomOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.4, 0.85, curve: Curves.easeOut),
      ),
    );

    _bottomSlide = Tween<double>(begin: 32, end: 0).animate(
      CurvedAnimation(
        parent: _entranceCtrl,
        curve: const Interval(0.4, 0.85, curve: Curves.easeOutCubic),
      ),
    );
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _entranceCtrl.dispose();
    _progressCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _floatCtrl,
          _entranceCtrl,
          _progressCtrl,
        ]),
        builder: (context, _) {
          final floatY = math.sin(_floatCtrl.value * 2 * math.pi) * 10;
          final floatRotate =
              math.sin(_floatCtrl.value * 2 * math.pi) * 0.018;

          return Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.15),
                    radius: 1.15,
                    colors: [
                      SplashColors.primaryLight,
                      SplashColors.primary,
                      SplashColors.primaryDeep,
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
                ),
              ),

              Positioned.fill(
                child: Image.asset(
                  'assets/images/img_bed.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  color: SplashColors.primaryDeep.withOpacity(0.72),
                  colorBlendMode: BlendMode.hardLight,
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      SplashColors.primaryDeep.withOpacity(0.55),
                      Colors.transparent,
                      SplashColors.primaryDeep.withOpacity(0.7),
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),

              CustomPaint(
                painter: SilkRibbonPainter(
                  progress: _floatCtrl.value,
                  color: Colors.white.withOpacity(0.1),
                ),
                size: Size.infinite,
              ),

              // Center(
              //   child: Opacity(
              //     opacity: _mattressOpacity.value,
              //     child: Transform.translate(
              //       offset: Offset(0, floatY),
              //       child: Transform.rotate(
              //         angle: -0.32 + floatRotate,
              //         child: Transform.scale(
              //           scale: _mattressScale.value,
              //           child: Container(
              //             width: size.width * 1.05,
              //             height: size.height * 0.42,
              //             decoration: BoxDecoration(
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: Colors.black.withOpacity(0.35),
              //                   blurRadius: 40,
              //                   offset: const Offset(0, 18),
              //                 ),
              //               ],
              //             ),
              //             child: ClipRRect(
              //               borderRadius: BorderRadius.circular(12),
              //               child: Image.asset(
              //                 'assets/images/img_bed.png',
              //                 fit: BoxFit.cover,
              //                 alignment: const Alignment(0, 0.15),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Opacity(
                      opacity: _topOpacity.value,
                      child: Transform.translate(
                        offset: Offset(0, _topSlide.value),
                        child: Column(
                          children: [
                            Text(
                              'PREMIUM COMFORT',
                              style: TextStyle(
                                fontFamily: FontFamily.medium,
                                fontSize: 11,
                                color: SplashColors.subText.withOpacity(0.85),
                                letterSpacing: 4,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'LUXURY',
                              style: TextStyle(
                                fontFamily: FontFamily.PlayfairDisplayBold,
                                fontSize: 42,
                                color: SplashColors.text,
                                letterSpacing: 2,
                                height: 1,
                              ),
                            ),
                            const SizedBox(height: 10),
                            _lineLabel('MATTRESS'),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Opacity(
                      opacity: _bottomOpacity.value,
                      child: Transform.translate(
                        offset: Offset(0, _bottomSlide.value),
                        child: Column(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  AppImages.appIcon_g,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              AppString.appName.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: FontFamily.bold,
                                fontSize: 20,
                                color: SplashColors.text,
                                letterSpacing: 6,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _lineLabel('PREMIUM MATTRESSES'),
                            const SizedBox(height: 14),
                            Text(
                              'Better Sleep. Better Life.',
                              style: TextStyle(
                                fontFamily: FontFamily.PlayfairDisplayRegular,
                                fontSize: 15,
                                color: SplashColors.subText.withOpacity(0.9),
                              ),
                            ),
                            const SizedBox(height: 28),
                            SizedBox(
                              width: size.width * 0.55,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: LinearProgressIndicator(
                                  value: _progressCtrl.value,
                                  minHeight: 2.5,
                                  backgroundColor: Colors.white24,
                                  valueColor: const AlwaysStoppedAnimation(
                                    SplashColors.text,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _lineLabel(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 1,
          color: SplashColors.subText.withOpacity(0.45),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: FontFamily.medium,
              fontSize: 11,
              color: SplashColors.subText.withOpacity(0.9),
              letterSpacing: 3,
            ),
          ),
        ),
        Container(
          width: 36,
          height: 1,
          color: SplashColors.subText.withOpacity(0.45),
        ),
      ],
    );
  }
}

class SilkRibbonPainter extends CustomPainter {
  SilkRibbonPainter({
    required this.progress,
    required this.color,
  });

  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 48
      ..strokeCap = StrokeCap.round;

    final wave = math.sin(progress * 2 * math.pi) * 18;

    final path = Path()
      ..moveTo(-size.width * 0.1, size.height * 0.52 + wave)
      ..quadraticBezierTo(
        size.width * 0.35,
        size.height * 0.38 - wave,
        size.width * 0.55,
        size.height * 0.5,
      )
      ..quadraticBezierTo(
        size.width * 0.85,
        size.height * 0.66 + wave,
        size.width * 1.1,
        size.height * 0.48,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SilkRibbonPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
