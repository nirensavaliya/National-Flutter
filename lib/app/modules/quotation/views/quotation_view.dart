import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/data/common_widget/common_button.dart';
import 'package:gurukrupa/app/modules/quotation/views/quotation_add_view.dart';
import 'package:intl/intl.dart';

import '../controllers/quotation_controller.dart';
import '../model/quoation_list_model.dart';

class QuotationView extends GetView<QuotationController> {
  const QuotationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuotationController>(
      builder: (controller) {
        return CommonScreen(
          title: AppString.quotation,
          floatingActionButton: controller.isAdd.value
              ? SizedBox()
              : Constants.isAddAllowed
                  ? GestureDetector(
                      onTap: () {
                        controller.addDateController.text =
                            DateFormat("dd/MM/yyyy")
                                .format(DateTime.now())
                                .toString();
                        controller.isAdd.value = true;
                        controller.isUpdate = false;
                        controller.nextSerialNoApi();
                        controller.update();
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 25,
                        child: Center(
                            child:
                                Icon(Icons.add, size: 35, color: Colors.white)),
                      ),
                    )
                  : SizedBox(),
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
              ? QuotationAddView()
              : controller.quotationList.isEmpty
                  ? Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                            fontFamily: FontFamily.medium,
                            fontSize: FontSize.s16,
                            color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.quotationList.length,
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
                      itemBuilder: (context, index) {
                        QuotationData model = controller.quotationList[index];
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
                                initiallyExpanded:
                                    controller.expandedIndex == index,
                                onExpansionChanged: (value) {
                                  controller.expandedIndex =
                                      value ? index : null;
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
                                    border: TableBorder.all(
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(12))),
                                    children: [
                                      TableRow(
                                        children: [
                                          commonTableText(
                                              title: "Customer Name"),
                                          commonTableText(
                                              title: model.customerName,
                                              isEnd: true),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          commonTableText(
                                              title: "Contact Number"),
                                          commonTableText(
                                              title: model.contactNumber,
                                              isEnd: true),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          commonTableText(title: "Date"),
                                          commonTableText(
                                              title: model.date, isEnd: true),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          commonTableText(
                                              title: "Invoice Type"),
                                          commonTableText(
                                              title: model.invoiceType,
                                              isEnd: true),
                                        ],
                                      ),
                                      TableRow(
                                        children: [
                                          commonTableText(title: "Net Amount"),
                                          commonTableText(
                                              title: model.netPayableAmount
                                                  .toString(),
                                              isEnd: true),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        if (model.allowEditEntry == true)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: GestureDetector(
                                                onTap: () {
                                                  controller.isAdd.value = true;
                                                  controller.isUpdate = true;
                                                  controller.quotationDataApi(
                                                      model.quoteId ?? 0);
                                                  controller.update();
                                                },
                                                child: Icon(Icons
                                                    .mode_edit_outline_outlined)),
                                          ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: GestureDetector(
                                              onTap: () {
                                                controller.quotationPDFApi(
                                                    model.quoteId ?? 0);
                                                controller.quId =
                                                    (model.quoteId ?? 0)
                                                        .toString();
                                                controller.update();
                                              },
                                              child:
                                                  Icon(Icons.picture_as_pdf)),
                                        ),
                                        if (model.allowDeleteEntry == true)
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: GestureDetector(
                                                onTap: () {
                                                  Get.dialog(Dialog(
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(24),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black38,
                                                              offset: Offset(
                                                                5.0,
                                                                5.0,
                                                              ),
                                                              blurRadius: 10.0,
                                                              spreadRadius: 2.0,
                                                            ),
                                                          ]),
                                                      child: Padding(
                                                        padding:
                                                        EdgeInsets.all(8.0),
                                                        child: Column(
                                                          mainAxisSize:
                                                          MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              "Are you sure you want to delete this?",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                            ),
                                                            SizedBox(
                                                                height: 20),
                                                            CommonButton(
                                                              btnName: "No",
                                                              btnColor: Colors
                                                                  .transparent,
                                                              textColor: Colors
                                                                  .black87,
                                                              borderColor:
                                                              Colors.blue,
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            CommonButton(
                                                              btnName: "Yes",
                                                              onTap: () {
                                                                controller
                                                                    .deleteQuotationApi(
                                                                    model.quoteId ??
                                                                        0);
                                                              },
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ));
                                                },
                                                child: Icon(Icons.delete)),
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

/*Scrollbar(
            thickness: 8.0,
            radius: Radius.circular(10),
            child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                dragStartBehavior: DragStartBehavior.start,
                child: DataTable(
                  border: TableBorder.all(),
                  columns: const <DataColumn>[
                    DataColumn(label: Text('ACTION')),
                    DataColumn(label: Text('INVOICE SERIAL NO.')),
                    DataColumn(label: Text('DATE')),
                    DataColumn(label: Text('CUSTOMER NAME')),
                    DataColumn(label: Text('CONTACT NO.')),
                    DataColumn(label: Text('INVOICE TYPE')),
                    DataColumn(label: Text('NET AMMOUNT')),
                    DataColumn(label: Text('GSTIN')),
                  ],
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Item 1')),
                        DataCell(Text('001')),
                        DataCell(Text('Pcs')),
                        DataCell(Text('100.0')),
                        DataCell(Text('90.0')),
                        DataCell(Text('10.0')),
                        DataCell(Text('5%')),
                        DataCell(Text('5%')),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(Text('Item 2')),
                        DataCell(Text('002')),
                        DataCell(Text('Box')),
                        DataCell(Text('200.0')),
                        DataCell(Text('180.0')),
                        DataCell(Text('20.0')),
                        DataCell(Text('10%')),
                        DataCell(Text('160.0')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )*/
