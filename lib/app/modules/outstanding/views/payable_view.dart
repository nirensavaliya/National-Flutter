import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/modules/outstanding/controllers/outstanding_controller.dart';
import 'package:gurukrupa/app/modules/sale_register/views/sale_register_form_ui.dart';

import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';
import 'outstanding_form_ui.dart';

class PayableView extends GetView<OutstandingController> {
  const PayableView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OutstandingController>(
      builder: (controller) {
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            SaleRegisterFilterCard(
              children: [
                CommonTextField(
                  borderRadius: 12,
                  controller: controller.asPerDateController,
                  title: AppString.asPerDate,
                  isTitle: true,
                  maxLength: 10,
                  hintText: "day-month-year",
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
              ],
            ),
            if (controller.outStandingPayableList.isNotEmpty) ...[
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
            OutstandingPayableTable(
              outStandingPayableList: controller.outStandingPayableList,
            ),
          ],
        );
      },
    );
  }
}
