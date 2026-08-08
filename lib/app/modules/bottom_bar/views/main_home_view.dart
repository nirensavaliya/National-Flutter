import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/modules/bottom_bar/controllers/bottom_bar_controller.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';
import 'package:shimmer/shimmer.dart';

import '../../../commons/all.dart';
import '../../../data/common_widget/sleepwave_night_sky.dart';

class MainHomeView extends GetView<BottomBarController> {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      builder: (controller) {
        return Stack(
          fit: StackFit.expand,
          children: [
            const SleepwaveNightSky(showClouds: false, starCount: 36),
            Column(
              children: [
                _DashboardAppBar(onLogout: () => showLogoutDialog(context)),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    children: [
                      _AdminHeroCard(
                        onTap: () => Get.toNamed(Routes.SALES_ORDER),
                      ),
                      const Gap(10),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 14,
                        crossAxisSpacing: 14,
                        childAspectRatio: 1.05,
                        children: [
                          DashboardStatCard(
                            title: "Today's Sales",
                            value: controller.todaySale,
                            icon: Icons.trending_up_rounded,
                            isLoading: controller.isLoading,
                            accentColor: SplashColors.accent,
                          ),
                          DashboardStatCard(
                            title: "Monthly Sales",
                            value: controller.monthSale,
                            icon: Icons.bar_chart_rounded,
                            isLoading: controller.isLoading,
                            accentColor: SplashColors.accentSoft,
                          ),
                          DashboardStatCard(
                            title: "Today's Purchase",
                            value: controller.todayPurchase,
                            icon: Icons.shopping_cart_outlined,
                            isLoading: controller.isLoading,
                            accentColor: SplashColors.accent,
                          ),
                          DashboardStatCard(
                            title: "Monthly Purchase",
                            value: controller.monthPurchase,
                            icon: Icons.inventory_2_outlined,
                            isLoading: controller.isLoading,
                            accentColor: SplashColors.accentSoft,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            "Logout",
            style: TextStyle(
              fontFamily: FontFamily.bold,
              color: SplashColors.nightSky,
            ),
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: TextStyle(fontFamily: FontFamily.regular),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black54,
                  fontFamily: FontFamily.medium,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: SplashColors.accent,
                foregroundColor: SplashColors.nightSkyDeep,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                GetStorageData.removeData(GetStorageData.token);
                GetStorageData.removeData(GetStorageData.isAdmin);
                GetStorageData.removeData(GetStorageData.isCustomer);
                GetStorageData.removeData(GetStorageData.isEmployee);
                GetStorageData.saveString(
                    GetStorageData.isOtpVerified, "false");
                Get.offAllNamed(Routes.LOGIN, arguments: {
                  'isEmployee': true,
                });
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  color: SplashColors.nightSkyDeep,
                  fontFamily: FontFamily.medium,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _AdminHeroCard extends StatelessWidget {
  const _AdminHeroCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white.withOpacity(0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            // Soft navy base so left text area stays clean
            const Positioned.fill(
              child: ColoredBox(color: Color(0xFF0B1D46)),
            ),
            // Bed image only — aligned to the right as background
            Positioned.fill(
              child: Image.asset(
                AppImages.adminHeroBed,
                fit: BoxFit.cover,
                alignment: Alignment.centerRight,
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color(0xFF0B1D46),
                      const Color(0xFF0B1D46).withOpacity(0.88),
                      const Color(0xFF0B1D46).withOpacity(0.35),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.36, 0.62, 1.0],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Premium Comfort',
                    style: TextStyle(
                      fontFamily: FontFamily.PlayfairDisplayBold,
                      fontSize: FontSize.s22,
                      color: Colors.white,
                      height: 1.15,
                    ),
                  ),
                  Text(
                    'for Trade Partners',
                    style: TextStyle(
                      fontFamily: FontFamily.bold,
                      fontSize: FontSize.s20,
                      color: SplashColors.accent,
                      height: 1.2,
                    ),
                  ),
                  const Gap(10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Text(
                      'Quality mattresses. Reliable service. Stronger partnerships.',
                      style: TextStyle(
                        fontFamily: FontFamily.regular,
                        fontSize: FontSize.s12,
                        height: 1.35,
                        color: Colors.white.withOpacity(0.88),
                      ),
                    ),
                  ),
                  const Gap(18),
                  // InkWell(
                  //   onTap: onTap,
                  //   borderRadius: BorderRadius.circular(14),
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 16,
                  //       vertical: 12,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: SplashColors.accent,
                  //       borderRadius: BorderRadius.circular(14),
                  //     ),
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         const Icon(
                  //           Icons.description_outlined,
                  //           color: SplashColors.nightSkyDeep,
                  //           size: 18,
                  //         ),
                  //         const Gap(8),
                  //         Text(
                  //           'Open Sales Order',
                  //           style: TextStyle(
                  //             fontFamily: FontFamily.semiBold,
                  //             fontSize: FontSize.s14,
                  //             color: SplashColors.nightSkyDeep,
                  //           ),
                  //         ),
                  //         const Gap(6),
                  //         const Icon(
                  //           Icons.chevron_right_rounded,
                  //           color: SplashColors.nightSkyDeep,
                  //           size: 20,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardAppBar extends StatelessWidget {
  const _DashboardAppBar({required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SplashColors.nightSkyMid,
            SplashColors.nightSky,
            SplashColors.nightSkyDeep,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -20,
            right: -10,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SplashColors.accent.withOpacity(0.08),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: -25,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppString.appName,
                          style: TextStyle(
                            fontFamily: FontFamily.PlayfairDisplayBold,
                            fontSize: FontSize.s20,
                            color: SplashColors.text,
                            letterSpacing: 0.3,
                          ),
                        ),
                        const Gap(6),
                        Container(
                          width: 40,
                          height: 3,
                          decoration: BoxDecoration(
                            color: SplashColors.accent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const Gap(6),
                        Text(
                          'Admin Dashboard',
                          style: TextStyle(
                            fontFamily: FontFamily.medium,
                            fontSize: FontSize.s12,
                            color: SplashColors.accentSoft.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: onLogout,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: SplashColors.accent.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: SplashColors.accent.withOpacity(0.45),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.logout_rounded,
                            color: SplashColors.accent,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontFamily: FontFamily.medium,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardStatCard extends StatelessWidget {
  const DashboardStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.isLoading,
    this.accentColor = SplashColors.accent,
  });

  final String title;
  final String value;
  final IconData icon;
  final bool isLoading;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.16),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: SplashColors.nightSky, size: 20),
          ),
          const Gap(12),
          Text(
            title,
            style: TextStyle(
              fontFamily: FontFamily.medium,
              fontSize: FontSize.s12,
              color: Colors.black54,
            ),
          ),
          const Gap(6),
          isLoading
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: Container(
                    height: 22,
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )
              : Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: FontSize.s18,
                    color: SplashColors.nightSky,
                  ),
                ),
          const Spacer(),
          Container(
            height: 3,
            width: double.infinity,
            decoration: BoxDecoration(
              color: SplashColors.accent.withOpacity(0.85),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardActionTile extends StatelessWidget {
  const DashboardActionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: SplashColors.accent.withOpacity(0.18)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: SplashColors.accent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: SplashColors.nightSky, size: 22),
            ),
            const Gap(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: FontSize.s14,
                      color: SplashColors.nightSky,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontFamily: FontFamily.regular,
                      fontSize: FontSize.s12,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: SplashColors.accent,
            ),
          ],
        ),
      ),
    );
  }
}
