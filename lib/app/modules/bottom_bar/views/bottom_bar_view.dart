import 'dart:io';

import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gap/gap.dart';

import '../controllers/bottom_bar_controller.dart';

class BottomBarView extends GetView<BottomBarController> {
  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      builder: (controller) {
        final bottomPad = MediaQuery.of(context).padding.bottom;

        return Scaffold(
          backgroundColor: const Color(0xFFF4F7F7),
          body: controller.screen[controller.indexCount.value],
          bottomNavigationBar: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            padding: EdgeInsets.only(
              top: 10,
              bottom: 5
              /*
              bottom: bottomPad > 0 ? bottomPad : (Platform.isIOS ? 0 : 0),
*/
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: SplashColors.primaryDeep.withOpacity(0.18),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                _BottomNavItem(
                  index: 0,
                  currentIndex: controller.indexCount.value,
                  icon: AppImages.home,
                  label: AppString.main,
                  onTap: () {
                    controller.indexCount.value = 0;
                    controller.update();
                  },
                ),
                _BottomNavItem(
                  index: 1,
                  currentIndex: controller.indexCount.value,
                  icon: AppImages.transaction,
                  label: AppString.transaction,
                  onTap: () {
                    controller.indexCount.value = 1;
                    controller.update();
                  },
                ),
                _BottomNavItem(
                  index: 2,
                  currentIndex: controller.indexCount.value,
                  icon: AppImages.report,
                  label: AppString.reports,
                  onTap: () {
                    controller.indexCount.value = 2;
                    controller.update();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final int index;
  final int currentIndex;
  final String icon;
  final String label;
  final VoidCallback onTap;

  bool get isActive => index == currentIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: isActive
                ? SplashColors.primary.withOpacity(0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: isActive
                      ? SplashColors.primary.withOpacity(0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(
                  icon,
                  height: 22,
                  color: isActive
                      ? SplashColors.primary
                      : const Color(0xFF9AA3AD),
                ),
              ),
              const Gap(4),
              Text(
                label,
                style: TextStyle(
                  fontFamily: isActive
                      ? FontFamily.semiBold
                      : FontFamily.medium,
                  fontSize: FontSize.s12,
                  color: isActive
                      ? SplashColors.primaryDark
                      : const Color(0xFF9AA3AD),
                ),
              ),
              const Gap(2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: isActive ? 18 : 0,
                height: 3,
                decoration: BoxDecoration(
                  color: SplashColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}