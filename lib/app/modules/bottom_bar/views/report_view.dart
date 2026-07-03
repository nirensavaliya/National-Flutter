import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/bottom_bar/controllers/bottom_bar_controller.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';
import 'package:gap/gap.dart';

import '../../../commons/all.dart';
import '../../sale_order_register/controllers/sale_order_register_controller.dart';
import 'bottom_bar_menu_widgets.dart';

class ReportView extends GetView<BottomBarController> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF4F7F7),
      child: Column(
        children: [
          SectionAppBar(
            title: AppString.reports,
            subtitle: 'Business Insights',
            icon: Icons.assessment_outlined,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              children: [
                Text(
                  'Reports & Analytics',
                  style: TextStyle(
                    fontFamily: FontFamily.semiBold,
                    fontSize: FontSize.s16,
                    color: SplashColors.primaryDark,
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
                const Gap(16),
                ...List.generate(
                  controller.reportList.length,
                  (index) {
                    final item = controller.reportList[index];
                    return MenuTile(
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
                        } else if (controller.reportList[index].name ==
                            AppString.saleRegister) {
                          Get.toNamed(Routes.SALE_REGISTER);
                        } else if (controller.reportList[index].name ==
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
