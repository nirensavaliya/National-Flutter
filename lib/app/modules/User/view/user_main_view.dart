import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/modules/bottom_bar/views/bottom_bar_menu_widgets.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';
import 'package:marquee/marquee.dart';

import '../../../commons/all.dart';
import '../controller/user_controller.dart';
import '../../sales_order/services/sales_order_cart_service.dart';
import '../../sales_order/views/sales_order_cart_button.dart';

class UserMainHomeView extends GetView<UserMainController> {
  const UserMainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserMainController>(
      builder: (controller) {
        return ColoredBox(
          color: SplashColors.scaffoldBg,
          child: Column(
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
                      onTap: () {
                        // Add your promotional banner click action here
                      },
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
                                      color:
                                          SplashColors.primary.withOpacity(0.1),
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
                                        text: Constants.promoMessageModel.message
                                            .toString(),
                                        style: TextStyle(
                                          color: SplashColors.primaryDark,
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
                      onTap: () {
                        // Get.toNamed(Routes.ADD_SALE_ORDER_CUSTOMER);
                        Get.toNamed(Routes.SALES_ORDER);
                      },
                    ),
                    MenuTile(
                      title: AppString.itemList,
                      image: AppImages.itemList,
                      onTap: () => Get.toNamed(Routes.ITEM_LIST),
                    ),
                    MenuTile(
                      title: AppString.ledgerStatement,
                      image: AppImages.ledgerStatement,
                      onTap: () => Get.toNamed(Routes.LEDGER_STATEMENT),
                    ),
                    MenuTile(
                      title: AppString.orderFromImage,
                      image: AppImages.invoice,
                      onTap: () => Get.toNamed(Routes.ORDER_FROM_IMAGE),
                    ),
                    MenuTile(
                      title: AppString.salesVisitFromImage,
                      image: AppImages.feedback,
                      onTap: () =>
                          Get.toNamed(Routes.SALE_PERSON_VISIT_FROM_IMAGE),
                    ),
                    MenuTile(
                      title: AppString.receipt,
                      image: AppImages.recipt,
                      onTap: () => Get.toNamed(Routes.RECEIPT),
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

                    // Gap(20),
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.toNamed(Routes.SHOW_REPORT,arguments: AppString.monthlyPurchase);
                    //   },
                    //   child: DecoratedBox(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(12),
                    //         gradient: LinearGradient(colors: [
                    //           Color(0xFF0FA172),
                    //           Color(0xFF44D2A4),
                    //         ])),
                    //     child: Padding(
                    //       padding: EdgeInsets.all(12),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             AppString.monthlyPurchase,
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: FontSize.s14,
                    //               fontFamily: FontFamily.semiBold,
                    //             ),
                    //           ),
                    //           Gap(12),
                    //           Text(
                    //             controller.monthPurchase,
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: FontSize.s18,
                    //               fontFamily: FontFamily.semiBold,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // if(controller.isAdmin)
                    // Gap(20),
                    // if(controller.isAdmin)
                    // GestureDetector(
                    //   onTap: () {
                    //     Get.toNamed(Routes.CUSTOMER_VIEW);
                    //   },
                    //   child: DecoratedBox(
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(12),
                    //         gradient: LinearGradient(colors: [
                    //           Color(0xFF6D1514),
                    //           Color(0xFFC41B22),
                    //         ])),
                    //     child: Padding(
                    //       padding: EdgeInsets.all(12),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             "Check Pending Customers and Read Customers Feedback.",
                    //             style: TextStyle(
                    //               color: Colors.white,
                    //               fontSize: FontSize.s16,
                    //               fontFamily: FontFamily.semiBold,
                    //             ),
                    //           ),
                    //           // Gap(12),
                    //           // Text(
                    //           //   "Check Pending Customers and Read Customers Feedback.",
                    //           //   style: TextStyle(
                    //           //     color: Colors.white,
                    //           //     fontSize: FontSize.s14,
                    //           //     fontFamily: FontFamily.semiBold,
                    //           //   ),
                    //           // ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            "Logout",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
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
                  'isEmployee':
                      true, // Replace with the appropriate boolean value
                });
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
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
                          'User Portal',
                          style: TextStyle(
                            fontFamily: FontFamily.medium,
                            fontSize: FontSize.s12,
                            color: SplashColors.subText.withOpacity(0.95),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(10),
                  SalesOrderCartActionButton(
                    itemCount: cartItemCount,
                    onTap: onCartTap,
                  ),
                  const Gap(10),
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

    // Start of the path (at the bottom-left corner)
    fillPath.moveTo(0, size.height);
    linePath.moveTo(0, size.height * 0.7);

    // Drawing the zigzag pattern
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

    // Copying the line path to the fill path
    fillPath.addPath(linePath, Offset.zero);
    fillPath.lineTo(size.width, size.height); // Close to bottom-right
    fillPath.lineTo(0, size.height); // Close back to bottom-left
    fillPath.close();

    // Draw the filled area
    canvas.drawPath(fillPath, fillPaint);

    // Draw the white line path
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
