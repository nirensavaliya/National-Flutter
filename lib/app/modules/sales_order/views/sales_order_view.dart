import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_add_view.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import '../../../commons/all.dart';
import '../../quotation/model/quoation_list_model.dart';
import '../controllers/sales_order_controller.dart';
import 'sales_order_form_ui.dart';

class SalesOrderView extends GetView<SalesOrderController> {
  const SalesOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesOrderController>(
      builder: (controller) {
        return CommonScreen(
          title: AppString.salesOrder,
          brandAppBar: true,
          scaffoldColor: const Color(0xFFF4F7F7),
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
          actions: controller.isAdd.value ? [] : [
            GestureDetector(
                onTap: () {

                  controller.filterSheet(context);
                },
                child: Icon(Icons.search,size: 30,)),
            Gap(20),
          ],
            body: Obx(() => controller.isAdd.value
                ? SalesOrderAddView()
                : controller.quotationList.isEmpty
                ? Utils().noDataFound(context, controller.isData)
                : ListView.builder(
              itemCount: controller.quotationList.length,
              padding: EdgeInsets.fromLTRB(16, 8, 16, 35),
              itemBuilder: (context, index) {
                QuotationData model = controller.quotationList[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: SalesOrderListCard(
                    salesOrderId: model.salesOrderID.toString(),
                    customerName: model.customerName,
                    netAmount: model.netAmount.toString(),
                    orderNumber: model.orderNumber,
                    date: model.date,
                    salesPerson: model.salesPerson,
                    contactNumber: model.contactNumber,
                    invoiceType: model.invoiceType,
                    allowEditEntry: model.allowEditEntry,
                    allowDeleteEntry: model.allowDeleteEntry,
                    onExpansionChanged: (value) {
                      print("Expansion changed: $value");
                      controller.update();
                    },
                    onEdit: () {
                      controller.isAdd.value = true;
                      controller.isUpdate = true;
                      controller.quotationDataApi(model.salesOrderID ?? 0);
                      controller.saleId = (model.salesOrderID ?? 0).toString();
                    },
                    onPdf: () => controller.quotationPDFApi(model.salesOrderID ?? 0),
                    onDelete: () {
                      Get.dialog(
                        SalesOrderDeleteDialog(
                          onConfirm: () {
                            controller.deleteQuotationApi(model.salesOrderID ?? 0);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            ),
        );
      },
    );
  }
}
