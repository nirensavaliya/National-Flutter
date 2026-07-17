import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';

import '../../../commons/all.dart';
import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../ledger_statement/views/ledger_statement_form_ui.dart';
import '../controllers/cus_ledger_statement_controller.dart';

class CustomerLedgerStatementView extends GetView<CusLedgerStatementController> {
  const CustomerLedgerStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CusLedgerStatementController>(
      builder: (controller) {
        return CommonScreen(
          title: AppString.ledgerStatement,
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            children: [
              LedgerStatementFilterCard(
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
                    suffix: ledgerCalendarSuffix(() {
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
                    suffix: ledgerCalendarSuffix(() {
                      controller.selectDate(context, "to");
                    }),
                  ),
                ],
              ),
              const Gap(16),
              if (controller.ledgerList.isNotEmpty) ...[
                CommonButton(
                  btnName: AppString.downloadPdf,
                  btnColor: SplashColors.primary,
                  onTap: () {
                    controller.genaratePDFApi();
                  },
                ),
                const Gap(16),
              ],
              LedgerStatementTable(
                ledgerList: controller.ledgerList,
                selectedLedger: controller.selectedLedger,
              ),
            ],
          ),
        );
      },
    );
  }
}
