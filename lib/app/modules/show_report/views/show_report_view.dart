import 'package:gurukrupa/app/commons/all.dart';

import '../../item_list/controllers/item_list_controller.dart';
import '../controllers/show_report_controller.dart';
import '../monhtly_total_purchase_model.dart';
import '../monthly_sale_model.dart';

class ShowReportView extends GetView<ShowReportController> {
  const ShowReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableWidget(),
    );
  }
}

class TableWidget extends GetView<ShowReportController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowReportController>(
      builder: (controller) {
        return CommonScreen(
          // floatingActionButton: FloatingActionButton(onPressed: () {
          //   if (Get.arguments == AppString.todayTotal) {
          //     controller.todaySaleApiCall();
          //   } else if (Get.arguments == AppString.monthlyTotal) {
          //     controller.monthlySaleApiCall();
          //   }
          //   else if(Get.arguments == AppString.todayPurchase)
          //   {
          //     controller.todayTotalPurchaseApiCall();
          //   }
          //   else{
          //     controller.monthlyTotalPurchaseApiCall();
          //   }
          // },),
            title: AppString.showReport,
            body: Get.arguments == AppString.monthlyPurchase || Get.arguments == AppString.todayPurchase ? monthlyPurchase() :  ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: controller.monthlySaleList.length,
              itemBuilder: (context, index) {
                MonthlySaleData model = controller.monthlySaleList[index];
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
                        key: Key(index.toString()),
                        onExpansionChanged: (value) {},
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.custName ?? "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: FontSize.s18,
                                fontFamily: FontFamily.medium,
                              ),
                            ),
                            Text(
                              "Serial No. ${model.billSrNo}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: FontSize.s16,
                                fontFamily: FontFamily.medium,
                              ),
                            ),
                            Text(
                              model.netAmount.toString() ?? "",
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
                                  commonTableText(title: "Customer Name"),
                                  commonTableText(
                                      title: model.custName, isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "DT"),
                                  commonTableText(
                                      title: model.date, isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Bill Sr No."),
                                  commonTableText(
                                      title: model.billSrNo, isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Gross Amount"),
                                  commonTableText(
                                      title: model.grossAmount.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Sale Type"),
                                  commonTableText(
                                      title: model.saleType, isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Discount"),
                                  commonTableText(
                                      title: model.discount.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Ship To"),
                                  commonTableText(
                                      title: model.shipTo, isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Contact No."),
                                  commonTableText(
                                      title: model.contactNo, isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Credit Days"),
                                  commonTableText(
                                      title: model.creditDays.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Invoice Type"),
                                  commonTableText(
                                      title: model.invoiceType, isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Paid"),
                                  commonTableText(
                                      title: model.paid.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Total Outstanding"),
                                  commonTableText(
                                      title: model.totalOutstanding.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Netpayable Amount"),
                                  commonTableText(
                                      title: model.netPayableAmount.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Sale Amount Ex. Discount"),
                                  commonTableText(
                                      title: model.saleAmountExDiscount.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Total Item Discount"),
                                  commonTableText(
                                      title: model.totalItemDiscount.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Net Amount"),
                                  commonTableText(
                                      title: model.netAmount.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Sale Amount inc. Discount"),
                                  commonTableText(
                                      title: model.saleAmountIncDiscount.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "IGST Per"),
                                  commonTableText(
                                      title: model.igstPer.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "IGST Amt"),
                                  commonTableText(
                                      title: model.igstAmt.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "CGST Per"),
                                  commonTableText(
                                      title: model.cgstPer.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "CGST Amt"),
                                  commonTableText(
                                      title: model.cgstAmt.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "SGST Per"),
                                  commonTableText(
                                      title: model.sgstPer.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "SGST Amt"),
                                  commonTableText(
                                      title: model.sgstAmt.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Tax Mode"),
                                  commonTableText(
                                      title: model.taxMode.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "GST Type"),
                                  commonTableText(
                                      title: model.gstType.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "GSTIN Number"),
                                  commonTableText(
                                      title: model.gstinNumber.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Customer GST Type"),
                                  commonTableText(
                                      title: model.customerGSTType.toString(), isEnd: true),
                                ],
                              ),
                              TableRow(
                                children: [
                                  commonTableText(title: "Sale Taxable AMT"),
                                  commonTableText(
                                      title: model.saleTaxableAmt.toString(), isEnd: true),
                                ],
                              ),
                            ],
                          ),
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

   monthlyPurchase() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: controller.monthlyPurchaseList.length,
      itemBuilder: (context, index) {
        MonhtlyPurchaseData model = controller.monthlyPurchaseList[index];
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
                key: Key(index.toString()),
                onExpansionChanged: (value) {

                },
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.partyname ?? "",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: FontSize.s18,
                        fontFamily: FontFamily.medium,
                      ),
                    ),
                    Text(
                      "Voucher No. ${model.voucherNo}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: FontSize.s16,
                        fontFamily: FontFamily.medium,
                      ),
                    ),
                    Text(
                      model.purchaseAmount.toString() ?? "",
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
                          commonTableText(title: "Party Name"),
                          commonTableText(
                              title: model.partyname, isEnd: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          commonTableText(title: "Voucher No."),
                          commonTableText(
                              title: model.voucherNo.toString(), isEnd: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          commonTableText(title: "DT"),
                          commonTableText(
                              title: model.date, isEnd: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          commonTableText(title: "Gross Amount"),
                          commonTableText(
                              title: model.paid.toString(), isEnd: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          commonTableText(title: "Discount"),
                          commonTableText(
                              title: model.discount.toString(), isEnd: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          commonTableText(title: "Invoice Type"),
                          commonTableText(
                              title: model.invoiceType, isEnd: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          commonTableText(title: "Paid"),
                          commonTableText(
                              title: model.paid.toString(), isEnd: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          commonTableText(title: "Total Outstanding"),
                          commonTableText(
                              title: model.totalOutstanding.toString(), isEnd: true),
                        ],
                      ),
                      // TableRow(
                      //   children: [
                      //     commonTableText(title: "Netpayable Amount"),
                      //     commonTableText(
                      //         title: model.netPayableAmount.toString(), isEnd: true),
                      //   ],
                      // ),
                      // TableRow(
                      //   children: [
                      //     commonTableText(title: "Sale Amount Ex. Discount"),
                      //     commonTableText(
                      //         title: model.saleAmountExDiscount.toString(), isEnd: true),
                      //   ],
                      // ),
                      // TableRow(
                      //   children: [
                      //     commonTableText(title: "Total Item Discount"),
                      //     commonTableText(
                      //         title: model.totalItemDiscount.toString(), isEnd: true),
                      //   ],
                      // ),
                      // TableRow(
                      //   children: [
                      //     commonTableText(title: "Net Amount"),
                      //     commonTableText(
                      //         title: model.netAmount.toString(), isEnd: true),
                      //   ],
                      // ),
                      // TableRow(
                      //   children: [
                      //     commonTableText(title: "Sale Amount inc. Discount"),
                      //     commonTableText(
                      //         title: model.saleAmountIncDiscount.toString(), isEnd: true),
                      //   ],
                      // ),
                      TableRow(
                        children: [
                          commonTableText(title: "IGST Per"),
                          commonTableText(
                              title: model.igstPer.toString(), isEnd: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          commonTableText(title: "IGST Amt"),
                          commonTableText(
                              title: model.igstAmt.toString(), isEnd: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          commonTableText(title: "CGST Per"),
                          commonTableText(
                              title: model.cgstPer.toString(), isEnd: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          commonTableText(title: "CGST Amt"),
                          commonTableText(
                              title: model.cgstAmt.toString(), isEnd: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          commonTableText(title: "SGST Per"),
                          commonTableText(
                              title: model.sgstPer.toString(), isEnd: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          commonTableText(title: "SGST Amt"),
                          commonTableText(
                              title: model.sgstAmt.toString(), isEnd: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          commonTableText(title: "Tax Mode"),
                          commonTableText(
                              title: model.taxMode.toString(), isEnd: true),
                        ],
                      ),
                      TableRow(
                        children: [
                          commonTableText(title: "GST Type"),
                          commonTableText(
                              title: model.gstType.toString(), isEnd: true),
                        ],
                      ),
                      // TableRow(
                      //   children: [
                      //     commonTableText(title: "GSTIN Number"),
                      //     commonTableText(
                      //         title: model.gstinNumber.toString(), isEnd: true),
                      //   ],
                      // ),
                      // TableRow(
                      //   children: [
                      //     commonTableText(title: "Customer GST Type"),
                      //     commonTableText(
                      //         title: model.customerGSTType.toString(), isEnd: true),
                      //   ],
                      // ),
                      // TableRow(
                      //   children: [
                      //     commonTableText(title: "Sale Taxable AMT"),
                      //     commonTableText(
                      //         title: model.saleTaxableAmt.toString(), isEnd: true),
                      //   ],
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
