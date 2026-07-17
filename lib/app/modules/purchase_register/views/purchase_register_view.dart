import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sale_register/views/sale_register_form_ui.dart';

import '../../../commons/all.dart';
import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../controllers/purchase_register_controller.dart';
import 'purchase_register_form_ui.dart';

class PurchaseRegisterView extends GetView<PurchaseRegisterController> {
  const PurchaseRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseRegisterController>(
      builder: (controller) {
        return CommonScreen(
          title: AppString.purchaseRegister,
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              SaleRegisterFilterCard(
                children: [
                  CommonTextField(
                    borderRadius: 12,
                    controller: controller.fromDateController,
                    title: AppString.fromDate,
                    isTitle: true,
                    maxLength: 10,
                    readOnly: true,
                    showCursor: false,
                    onTap: () {
                      controller.selectDate(context, "from");
                    },
                    inputFormatters: [
                      DateInputFormatter(),
                    ],
                    suffix: saleRegisterCalendarSuffix(() {
                      controller.selectDate(context, "from");
                    }),
                  ),
                  const Gap(12),
                  CommonTextField(
                    borderRadius: 12,
                    controller: controller.toDateController,
                    title: AppString.toDate,
                    isTitle: true,
                    maxLength: 10,
                    readOnly: true,
                    showCursor: false,
                    onTap: () {
                      controller.selectDate(context, "to");
                    },
                    inputFormatters: [
                      DateInputFormatter(),
                    ],
                    suffix: saleRegisterCalendarSuffix(() {
                      controller.selectDate(context, "to");
                    }),
                  ),
                  const Gap(12),
                  CommonTextField(
                    borderRadius: 12,
                    controller: controller.ledgerController,
                    title: AppString.supplier,
                    isTitle: true,
                    maxLength: 10,
                    hintText: "Please Select...",
                    showCursor: false,
                    readOnly: true,
                    onTap: () {
                      controller.selectLedger();
                    },
                    suffix: saleRegisterDropdownSuffix(),
                  ),
                  const Gap(12),
                  CommonTextField(
                    borderRadius: 12,
                    controller: controller.branchController,
                    title: AppString.branch,
                    isTitle: true,
                    maxLength: 10,
                    hintText: "Please Select...",
                    showCursor: false,
                    readOnly: true,
                    onTap: () {
                      controller.selectBranch();
                    },
                    suffix: saleRegisterDropdownSuffix(),
                  ),
                ],
              ),
              const Gap(16),
              CommonButton(
                btnName: AppString.downloadPdf,
                btnColor: SplashColors.primary,
                onTap: () {
                  controller.genaratePDFApi();
                },
              ),
              const Gap(16),
              PurchaseRegisterTable(
                registerData: controller.registerData,
              ),
            ],
          ),
        );
      },
    );
  }
}
