import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/bottom_bar/controllers/bottom_bar_controller.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';
import 'package:gap/gap.dart';

import '../../../commons/all.dart';
import 'bottom_bar_menu_widgets.dart';

class TransactionView extends GetView<BottomBarController> {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF4F7F7),
      child: Column(
        children: [
          SectionAppBar(
            title: AppString.transaction,
            subtitle: 'Sales Operations',
            icon: Icons.swap_horiz_rounded,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              children: [
                Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontFamily: FontFamily.semiBold,
                    fontSize: FontSize.s16,
                    color: SplashColors.primaryDark,
                  ),
                ),
                const Gap(4),
                Text(
                  'Choose a transaction type',
                  style: TextStyle(
                    fontFamily: FontFamily.regular,
                    fontSize: FontSize.s14,
                    color: const Color(0xFF78829A),
                  ),
                ),
                const Gap(16),
                ...List.generate(
                  controller.transactionTab.length,
                  (index) {
                    final item = controller.transactionTab[index];
                    return MenuTile(
                      title: item.name ?? '',
                      image: item.image ?? '',
                      onTap: () {
                        if (controller.isCustomer == true) {
                          if (controller.transactionTab[index].name ==
                              AppString.salesOrder) {
                            Get.toNamed(Routes.SALES_ORDER);
                          }
                        } else {
                          // if (controller.transactionTab[index].name ==
                          //     AppString.quotation) {
                          //   Get.toNamed(Routes.QUOTATION);
                          // } else
                            if (controller.transactionTab[index].name ==
                              AppString.salesOrder) {
                            Get.toNamed(Routes.SALES_ORDER);
                          } else if (controller.transactionTab[index].name ==
                              AppString.recipt) {
                            Get.toNamed(Routes.RECEIPT);
                          } else {
                            Get.toNamed(Routes.SALE_INVOICE);
                          }
                        }
                      },
                    );
                  },
                ),
                MenuTile(
                  title: 'Claims',
                  image: AppImages.feedback,
                  onTap: () => Get.toNamed(Routes.CLAIMS),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
