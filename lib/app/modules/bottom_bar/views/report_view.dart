import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/bottom_bar/controllers/bottom_bar_controller.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';
import 'package:gap/gap.dart';

import '../../../commons/all.dart';
import '../../sale_order_register/controllers/sale_order_register_controller.dart';

class ReportView extends GetView<BottomBarController> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF3F5FA),
      child: Column(
        children: [
          const _ReportHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              children: [
                Text(
                  'Reports & Analytics',
                  style: TextStyle(
                    fontFamily: FontFamily.PlayfairDisplayBold,
                    fontSize: FontSize.s20,
                    color: SplashColors.nightSky,
                  ),
                ),
                const Gap(4),
                Text(
                  'View and download business reports',
                  style: TextStyle(
                    fontFamily: FontFamily.regular,
                    fontSize: FontSize.s14,
                    color: const Color(0xFF78829A),
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
                const Gap(18),
                ...List.generate(
                  controller.reportList.length,
                  (index) {
                    final item = controller.reportList[index];
                    return _ReportTile(
                      title: item.name ?? '',
                      image: item.image ?? '',
                      onTap: () {
                        if (controller.isCustomer == true) {
                          if (controller.reportList[index].name ==
                              AppString.Feedback) {
                            Get.toNamed(Routes.FEEDBACK);
                          }
                        } else {}
                        if (controller.reportList[index].name ==
                            AppString.itemList) {
                          Get.toNamed(Routes.ITEM_LIST);
                        } else if (controller.reportList[index].name ==
                            AppString.ledgerStatement) {
                          Get.toNamed(Routes.LEDGER_STATEMENT);
                        }
                        // else if (controller.reportList[index].name ==
                        //     AppString.saleRegister) {
                        //   Get.toNamed(Routes.SALE_REGISTER);
                        // }
                        else if (controller.reportList[index].name ==
                            AppString.purchaseRegister) {
                          Get.toNamed(Routes.PURCHASE_REGISTER);
                        } else if (controller.reportList[index].name ==
                            AppString.outstandingReceivable) {
                          Get.toNamed(Routes.OUTSTANDING,
                              arguments: AppString.outstandingReceivable);
                        } else if (controller.reportList[index].name ==
                            AppString.outstandingPayables) {
                          Get.toNamed(Routes.OUTSTANDING,
                              arguments: AppString.outstandingPayables);
                        } else if (controller.reportList[index].name ==
                            AppString.saleOrderRegister) {
                          final saleOrderCtrl =
                              Get.put(SaleOrderRegisterController());
                          saleOrderCtrl.salesPersonController.clear();
                          saleOrderCtrl.showFilterDialog(context);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReportHeader extends StatelessWidget {
  const _ReportHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
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
            color: Colors.black.withOpacity(0.28),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -24,
            right: -8,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: SplashColors.accent.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -20,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            right: 18,
            bottom: 18,
            child: Icon(
              Icons.assessment_outlined,
              size: 78,
              color: Colors.white.withOpacity(0.07),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             AppString.appName,
                  //             style: TextStyle(
                  //               fontFamily: FontFamily.PlayfairDisplayBold,
                  //               fontSize: 16,
                  //               color: SplashColors.text,
                  //               letterSpacing: 0.2,
                  //             ),
                  //           ),
                  //           const Gap(4),
                  //           Container(
                  //             width: 36,
                  //             height: 2.5,
                  //             decoration: BoxDecoration(
                  //               color: SplashColors.accent,
                  //               borderRadius: BorderRadius.circular(2),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Container(
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 10,
                  //         vertical: 7,
                  //       ),
                  //       decoration: BoxDecoration(
                  //         color: Colors.white.withOpacity(0.08),
                  //         borderRadius: BorderRadius.circular(20),
                  //         border: Border.all(
                  //           color: SplashColors.accent.withOpacity(0.35),
                  //         ),
                  //       ),
                  //       child: Row(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           Container(
                  //             width: 26,
                  //             height: 26,
                  //             decoration: BoxDecoration(
                  //               shape: BoxShape.circle,
                  //               border: Border.all(
                  //                 color: SplashColors.accent,
                  //                 width: 1.4,
                  //               ),
                  //             ),
                  //             child: const Icon(
                  //               Icons.person_outline_rounded,
                  //               size: 15,
                  //               color: SplashColors.accent,
                  //             ),
                  //           ),
                  //           const Gap(8),
                  //           Text(
                  //             'Admin',
                  //             style: TextStyle(
                  //               fontFamily: FontFamily.semiBold,
                  //               fontSize: 12,
                  //               color: Colors.white.withOpacity(0.95),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const Gap(22),
                  Text(
                    AppString.reports,
                    style: TextStyle(
                      fontFamily: FontFamily.PlayfairDisplayBold,
                      fontSize: 28,
                      color: SplashColors.text,
                      height: 1.1,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'Business insights and downloadable reports.',
                    style: TextStyle(
                      fontFamily: FontFamily.regular,
                      fontSize: FontSize.s12,
                      color: SplashColors.accentSoft.withOpacity(0.88),
                      height: 1.35,
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

class _ReportTile extends StatelessWidget {
  const _ReportTile({
    required this.title,
    required this.image,
    required this.onTap,
  });

  final String title;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: SplashColors.accent.withOpacity(0.16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: SplashColors.accent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: SplashColors.accent.withOpacity(0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Image.asset(
                image,
                color: SplashColors.nightSkyDeep,
                fit: BoxFit.contain,
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
                      color: SplashColors.nightSky,
                    ),
                  ),
                  const Gap(3),
                  Text(
                    'Tap to open',
                    style: TextStyle(
                      fontFamily: FontFamily.regular,
                      fontSize: 11,
                      color: const Color(0xFF8A93A6),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: SplashColors.nightSky.withOpacity(0.06),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13,
                color: SplashColors.nightSky,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
