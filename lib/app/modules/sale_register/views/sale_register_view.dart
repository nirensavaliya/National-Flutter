import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/commons/all.dart';

import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../controllers/sale_register_controller.dart';
import 'sale_register_form_ui.dart';

class SaleRegisterView extends GetView<SaleRegisterController> {
  const SaleRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaleRegisterController>(
      builder: (controller) {
        return CommonScreen(
          title: AppString.saleRegister,
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
                    showCursor: false,
                    readOnly: true,
                    inputFormatters: [
                      DateInputFormatter(),
                    ],
                    onTap: () {
                      controller.selectDate(context, "from");
                    },
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
                    showCursor: false,
                    readOnly: true,
                    inputFormatters: [
                      DateInputFormatter(),
                    ],
                    onTap: () {
                      controller.selectDate(context, "to");
                    },
                    suffix: saleRegisterCalendarSuffix(() {
                      controller.selectDate(context, "to");
                    }),
                  ),
                  const Gap(12),
                  CommonTextField(
                    borderRadius: 12,
                    controller: controller.customerController,
                    title: AppString.customer,
                    isTitle: true,
                    maxLength: 10,
                    hintText: "Please Select...",
                    showCursor: false,
                    readOnly: true,
                    onTap: () {
                      controller.selectCustomer();
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
              if (controller.saleRegisterList.isNotEmpty) ...[
                const Gap(16),
                CommonButton(
                  btnName: AppString.downloadPdf,
                  btnColor: SplashColors.primary,
                  onTap: () {
                    controller.genaratePDFApi();
                  },
                ),
                const Gap(16),
              ],
              SaleRegisterTable(
                saleRegisterList: controller.saleRegisterList,
              ),
            ],
          ),
        );
      },
    );
  }
}
