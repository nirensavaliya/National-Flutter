import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/modules/bottom_bar/views/bottom_bar_menu_widgets.dart';
import 'package:gurukrupa/app/modules/customer/controllers/customer_controller.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';
import 'package:marquee/marquee.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../commons/all.dart';

class CustomerMainHomeView extends GetView<CustomerMainController> {
  const CustomerMainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerMainController>(
      builder: (controller) {
        return ColoredBox(
          color: SplashColors.scaffoldBg,
          child: Column(
            children: [
              _CustomerDashboardAppBar(
                onProfileTap: () => Get.toNamed(Routes.PROFILE),
                onLogout: () => showLogoutDialog(context),
              ),
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
                      child: Text(
                        AppString.hiWelcomeBack,
                        style: TextStyle(
                          fontFamily: FontFamily.PlayfairDisplayBold,
                          fontSize: FontSize.s20,
                          color: SplashColors.primaryDark,
                        ),
                      ),
                    ),
                    const Gap(16),
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
                                  color: SplashColors.primary.withOpacity(0.12),
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
                                      color: SplashColors.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.local_offer_outlined,
                                      color: SplashColors.primary,
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
                                          color: SplashColors.primaryDark,
                                          fontSize: FontSize.s14,
                                          fontFamily: FontFamily.semiBold,
                                        ),
                                        scrollAxis: Axis.horizontal,
                                        blankSpace: 50,
                                        velocity: 30,
                                        pauseAfterRound: const Duration(seconds: 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ),
                    Text(
                      'Quick Actions',
                      style: TextStyle(
                        fontFamily: FontFamily.semiBold,
                        fontSize: FontSize.s16,
                        color: SplashColors.primaryDark,
                      ),
                    ),
                    const Gap(12),
                    MenuTile(
                      title: AppString.salesOrder,
                      image: AppImages.salesOrder,
                      onTap: () => Get.toNamed(Routes.ADD_SALE_ORDER_CUSTOMER),
                    ),
                    MenuTile(
                      title: AppString.pendingSaleOrder,
                      image: AppImages.pending,
                      onTap: () => Get.toNamed(Routes.PENDING_SALE_ORDER),
                    ),
                    MenuTile(
                      title: AppString.Feedback,
                      image: AppImages.feedback,
                      onTap: () => Get.toNamed(Routes.FEEDBACK),
                    ),
                    MenuTile(
                      title: AppString.orderLaterSales,
                      image: AppImages.quotation,
                      onTap: () => Get.toNamed(Routes.ORDER_LATER_SALE),
                    ),
                    MenuTile(
                      title: 'Ledger Statement',
                      image: AppImages.ledgerStatement,
                      onTap: () => Get.toNamed(Routes.CUS_LEDGER_STATEMENT),
                    ),
                    Obx(() {
                      print("Image URL: ${controller.offerImage.value}");
                      if (controller.offerImage.value.isEmpty) {
                        return const SizedBox();
                      }
                      return Container(
                        margin: const EdgeInsets.only(top: 8, bottom: 8),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSocialIcon(
                      AppImages.instagram,
                      "https://www.instagram.com/gurukrupa2006?igsh=MWRnYWp3M2lzdGhuaw==&utm_source=ig_contact_invite",
                    ),
                    const SizedBox(width: 20),
                    _buildSocialIcon(
                      AppImages.facebook,
                      "https://www.facebook.com/share/16y9cSYa3T/?mibextid=wwXIfr",
                    ),
                    const SizedBox(width: 20),
                    _buildSocialIcon(
                      AppImages.youTube,
                      "https://www.youtube.com/@gurukrupawholesale6713",
                    ),
                    const SizedBox(width: 20),
                    _buildSocialIcon(
                      AppImages.location,
                      "https://maps.app.goo.gl/Cgr3RiZ9CZuBVBNh7?g_st=ac",
                    ),
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
                GetStorageData.saveString(GetStorageData.isOtpVerified, "false");
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
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onProfileTap,
                    child: Container(
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
                      child: Icon(
                        Icons.person_rounded,
                        color: SplashColors.primary,
                        size: 28,
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
                          'Customer Portal',
                          style: TextStyle(
                            fontFamily: FontFamily.medium,
                            fontSize: FontSize.s12,
                            color: SplashColors.subText.withOpacity(0.95),
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
                        color: Colors.white.withOpacity(0.14),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.25),
                        ),
                      ),
                      child: const Icon(
                        Icons.logout_rounded,
                        color: Colors.white,
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

Widget _buildSocialIcon(String assetPath, String url) {
  return InkWell(
    onTap: () => openUrl(url),
    child: Container(
      color: Colors.transparent,
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        width: 45,
        height: 45,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.error, color: Colors.red);
        },
      ),
    ),
  );
}

Future<void> _openSocialMedia(String username, bool isInstagram) async {
  String appUrl = isInstagram
      ? "instagram://user?username=$username"
      : "fb://profile/$username";
  String webUrl = isInstagram
      ? "https://www.instagram.com/$username"
      : "https://www.facebook.com/$username";

  Uri uriApp = Uri.parse(appUrl);
  Uri uriWeb = Uri.parse(webUrl);

  if (await canLaunchUrl(uriApp)) {
    await launchUrl(uriApp, mode: LaunchMode.externalApplication);
  } else {
    await launchUrl(uriWeb, mode: LaunchMode.externalApplication);
  }
}

Future<void> openUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    print("Could not launch $url");
  }
}

class LineGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint linePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    Paint fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withOpacity(0.4),
          Colors.transparent,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    Path linePath = Path();
    Path fillPath = Path();

    fillPath.moveTo(0, size.height);
    linePath.moveTo(0, size.height * 0.7);

    linePath.lineTo(size.width * 0.1, size.height * 0.75);
    linePath.lineTo(size.width * 0.2, size.height * 0.65);
    linePath.lineTo(size.width * 0.3, size.height * 0.75);
    linePath.lineTo(size.width * 0.4, size.height * 0.6);
    linePath.lineTo(size.width * 0.5, size.height * 0.7);
    linePath.lineTo(size.width * 0.6, size.height * 0.65);
    linePath.lineTo(size.width * 0.7, size.height * 0.8);
    linePath.lineTo(size.width * 0.8, size.height * 0.7);
    linePath.lineTo(size.width * 0.9, size.height * 0.75);
    linePath.lineTo(size.width, size.height * 0.7);

    fillPath.addPath(linePath, Offset.zero);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
