import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/bottom_bar/views/bottom_bar_menu_widgets.dart';

import '../../../commons/all.dart';
import '../../../data/common_widget/common_screen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/customer_controller.dart';

class CustomerView extends GetView<CustomerController> {
  const CustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomerController>(
      builder: (controller) {
        return CommonScreen(
          title: 'Customer Action',
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
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
                'Manage customer requests and feedback',
                style: TextStyle(
                  fontFamily: FontFamily.regular,
                  fontSize: FontSize.s14,
                  color: const Color(0xFF78829A),
                ),
              ),
              const Gap(16),
              ...List.generate(
                controller.CustomerPending.length,
                (index) {
                  final item = controller.CustomerPending[index];
                  return MenuTile(
                    title: item.name ?? '',
                    image: item.image ?? '',
                    onTap: () {
                      if (item.name == AppString.customerPending) {
                        Get.toNamed(Routes.PENDING_CUSTOMER);
                      } else if (item.name == AppString.customerFeedback) {
                        Get.toNamed(Routes.CUSTOMER_FEEDBACK);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
