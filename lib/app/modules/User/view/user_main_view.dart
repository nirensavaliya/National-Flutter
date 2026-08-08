import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';

import '../../../commons/all.dart';
import '../../../data/common_widget/sleepwave_night_sky.dart';
import '../controller/user_controller.dart';
import '../../sales_order/services/sales_order_cart_service.dart';
import '../../sales_order/views/sales_order_cart_button.dart';

class UserMainHomeView extends GetView<UserMainController> {
  const UserMainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserMainController>(
      builder: (controller) {
        return Stack(
          fit: StackFit.expand,
          children: [
            const SleepwaveNightSky(showClouds: false, starCount: 36),
            Column(
              children: [
                _UserDashboardAppBar(
                  cartItemCount: SalesOrderCartService.itemCount(),
                  onCartTap: () async {
                    await Get.toNamed(Routes.SALES_ORDER_CART);
                    controller.update();
                  },
                  onLogout: () => showLogoutDialog(context),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    children: [
                      const _GreetingBlock(),
                      const Gap(18),
                      _FeatureActionCard(
                        title: AppString.salesOrder,
                        subtitle: 'Create and manage customer sales orders',
                        icon: Icons.note_alt_outlined,
                        isPrimary: true,
                        onTap: () => Get.toNamed(Routes.SALES_ORDER),
                      ),
                      const Gap(12),
                      _FeatureActionCard(
                        title: AppString.itemList,
                        subtitle: 'Browse products, rates and stock details',
                        icon: Icons.inventory_2_outlined,
                        onTap: () => Get.toNamed(Routes.ITEM_LIST),
                      ),
                      const Gap(12),
                      _FeatureActionCard(
                        title: AppString.ledgerStatement,
                        subtitle: 'Check balances and account statements',
                        icon: Icons.receipt_long_outlined,
                        onTap: () => Get.toNamed(Routes.LEDGER_STATEMENT),
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
                GetStorageData.saveString(GetStorageData.isOtpVerified, "false");
                GetStorageData.removeData(GetStorageData.isOtpVerified);
                GetStorageData.removeData(GetStorageData.isAdmin);
                GetStorageData.removeData(GetStorageData.isCustomer);
                GetStorageData.removeData(GetStorageData.isEmployee);
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

class _UserDashboardAppBar extends StatelessWidget {
  const _UserDashboardAppBar({
    required this.onLogout,
    required this.onCartTap,
    required this.cartItemCount,
  });

  final VoidCallback onLogout;
  final VoidCallback onCartTap;
  final int cartItemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF122959),
            SplashColors.nightSky,
            Color(0xFF081B43),
          ],
        ),
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
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
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
                          'Employee Home',
                          style: TextStyle(
                            fontFamily: FontFamily.bold,
                            fontSize: FontSize.s18,
                            color: SplashColors.text,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          AppString.appName,
                          style: TextStyle(
                            fontFamily: FontFamily.medium,
                            fontSize: FontSize.s10,
                            color: Colors.white.withOpacity(0.72),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SalesOrderCartActionButton(
                    itemCount: cartItemCount,
                    onTap: onCartTap,
                  ),
                  const Gap(10),
                  GestureDetector(
                    onTap: onLogout,
                    child: Container(
                      width: 42,
                      height: 42,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: const Icon(
                        Icons.logout_rounded,
                        color: SplashColors.text,
                        size: 18,
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

class _GreetingBlock extends StatelessWidget {
  const _GreetingBlock();

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  String get _dateLabel {
    final now = DateTime.now();
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    const weekdays = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return '${weekdays[now.weekday - 1]}, ${now.day} ${months[now.month - 1]}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _greeting,
          style: TextStyle(
            fontFamily: FontFamily.PlayfairDisplayBold,
            fontSize: FontSize.s24,
            color: SplashColors.text,
          ),
        ),
        const Gap(4),
        Text(
          _dateLabel,
          style: TextStyle(
            fontFamily: FontFamily.regular,
            fontSize: FontSize.s14,
            color: SplashColors.accentSoft.withOpacity(0.9),
          ),
        ),
        const Gap(10),
        Container(
          width: 42,
          height: 3,
          decoration: BoxDecoration(
            color: SplashColors.accent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

class _FeatureActionCard extends StatelessWidget {
  const _FeatureActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            color: isPrimary
                ? SplashColors.accent.withOpacity(0.14)
                : Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isPrimary
                  ? SplashColors.accent.withOpacity(0.45)
                  : Colors.white.withOpacity(0.08),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 14, 16),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: isPrimary
                        ? SplashColors.accent
                        : Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: isPrimary
                        ? SplashColors.nightSkyDeep
                        : SplashColors.accent,
                    size: 26,
                  ),
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
                          fontSize: FontSize.s16,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: FontFamily.regular,
                          fontSize: FontSize.s12,
                          height: 1.3,
                          color: Colors.white.withOpacity(0.72),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: isPrimary ? SplashColors.accent : Colors.white70,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
