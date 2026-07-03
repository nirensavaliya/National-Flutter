import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/modules/sale_invoice/controllers/sale_invoice_controller.dart';
import 'package:gap/gap.dart';

import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../bottom_bar/model/get_item_list.dart';
import '../../quotation/model/quotation_model.dart';
import '../model/sales_invoice_detail_model.dart';

class SaleInvoiceAddView extends GetView<SaleInvoiceController> {
  const SaleInvoiceAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaleInvoiceController>(
      builder: (controller) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 18),
          children: [
            CommonTextField(
              borderRadius: 12,
              controller: controller.addDateController,
              title: AppString.date,
              isTitle: true,
              maxLength: 10,
              showCursor: false,
              readOnly: true,
              onTap: (){
                controller.selectDate(context, "add");
              },
              inputFormatters: [
                DateInputFormatter(),
              ],
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
                  child: CommonTextField(
                    borderRadius: 12,
                    controller: TextEditingController(text: "GST"),
                    title: AppString.textMode,
                    isTitle: true,
                    readOnly: true,
                    showCursor: false,
                  ),
                ),
                Gap(15),
                Expanded(
                  child: CommonTextField(
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
            Gap(5),
            Text(
              AppString.invoiceType,
              style: TextStyle(
                fontFamily: FontFamily.bold,
                fontSize: FontSize.s18,
                color: Colors.black45,
              ),
            ),
            Gap(5),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                    color: controller.isOpen.value ? Colors.blue : Colors.black38),
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
                  title: Text(
                    controller.addInvoiceTypeController.text,
                  ),
                  children: List.generate(
                    controller.invoiceList.length,
                        (index) {
                      return GestureDetector(
                        onTap: () {
                          controller.addInvoiceTypeController.text =
                          controller.invoiceList[index];
                          controller.nextSerialNoApi();
                          controller.collapse();
                          controller.isOpen.value = false;
                          controller.update();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            controller.invoiceList[index],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Gap(5),
            CommonTextField(
              borderRadius: 12,
              controller: controller.customerController,
              title: AppString.customerName,
              isTitle: true,
              maxLength: 10,
              hintText: "Please Select...",
              showCursor: false,
              readOnly: true,
              onTap: () {
                controller.selectCustomer();
              },

              suffix: RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  )),
            ),
            Gap(5),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addCustomerNumberController,
              title: AppString.contactNumber,
              isTitle: true,
              maxLength: 12,
              textInputType: TextInputType.number,
            ),
            Gap(5),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addShippingAddressController,
              title: AppString.shippingAddress,
              isTitle: true,
              maxLine: 2,
              textInputType: TextInputType.streetAddress,
            ),
            Gap(5),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addCreditDaysController,
              title: AppString.CreditType,
              isTitle: true,
              textInputType: TextInputType.number,
            ),
            Gap(5),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addGSTinController,
              title: AppString.gstIn,
              isTitle: true,
              textInputType: TextInputType.number,
            ),
            Gap(5),
            Text(
              AppString.salesPerson,
              style: TextStyle(
                fontFamily: FontFamily.bold,
                fontSize: FontSize.s18,
                color: Colors.black45,
              ),
            ),
            Gap(5),
            DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black38),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Theme(
                data: ThemeData(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  childrenPadding: EdgeInsets.zero,
                  dense: true,
                  key: Key(controller.key.toString()),
                  title: Text(
                    controller.addSalesNameController.text,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSize.s16,
                      fontFamily: FontFamily.bold,
                    ),
                  ),
                  children: List.generate(
                    controller.salesList.length,
                        (index) {
                      return GestureDetector(
                        onTap: () {
                          controller.addSalesNameController.text =
                              controller.salesList[index].salesPerson ?? "";
                          controller.salesPersonId = controller.salesList[index].salesPersonId!;
                          controller.collapse();
                          controller.update();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            controller.salesList[index].salesPerson ?? "",
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Gap(5),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addRemarkController,
              title: AppString.remark,
              isTitle: true,
            ),
            Gap(5),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addRefController,
              title: AppString.refDocChallanNo,
              isTitle: true,
            ),
            Gap(5),
            if (controller.addInvoiceTypeController.text == controller.invoiceList[1])
              Text(
                AppString.gstType,
                style: TextStyle(
                  fontFamily: FontFamily.medium,
                  fontSize: FontSize.s16,
                  color: Colors.black38,
                ),
              ),
            if (controller.addInvoiceTypeController.text == controller.invoiceList[1])
              Gap(5),
            if (controller.addInvoiceTypeController.text == controller.invoiceList[1])
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: controller.isOpen.value ? Colors.blue : Colors.black38),
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
                    title: Text(
                      controller.addGstTypeController.text,
                    ),
                    children: List.generate(
                      controller.gstTYpe.length,
                          (index) {
                        return GestureDetector(
                          onTap: () {
                            controller.addGstTypeController.text =
                            controller.gstTYpe[index];
                            controller.collapse();
                            controller.isOpen.value = false;
                            controller.update();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              controller.gstTYpe[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            if (controller.invoiceController.text == controller.invoiceList[1])
              Gap(5),
            if (controller.itemList.isNotEmpty)
              Gap(15),
            if (controller.itemList.isNotEmpty)
              itemData(),
            Gap(25),
            if(controller.customerController.text.isNotEmpty)
              CommonButton(
                btnName: AppString.addItem,
                onTap: () {
                  selectItemSheet();
                },
              ),
            Gap(12),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    commonTableText(title: "Total"),
                    commonTableText(title: controller.total, isEnd: true),
                  ],
                ),
                TableRow(
                  children: [
                    commonTableText(title: "(-)DiscountTotal"),
                    commonTableText(
                        title: controller.discountTotal,
                        isLight: true,
                        isEnd: true),
                  ],
                ),
                TableRow(
                  children: [
                    commonTableText(title: "(+)CGSTTotal"),
                    commonTableText(
                        title: controller.cGstTotal,
                        isLight: true,
                        isEnd: true),
                  ],
                ),
                TableRow(
                  children: [
                    commonTableText(title: "(+)SGSTTotal"),
                    commonTableText(
                        title: controller.sGstTotal,
                        isLight: true,
                        isEnd: true),
                  ],
                ),
                TableRow(
                  children: [
                    commonTableText(title: "(+)IGSTTotal"),
                    commonTableText(
                        title: controller.iGstTotal,
                        isLight: true,
                        isEnd: true),
                  ],
                ),
                TableRow(
                  children: [
                    commonTableText(title: "TotalItem"),
                    commonTableText(
                        title: controller.totalItem,
                        isLight: true,
                        isEnd: true),
                  ],
                ),
                TableRow(
                  children: [
                    commonTableText(title: "NetTotal"),
                    commonTableText(
                        title: controller.netTotal, isLight: true, isEnd: true),
                  ],
                ),
              ],
            ),
            Gap(15),
            CommonButton(btnName: AppString.save, onTap: () {
              controller.isAdd.value = false;
              controller.createQuotationApi();
              // controller.update();
            },),
            Gap(Platform.isIOS ? 25 : 20),
          ],
        );
      },
    );
  }

  Widget commonTableText({
    String? title,
    bool? isLight,
    bool? isEnd,
    String? imageUrl,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (imageUrl != null) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(7, 3, 5, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.asset(
                      AppImages.appIcon_g,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(width: 5),
        ],
        Expanded(
          child: Padding(
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
          ),
        ),
      ],
    );
  }


  // Widget commonTableText({String? title, bool? isLight, bool? isEnd}) {
  //   return Padding(
  //     padding: EdgeInsets.all(8.0),
  //     child: Text(
  //       title ?? "",
  //       textAlign: isEnd == true ? TextAlign.end : TextAlign.start,
  //       style: TextStyle(
  //         fontSize: FontSize.s16,
  //         color: isLight == true ? Colors.black45 : Colors.black,
  //         fontFamily: FontFamily.medium,
  //       ),
  //     ),
  //   );
  // }

  // Widget itemData() {
  //   return SingleChildScrollView(
  //     padding: EdgeInsets.zero,
  //     scrollDirection: Axis.horizontal,
  //     dragStartBehavior: DragStartBehavior.start,
  //     child: DataTable(
  //       border: TableBorder.all(),
  //       dataRowHeight: 80,
  //
  //       columns: const <DataColumn>[
  //         DataColumn(label: Text('ACTION')),
  //         DataColumn(label: Text('Name')),
  //         // DataColumn(label: Text('UNIT')),
  //         // DataColumn(label: Text('QTY')),
  //         DataColumn(label: Text('PRICE')),
  //         DataColumn(label: Text('DISCOUNT(%)')),
  //         DataColumn(label: Text('DISCOUNT')),
  //         DataColumn(label: Text('TOTAL DISCOUNT')),
  //         DataColumn(label: Text('GST TEX')),
  //         DataColumn(label: Text('NETPRICE\n(INC. TEX)')),
  //         DataColumn(label: Text('CGSTPER')),
  //         DataColumn(label: Text('CGSTAMT')),
  //         DataColumn(label: Text('SGSTPER')),
  //         DataColumn(label: Text('SGSTAMT')),
  //         DataColumn(label: Text('IGSTPER')),
  //         DataColumn(label: Text('IGSTAMT')),
  //         DataColumn(label: Text('TEXABLE\nAMOUNT')),
  //       ],
  //       rows: List.generate(
  //         controller.itemList.length,
  //             (index) {
  //               SaleDetails data = controller.itemList[index];
  //           return DataRow(
  //             cells: <DataCell>[
  //               DataCell(Icon(Icons.delete)),
  //               DataCell(
  //                 Container(
  //                   // width: 200,
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min, // important
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         data.itemName ?? "",
  //                         style: TextStyle(fontWeight: FontWeight.w600),
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //                       SizedBox(height: 4),
  //                       Text("UNIT: ${data.unit ?? ""}", overflow: TextOverflow.ellipsis),
  //                       Flexible(
  //                         child: Text("QTY: ${data.qty.toString()}", overflow: TextOverflow.ellipsis),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //
  //               // DataCell(Text(data.unit ?? "")),
  //               // DataCell(Text(data.qty.toString())),
  //               DataCell(Text(data.price.toString())),
  //               DataCell(Text(data.discountPer.toString())),
  //               DataCell(Text(data.discount.toString())),
  //               DataCell(Text(data.totalDiscount.toString())),
  //               DataCell(Text(data.gstcodeId.toString())),
  //               DataCell(Text(data.netPriceINCTax.toString())),
  //               DataCell(Text(data.cgstPer.toString())),
  //               DataCell(Text(data.cgstAmount.toString())),
  //               DataCell(Text(data.sgstPer.toString())),
  //               DataCell(Text(data.sgstAmount.toString())),
  //               DataCell(Text(data.igstPer.toString())),
  //               DataCell(Text(data.igstAmount.toString())),
  //               DataCell(Text(data.taxableAmount.toString())),
  //             ],
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  Widget itemData() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder.all(),
        dataRowHeight: 75,
        columns: const <DataColumn>[
          DataColumn(label: Text('NAME')),
          DataColumn(label: Text('PRICE')),
          // DataColumn(label: Text('DISCOUNT(%)')),
          DataColumn(label: Text('DISCOUNT')),
          DataColumn(label: Text('TOTAL DISCOUNT')),
          DataColumn(label: Text('GST TAX')),
          DataColumn(label: Text('NETPRICE\n(INC. TAX)')),
          DataColumn(label: Text('CGST(%)')),
          DataColumn(label: Text('CGSTAMT')),
          DataColumn(label: Text('SGST(%)')),
          DataColumn(label: Text('SGSTAMT')),
          DataColumn(label: Text('IGST(%)')),
          DataColumn(label: Text('IGSTAMT')),
          DataColumn(label: Text('TEXABLE\nAMOUNT')),
          DataColumn(label: Text('ACTION')),
        ],
        rows: List.generate(
          controller.itemList.length,
              (index) {
            SaleDetails data = controller.itemList[index];
            return DataRow(
              cells: <DataCell>[
                DataCell(
                  Container(
                    width: 250,
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // important
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.itemName ?? "-",
                          style: TextStyle(fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        Text("UNIT: ${data.unit ?? "-"}", overflow: TextOverflow.ellipsis),
                        Row(
                          children: [
                            Flexible(
                              child: Text("QTY: ${data.qty?.toString() ?? "-"}", overflow: TextOverflow.ellipsis),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text("DIS(%): ${data.discountPer?.toString() ?? "-"}", overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                DataCell(Center(child: Text(data.price?.toString() ?? "-"))),
                // DataCell(Text(data.discountPer.toString())),
                DataCell(Center(child: Text(data.discount?.toString() ?? "-"))),
                DataCell(Center(child: Text(data.totalDiscount?.toString() ?? "-"))),
                DataCell(Center(child: Text(data.gstcodeId?.toString() ?? "-"))),
                DataCell(Center(child: Text(data.netPriceINCTax?.toString() ?? "-"))),
                DataCell(Center(child: Text(data.cgstPer?.toString() ?? "-"))),
                DataCell(Center(child: Text(data.cgstAmount?.toString() ?? "-"))),
                DataCell(Center(child: Text(data.sgstPer?.toString() ?? "-"))),
                DataCell(Center(child: Text(data.sgstAmount?.toString() ?? "-"))),
                DataCell(Center(child: Text(data.igstPer?.toString() ?? "-"))),
                DataCell(Center(child: Text(data.igstAmount?.toString() ?? "-"))),
                DataCell(Center(child: Text(data.taxableAmount?.toString() ?? "-"))),
                DataCell(Icon(Icons.delete)),
              ],
            );
          },
        ),
      ),
    );
  }


  selectItemSheet() {
    filteredItems = Constants.itemList;
    Get.bottomSheet(
      isScrollControlled: true,
      GetBuilder<SaleInvoiceController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.only(top: AppBar().preferredSize.height),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gap(10),
                  Text(
                    "Select Item",
                    style: TextStyle(
                      fontSize: FontSize.s22,
                      color: Colors.black,
                      fontFamily: FontFamily.semiBold,
                    ),
                  ),
                  Gap(10),
                  Divider(
                    color: Colors.black,
                  ),
                  Gap(10),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: CommonTextField(
                      controller: controller.searchFieldController,
                      borderRadius: 12,
                      prefix: Icon(Icons.search),
                      onChanged: (p0) {
                        // controller.filterItems(p0);
                        controller.customerNameFilterItems(p0);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                      // padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              addItemSheet(filteredItems[index]);
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(7)),
                              child: commonTableText(
                                  imageUrl: filteredItems[index].imageUrl,
                                  title: filteredItems[index].itemName ?? ""),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  addItemSheet(ItemData filteredItem) {
    controller.itemUnitController.text = filteredItem.unitCode ?? "";
    controller.itemQtyController.text = "1";
    controller.itemDiscountPerController.text = "0";
    controller.itemDiscountController.text = "0";
    controller.itemTotalDiscountController.text = "0";
    controller.itemPriceController.text = filteredItem.price.toString();
    controller.itemGrossAmountController.text = filteredItem.price.toString();
    for (int i = 0; i < Constants.gstList.length; i++) {
      if (Constants.gstList[i].gstCodeId == filteredItem.gstCodeId) {
        controller.addGstController.text =
            Constants.gstList[i].gstTaxName ?? "";
        controller.gstId = Constants.gstList[i].gstCodeId ?? 0;
      }
    }

    Get.bottomSheet(
      GetBuilder<SaleInvoiceController>(
        builder: (controller) {
          return DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(12),
                Text(
                  filteredItem.itemName ?? "",
                  style: TextStyle(
                    fontSize: FontSize.s18,
                    color: Colors.black,
                    fontFamily: FontFamily.medium,
                  ),
                ),
                Gap(10),
                Divider(
                  color: Colors.black,
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: controller.itemDesController,
                        title: AppString.itemDec,
                        isTitle: true,
                      ),
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: controller.itemUnitController,
                        title: AppString.unit,
                        isTitle: true,
                      ),
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: controller.itemQtyController,
                        title: AppString.qty,
                        isTitle: true,
                        onChanged: (p0) {
                          controller.calculateGstAndDiscount();
                        },
                      ),
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: controller.itemPriceController,
                        title: AppString.price,
                        isTitle: true,
                        onChanged: (p0) {
                          controller.calculateGstAndDiscount();
                        },
                      ),
                      if(controller.addGstTypeController.text.isNotEmpty)
                      Gap(10),
                      if(controller.addGstTypeController.text.isNotEmpty)
                      Text(
                        AppString.gstTax,
                        style: TextStyle(
                          fontFamily: FontFamily.medium,
                          fontSize: FontSize.s16,
                          color: Colors.black38,
                        ),
                      ),
                      if(controller.addGstTypeController.text.isNotEmpty)
                      Gap(8),
                      if(controller.addGstTypeController.text.isNotEmpty)
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: controller.isOpen.value
                                  ? Colors.blue
                                  : Colors.black38),
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
                            title: Text(
                              controller.addGstController.text,
                            ),
                            children: List.generate(
                              Constants.gstList.length,
                                  (index) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.addGstController.text =
                                        Constants.gstList[index].gstTaxName ?? "";
                                    controller.gstId = Constants.gstList[index].gstCodeId ?? 0;
                                    controller.calculateGstAndDiscount();
                                    controller.collapse();
                                    controller.isOpen.value = false;
                                    controller.update();
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      Constants.gstList[index].gstTaxName ?? "",
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemDiscountPerController,
                              title: AppString.discountPer,
                              isTitle: true,
                              onChanged: (p0) {
                                controller.calculateGstAndDiscount();
                              },
                            ),
                          ),
                          Gap(12),
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemDiscountController,
                              title: AppString.discount,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                        ],
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller:
                              controller.itemTotalDiscountController,
                              title: AppString.totalDiscount,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                          Gap(12),
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemNetPriceController,
                              title: AppString.netPrice,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                        ],
                      ),
                      if(controller.addGstTypeController.text.isNotEmpty)
                        if(controller.addGstTypeController.text != 'IGST')
                        Gap(10),
                      if(controller.addGstTypeController.text.isNotEmpty)
                        if(controller.addGstTypeController.text != 'IGST')
                        Row(
                          children: [
                            Expanded(
                              child: CommonTextField(
                                borderRadius: 12,
                                controller: controller.itemCGstPerController,
                                title: AppString.CGSTPer,
                                isTitle: true,
                                readOnly: true,
                                showCursor: false,
                              ),
                            ),
                            Gap(12),
                            Expanded(
                              child: CommonTextField(
                                borderRadius: 12,
                                controller: controller.itemCGstAmtController,
                                title: AppString.CGSTAmt,
                                isTitle: true,
                                readOnly: true,
                                showCursor: false,
                              ),
                            ),
                          ],
                        ),
                      if(controller.addGstTypeController.text.isNotEmpty)
                        if(controller.addGstTypeController.text != 'IGST')
                        Gap(10),
                      if(controller.addGstTypeController.text.isNotEmpty)
                        if(controller.addGstTypeController.text != 'IGST')
                        Row(
                          children: [
                            Expanded(
                              child: CommonTextField(
                                borderRadius: 12,
                                controller: controller.itemSGstPerController,
                                title: AppString.SGSTPer,
                                isTitle: true,
                                readOnly: true,
                                showCursor: false,
                              ),
                            ),
                            Gap(12),
                            Expanded(
                              child: CommonTextField(
                                borderRadius: 12,
                                controller: controller.itemSGstAmtController,
                                title: AppString.SGSTAmt,
                                isTitle: true,
                                readOnly: true,
                                showCursor: false,
                              ),
                            ),
                          ],
                        ),
                      if(controller.addGstTypeController.text.isNotEmpty)
                        if(controller.addGstTypeController.text == 'IGST')
                        Gap(10),
                      if(controller.addGstTypeController.text.isNotEmpty)
                        if(controller.addGstTypeController.text == 'IGST')
                        Row(
                          children: [
                            Expanded(
                              child: CommonTextField(
                                borderRadius: 12,
                                controller: controller.itemIGstPerController,
                                title: AppString.IGSTPer,
                                isTitle: true,
                                readOnly: true,
                                showCursor: false,
                              ),
                            ),
                            Gap(12),
                            Expanded(
                              child: CommonTextField(
                                borderRadius: 12,
                                controller: controller.itemIGstAmtController,
                                title: AppString.IGSTAmt,
                                isTitle: true,
                                readOnly: true,
                                showCursor: false,
                              ),
                            ),
                          ],
                        ),
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: controller.itemTaxablePriceController,
                        title: AppString.taxableAmount,
                        isTitle: true,
                        readOnly: true,
                        showCursor: false,
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemNetAmountController,
                              title: AppString.netAmount,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                          Gap(12),
                          Expanded(
                            child: CommonTextField(
                              borderRadius: 12,
                              controller: controller.itemGrossAmountController,
                              title: AppString.grossAmount,
                              isTitle: true,
                              readOnly: true,
                              showCursor: false,
                            ),
                          ),
                        ],
                      ),
                      Gap(25),
                      CommonButton(
                        btnName: AppString.save,
                        onTap: () {
                          controller.total =
                              (int.parse(controller.itemQtyController.text) *
                                  double.parse(
                                      controller.itemPriceController.text))
                                  .toStringAsFixed(2)
                                  .toString();
                          controller.discountTotal =
                              controller.itemTotalDiscountController.text;
                          controller.sGstTotal =
                              controller.itemSGstAmtController.text;
                          controller.cGstTotal =
                              controller.itemCGstAmtController.text;
                          controller.iGstTotal =
                              controller.itemIGstAmtController.text;
                          controller.iGstTotal =
                              controller.itemIGstAmtController.text;
                          controller.totalItem =
                              controller.itemList.length.toString();
                          controller.netTotal =
                              controller.itemNetAmountController.text;
                          controller.itemList.add(SaleDetails(
                            itemId: filteredItem.itemid,
                            itemName: filteredItem.itemName,
                            itemDescription: controller.itemDesController.text,
                            unit: controller.itemUnitController.text,
                            qty: double.tryParse(controller.itemQtyController.text),
                            price: double.tryParse(
                                controller.itemPriceController.text),
                            discountPer: double.tryParse(
                                controller.itemDiscountPerController.text),
                            discount: double.tryParse(
                                controller.itemDiscountController.text),
                            totalDiscount: double.tryParse(
                                controller.itemTotalDiscountController.text),
                            gstcodeId: controller.gstId > 0
                                ? controller.gstId
                                : (filteredItem.gstCodeId ?? 0),
                            netPriceINCTax: double.tryParse(
                                controller.itemNetPriceController.text),
                            cgstPer: double.tryParse(
                                controller.itemCGstPerController.text),
                            cgstAmount: double.tryParse(
                                controller.itemCGstAmtController.text),
                            sgstPer: double.tryParse(
                                controller.itemSGstPerController.text),
                            sgstAmount: double.tryParse(
                                controller.itemSGstAmtController.text),
                            igstPer: double.tryParse(
                                controller.itemIGstPerController.text),
                            igstAmount: double.tryParse(
                                controller.itemIGstAmtController.text),
                            taxableAmount: double.tryParse(
                                controller.itemTaxablePriceController.text),
                            netAmount: double.tryParse(
                                controller.itemNetAmountController.text),
                            grossAmount: double.tryParse(
                                controller.itemGrossAmountController.text),
                          ));
                          controller.update();
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
                Gap(30),
              ],
            ),
          );
        },
      ),
    );
  }
}
