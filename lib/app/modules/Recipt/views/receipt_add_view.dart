import 'dart:io';

import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/Recipt/model/BillDataModel.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';

import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_receipt_textfield.dart'
    show CommonReceiptTextfield;
import '../../../data/common_widget/common_textfeild.dart';
import '../controllers/receipt_controller.dart';

class ReceiptAddView extends GetView<ReceiptController> {
  const ReceiptAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiptController>(
      builder: (controller) {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            SalesOrderFormSection(
              title: 'Receipt Details',
              icon: Icons.receipt_long_outlined,
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
                Gap(5),
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
              ],
            ),
            const Gap(16),
            SalesOrderFormSection(
              title: 'Payment Details',
              icon: Icons.payments_outlined,
              children: [
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
                    ),
                  ),
                ),
                Gap(5),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: SplashColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      controller.selectedPaidByAmount,
                      style: TextStyle(
                        fontSize: FontSize.s12,
                        color: SplashColors.primary,
                        fontFamily: FontFamily.semiBold,
                      ),
                    ),
                  ),
                ),
                Gap(5),
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
                    ),
                  ),
                ),
                Gap(5),
                Obx(
                  () => controller.selectedBookType.value == "BankBook"
                      ? Text(
                          AppString.channel,
                          style: TextStyle(
                            fontFamily: FontFamily.bold,
                            fontSize: FontSize.s14,
                            color: Colors.black45,
                          ),
                        )
                      : SizedBox(),
                ),
                Gap(5),
                Obx(
                  () => controller.selectedBookType.value == "BankBook"
                      ? Material(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: salesOrderFieldBorder(
                                  controller.isOpen.value),
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Theme(
                            data: ThemeData(dividerColor: Colors.transparent),
                            child: ExpansionTile(
                              backgroundColor: Colors.white,
                              collapsedBackgroundColor: Colors.white,
                              childrenPadding: EdgeInsets.zero,
                              dense: true,
                              key: Key(controller.key.toString()),
                              onExpansionChanged: (value) {
                                print("value -- $value");
                                controller.isOpen.value = value;
                                controller.update();
                              },
                              title: Text(
                                controller.channelController.text,
                                style: TextStyle(
                                  fontFamily: FontFamily.semiBold,
                                  fontSize: FontSize.s16,
                                  color: Colors.black,
                                ),
                              ),
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
                        )
                      : SizedBox(),
                ),
                Obx(() {
                  return controller.cashBankText.value ==
                          "Cash In Hand Account"
                      ? SizedBox()
                      : Column(
                          children: [
                            controller.selectedBookType.value == "BankBook"
                                ? Gap(5)
                                : Gap(0),
                            controller.selectedBookType.value == "BankBook"
                                ? CommonReceiptTextfield(
                                    borderRadius: 12,
                                    controller:
                                        controller.partyBankNameController,
                                    title: AppString.partyBankName,
                                    isTitle: true,
                                    textInputType: TextInputType.number,
                                  )
                                : SizedBox(),
                            controller.selectedBookType.value == "BankBook"
                                ? Gap(5)
                                : Gap(0),
                            controller.selectedBookType.value == "BankBook"
                                ? CommonReceiptTextfield(
                                    borderRadius: 12,
                                    controller: controller.chequeNoController,
                                    title: AppString.chequeNo,
                                    isTitle: true,
                                    textInputType: TextInputType.number,
                                  )
                                : SizedBox(),
                            controller.selectedBookType.value == "BankBook"
                                ? Gap(5)
                                : Gap(0),
                            controller.selectedBookType.value == "BankBook"
                                ? CommonReceiptTextfield(
                                    borderRadius: 12,
                                    controller:
                                        controller.chequeDateController,
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
                                  )
                                : SizedBox(),
                          ],
                        );
                }),
              ],
            ),
            const Gap(16),
            SalesOrderFormSection(
              title: 'Collection',
              icon: Icons.person_outline,
              children: [
                CommonReceiptTextfield(
                  borderRadius: 12,
                  controller: controller.collectedByController,
                  title: AppString.collectedBy,
                  isTitle: true,
                  showCursor: false,
                  readOnly: true,
                  textInputType: TextInputType.number,
                ),
              ],
            ),
            const Gap(16),
            SalesOrderFormSection(
              title: 'Amount Adjustment',
              icon: Icons.tune_outlined,
              children: [
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Manual',
                              groupValue: controller.selectedOption.value,
                              activeColor: SplashColors.primary,
                              onChanged: (String? value) {
                                controller.selectedOption.value = "Manual";
                              },
                            ),
                            Text(
                              'Manual',
                              style: TextStyle(
                                fontFamily: FontFamily.medium,
                                fontSize: FontSize.s14,
                                color: SplashColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            Radio<String>(
                              value: 'Auto',
                              groupValue: controller.selectedOption.value,
                              activeColor: SplashColors.primary,
                              onChanged: (String? value) {
                                controller.selectedOption.value = "Auto";
                              },
                            ),
                            Text(
                              'Auto',
                              style: TextStyle(
                                fontFamily: FontFamily.medium,
                                fontSize: FontSize.s14,
                                color: SplashColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                Obx(() => Column(children: [
                      controller.selectedOption.value == "Auto"
                          ? Gap(8)
                          : Gap(0),
                      Row(
                        children: [
                          controller.selectedOption.value == "Auto"
                              ? Expanded(
                                  child: CommonReceiptTextfield(
                                    borderRadius: 12,
                                    controller:
                                        controller.againstInvoiceController,
                                    title: AppString.againstInvoice,
                                    textInputType: TextInputType.number,
                                    isTitle: true,
                                    showCursor:
                                        controller.selectedOption.value ==
                                            "Auto",
                                    readOnly:
                                        controller.selectedOption.value !=
                                            "Auto",
                                    onChanged: (value) {
                                      if (controller.selectedOption.value ==
                                          "Auto") {
                                        controller.updateReceivedAmount();
                                      }
                                    },
                                  ),
                                )
                              : SizedBox(),
                          controller.selectedOption.value == "Auto"
                              ? Gap(10)
                              : SizedBox(),
                          controller.selectedOption.value == "Auto"
                              ? Expanded(
                                  child: CommonReceiptTextfield(
                                    borderRadius: 12,
                                    controller:
                                        controller.advanceDepositeController,
                                    title: AppString.advanceDeposit,
                                    textInputType: TextInputType.number,
                                    isTitle: true,
                                    showCursor:
                                        controller.selectedOption.value ==
                                            "Auto",
                                    readOnly:
                                        controller.selectedOption.value !=
                                            "Auto",
                                    onChanged: (value) {
                                      if (controller.selectedOption.value ==
                                          "Auto") {
                                        controller.updateReceivedAmount();
                                      }
                                    },
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                      controller.selectedOption.value == "Auto"
                          ? Gap(8)
                          : SizedBox(),
                      controller.selectedOption.value == "Auto"
                          ? Row(
                              children: [
                                Expanded(
                                  child: CommonReceiptTextfield(
                                    borderRadius: 12,
                                    controller:
                                        controller.totalReceivedController,
                                    title: AppString.totalReceived,
                                    isTitle: true,
                                    showCursor: false,
                                    readOnly: true,
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
                      controller.selectedOption.value == "Auto"
                          ? Gap(8)
                          : SizedBox(),
                    ])),
                Obx(() {
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
                            if (controller
                                    .discountPercentageControllers.length <=
                                index) {
                              controller.discountPercentageControllers
                                  .add(TextEditingController());
                            }
                            if (controller.discountAmountControllers.length <=
                                index) {
                              controller.discountAmountControllers
                                  .add(TextEditingController());
                            }

                            return _manualBillCard(controller, bill, index);
                          },
                        )
                      : SizedBox();
                }),
              ],
            ),
            const Gap(16),
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
              btnColor: SplashColors.primary,
              textColor: Colors.white,
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

  Widget _manualBillCard(
    ReceiptController controller,
    BillData bill,
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: SplashColors.primary.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: SplashColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.description_outlined,
                    color: SplashColors.primary,
                    size: 20,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Text(
                    "Bill No: ${bill.billNo} | Date: ${bill.billDate}",
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: FontSize.s14,
                      color: SplashColors.primaryDark,
                    ),
                  ),
                ),
              ],
            ),
            Gap(12),
            CommonReceiptTextfield(
              borderRadius: 12,
              controller: controller.receivedAmountControllers[index],
              title: "Received Amount",
              isTitle: true,
              textInputType: TextInputType.number,
              onChanged: (value) => controller.updateBillAmount(index),
            ),
            Gap(8),
            CommonReceiptTextfield(
              borderRadius: 12,
              controller: controller.discountPercentageControllers[index],
              title: "Discount %",
              isTitle: true,
              textInputType: TextInputType.number,
              onChanged: (value) => controller.updateBillAmount(index),
            ),
            Gap(8),
            CommonReceiptTextfield(
              borderRadius: 12,
              controller: controller.discountAmountControllers[index],
              title: "Discount Amount",
              isTitle: true,
              textInputType: TextInputType.number,
              onChanged: (value) => controller.updateBillAmount(index),
            ),
            Gap(8),
            _billDetailRow('Bill Amount', '${bill.billAmount}'),
            _billDetailRow('Outstanding Amt', '${bill.outstanding}'),
            _billDetailRow('Challan No', '${bill.challanNo}'),
            _billDetailRow('Sale Type', '${bill.saleType}'),
            _billDetailRow('Sales Person', '${bill.salesPerson}'),
            _billDetailRow('Broker', '${bill.broker}'),
          ],
        ),
      ),
    );
  }

  Widget _billDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontFamily: FontFamily.medium,
                fontSize: FontSize.s12,
                color: const Color(0xFF78829A),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontFamily: FontFamily.semiBold,
                fontSize: FontSize.s12,
                color: SplashColors.primaryDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
