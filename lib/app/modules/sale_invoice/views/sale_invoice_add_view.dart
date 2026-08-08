import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sale_invoice/controllers/sale_invoice_controller.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            SalesOrderFormSection(
              title: 'Invoice Details',
              icon: Icons.receipt_long_outlined,
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
                    fontFamily: FontFamily.semiBold,
                    fontSize: FontSize.s16,
                    color: Colors.black,
                  ),
                ),
                Gap(8),
            Material(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: salesOrderFieldBorder(controller.isOpen.value),
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
              ],
            ),
            const Gap(16),
            SalesOrderFormSection(
              title: 'Customer & Billing',
              icon: Icons.person_outline,
              children: [
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
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.streetAddress,
            ),
            Gap(5),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addCreditDaysController,
              title: AppString.CreditType,
              isTitle: true,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
            ),
            Gap(5),
            CommonTextField(
              borderRadius: 12,
              controller: controller.addGSTinController,
              title: AppString.gstIn,
              isTitle: true,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.number,
            ),
            Gap(5),
            Text(
              AppString.salesPerson,
              style: TextStyle(
                fontFamily: FontFamily.bold,
                fontSize: FontSize.s16,
                color: Colors.black,
              ),
            ),
            Gap(8),
            Material(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: SplashColors.nightSky.withOpacity(0.25),
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
              textInputAction: TextInputAction.done,
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
              Material(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: salesOrderFieldBorder(controller.isOpen.value),
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
              ],
            ),
            if (controller.itemList.isNotEmpty) ...[
              const Gap(20),
              itemData(),
            ],
            if (controller.customerController.text.isNotEmpty) ...[
              const Gap(16),
              _InvoiceOutlineButton(
                label: AppString.addItem,
                icon: Icons.add_rounded,
                onTap: () {
                  selectItemSheet();
                },
              ),
            ],
            const Gap(16),
            orderSummaryCard(),
            const Gap(14),
            _InvoiceSaveButton(
              onTap: () {
                controller.isAdd.value = false;
                controller.createQuotationApi();
              },
            ),
            Gap(Platform.isIOS ? 25 : 20),
          ],
        );
      },
    );
  }

  Widget orderSummaryCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SplashColors.nightSky.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'BILL SUMMARY',
            style: TextStyle(
              fontFamily: FontFamily.bold,
              fontSize: FontSize.s14,
              color: SplashColors.nightSky,
              letterSpacing: 0.6,
            ),
          ),
          const Gap(12),
          summaryRow(
            icon: Icons.calculate_outlined,
            label: 'Total',
            value: controller.total,
          ),
          summaryRow(
            icon: Icons.local_offer_outlined,
            label: 'Discount',
            value: controller.discountTotal,
            valueColor: const Color(0xFF16A34A),
            trailing: '-',
          ),
          summaryRow(
            icon: Icons.receipt_outlined,
            label: 'CGST',
            value: controller.cGstTotal,
            trailing: '+',
          ),
          summaryRow(
            icon: Icons.receipt_outlined,
            label: 'SGST',
            value: controller.sGstTotal,
            trailing: '+',
          ),
          summaryRow(
            icon: Icons.receipt_long_outlined,
            label: 'IGST',
            value: controller.iGstTotal,
            trailing: '+',
          ),
          summaryRow(
            icon: Icons.inventory_2_outlined,
            label: 'Total Items',
            value: controller.totalItem,
          ),
          Divider(color: SplashColors.nightSky.withOpacity(0.12), height: 20),
          summaryRow(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Net Total',
            value: '₹ ${controller.netTotal}',
            bold: true,
            highlight: true,
          ),
        ],
      ),
    );
  }

  Widget summaryRow({
    required IconData icon,
    required String label,
    required String value,
    bool bold = false,
    bool highlight = false,
    Color? valueColor,
    String? trailing,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: SplashColors.accent.withOpacity(0.14),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: SplashColors.nightSky),
          ),
          const Gap(10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: bold ? FontFamily.bold : FontFamily.medium,
                fontSize: bold ? FontSize.s16 : FontSize.s14,
                color: SplashColors.nightSky,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: bold ? FontFamily.bold : FontFamily.semiBold,
              fontSize: bold ? FontSize.s18 : FontSize.s14,
              color: valueColor ??
                  (highlight ? SplashColors.nightSky : Colors.black87),
            ),
          ),
          if (trailing != null) ...[
            const Gap(8),
            Text(
              trailing,
              style: TextStyle(
                fontFamily: FontFamily.bold,
                fontSize: FontSize.s14,
                color: valueColor ?? const Color(0xFF8A93A6),
              ),
            ),
          ],
        ],
      ),
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
    final items = controller.itemList;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SplashColors.nightSky.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Row(
              children: [
                Text(
                  'ITEMS',
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: FontSize.s14,
                    color: SplashColors.nightSky,
                    letterSpacing: 0.6,
                  ),
                ),
                const Spacer(),
                Text(
                  '${items.length} Item${items.length == 1 ? '' : 's'}',
                  style: TextStyle(
                    fontFamily: FontFamily.medium,
                    fontSize: FontSize.s12,
                    color: const Color(0xFF8A93A6),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            color: SplashColors.nightSky,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Text(
                    'Item',
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Qty',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Rate (₹)',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Amount (₹)',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                ),
                const SizedBox(width: 28),
              ],
            ),
          ),
          ...List.generate(items.length, (index) {
            final data = items[index];
            final qty = data.qty ?? 0;
            final rate = data.price ?? 0;
            final amount = data.netAmount ??
                data.netPriceINCTax ??
                (rate * qty);
            return Container(
              padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: SplashColors.nightSky.withOpacity(0.08),
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.itemName ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: FontFamily.semiBold,
                            fontSize: FontSize.s14,
                            color: SplashColors.nightSky,
                            height: 1.2,
                          ),
                        ),
                        if ((data.unit ?? '').isNotEmpty) ...[
                          const Gap(3),
                          Text(
                            data.unit!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: FontFamily.regular,
                              fontSize: 11,
                              color: const Color(0xFF78829A),
                            ),
                          ),
                        ],
                        if ((data.discountPer ?? 0) > 0) ...[
                          const Gap(2),
                          Text(
                            'Disc ${data.discountPer}%',
                            style: TextStyle(
                              fontFamily: FontFamily.medium,
                              fontSize: 10,
                              color: const Color(0xFF8A93A6),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 6,
                          ),
                          constraints: const BoxConstraints(minWidth: 36),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F5FA),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: SplashColors.nightSky.withOpacity(0.12),
                            ),
                          ),
                          child: Text(
                            _fmtQty(qty),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FontFamily.semiBold,
                              fontSize: 12,
                              color: SplashColors.nightSky,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      _fmtAmt(rate),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: FontFamily.medium,
                        fontSize: 12,
                        color: SplashColors.nightSky,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      _fmtAmt(amount),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontFamily: FontFamily.semiBold,
                        fontSize: 12,
                        color: SplashColors.nightSky,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: Color(0xFF9AA3AD),
                      size: 20,
                    ),
                    onSelected: (value) {
                      if (value == 'delete') {
                        controller.itemList.removeAt(index);
                        controller.totalItem =
                            controller.itemList.length.toString();
                        controller.update();
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _fmtQty(double qty) {
    if (qty == qty.roundToDouble()) return qty.toInt().toString();
    return qty.toStringAsFixed(2);
  }

  String _fmtAmt(double value) {
    return value.toStringAsFixed(2);
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                color: SplashColors.scaffoldBg,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SalesOrderSheetHeader(
                    title: 'Select Item',
                    subtitle: 'Search and add products to invoice',
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextField(
                      controller: controller.searchFieldController,
                      onChanged: (p0) {
                        controller.customerNameFilterItems(p0);
                      },
                      decoration: salesOrderSearchDecoration(),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              addItemSheet(filteredItems[index]);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: SplashColors.nightSky.withOpacity(0.1),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.04),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  if (item.imageUrl != null &&
                                      item.imageUrl!.isNotEmpty)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        item.imageUrl!,
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            AppImages.appIcon_g,
                                            width: 48,
                                            height: 48,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    )
                                  else
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: SplashColors.accent
                                            .withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.inventory_2_outlined,
                                        color: SplashColors.nightSky,
                                        size: 22,
                                      ),
                                    ),
                                  const Gap(12),
                                  Expanded(
                                    child: Text(
                                      item.itemName ?? '',
                                      style: TextStyle(
                                        fontFamily: FontFamily.semiBold,
                                        fontSize: FontSize.s14,
                                        color: SplashColors.nightSky,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: SplashColors.nightSky,
                                  ),
                                ],
                              ),
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
      isScrollControlled: true,
      GetBuilder<SaleInvoiceController>(
        builder: (controller) {
          return Container(
            height: Get.height * 0.85,
            decoration: const BoxDecoration(
              color: SplashColors.scaffoldBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                SalesOrderSheetHeader(
                  title: filteredItem.itemName ?? 'Add Item',
                  subtitle: 'Enter item details below',
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: controller.itemDesController,
                        title: AppString.itemDec,
                        isTitle: true,
                        maxLine: 2,
                        textInputAction: TextInputAction.next,
                      ),
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: controller.itemUnitController,
                        title: AppString.unit,
                        isTitle: true,
                        textInputAction: TextInputAction.next,
                      ),
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: controller.itemQtyController,
                        title: AppString.qty,
                        isTitle: true,
                        textInputAction: TextInputAction.next,
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
                      Material(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: salesOrderFieldBorder(controller.isOpen.value),
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
                        btnColor: SplashColors.accent,
                        textColor: SplashColors.nightSkyDeep,
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
              ],
            ),
          );
        },
      ),
    );
  }
}

class _InvoiceOutlineButton extends StatelessWidget {
  const _InvoiceOutlineButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: SplashColors.accent, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: SplashColors.nightSky),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontFamily: FontFamily.semiBold,
                  fontSize: FontSize.s14,
                  color: SplashColors.nightSky,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InvoiceSaveButton extends StatelessWidget {
  const _InvoiceSaveButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: SplashColors.accent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 52,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.save_outlined,
                size: 20,
                color: SplashColors.nightSkyDeep,
              ),
              const SizedBox(width: 8),
              Text(
                AppString.save,
                style: TextStyle(
                  fontFamily: FontFamily.semiBold,
                  fontSize: FontSize.s16,
                  color: SplashColors.nightSkyDeep,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
