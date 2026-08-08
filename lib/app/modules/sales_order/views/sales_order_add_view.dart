import 'dart:io';

import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/modules/sales_order/controllers/sales_order_controller.dart';

import '../../../data/common_widget/common_button.dart';
import 'sales_order_form_ui.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../bottom_bar/model/get_item_list.dart';
import '../../customer/model/brand_list_model.dart';
import '../../customer/model/get_catefory_brand_list_model.dart';
import '../model/sale_order_model.dart';

class SalesOrderAddView extends GetView<SalesOrderController> {
  const SalesOrderAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesOrderController>(
      builder: (controller) {
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            SalesOrderFormSection(
              title: 'Order Details',
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
                  onTap: controller.isCustomer
                      ? null
                      : () {
                    controller.selectCustomer();
                  },
                  suffix: controller.isCustomer
                      ? null
                      : RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(16),
            SalesOrderFormSection(
              title: 'Customer & Delivery',
              icon: Icons.local_shipping_outlined,
              children: [

                // CommonTextField(
                //   borderRadius: 12,
                //   controller: controller.customerController,
                //   title: AppString.customerName,
                //   isTitle: true,
                //   maxLength: 10,
                //   hintText: "Please Select...",
                //   showCursor: false,
                //   readOnly: true,
                //   onTap: () {
                //     controller.selectCustomer();
                //   },
                //   suffix: RotatedBox(
                //       quarterTurns: 1,
                //       child: Icon(
                //         Icons.arrow_forward_ios,
                //         size: 20,
                //       )),
                // ),
                Gap(5),
                CommonTextField(
                    borderRadius: 12,
                    controller: controller.addCustomerNumberController,
                    title: AppString.contactNumber,
                    isTitle: true,
                    maxLength: 12,
                    textInputType: TextInputType.number,
                    readOnly: controller.isCustomer,
                    textInputAction: TextInputAction.next,
                    // Disable if the user is a customer
                    showCursor: !controller.isCustomer,
                    // This will make it not editable if the user is a customer
                    onTap: controller.isCustomer
                        ? null // Disable onTap if the user is a customer
                        : () {
                      controller.addCustomerNumberController;
                    } // Regular behavior
                ),
                Gap(5),
                CommonTextField(
                  borderRadius: 12,
                  controller: controller.addShippingAddressController,
                  title: AppString.shippingAddress,

                  isTitle: true,
                  maxLine: 2,
                  textInputType: TextInputType.streetAddress,
                  textInputAction: TextInputAction.next,
                ),
                if (GetStorageData.readBoolean(GetStorageData.isAdmin) == true)
                  Gap(5),
                // if (GetStorageData.readBoolean(GetStorageData.isAdmin) == true)
                //   CommonTextField(
                //     borderRadius: 12,
                //     controller: controller.addDeliveryDateController,
                //     title: AppString.deliveryDate,
                //     isTitle: true,
                //     maxLength: 10,
                //     readOnly: true,
                //     showCursor: false,
                //     onTap: (){
                //       controller.selectDate(context, "delivery");
                //     },
                //     inputFormatters: [
                //       DateInputFormatter(),
                //     ],
                //     suffix: GestureDetector(
                //       onTap: () {
                //         controller.selectDate(context, "delivery");
                //       },
                //       child: Icon(Icons.calendar_month),
                //     ),
                //   ),
                // if (GetStorageData.readBoolean(GetStorageData.isAdmin) == true)
                //   Gap(5),
                // if (GetStorageData.readBoolean(GetStorageData.isAdmin) == true)
                //   CommonTextField(
                //     borderRadius: 12,
                //     controller: controller.addPoDateController,
                //     title: AppString.poDate,
                //     isTitle: true,
                //     maxLength: 10,
                //     showCursor: false,
                //     readOnly: true,
                //     onTap: (){
                //       controller.selectDate(context, "poDate");
                //     },
                //     inputFormatters: [
                //       DateInputFormatter(),
                //     ],
                //     suffix: GestureDetector(
                //       onTap: () {
                //         controller.selectDate(context, "poDate");
                //       },
                //       child: Icon(Icons.calendar_month),
                //     ),
                //   ),
                // if (GetStorageData.readBoolean(GetStorageData.isAdmin) == true)
                //   Gap(5),
                // if (GetStorageData.readBoolean(GetStorageData.isAdmin) == true)
                //   CommonTextField(
                //     borderRadius: 12,
                //     controller: controller.addPoNumberController,
                //     title: AppString.poNumber,
                //     isTitle: true,
                //     textInputType: TextInputType.number,
                //   ),
                if (GetStorageData.readBoolean(GetStorageData.isAdmin) == true)
                  Gap(5),
                if (GetStorageData.readBoolean(GetStorageData.isAdmin) == true)
                  CommonTextField(
                    borderRadius: 12,
                    controller: controller.addTransportController,
                    title: AppString.transport,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.number,
                    isTitle: true,
                  ),
                // if (GetStorageData.readBoolean(GetStorageData.isAdmin) == true)
                //   Gap(5),
                // if (GetStorageData.readBoolean(GetStorageData.isAdmin) == true)
                //   Text(
                //     AppString.status,
                //     style: TextStyle(
                //       fontFamily: FontFamily.bold,
                //       fontSize: FontSize.s18,
                //       color: Colors.black45,
                //     ),
                //   ),
                // if (GetStorageData.readBoolean(GetStorageData.isAdmin) == true)
                //   Gap(5),
                // if (GetStorageData.readBoolean(GetStorageData.isAdmin) == true)
                //   DecoratedBox(
                //     decoration: BoxDecoration(
                //       border: Border.all(color: Colors.black38),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Theme(
                //       data: ThemeData(dividerColor: Colors.transparent),
                //       child: ExpansionTile(
                //         childrenPadding: EdgeInsets.zero,
                //         dense: true,
                //         key: Key(controller.key.toString()),
                //         title: Text(
                //           controller.statusController.text,
                //         ),
                //         children: List.generate(
                //           controller.statusList.length,
                //           (index) {
                //             return GestureDetector(
                //               onTap: () {
                //                 controller.statusController.text =
                //                     controller.statusList[index];
                //                 controller.collapse();
                //                 controller.update();
                //               },
                //               child: Padding(
                //                 padding: EdgeInsets.all(8.0),
                //                 child: Text(
                //                   controller.statusList[index],
                //                 ),
                //               ),
                //             );
                //           },
                //         ),
                //       ),
                //     ),
                //   ),
                Gap(5),
                CommonTextField(
                  borderRadius: 12,
                  controller: controller.addRemarkController,
                  title: AppString.remark,
                  isTitle: true,
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                Gap(5),
                if (controller.addInvoiceTypeController.text ==
                    controller.invoiceList[1])
                  Text(
                    AppString.gstType,
                    style: TextStyle(
                      fontFamily: FontFamily.medium,
                      fontSize: FontSize.s16,
                      color: Colors.black38,
                    ),
                  ),
                if (controller.addInvoiceTypeController.text ==
                    controller.invoiceList[1])
                  Gap(5),
                if (controller.addInvoiceTypeController.text ==
                    controller.invoiceList[1])
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
            if (controller.customerId > 0) ...[
              const Gap(16),
              _OutlineActionButton(
                label: AppString.addItem,
                icon: Icons.add_rounded,
                onTap: () {
                  controller.selectedItems.clear();
                  controller.itemQuantities.clear();
                  controller.customSizeLabels.clear();
                  selectItemSheet();
                },
              ),
            ],
            const Gap(16),
            orderSummaryCard(),
            const Gap(14),
            _SaveActionButton(
              onTap: () async {
                if (GetStorageData.readBoolean(GetStorageData.isAdmin) ==
                    true) {
                  controller.isAdd.value = false;
                  await controller.persistSalesOrderCart();
                  if (controller.isUpdate) {
                    controller.updateQuotationApi();
                  } else {
                    controller.createQuotationApi();
                  }
                } else {
                  controller.isAdd.value = false;
                  await controller.persistSalesOrderCart();
                  if (controller.isUpdate) {
                    controller.updateQuotationApi();
                  } else {
                    controller.createQuotationApi();
                  }
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
                    icon: Icon(
                      Icons.more_vert_rounded,
                      color: const Color(0xFF9AA3AD),
                      size: 20,
                    ),
                    onSelected: (value) {
                      if (value == 'delete') {
                        controller.removeItem(index);
                        controller.calculateGstAndDiscountForAllItems();
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
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
            trailing: '',
          ),
          summaryRow(
            icon: Icons.receipt_outlined,
            label: 'CGST',
            value: controller.cGstTotal,
            trailing: '',
          ),
          summaryRow(
            icon: Icons.receipt_outlined,
            label: 'SGST',
            value: controller.sGstTotal,
            trailing: '',
          ),
          summaryRow(
            icon: Icons.receipt_long_outlined,
            label: 'IGST',
            value: controller.iGstTotal,
            trailing: '',
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

  selectItemSheet() {
    filteredItems = Constants.categoryWiseItemList;
    Get.bottomSheet(
      isScrollControlled: true,
      Padding(
        padding: EdgeInsets.only(top: AppBar().preferredSize.height),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            color: SplashColors.scaffoldBg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SalesOrderSheetHeader(
                title: 'Select Items',
                subtitle: 'Search and add products to order',
              ),
              Gap(10),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  controller: controller.searchFieldController,
                  onChanged: (value) {
                    controller.categoryWiseFilterItems(
                        value);
                  },
                  decoration: salesOrderSearchDecoration(),
                ),
              ),
              // Category Selection TextField
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: GestureDetector(
                  onTap: () {
                    // Open Category Selection Bottom Sheet
                    openCategorySelection(controller);
                  },
                  child: DecoratedBox(
                    decoration: salesOrderDropdownDecoration(),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Use Obx to listen for changes in selectedCategoryBrandData
                          Obx(() {
                            final selectedCategory =
                                controller.selectedCategoryBrandData.value;
                            return Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Display selected category name or the default text
                                    Text(
                                      selectedCategory.categoryName ??
                                          "Select Category",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),

                          // Show either dropdown or cancel button based on selection
                          Obx(() {
                            final hasCategory = controller
                                .selectedCategoryBrandData
                                .value
                                .categoryName !=
                                null;
                            return GestureDetector(
                              onTap: () async {
                                if (hasCategory) {
                                  await controller.clearCategorySelection();
                                }
                              },
                              child: Icon(
                                hasCategory
                                    ? Icons.cancel
                                    : Icons
                                    .arrow_drop_down, // Change icon dynamically
                                color: Colors.black54,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Brand Selection TextField
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                child: GestureDetector(
                  onTap: () {
                    // Open Category Selection Bottom Sheet
                    openBrandSelection(controller);
                  },
                  child: DecoratedBox(
                    decoration: salesOrderDropdownDecoration(),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Use Obx to listen for changes in selectedCategoryBrandData
                          Obx(() {
                            final selectedCategory =
                                controller.selectedBrandData.value;
                            return Padding(
                              padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  // Display selected category name or the default text
                                  Text(
                                    selectedCategory.brandName ??
                                        "Select Brand",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          }),
                          Obx(() {
                            final hasCategory =
                                controller.selectedBrandData.value.brandName !=
                                    null;
                            return GestureDetector(
                              onTap: () {
                                if (hasCategory) {
                                  // Reset category selection
                                  controller.selectedBrandData.value =
                                      BranddData();
                                  controller.validationForApiCall();
                                }
                              },
                              child: Icon(
                                hasCategory
                                    ? Icons.cancel
                                    : Icons
                                    .arrow_drop_down, // Change icon dynamically
                                color: Colors.black54,
                              ),
                            );
                          }),
                          // Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Obx(() {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.categoryWisefilteredItemss.length,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    itemBuilder: (context, index) {
                      final item = controller.categoryWisefilteredItemss[index];
                      final isSelected = controller.isSelected(item);

                      return Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: GestureDetector(
                          onTap: () {
                            if (!controller.isSelected(item)) {
                              controller.toggleSelection(item);
                            }

                            if (controller.isSelected(item)) {
                              // TextEditingController qtyController = TextEditingController();
                              // TextEditingController qtyController =
                              // TextEditingController(text: item.quantity?.toString() ?? "");
                              // final qtyController = TextEditingController(
                              //   text: controller.getQuantity(item),
                              // );


                              _showCustomSizeDialog(context, controller, item);
                            }

                          },
                          child: Obx(() => Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: controller.isSelected(item)
                                    ? SplashColors.accent
                                    : SplashColors.nightSky.withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(14),
                              color: controller.isSelected(item)
                                  ? SplashColors.accent.withOpacity(0.12)
                                  : Colors.white,
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
                                // Item Image
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(7, 3, 5, 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      item.imageUrl!,
                                      width: 60,
                                      height: 60,
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Padding(
                                          padding:
                                          const EdgeInsets.all(5.0),
                                          child: Image.asset(
                                            AppImages.appIcon_g,
                                            // Replace with your placeholder image path
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.fill,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                SizedBox(width: 5),

                                // Item Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.itemName ?? "",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: FontFamily.semiBold,
                                            color: Colors.black),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Price: ₹${item.price ?? "0.00"}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: FontFamily.medium,
                                                fontWeight: FontWeight.w500,
                                                color: SplashColors.nightSky),
                                          ),
                                          SizedBox(width: 2),
                                          if (controller.isSelected(item) && controller.getQuantity(item).isNotEmpty)
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: "Qty: ",
                                                      style: TextStyle(
                                                        color: Colors.black54,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:"${controller.getQuantity(item)}",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),

                                      // Text(
                                      //   "Cost: ${item.salesDiscountper ?? "0"}%",
                                      //   style: TextStyle(
                                      //       fontSize: 14,
                                      //       fontFamily: FontFamily.medium,
                                      //       color: Colors.blueGrey),
                                      // ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 1),

                                // controller.isSelected(item)
                                //     ? SizedBox(
                                //         width: 40,
                                //         height: 40,
                                //         child: TextField(
                                //           keyboardType:
                                //               TextInputType.number,
                                //           textAlign: TextAlign.center,
                                //           // Centers text inside the field
                                //           textAlignVertical:
                                //               TextAlignVertical.center,
                                //           // Centers text vertically
                                //           style: TextStyle(fontSize: 16),
                                //           // Adjust font size if needed
                                //           decoration: InputDecoration(
                                //             hintText: "Qty",
                                //             contentPadding: EdgeInsets.zero,
                                //             // Removes extra padding
                                //             border: OutlineInputBorder(
                                //               borderRadius:
                                //                   BorderRadius.circular(8),
                                //               borderSide: BorderSide(
                                //                   color: Colors.grey),
                                //             ),
                                //           ),
                                //           onChanged: (value) {
                                //             controller.updateQuantity(
                                //                 item, value);
                                //           },
                                //         ),
                                //       )
                                //     : SizedBox(),

                                // Selection Checkbox
                                Checkbox(
                                  activeColor: SplashColors.accent,
                                  value: controller.isSelected(item),
                                  onChanged: (value) {
                                    controller.toggleSelection(item);

                                    if (controller.isSelected(item)) {
                                      // TextEditingController qtyController = TextEditingController();
                                      // TextEditingController qtyController =
                                      // TextEditingController(text: item.quantity?.toString() ?? "");
                                      // final qtyController = TextEditingController(
                                      //   text: controller.getQuantity(item),
                                      // );


                                      _showCustomSizeDialog(context, controller, item);
                                    }


                                  },
                                ),
                                SizedBox(width: 1.5),
                              ],
                            ),
                          )),
                        ),
                      );
                    },
                  ),
                );
              }),

              Obx(() {
                return controller.selectedItems.isNotEmpty
                    ? Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      for (var item in controller.selectedItems) {
                        final qty = controller.itemQuantities[item] ?? 0;
                        if (qty <= 0) {
                          Get.snackbar(
                            "Error",
                            "Please add quantity for '${item.itemName}'.",
                            snackPosition: SnackPosition.BOTTOM,
                            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 70),
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return; // Stop execution, keep bottom sheet open
                        }
                        // if (controller.itemQuantities[item] == null ||
                        //     controller.itemQuantities[item]! <= 0) {
                        //   Get.snackbar(
                        //     "Error",
                        //     "Please add Quantity. Quantity is missing!",
                        //     snackPosition: SnackPosition.BOTTOM,
                        //     margin: EdgeInsets.only(
                        //         left: 10, right: 10, bottom: 70),
                        //     // Adjust to position above BottomSheet
                        //     backgroundColor: Colors.red,
                        //     colorText: Colors.white,
                        //   );
                        //   return; // Stop execution if quantity is invalid, but keep the bottom sheet open
                        // }
                      }
                      controller
                          .calculateGstAndDiscountForSelectedItems();
                      Get.back();
                      // addItemSheet(selectedWithQty);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SplashColors.accent,
                      foregroundColor: SplashColors.nightSkyDeep,
                      padding: EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Add Items",
                      style: TextStyle(
                        color: SplashColors.nightSkyDeep,
                        fontSize: 16,
                        fontFamily: FontFamily.semiBold,
                      ),
                    ),
                  ),
                )
                    : SizedBox(); // Hide button when no items selected
              })
            ],
          ),
        ),
      ),
    );
  }

  // selectItemSheet() {
  //   filteredItems = Constants.itemList;
  //   Get.bottomSheet(
  //     isScrollControlled: true,
  //     Padding(
  //       padding: EdgeInsets.only(top: AppBar().preferredSize.height),
  //       child: DecoratedBox(
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.vertical(
  //               top: Radius.circular(24),
  //             ),
  //             color: Colors.white),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Gap(10),
  //             Text(
  //               "Select Item",
  //               style: TextStyle(
  //                 fontSize: FontSize.s22,
  //                 color: Colors.black,
  //                 fontFamily: FontFamily.semiBold,
  //               ),
  //             ),
  //             Gap(10),
  //             Divider(
  //               color: Colors.black,
  //             ),
  //             Gap(10),
  //             Padding(
  //               padding: EdgeInsets.fromLTRB(20, 5, 20, 8),
  //               child: CommonTextField(
  //                 controller: controller.searchFieldController,
  //                 borderRadius: 12,
  //                 prefix: Icon(Icons.search),
  //                 onChanged: (p0) {
  //                   controller.filterItems(p0);
  //                 },
  //               ),
  //             ),
  //             Expanded(
  //               child: ListView.builder(
  //                 itemCount: filteredItems.length,
  //                 padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
  //                 itemBuilder: (context, index) {
  //                   return Padding(
  //                     padding: EdgeInsets.only(bottom: 6),
  //                     child: GestureDetector(
  //                       onTap: () {
  //                         Get.back();
  //                         addItemSheet(filteredItems[index]);
  //                       },
  //                       child: DecoratedBox(
  //                         decoration: BoxDecoration(
  //                             border: Border.all(),
  //                             borderRadius: BorderRadius.circular(12)),
  //                         child: commonTableText(
  //                             title: filteredItems[index].itemName ?? ""),
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void openCategorySelection(SalesOrderController controller) async {
    await controller.ensureFilterListsLoaded();
    controller.filteredCategoryBrands.value =
        Constants.categoryBrandList; // Initialize observable list

    Get.bottomSheet(
      isScrollControlled: true,
      Padding(
        padding: EdgeInsets.only(top: AppBar().preferredSize.height),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            color: SplashColors.scaffoldBg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SalesOrderSheetHeader(
                title: 'Select Category',
                subtitle: 'Filter products by category',
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  onChanged: (value) {
                    controller.categoryFilter(value);
                  },
                  decoration: salesOrderSearchDecoration(),
                ),
              ),
              Gap(10),
              // Obx(() {
              //   return Expanded(
              //     child: ListView.builder(
              //       itemCount: controller.filteredCategoryBrands.length,
              //       // Use observable
              //       padding: EdgeInsets.symmetric(horizontal: 20),
              //       itemBuilder: (context, index) {
              //         final category = controller.filteredCategoryBrands[index];
              //         return Padding(
              //           padding: EdgeInsets.only(bottom: 12),
              //           child: GestureDetector(
              //             onTap: () {
              //               controller.selectCategory(category);
              //               controller.validationForApiCall();
              //               Get.back();
              //             },
              //             child: DecoratedBox(
              //               decoration: BoxDecoration(
              //                 border: Border.all(color: Colors.grey),
              //                 borderRadius: BorderRadius.circular(12),
              //               ),
              //               child: Row(
              //                 children: [
              //                   Padding(
              //                     padding: const EdgeInsets.all(3.0),
              //                     child: ClipRRect(
              //                       borderRadius: BorderRadius.circular(12),
              //                       child: Image.network(
              //                         category.imageUrl!,
              //                         width: 60,
              //                         height: 60,
              //                         fit: BoxFit.fill,
              //                         errorBuilder:
              //                             (context, error, stackTrace) {
              //                           return Padding(
              //                             padding: const EdgeInsets.all(5.0),
              //                             child: Image.asset(
              //                               AppImages.appIcon_g,
              //                               width: 40,
              //                               height: 40,
              //                               fit: BoxFit.fill,
              //                             ),
              //                           );
              //                         },
              //                       ),
              //                     ),
              //                   ),
              //                   SizedBox(width: 12),
              //                   Expanded(
              //                     child: Text(
              //                       category.categoryName!,
              //                       style: TextStyle(
              //                         fontSize: 16,
              //                         color: Colors.black,
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   );
              // }),

              Obx(() {
                return Expanded(
                  child: GridView.builder(
                    itemCount: controller.filteredCategoryBrands.length,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // ✅ Two items per row
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final category = controller.filteredCategoryBrands[index];

                      return GestureDetector(
                        onTap: () async {
                          Get.back();
                          await controller.onCategorySelected(
                            Get.context!,
                            category,
                          );
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ✅ Image at top (no padding)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  category.imageUrl ?? '',
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      AppImages.appIcon_g,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),

                              // Space between image & text
                              const SizedBox(height: 6),

                              // ✅ Text below image (no padding wrapper)
                              Text(
                                category.categoryName ?? '',
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              })

            ],
          ),
        ),
      ),
    );
  }

  void openBrandSelection(SalesOrderController controller) async {
    await controller.ensureFilterListsLoaded();

    final categoryId = controller.selectedCategoryBrandData.value.categoryID;
    if (categoryId != null) {
      await controller.getBrandListByCategoryApi(Get.context!, categoryId);
    } else {
      controller.filteredBrands.value = Constants.brandList;
    }

    Get.bottomSheet(
      isScrollControlled: true,
      Padding(
        padding: EdgeInsets.only(top: AppBar().preferredSize.height),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            color: SplashColors.scaffoldBg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SalesOrderSheetHeader(
                title: 'Select Brand',
                subtitle: 'Filter products by brand',
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: TextField(
                  onChanged: (value) {
                    controller
                        .brandFilter(value); // Apply filter on text change
                  },
                  decoration: salesOrderSearchDecoration().copyWith(
                    hintText: 'Enter brand to search',
                  ),
                ),
              ),
              Gap(10),
              // Obx(() {
              //   return Expanded(
              //     child: ListView.builder(
              //       itemCount: controller.filteredBrands.length,
              //       // ✅ Use observable
              //       padding: EdgeInsets.symmetric(horizontal: 20),
              //       itemBuilder: (context, index) {
              //         final brand = controller
              //             .filteredBrands[index]; // ✅ Updated variable
              //         return Padding(
              //           padding: EdgeInsets.only(bottom: 12),
              //           child: GestureDetector(
              //             onTap: () {
              //               controller.selectBrand(brand);
              //               controller.validationForApiCall();
              //               Get.back();
              //             },
              //             child: DecoratedBox(
              //               decoration: BoxDecoration(
              //                 border: Border.all(color: Colors.grey),
              //                 borderRadius: BorderRadius.circular(12),
              //               ),
              //               child: Row(
              //                 children: [
              //                   Padding(
              //                     padding: const EdgeInsets.all(3.0),
              //                     child: ClipRRect(
              //                       borderRadius: BorderRadius.circular(12),
              //                       child: Image.network(
              //                         brand.imageUrl!,
              //                         width: 60,
              //                         height: 60,
              //                         fit: BoxFit.fill,
              //                         errorBuilder:
              //                             (context, error, stackTrace) {
              //                           return Padding(
              //                             padding: const EdgeInsets.all(5.0),
              //                             child: Image.asset(
              //                               AppImages.appIcon_g,
              //                               width: 40,
              //                               height: 40,
              //                               fit: BoxFit.fill,
              //                             ),
              //                           );
              //                         },
              //                       ),
              //                     ),
              //                   ),
              //                   SizedBox(width: 12),
              //                   Expanded(
              //                     child: Text(
              //                       brand.brandName!,
              //                       style: TextStyle(
              //                         fontSize: 16,
              //                         color: Colors.black,
              //                       ),
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ),
              //         );
              //       },
              //     ),
              //   );
              // }),

              Obx(() {
                return Expanded(
                  child: GridView.builder(
                    itemCount: controller.filteredBrands.length,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // ✅ Two items per row
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final brand = controller.filteredBrands[index];

                      return GestureDetector(
                        onTap: () {
                          controller.selectBrand(brand);
                          controller.validationForApiCall();
                          Get.back();
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // 🖼 Brand image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    brand.imageUrl ?? '',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.asset(
                                          AppImages.appIcon_g,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // 🏷 Brand name
                                Text(
                                  brand.brandName ?? '',
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              })


            ],
          ),
        ),
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
    controller.calculateGstAndDiscount();
    Get.bottomSheet(
      GetBuilder<SalesOrderController>(
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
                    fontSize: FontSize.s20,
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
                      if (controller.addGstTypeController.text.isNotEmpty)
                        Gap(10),
                      if (controller.addGstTypeController.text.isNotEmpty)
                        Text(
                          AppString.gstTax,
                          style: TextStyle(
                            fontFamily: FontFamily.medium,
                            fontSize: FontSize.s16,
                            color: Colors.black38,
                          ),
                        ),
                      if (controller.addGstTypeController.text.isNotEmpty)
                        Gap(8),
                      if (controller.addGstTypeController.text.isNotEmpty)
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
                                          Constants.gstList[index].gstTaxName ??
                                              "";
                                      controller.gstId =
                                          Constants.gstList[index].gstCodeId ??
                                              0;
                                      controller.calculateGstAndDiscount();
                                      controller.collapse();
                                      controller.isOpen.value = false;
                                      controller.update();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        controller.gstList[index],
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
                      if (controller.addGstTypeController.text.isNotEmpty)
                        if (controller.addGstTypeController.text != 'IGST')
                          Gap(10),
                      if (controller.addGstTypeController.text.isNotEmpty)
                        if (controller.addGstTypeController.text != 'IGST')
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
                      if (controller.addGstTypeController.text.isNotEmpty)
                        if (controller.addGstTypeController.text != 'IGST')
                          Gap(10),
                      if (controller.addGstTypeController.text.isNotEmpty)
                        if (controller.addGstTypeController.text != 'IGST')
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
                      if (controller.addGstTypeController.text.isNotEmpty)
                        if (controller.addGstTypeController.text == 'IGST')
                          Gap(10),
                      if (controller.addGstTypeController.text.isNotEmpty)
                        if (controller.addGstTypeController.text == 'IGST')
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
                          controller.itemList.add(SaleOrderDetails(
                            itemId: filteredItem.itemid,
                            itemName: filteredItem.itemName,
                            unit: controller.itemUnitController.text,
                            qty:
                            double.parse(controller.itemQtyController.text),
                            price: double.parse(
                                controller.itemPriceController.text),
                            discountPer: double.parse(
                                controller.itemDiscountPerController.text),
                            discount: double.parse(
                                controller.itemDiscountController.text),
                            totalDiscount: double.parse(
                                controller.itemTotalDiscountController.text),
                            gstcodeId: controller.gstId,
                            netPriceINCTax: double.parse(
                                controller.itemNetPriceController.text),
                            cgstPer: double.parse(
                                controller.itemCGstPerController.text),
                            cgstAmount: double.parse(
                                controller.itemCGstAmtController.text),
                            sgstPer: double.parse(
                                controller.itemSGstPerController.text),
                            sgstAmount: double.parse(
                                controller.itemSGstAmtController.text),
                            igstPer: double.parse(
                                controller.itemIGstPerController.text),
                            igstAmount: double.parse(
                                controller.itemIGstAmtController.text),
                            taxableAmount: double.parse(
                                controller.itemTaxablePriceController.text),
                            netAmount: double.parse(
                                controller.itemNetAmountController.text),
                            grossAmount: double.parse(
                                controller.itemGrossAmountController.text),
                          ));
                          controller.calculateGstAndDiscountForAllItems();
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

void _showAddQuantityDialog(
    BuildContext context,
    SalesOrderController controller,
    ItemData item,
    ) {
  showDialog(
    context: context,
    builder: (context) {
      final existingQty = controller.itemQuantities.containsKey(item)
          ? controller.itemQuantities[item].toString()
          : "";

      final qtyController = TextEditingController(text: existingQty);
      return AddQuantityDialog(
        itemName: item.itemName ?? "",
        imageUrl: item.imageUrl ?? "",
        rate: (item.price ?? "").toString(),
        qtyController: qtyController,
        onConfirm: () {
          final qty = qtyController.text.trim();
          debugPrint("Updating quantity for item: ${item.itemName}, Qty: $qty");
          controller.updateQuantity(item, qty);

          if (qty.isEmpty || int.tryParse(qty) == null || int.parse(qty) <= 0) {
            Get.snackbar(
              "Error",
              "Please enter a valid quantity!",
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 70),
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }

          Navigator.pop(context);
        },
      );
    },
  );
}

void _showCustomSizeDialog(
  BuildContext context,
  SalesOrderController controller,
  ItemData item,
) {
  final lengthController = TextEditingController();
  final widthController = TextEditingController();
  final pieceController = TextEditingController(
    text: controller.itemQuantities.containsKey(item)
        ? controller.itemQuantities[item].toString()
        : '',
  );
  final remarksController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return CustomSizeDialog(
        itemName: item.itemName ?? '',
        imageUrl: item.imageUrl ?? '',
        lengthController: lengthController,
        widthController: widthController,
        pieceController: pieceController,
        remarksController: remarksController,
        onCancel: () => Navigator.pop(context),
        onSave: () {
          final lengthText = lengthController.text.trim();
          final widthText = widthController.text.trim();
          final pieceText = pieceController.text.trim();
          final remarks = remarksController.text.trim();

          final length = double.tryParse(lengthText);
          final width = double.tryParse(widthText);
          final piece = int.tryParse(pieceText);

          if (length == null || length <= 0) {
            Get.snackbar(
              "Error",
              "Please enter a valid Length!",
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 70),
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }

          if (width == null || width <= 0) {
            Get.snackbar(
              "Error",
              "Please enter a valid Width!",
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 70),
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }

          if (piece == null || piece <= 0) {
            Get.snackbar(
              "Error",
              "Please enter a valid Piece!",
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 70),
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            return;
          }

          final sqFt = length * width;
          final sqFtLabel =
              sqFt % 1 == 0 ? sqFt.toInt().toString() : sqFt.toStringAsFixed(2);
          final sizeLabel =
              '${length % 1 == 0 ? length.toInt() : length}x${width % 1 == 0 ? width.toInt() : width}';

          if (remarks.isNotEmpty) {
            if (controller.addRemarkController.text.trim().isEmpty) {
              controller.addRemarkController.text = remarks;
            } else {
              controller.addRemarkController.text =
                  '${controller.addRemarkController.text.trim()}\n$remarks';
            }
          }

          controller.updateQuantity(item, piece.toString());
          controller.customSizeLabels[item] =
              '($sizeLabel, $sqFtLabel Sq.ft)';
          controller.update();
          Navigator.pop(context);
        },
      );
    },
  );
}
class _OutlineActionButton extends StatelessWidget {
  const _OutlineActionButton({
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
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: FontFamily.semiBold,
                    fontSize: FontSize.s14,
                    color: SplashColors.nightSky,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaveActionButton extends StatelessWidget {
  const _SaveActionButton({required this.onTap});

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
