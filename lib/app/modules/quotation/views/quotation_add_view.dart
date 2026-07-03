import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/data/common_widget/common_button.dart';
import 'package:gurukrupa/app/modules/bottom_bar/model/get_item_list.dart';
import 'package:gurukrupa/app/modules/quotation/controllers/quotation_controller.dart';
import 'package:gurukrupa/app/modules/quotation/model/quotation_model.dart';
import 'package:gap/gap.dart';

import '../../../data/common_widget/common_textfeild.dart';
import '../../item_list/controllers/item_list_controller.dart';

class QuotationAddView extends GetView<QuotationController> {
  const QuotationAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuotationController>(
      builder: (controller) {
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 18),
          children: [
            CommonTextField(
              borderRadius: 12,
              controller: controller.addDateController,
              title: AppString.date,
              isTitle: true,
              readOnly: true,
              showCursor: false,
              maxLength: 10,
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
            Gap(12),
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
            Gap(12),
            Text(
              AppString.invoiceType,
              style: TextStyle(
                fontFamily: FontFamily.bold,
                fontSize: FontSize.s18,
                color: Colors.black45,
              ),
            ),
            Gap(8),
            DecoratedBox(
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
            Gap(12),
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
            Gap(12),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addCustomerNumberController,
              title: AppString.contactNumber,
              isTitle: true,
              maxLength: 12,
              textInputType: TextInputType.number,
            ),
            Gap(12),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addShippingAddressController,
              title: AppString.shippingAddress,
              isTitle: true,
              maxLine: 2,
              textInputType: TextInputType.streetAddress,
            ),
            Gap(12),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addCreditDaysController,
              title: AppString.CreditType,
              isTitle: true,
              textInputType: TextInputType.number,
            ),
            Gap(12),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addGSTinController,
              title: AppString.gstIn,
              isTitle: true,
              textInputType: TextInputType.number,
            ),
            Gap(12),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addRemarkController,
              title: AppString.remark,
              isTitle: true,
            ),
            Gap(12),
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
              Gap(8),
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
              Gap(12),
            if (controller.itemList.isNotEmpty) Gap(20),
            if (controller.itemList.isNotEmpty) itemData(),
            Gap(21),
            CommonButton(
              btnName: AppString.addItem,
              onTap: () {
                selectItemSheet();
              },
            ),
            Gap(30),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    commonTableText(title: "Total"),
                    commonTableText(title: controller.total ?? "-", isEnd: true),
                  ],
                ),
                TableRow(
                  children: [
                    commonTableText(title: "(-)DiscountTotal"),
                    commonTableText(
                        title: controller.discountTotal ?? "-",
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
            Gap(10),
            CommonButton(
              btnName: AppString.save,
              onTap: () {
                controller.isAdd.value = false;
                if (controller.isUpdate) {
                  controller.updateQuotationApi();
                }
                else
                  {
                controller.createQuotationApi();
                  }
                controller.isUpdate = false;
                controller.update();
              },
            ),
            Gap(Platform.isIOS ? 25 : 20),
          ],
        );
      },
    );
  }

  Widget itemData() {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.horizontal,
      dragStartBehavior: DragStartBehavior.start,
      child: DataTable(
        border: TableBorder.all(),
        columns: const <DataColumn>[
          DataColumn(label: Text('NAME')),
          DataColumn(label: Text('UNIT')),
          DataColumn(label: Text('QTY')),
          DataColumn(label: Text('PRICE')),
          DataColumn(label: Text('DISCOUNT(%)')),
          DataColumn(label: Text('DISCOUNT')),
          DataColumn(label: Text('TOTAL DISCOUNT')),
          DataColumn(label: Text('GST TEX')),
          DataColumn(label: Text('NETPRICE\n(INC. TEX)')),
          DataColumn(label: Text('CGSTPER')),
          DataColumn(label: Text('CGSTAMT')),
          DataColumn(label: Text('SGSTPER')),
          DataColumn(label: Text('SGSTAMT')),
          DataColumn(label: Text('IGSTPER')),
          DataColumn(label: Text('IGSTAMT')),
          DataColumn(label: Text('TEXABLE\nAMOUNT')),
          DataColumn(label: Text('ACTION')),
        ],
        rows: List.generate(
          controller.itemList.length,
          (index) {
            QuotationDetails data = controller.itemList[index];
            return DataRow(
              cells: <DataCell>[
                DataCell(Text(
                  data.itemName ?? "",
                  maxLines: 2,
                )),
                DataCell(Center(child: Text(data.unit ?? "-"))),
                DataCell(Center(child: Text(data.qty?.toString() ?? "-"))),
                DataCell(Center(child: Text(data.price?.toString() ?? "-"))),
                DataCell(Center(child: Text(data.discountPer?.toString() ?? "-"))),
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
    controller.searchFieldController.clear();
    Get.bottomSheet(
      isScrollControlled: true,
      GetBuilder<QuotationController>(
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
                        controller.filterItems(p0);
                      },
                    ),
                  ),
                  Gap(15),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              controller.itemNetPriceController.text = filteredItems[index].price.toString();
                              addItemSheet(filteredItems[index]);
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(7)),
                              child: commonTableText(
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
    for(int i = 0;i< Constants.gstList.length; i++) {
      if (Constants.gstList[i].gstCodeId == filteredItem.gstCodeId)
      {
        controller.addGstController.text =
            Constants.gstList[i].gstTaxName ?? "";
        controller.gstId = Constants.gstList[i].gstCodeId ?? 0;
      }
    }
    Get.bottomSheet(
      GetBuilder<QuotationController>(
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
                  color: Colors.grey,
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
                          fontFamily: FontFamily.bold,
                          fontSize: FontSize.s18,
                          color: Colors.black45,
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
                                    // controller.calculateDiscount();
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
                                // controller.calculateGST();
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
                          controller.itemList.add(QuotationDetails(
                            itemId: filteredItem.itemid,
                            itemName: filteredItem.itemName,
                            itemDescription: controller.itemDesController.text,
                            unit: controller.itemUnitController.text,
                            qty: double.parse(controller.itemQtyController.text),
                            price: double.parse(
                                controller.itemPriceController.text),
                            discountPer: double.parse(
                                controller.itemDiscountPerController.text),
                            discount: double.parse(
                                controller.itemDiscountController.text),
                            totalDiscount: double.parse(
                                controller.itemTotalDiscountController.text),
                            gstcodeId: 0,
                            netPriceINCTax: double.parse(
                                controller.itemNetPriceController.text),
                            cgstPer: controller.itemCGstPerController.text.isNotEmpty
                                ? double.parse(controller.itemCGstPerController.text)
                                : 0.0,
                            cgstAmount: controller.itemCGstAmtController.text.isNotEmpty
                            ? double.parse(controller.itemCGstAmtController.text) :0.0,
                            sgstPer: controller.itemSGstPerController.text.isNotEmpty
                            ? double.parse(controller.itemSGstPerController.text):0.0,
                            sgstAmount: controller.itemSGstAmtController.text.isNotEmpty
                            ? double.parse(controller.itemSGstAmtController.text) : 0.0,
                            igstPer: double.tryParse(
                                    controller.itemIGstPerController.text) ??
                                0.0,
                            igstAmount: double.tryParse(
                                    controller.itemIGstAmtController.text) ??
                                0.0,
                            taxableAmount: double.tryParse(
                                    controller.itemTaxablePriceController.text) ??
                                0.0,
                            netAmount: double.tryParse(
                                    controller.itemNetAmountController.text) ??
                                0.0,
                            grossAmount: double.tryParse(
                                    controller.itemGrossAmountController.text) ??
                                0.0,
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
