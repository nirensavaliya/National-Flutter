import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/data/common_widget/common_button.dart';
import 'package:gurukrupa/app/data/common_widget/common_textfeild.dart';
import 'package:gurukrupa/app/modules/sale_invoice/controllers/sale_invoice_controller.dart';

import '../../../commons/all.dart';
import '../../../routes/app_pages.dart';
import '../controllers/ledger_statement_controller.dart';
import 'ledger_statement_form_ui.dart';

class LedgerStatementView extends GetView<LedgerStatementController> {
  const LedgerStatementView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SaleInvoiceController());
    return GetBuilder<LedgerStatementController>(
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
                  const Gap(12),
                  CommonTextField(
                    borderRadius: 12,
                    controller: controller.ledgerController,
                    title: AppString.ledger,
                    isTitle: true,
                    maxLength: 10,
                    hintText: "Please Select...",
                    showCursor: false,
                    readOnly: true,
                    onTap: () {
                      controller.selectLedger();
                    },
                    suffix: ledgerDropdownSuffix(),
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
              GetBuilder<SaleInvoiceController>(
                builder: (saleInvoiceController) {
                  return LedgerStatementTable(
                    ledgerList: controller.ledgerList,
                    selectedLedger: controller.selectedLedger,
                    onRowSelected: (ledger) {
                      controller.selectLedgerRow(ledger);

                      int id = int.tryParse(ledger.zoomPkValue ?? '0') ?? 0;
                      saleInvoiceController.quotationDataApi(id);

                      saleInvoiceController.isAdd.value = true;
                      Get.toNamed(Routes.SALE_INVOICE, arguments: {
                        'ledgerId': id,
                      });
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
