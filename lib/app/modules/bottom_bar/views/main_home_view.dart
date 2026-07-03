import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/modules/bottom_bar/controllers/bottom_bar_controller.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';

import '../../../commons/all.dart';

class MainHomeView extends GetView<BottomBarController> {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarController>(
      builder: (controller) {
        return ColoredBox(
          color: const Color(0xFFF4F7F7),
          child: Column(
            children: [
              _DashboardAppBar(onLogout: () => showLogoutDialog(context)),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppString.hiWelcomeBack,
                            style: TextStyle(
                              fontFamily: FontFamily.PlayfairDisplayBold,
                              fontSize: FontSize.s20,
                              color: SplashColors.primaryDark,
                            ),
                          ),
                          const Gap(6),
                          Text(
                            AppString.salesAndPurchase,
                            style: TextStyle(
                              fontFamily: FontFamily.regular,
                              fontSize: FontSize.s14,
                              color: const Color(0xFF78829A),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 14,
                      crossAxisSpacing: 14,
                      childAspectRatio: 1.12,
                      children: [
                        DashboardStatCard(
                          title: "Today's Sales",
                          value: controller.todaySale,
                          icon: Icons.trending_up_rounded,
                          accentColor: SplashColors.primary,
                          onTap: () => Get.toNamed(
                            Routes.SHOW_REPORT,
                            arguments: AppString.todayTotal,
                          ),
                        ),
                        DashboardStatCard(
                          title: "Monthly Sales",
                          value: controller.monthSale,
                          icon: Icons.bar_chart_rounded,
                          accentColor: SplashColors.primaryLight,
                          onTap: () => Get.toNamed(
                            Routes.SHOW_REPORT,
                            arguments: AppString.monthlyTotal,
                          ),
                        ),
                        DashboardStatCard(
                          title: "Today's Purchase",
                          value: controller.todayPurchase,
                          icon: Icons.shopping_cart_outlined,
                          accentColor: SplashColors.primaryDark,
                          onTap: () => Get.toNamed(
                            Routes.SHOW_REPORT,
                            arguments: AppString.todayPurchase,
                          ),
                        ),
                        DashboardStatCard(
                          title: "Monthly Purchase",
                          value: controller.monthPurchase,
                          icon: Icons.inventory_2_outlined,
                          accentColor: SplashColors.primaryDeep,
                          onTap: () => Get.toNamed(
                            Routes.SHOW_REPORT,
                            arguments: AppString.monthlyPurchase,
                          ),
                        ),
                      ],
                    ),
                    if (controller.isAdmin) ...[
                      const Gap(24),
                      Text(
                        'Admin Actions',
                        style: TextStyle(
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSize.s16,
                          color: SplashColors.primaryDark,
                        ),
                      ),
                      const Gap(12),
                      DashboardActionTile(
                        title: 'Customer Feedback',
                        subtitle:
                            'Check Pending Customers and Read Customers Feedback.',
                        icon: Icons.people_outline_rounded,
                        onTap: () => Get.toNamed(Routes.CUSTOMER_VIEW),
                      ),
                      DashboardActionTile(
                        title: 'Promotional Message',
                        subtitle: 'Change Promotional Message.',
                        icon: Icons.campaign_outlined,
                        onTap: () async {
                          final result =
                              await Get.toNamed(Routes.ADD_PROMO_MESSAGE);
                          if (result != null && result is String) {
                            controller.promoMessage.value = result;
                            controller.update();
                          }
                        },
                      ),
                      DashboardActionTile(
                        title: 'Offer Image',
                        subtitle: 'Change Offer Image.',
                        icon: Icons.image_outlined,
                        onTap: () async {
                          final result =
                              await Get.toNamed(Routes.ADD_OFFER_IMAGE);
                          if (result != null && result is String) {
                            controller.apiOfferImageMessage();
                            controller.update();
                          }
                        },
                      ),
                    ],
                    const Gap(8),
                    Obx(() {
                      print("Image URL: ${controller.offerImage.value}");
                      if (controller.offerImage.value.isEmpty) {
                        return const SizedBox();
                      }
                      return Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl: controller.offerImage.value,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: SplashColors.primary,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error, color: Colors.red),
                            fadeInDuration: Duration.zero,
                            fadeOutDuration: Duration.zero,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
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
              color: SplashColors.primaryDark,
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
                backgroundColor: SplashColors.primary,
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
                  color: Colors.white,
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
            SplashColors.primaryDeep,
            SplashColors.primary,
            SplashColors.primaryDark,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: SplashColors.primaryDeep.withOpacity(0.45),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 1,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Decorative soft circles
          Positioned(
            top: -20,
            right: -10,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
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
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
              child: Row(
                children: [
                  // Logo with shadow
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.18),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.asset(
                        AppImages.appIcon_g,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Gap(14),

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
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                            fontFamily: FontFamily.medium,
                            fontSize: FontSize.s12,
                            color: SplashColors.subText.withOpacity(0.95),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Logout button
                  GestureDetector(
                    onTap: onLogout,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.14),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom shine line
          Positioned(
            left: 24,
            right: 24,
            bottom: 0,
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.white.withOpacity(0.35),
                    Colors.transparent,
                  ],
                ),
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
    required this.onTap,
    this.accentColor = SplashColors.primary,
  });

  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onTap;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
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
                color: accentColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: accentColor, size: 20),
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
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: FontFamily.bold,
                fontSize: FontSize.s18,
                color: SplashColors.primaryDark,
              ),
            ),
          ],
        ),
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
          border: Border.all(color: SplashColors.primary.withOpacity(0.12)),
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
                color: SplashColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: SplashColors.primary, size: 22),
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
                      color: SplashColors.primaryDark,
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
              color: SplashColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
