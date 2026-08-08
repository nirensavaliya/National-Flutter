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
          backgroundColor: SplashColors.nightSky,
          body: controller.screen[controller.indexCount.value],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: SplashColors.nightSkyDeep,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
              border: Border(
                top: BorderSide(
                  color: SplashColors.accent.withOpacity(0.18),
                  width: 1,
                ),
              ),
            ),
            padding: EdgeInsets.only(
              top: 6,
              bottom: bottomPad > 0 ? bottomPad : 10,
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
    final activeColor = SplashColors.accent;
    final inactiveColor = Colors.white.withOpacity(0.55);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOutCubic,
              width: isActive ? 28 : 0,
              height: 3,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(2),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: activeColor.withOpacity(0.45),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: isActive
                    ? SplashColors.accent.withOpacity(0.12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                icon,
                height: 22,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
            const Gap(4),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily:
                    isActive ? FontFamily.semiBold : FontFamily.medium,
                fontSize: FontSize.s12,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
