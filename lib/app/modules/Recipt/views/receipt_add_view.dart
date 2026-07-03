import 'dart:io';

import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/all.dart';

import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_receipt_textfield.dart' show CommonReceiptTextfield;
import '../../../data/common_widget/common_textfeild.dart';
import '../controllers/receipt_controller.dart';

class ReceiptAddView extends GetView<ReceiptController> {
  const ReceiptAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiptController>(
      builder: (controller) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 18),
          children: [
            CommonReceiptTextfield(
              borderRadius: 12,
              controller: controller.addDateController,
              title: AppString.date,
              isTitle: true,
              maxLength: 10,
              readOnly: true,
              showCursor: false,
              inputFormatters: [
                DateInputFormatter(),
              ],
              onTap: () {
                controller.selectDate(context, "add");
              },
              textInputType: TextInputType.datetime,
              suffix: GestureDetector(
                onTap: () {
                  controller.selectDate(context, "add");
                },
                child: Icon(Icons.calendar_month),
              ),
            ),
            Gap(4),
            Row(
              children: [
                Expanded(
                  child: CommonReceiptTextfield(
                    borderRadius: 12,
                    controller: controller.addRefNoController,
                    title: AppString.ref_no,
                    isTitle: true,
                    showCursor: true,
                  ),
                ),
                Gap(15),
                Expanded(
                  child: CommonReceiptTextfield(
                    borderRadius: 12,
                    controller: controller.addSerialController,
                    title: AppString.invoiceSerialNo,
                    isTitle: true,
                    readOnly: true,
                    showCursor: false,
                  ),
                ),
              ],
            ),
            Gap(4),
            CommonReceiptTextfield(
              borderRadius: 12,
              controller: controller.paidByController,
              title: AppString.paidBy,
              isTitle: true,
              maxLength: 10,
              hintText: "Please Select...",
              showCursor: false,
              readOnly: true,
              onTap: () {
                controller.selectPaidByList();
              },
              suffix: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  )),
            ),
            Gap(4),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 7, 0),
              child: Text(
                controller.selectedPaidByAmount,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: FontSize.s14,
                  color: Colors.black,
                  fontFamily: FontFamily.medium,
                ),
              ),
            ),
            CommonReceiptTextfield(
              borderRadius: 12,
              controller: controller.cashBankController,
              title: AppString.cashBank,
              isTitle: true,
              maxLength: 10,
              hintText: "Please Select...",
              showCursor: false,
              readOnly: true,
              onTap: () {
                controller.selectCashBankBookList();
              },
              suffix: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  )),
            ),
            // Gap(5),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(0, 0, 7, 0),
            //   child: Text(
            //     controller.selectedAmount,
            //     // controller.cashBankAmount.text,
            //     textAlign: TextAlign.end,
            //     style: TextStyle(
            //       fontSize: FontSize.s16,
            //       color: Colors.black,
            //       fontFamily: FontFamily.medium,
            //     ),
            //   ),
            // ),
            Gap(4),
            Obx(()
              => controller.selectedBookType.value == "BankBook"
              ? Text(
                AppString.channel,
                style: TextStyle(
                  fontFamily: FontFamily.bold,
                  fontSize: FontSize.s14,
                  color: Colors.black45,
                ),
              ): SizedBox(),
            ),
            Gap(4),
            Obx(()
              => controller.selectedBookType.value == "BankBook"
               ? DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                      color:
                          controller.isOpen.value ? Colors.blue : Colors.black38),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Theme(
                  data: ThemeData(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.zero,
                    dense: true,
                    key: Key(controller.key.toString()),
                    onExpansionChanged: (value) {
                      print("value -- $value");
                      controller.isOpen.value = value;
                      controller.update();
                    },
                    title: Text(controller.channelController.text,
                        style: TextStyle(
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSize.s16,
                          color: Colors.black,
                        )),
                    children: List.generate(
                      controller.channelList.length,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            controller.channelController.text =
                                controller.channelList[index];
                            controller.collapse();
                            controller.isOpen.value = false;
                            controller.update();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              controller.channelList[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ): SizedBox(),
            ),
            // CommonTextField(
            //   borderRadius: 12,
            //   controller: controller.channelController,
            //   title: AppString.channel,
            //   isTitle: true,
            //   maxLength: 10,
            //   hintText: "Please Select...",
            //   showCursor: false,
            //   readOnly: true,
            //   onTap: () {},
            //   suffix: RotatedBox(
            //       quarterTurns: 1,
            //       child: Icon(
            //         Icons.arrow_forward_ios,
            //         size: 20,
            //       )),
            // ),

              Obx(() {
              return  controller.cashBankText.value == "Cash In Hand Account"
                  ? SizedBox()
                  : Column(
                      children: [
                        controller.selectedBookType.value == "BankBook"
                        ? Gap(4): Gap(0),
                        controller.selectedBookType.value == "BankBook"
                        ? CommonReceiptTextfield(
                          borderRadius: 12,
                          controller: controller.partyBankNameController,
                          title: AppString.partyBankName,
                          isTitle: true,
                          textInputType: TextInputType.number,
                        ): SizedBox(),
                        controller.selectedBookType.value == "BankBook" ?Gap(4):Gap(0),
                        controller.selectedBookType.value == "BankBook"
                        ? CommonReceiptTextfield(
                          borderRadius: 12,
                          controller: controller.chequeNoController,
                          title: AppString.chequeNo,
                          isTitle: true,
                          textInputType: TextInputType.number,
                        ): SizedBox(),
                        controller.selectedBookType.value == "BankBook"? Gap(4) : Gap(0),
                        controller.selectedBookType.value == "BankBook"
                        ? CommonReceiptTextfield(
                          borderRadius: 12,
                          controller: controller.chequeDateController,
                          title: AppString.chequeDate,
                          isTitle: true,
                          maxLength: 10,
                          showCursor: false,
                          readOnly: true,
                          onTap: () {
                            controller.selectDate(context, "add");
                          },
                          textInputType: TextInputType.datetime,
                          suffix: GestureDetector(
                            onTap: () {
                              controller.selectDate(context, "add");
                            },
                            child: Icon(Icons.calendar_month),
                          ),
                        ):SizedBox(),
                      ],
                    );
            }),
            controller.selectedBookType.value == "BankBook" ? Gap(4):Gap(0),
            CommonReceiptTextfield(
              borderRadius: 12,
              controller: controller.collectedByController,
              title: AppString.collectedBy,
              isTitle: true,
              showCursor: false,
              readOnly: true,
              textInputType: TextInputType.number,
            ),
            // Gap(12),
            // CommonTextField(
            //   borderRadius: 12,
            //   controller: controller.branchController,
            //   title: AppString.branch,
            //   isTitle: true,
            //   showCursor: false,
            //   readOnly: true,
            //   textInputType: TextInputType.number,
            // ),
            // Gap(14),
            // Divider(height: 2, color: Colors.grey),
            Gap(9),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                "Received Amount Adjustment",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: FontSize.s14,
                  color: Colors.black,
                  fontFamily: FontFamily.semiBold,
                ),
              ),
            ),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Manual',
                          groupValue: controller.selectedOption.value,
                          onChanged: (String? value) {
                            controller.selectedOption.value = "Manual";
                          },
                        ),
                        Text('Manual'),
                      ],
                    ),
                    SizedBox(width: 20),
                    Row(
                      children: [
                        Radio<String>(
                          value: 'Auto',
                          groupValue: controller.selectedOption.value,
                          onChanged: (String? value) {
                            controller.selectedOption.value = "Auto";
                          },
                        ),
                        Text('Auto'),
                      ],
                    ),
                  ],
                )),
            Obx(() => Column(children: [
              controller.selectedOption.value == "Auto"? Gap(5) :Gap(0),
                 Row(
                    children: [
                      controller.selectedOption.value == "Auto"
                       ? Expanded(
                        child: CommonReceiptTextfield(
                            borderRadius: 12,
                            controller: controller.againstInvoiceController,
                            title: AppString.againstInvoice,
                            textInputType: TextInputType.number,
                            isTitle: true,
                            showCursor:
                                controller.selectedOption.value == "Auto"
                                    ? true
                                    : false,
                            readOnly: controller.selectedOption.value == "Auto"
                                ? false
                                : true,
                            onChanged: (value) {
                              if (controller.selectedOption.value == "Auto") {
                                controller.updateReceivedAmount();
                              }
                            }),
                      ): SizedBox(),
                      controller.selectedOption.value == "Auto"? Gap(10):SizedBox(),
                      controller.selectedOption.value == "Auto"
                      ? Expanded(
                        child: CommonReceiptTextfield(
                          borderRadius: 12,
                          controller: controller.advanceDepositeController,
                          title: AppString.advanceDeposit,
                          textInputType: TextInputType.number,
                          isTitle: true,
                          showCursor: controller.selectedOption.value == "Auto"
                              ? true
                              : false,
                          readOnly: controller.selectedOption.value == "Auto"
                              ? false
                              : true,
                            onChanged: (value) {
                              if (controller.selectedOption.value == "Auto") {
                                controller.updateReceivedAmount();
                              }
                            }
                        ),
                      ): SizedBox(),
                    ],
                  ) ,
              // controller.selectedOption.value == "Auto" ? Gap(10):SizedBox(),
              // controller.selectedOption.value == "Auto"
              // ? CommonReceiptTextfield(
              //       borderRadius: 12,
              //       controller: controller.onAccountController,
              //       title: AppString.onAccount,
              //       textInputType: TextInputType.number,
              //       isTitle: true,
              //       readOnly: controller.selectedOption.value == "Auto"
              //           ? false
              //           : true,
              //       showCursor: controller.selectedOption.value == "Auto"
              //           ? true
              //           : false,
              //         onChanged: (value) {
              //           if (controller.selectedOption.value == "Auto") {
              //             controller.updateReceivedAmount();
              //           }
              //         }
              //     ):SizedBox() ,
              controller.selectedOption.value == "Auto" ? Gap(5):SizedBox(),
              controller.selectedOption.value == "Auto" ? Row(
                    children: [
                       Expanded(
                        child: CommonReceiptTextfield(
                          borderRadius: 12,
                          controller: controller.totalReceivedController,
                          title: AppString.totalReceived,
                          isTitle: true,
                          showCursor: false,
                          readOnly: true,
                        ),
                      ),
                      // Gap(15),
                      // Expanded(
                      //   child: CommonReceiptTextfield(
                      //     borderRadius: 12,
                      //     controller: controller.discountGivenController,
                      //     title: AppString.discountGiven,
                      //     isTitle: true,
                      //     onChanged: (value) {
                      //       if (controller.selectedOption.value == "Auto") {
                      //         controller.updateReceivedAmount();
                      //       }
                      //     },
                      //     readOnly: controller.selectedOption.value == "Auto"
                      //         ? false
                      //         : true,
                      //     textInputType: TextInputType.number,
                      //     showCursor: controller.selectedOption.value == "Manual"
                      //         ? true
                      //         : false,
                      //   ),
                      // ),
                    ],
                  ):SizedBox(),
              controller.selectedOption.value == "Auto"? Gap(5):SizedBox(),
              // controller.selectedOption.value == "Auto"? CommonReceiptTextfield(
              //       borderRadius: 12,
              //       controller: controller.totalAdjustedController,
              //       title: AppString.totalAdjusted,
              //       isTitle: true,
              //       showCursor: false,
              //       readOnly: true,
              //     ):SizedBox()
                ])),
            // Constants.BillDataList.isNotEmpty ? Gap(5) : SizedBox(),
            Obx((){
              return controller.selectedOption.value == "Manual"
                  ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: Constants.BillDataList.length,
                itemBuilder: (context, index) {
                  final bill = Constants.BillDataList[index];

                  if (controller.receivedAmountControllers.length <=
                      index) {
                    controller.receivedAmountControllers
                        .add(TextEditingController());
                  }
                  if (controller.discountPercentageControllers.length <=
                      index) {
                    controller.discountPercentageControllers
                        .add(TextEditingController());
                  }
                  if (controller.discountAmountControllers.length <=
                      index) {
                    controller.discountAmountControllers
                        .add(TextEditingController());
                  }

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Bill No: ${bill.billNo} | Date: ${bill.billDate}",
                            style: TextStyle(
                              fontSize: FontSize.s14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(15),
                          TextField(
                            controller:
                            controller.receivedAmountControllers[index],
                            decoration: InputDecoration(
                              labelText: "Received Amount",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                                controller.updateBillAmount(index),
                          ),
                          Gap(15),
                          TextField(
                            controller: controller
                                .discountPercentageControllers[index],
                            decoration: InputDecoration(
                              labelText: "Discount %",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                                controller.updateBillAmount(index),
                          ),
                          Gap(15),
                          TextField(
                            controller:
                            controller.discountAmountControllers[index],
                            decoration: InputDecoration(
                              labelText: "Discount Amount",
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) =>
                                controller.updateBillAmount(index),
                          ),
                          Gap(5),
                          Text("Bill Amount: ${bill.billAmount}"),
                          Text("Outstanding Amt: ${bill.outstanding}"),
                          Text("Challan No: ${bill.challanNo}"),
                          Text("Sale Type: ${bill.saleType}"),
                          Text("Sales Person: ${bill.salesPerson}"),
                          Text("Broker: ${bill.broker}"),
                        ],
                      ),
                    ),
                  );
                },
              )
                  : SizedBox();
            }),
            // Constants.BillDataList.isNotEmpty
            //     ? ListView.builder(
            //         shrinkWrap: true,
            //         physics: NeverScrollableScrollPhysics(),
            //         itemCount: Constants.BillDataList.length,
            //         itemBuilder: (context, index) {
            //           final bill = Constants.BillDataList[index];
            //
            //           if (controller.receivedAmountControllers.length <=
            //               index) {
            //             controller.receivedAmountControllers
            //                 .add(TextEditingController());
            //           }
            //           if (controller.discountPercentageControllers.length <=
            //               index) {
            //             controller.discountPercentageControllers
            //                 .add(TextEditingController());
            //           }
            //           if (controller.discountAmountControllers.length <=
            //               index) {
            //             controller.discountAmountControllers
            //                 .add(TextEditingController());
            //           }
            //
            //           return Card(
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(12),
            //             ),
            //             elevation: 2,
            //             color: Colors.white,
            //             margin: EdgeInsets.symmetric(vertical: 8),
            //             child: Padding(
            //               padding: EdgeInsets.all(12),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     "Bill No: ${bill.billNo} | Date: ${bill.billDate}",
            //                     style: TextStyle(
            //                       fontSize: FontSize.s14,
            //                       fontWeight: FontWeight.bold,
            //                     ),
            //                   ),
            //                   Gap(15),
            //                   TextField(
            //                     controller:
            //                         controller.receivedAmountControllers[index],
            //                     decoration: InputDecoration(
            //                       labelText: "Received Amount",
            //                       border: OutlineInputBorder(),
            //                     ),
            //                     keyboardType: TextInputType.number,
            //                     onChanged: (value) =>
            //                         controller.updateBillAmount(index),
            //                   ),
            //                   Gap(15),
            //                   TextField(
            //                     controller: controller
            //                         .discountPercentageControllers[index],
            //                     decoration: InputDecoration(
            //                       labelText: "Discount %",
            //                       border: OutlineInputBorder(),
            //                     ),
            //                     keyboardType: TextInputType.number,
            //                     onChanged: (value) =>
            //                         controller.updateBillAmount(index),
            //                   ),
            //                   Gap(15),
            //                   TextField(
            //                     controller:
            //                         controller.discountAmountControllers[index],
            //                     decoration: InputDecoration(
            //                       labelText: "Discount Amount",
            //                       border: OutlineInputBorder(),
            //                     ),
            //                     keyboardType: TextInputType.number,
            //                     onChanged: (value) =>
            //                         controller.updateBillAmount(index),
            //                   ),
            //                   Gap(5),
            //                   Text("Bill Amount: ${bill.billAmount}"),
            //                   Text("Outstanding Amt: ${bill.outstanding}"),
            //                   Text("Challan No: ${bill.challanNo}"),
            //                   Text("Sale Type: ${bill.saleType}"),
            //                   Text("Sales Person: ${bill.salesPerson}"),
            //                   Text("Broker: ${bill.broker}"),
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //       )
            //     : SizedBox(),

            Gap(4),
            CommonReceiptTextfield(
              borderRadius: 12,
              controller: controller.descriptionController,
              title: AppString.description,
              isTitle: true,
              showCursor: true,
              readOnly: false,
            ),
            Gap(20),
            CommonButton(
              btnName: AppString.save,
              onTap: () {
                controller.saveReceiptApi();
              },
            ),
            Gap(Platform.isIOS ? 25 : 20),
          ],
        );
      },
    );
  }
}
