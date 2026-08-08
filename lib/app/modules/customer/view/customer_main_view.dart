import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/modules/customer/controllers/customer_controller.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../commons/all.dart';
import '../../../data/common_widget/sleepwave_night_sky.dart';

class CustomerMainHomeView extends GetView<CustomerMainController> {
  const CustomerMainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerMainController>(
      builder: (controller) {
        return Stack(
          fit: StackFit.expand,
          children: [
            const SleepwaveNightSky(showClouds: false, starCount: 34),
            Column(
              children: [
                _CustomerDashboardAppBar(
                  onProfileTap: () => Get.toNamed(Routes.PROFILE),
                  onLogout: () => showLogoutDialog(context),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                    children: [
                      Text(
                        'NATIONAL MATTRESS',
                        style: TextStyle(
                          fontFamily: FontFamily.medium,
                          fontSize: FontSize.s10,
                          letterSpacing: 3,
                          color: SplashColors.text.withOpacity(0.88),
                        ),
                      ),
                      const Gap(14),
                      _CustomerHeroCard(
                        onTap: () =>
                            Get.toNamed(Routes.ADD_SALE_ORDER_CUSTOMER),
                      ),
                      const Gap(18),
                      GestureDetector(
                        onTap: () {},
                        child: Constants.promoMessageModel.message !=
                                "No promotional message available."
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: SplashColors.accent.withOpacity(0.18),
                                  ),
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
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: SplashColors.accent.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.local_offer_outlined,
                                        color: SplashColors.nightSky,
                                        size: 22,
                                      ),
                                    ),
                                    const Gap(12),
                                    Expanded(
                                      child: SizedBox(
                                        height: 22,
                                        child: Marquee(
                                          key: ValueKey(
                                            (Constants.promoMessageModel.message
                                                        ?.trim()
                                                        .isNotEmpty ??
                                                    false)
                                                ? Constants.promoMessageModel
                                                    .message!
                                                    .trim()
                                                : "No promotional message available.",
                                          ),
                                          text: (Constants.promoMessageModel.message
                                                      ?.trim()
                                                      .isNotEmpty ??
                                                  false)
                                              ? Constants.promoMessageModel.message!
                                                  .trim()
                                              : "No promotional message available.",
                                          style: TextStyle(
                                            color: SplashColors.nightSky,
                                            fontSize: FontSize.s14,
                                            fontFamily: FontFamily.semiBold,
                                          ),
                                          scrollAxis: Axis.horizontal,
                                          blankSpace: 50,
                                          velocity: 30,
                                          pauseAfterRound:
                                              const Duration(seconds: 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ),
                      const _SectionHeader(title: 'Quick Actions'),
                      const Gap(12),
                      Column(
                        children: [
                          _QuickActionCard(
                            title: 'Add Sale Order',
                            icon: Icons.note_alt_outlined,
                            onTap: () => Get.toNamed(
                              Routes.ADD_SALE_ORDER_CUSTOMER,
                            ),
                          ),
                          const Gap(12),
                          _QuickActionCard(
                            title: 'Pending Orders',
                            icon: Icons.pending_actions_outlined,
                            onTap: () =>
                                Get.toNamed(Routes.PENDING_SALE_ORDER),
                          ),
                          const Gap(12),
                          _QuickActionCard(
                            title: 'Claims / Feedback',
                            icon: Icons.mark_chat_unread_outlined,
                            onTap: () => Get.toNamed(Routes.CLAIMS),
                          ),
                          const Gap(12),
                          _QuickActionCard(
                            title: 'Ledger Statement',
                            icon: Icons.receipt_long_outlined,
                            onTap: () =>
                                Get.toNamed(Routes.CUS_LEDGER_STATEMENT),
                          ),
                        ],
                      ),
                      Obx(() {
                        if (controller.offerImage.value.isEmpty) {
                          return const SizedBox();
                        }
                        return Container(
                          margin: const EdgeInsets.only(top: 16, bottom: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: CachedNetworkImage(
                              imageUrl: controller.offerImage.value,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: SplashColors.accent,
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
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                //   child: Container(
                //     padding: const EdgeInsets.symmetric(vertical: 14),
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(18),
                //       border: Border.all(
                //         color: SplashColors.accent.withOpacity(0.18),
                //       ),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         _buildSocialIcon(
                //           AppImages.instagram,
                //           "https://www.instagram.com/gurukrupa2006?igsh=MWRnYWp3M2lzdGhuaw==&utm_source=ig_contact_invite",
                //         ),
                //         const SizedBox(width: 20),
                //         _buildSocialIcon(
                //           AppImages.facebook,
                //           "https://www.facebook.com/share/16y9cSYa3T/?mibextid=wwXIfr",
                //         ),
                //         const SizedBox(width: 20),
                //         _buildSocialIcon(
                //           AppImages.youTube,
                //           "https://www.youtube.com/@gurukrupawholesale6713",
                //         ),
                //         const SizedBox(width: 20),
                //         _buildSocialIcon(
                //           AppImages.location,
                //           "https://maps.app.goo.gl/Cgr3RiZ9CZuBVBNh7?g_st=ac",
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
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
                GetStorageData.saveString(GetStorageData.isOtpVerified, "false");
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

class _CustomerDashboardAppBar extends StatelessWidget {
  const _CustomerDashboardAppBar({
    required this.onProfileTap,
    required this.onLogout,
  });

  final VoidCallback onProfileTap;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
                  GestureDetector(
                    onTap: onProfileTap,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        color: SplashColors.text,
                        size: 24,
                      ),
                    ),
                  ),
                  const Gap(14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Customer Home',
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

class _CustomerHeroCard extends StatelessWidget {
  const _CustomerHeroCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
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
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AppImages.customerHeroBed,
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
                      const Color(0xFF0B1D46).withOpacity(0.92),
                      const Color(0xFF0B1D46).withOpacity(0.72),
                      const Color(0xFF0B1D46).withOpacity(0.28),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.38, 0.68, 1.0],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontFamily: FontFamily.bold,
                      fontSize: FontSize.s16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Customer',
                    style: TextStyle(
                      fontFamily: FontFamily.PlayfairDisplayBold,
                      fontSize: 34,
                      height: 1,
                      color: SplashColors.accent,
                    ),
                  ),
                  const Gap(12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.52,
                    child: Text(
                      'Your trusted wholesale partner for quality sleep solutions.',
                      style: TextStyle(
                        fontFamily: FontFamily.regular,
                        fontSize: FontSize.s12,
                        height: 1.35,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                  const Gap(18),
                  InkWell(
                    onTap: onTap,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: SplashColors.accent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Shop Now',
                            style: TextStyle(
                              fontFamily: FontFamily.semiBold,
                              fontSize: FontSize.s16,
                              color: SplashColors.nightSkyDeep,
                            ),
                          ),
                          const Gap(8),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: SplashColors.nightSkyDeep,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontFamily: FontFamily.bold,
              fontSize: FontSize.s20,
              color: SplashColors.text,
            ),
          ),
        ),
        // Text(
        //   'View All',
        //   style: TextStyle(
        //     fontFamily: FontFamily.semiBold,
        //     fontSize: FontSize.s14,
        //     color: SplashColors.accent,
        //   ),
        // ),
        // const Gap(4),
        // const Icon(
        //   Icons.arrow_forward_ios_rounded,
        //   color: SplashColors.accent,
        //   size: 14,
        // ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  const _QuickActionCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.white.withOpacity(0.06),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.08),
                    border: Border.all(
                      color: SplashColors.accent.withOpacity(0.45),
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: SplashColors.accent,
                    size: 24,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: FontSize.s14,
                      height: 1.2,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildSocialIcon(String assetPath, String url) {
  return InkWell(
    onTap: () => openUrl(url),
    child: Container(
      width: 44,
      height: 44,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: SplashColors.accent.withOpacity(0.14),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        assetPath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, color: Colors.red);
        },
      ),
    ),
  );
}

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    print("Could not launch $url");
  }
}
