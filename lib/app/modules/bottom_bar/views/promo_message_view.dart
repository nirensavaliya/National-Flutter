import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';

import '../../../commons/all.dart';
import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_screen.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../controllers/promo_message_controller.dart';

class PromoMessageView extends StatelessWidget {
  const PromoMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PromoMessageController>(
      builder: (controller) {
        return CommonScreen(
          title: 'Change Promo Message',
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Column(
              children: [
                SalesOrderFormSection(
                  title: 'Promo Message',
                  icon: Icons.campaign_outlined,
                  children: [
                    CommonTextField(
                      borderRadius: 12,
                      controller: controller.addPromoController,
                      title: 'Enter New Promo Message',
                      isTitle: true,
                      maxLine: 5,
                      hintText: 'Type your promotional message here...',
                    ),
                  ],
                ),
                const Gap(20),
                CommonButton(
                  btnName: 'Save Promo Message',
                  btnColor: SplashColors.primary,
                  onTap: () {
                    Get.back();
                    controller.apiSavePromotionalMessage(Get.context!);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
