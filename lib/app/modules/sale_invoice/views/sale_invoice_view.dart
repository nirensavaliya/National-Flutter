import 'package:gurukrupa/app/modules/sale_invoice/views/sale_invoice_add_view.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../commons/all.dart';
import '../../../data/common_widget/common_button.dart';
import '../../quotation/model/quoation_list_model.dart';
import '../controllers/sale_invoice_controller.dart';
import '../model/sales_invoice_model.dart';

class SaleInvoiceView extends GetView<SaleInvoiceController> {
  const SaleInvoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaleInvoiceController>(
      builder: (controller) {
        return CommonScreen(
          title: AppString.salesInvoice,
          floatingActionButton: controller.isAdd.value ? SizedBox() : GestureDetector(
            onTap: () {
              controller.addDateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
              controller.isAdd.value = true;
              controller.isUpdate = false;
              controller.nextSerialNoApi();
              controller.update();
            },
            child: CircleAvatar(
              backgroundColor: Colors.blue,
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
            padding: EdgeInsets.fromLTRB(20,0,20,50),
            itemBuilder: (context, index) {
              SalesInvoiceData model = controller.quotationList[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Theme(
                    data: ThemeData(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      childrenPadding: EdgeInsets.zero,
                      dense: true,
                      key: Key(key.toString()),
                      onExpansionChanged: (value) {
                        print("value -- $value");
                        controller.update();
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            model.customerName ?? "",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: FontSize.s18,
                              fontFamily: FontFamily.medium,
                            ),
                          ),
                          Text(
                            model.netPayableAmount.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: FontSize.s16,
                              fontFamily: FontFamily.medium,
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Table(
                          border: TableBorder.all(borderRadius: BorderRadius.vertical(bottom: Radius.circular(12))),
                          children: [
                            TableRow(
                              children: [
                                commonTableText(title: "Customer Name"),
                                commonTableText(title: model.customerName, isEnd: true),
                              ],
                            ),
                            TableRow(
                              children: [
                                commonTableText(title: "Contact Number"),
                                commonTableText(title: model.contactNumber, isEnd: true),
                              ],
                            ),
                            TableRow(
                              children: [
                                commonTableText(title: "Invoice Serial No."),
                                commonTableText(title: model.invoiceSerialNo, isEnd: true),
                              ],
                            ),
                            TableRow(
                              children: [
                                commonTableText(title: "Date"),
                                commonTableText(title: model.date, isEnd: true),
                              ],
                            ),
                            TableRow(
                              children: [
                                commonTableText(title: "Invoice Type"),
                                commonTableText(title: model.invoiceType, isEnd: true),
                              ],
                            ),
                            TableRow(
                              children: [
                                commonTableText(title: "Net Amount"),
                                commonTableText(title: model.netPayableAmount.toString(), isEnd: true),
                              ],
                            ),
                            TableRow(
                              children: [
                                commonTableText(title: "GstIn"),
                                commonTableText(title: model.gstinNumber.toString(), isEnd: true),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              if(model.allowEditEntry == true)
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(onTap: () {
                                    controller.isAdd.value = true;
                                    controller.quotationDataApi(model.billId ?? 0);
                                    controller.update();
                                  },child: Icon(Icons.mode_edit_outline_outlined)),
                                ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: GestureDetector(onTap: () {
                                  controller.quotationPDFApi(model.billId ?? 0);
                                  // controller.isUpdate = true;
                                  // controller.quId = (model.quoteId ?? 0).toString();
                                  controller.update();
                                },child: Icon(Icons.picture_as_pdf)),
                              ),
                              if(model.allowDeleteEntry == true)
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(onTap: () {
                                    Get.dialog(Dialog(
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(24),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black38,
                                                offset: Offset(
                                                  5.0,
                                                  5.0,
                                                ),
                                                blurRadius: 10.0,
                                                spreadRadius: 2.0,
                                              ),
                                            ]
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Are you sure you want to delete this?",
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              CommonButton(
                                                btnName: "No",
                                                btnColor: Colors.transparent,
                                                textColor: Colors.black87,
                                                borderColor: Colors.blue,
                                                onTap: () {
                                                  Get.back();
                                                },
                                              ),
                                              SizedBox(height: 10),
                                              CommonButton(
                                                btnName: "Yes",
                                                onTap: () {

                                                  controller.deleteInvoiceApi(model.billId ?? 0);
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));

                                  },child: Icon(Icons.delete)),
                                ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
  Widget commonTableText({String? title, bool? isLight, bool? isEnd}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        title ?? "",
        textAlign: isEnd == true ? TextAlign.end : TextAlign.start,
        style: TextStyle(
          fontSize: FontSize.s16,
          color: isLight == true ? Colors.black45 : Colors.black,
          fontFamily: FontFamily.medium,
        ),
      ),
    );
  }
}
