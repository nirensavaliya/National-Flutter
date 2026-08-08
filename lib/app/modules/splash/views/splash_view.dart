import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../commons/app_colors.dart';
import '../../../commons/app_images.dart';
import '../../../commons/app_string.dart';
import '../../../commons/font_family.dart';
import '../../../data/common_widget/sleepwave_night_sky.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Get.put(SplashController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SplashColors.nightSky,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const SleepwaveNightSky(),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: SplashColors.accent.withOpacity(0.35),
                        blurRadius: 28,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(
                      color: SplashColors.accent.withOpacity(0.65),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Image.asset(
                      AppImages.appIcon_g,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  AppString.appName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontFamily.PlayfairDisplayBold,
                    fontSize: 30,
                    color: SplashColors.text,
                    letterSpacing: 0.5,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 56,
                  height: 3,
                  decoration: BoxDecoration(
                    color: SplashColors.accent,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Premium Comfort. Better Sleep.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontFamily.medium,
                    fontSize: 13,
                    color: SplashColors.accentSoft.withOpacity(0.9),
                    letterSpacing: 0.8,
                  ),
                ),
                const Spacer(flex: 2),
                const SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation(SplashColors.accent),
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _badge('Health & Hygiene'),
                    const SizedBox(width: 10),
                    _badge('Trusted Trade'),
                  ],
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: SplashColors.accent.withOpacity(0.35)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: FontFamily.medium,
          fontSize: 11,
          color: Colors.white.withOpacity(0.9),
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
