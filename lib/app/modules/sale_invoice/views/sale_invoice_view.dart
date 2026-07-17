import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sale_invoice/views/sale_invoice_add_view.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../commons/all.dart';
import '../controllers/sale_invoice_controller.dart';
import '../model/sales_invoice_model.dart';
import 'sale_invoice_form_ui.dart';

class SaleInvoiceView extends GetView<SaleInvoiceController> {
  const SaleInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaleInvoiceController>(
      builder: (controller) {
        return CommonScreen(
          title: AppString.salesInvoice,
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          floatingActionButton: controller.isAdd.value ? SizedBox() : GestureDetector(
            onTap: () {
              controller.addDateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
              controller.isAdd.value = true;
              controller.isUpdate = false;
              controller.nextSerialNoApi();
              controller.update();
            },
            child: CircleAvatar(
              backgroundColor: SplashColors.primary,
              radius: 25,
              child: Center(child: Icon(Icons.add,size: 35,color: Colors.white)),
            ),
          ),
          actions: controller.isAdd.value
              ? []
              : [
                  GestureDetector(
                      onTap: () {
                        controller.filterSheet(context);
                      },
                      child: Icon(
                        Icons.search,
                        size: 30,
                      )),
                  Gap(20),
                ],
          body: controller.isAdd.value
              ? SaleInvoiceAddView()
              :  controller.quotationList.isEmpty ? Utils().noDataFound(context,controller.isData) : ListView.builder(
            itemCount: controller.quotationList.length,
            padding: EdgeInsets.fromLTRB(16, 8, 16, 35),
            itemBuilder: (context, index) {
              SalesInvoiceData model = controller.quotationList[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: SaleInvoiceListCard(
                  billId: (model.billId ?? 0).toString(),
                  customerName: model.customerName,
                  netAmount: model.netPayableAmount.toString(),
                  invoiceSerialNo: model.invoiceSerialNo,
                  date: model.date,
                  contactNumber: model.contactNumber,
                  invoiceType: model.invoiceType,
                  gstinNumber: model.gstinNumber,
                  allowEditEntry: model.allowEditEntry,
                  allowDeleteEntry: model.allowDeleteEntry,
                  onExpansionChanged: (value) {
                    print("value -- $value");
                    controller.update();
                  },
                  onEdit: () {
                    controller.isAdd.value = true;
                    controller.quotationDataApi(model.billId ?? 0);
                    controller.update();
                  },
                  onPdf: () {
                    controller.quotationPDFApi(model.billId ?? 0);
                    controller.update();
                  },
                  onDelete: () {
                    Get.dialog(
                      SalesOrderDeleteDialog(
                        onConfirm: () {
                          controller.deleteInvoiceApi(model.billId ?? 0);
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
