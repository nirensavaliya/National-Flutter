import 'dart:io';

import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/modules/customer/controllers/add_sales_order_customer_controller.dart';
import 'package:gurukrupa/app/modules/customer/model/brand_list_model.dart';
import 'package:gap/gap.dart';

import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../bottom_bar/model/get_item_list.dart';
import '../../sales_order/model/sale_order_model.dart';
import '../../sales_order/views/sales_order_form_ui.dart';

class AddSalesOrderCustomerView
    extends GetView<AddSalesOrderCustomerController> {
  const AddSalesOrderCustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddSalesOrderCustomerController>(
      builder: (controller) {
        return CommonScreen(
          title: "Sale Order",
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
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
                    readOnly: true,
                    showCursor: false,
                    inputFormatters: [
                      DateInputFormatter(),
                    ],
                    suffix: GestureDetector(
                      onTap: () {
                        // controller.selectDate(context, "add");
                      },
                      child: const Icon(
                        Icons.calendar_month_outlined,
                        color: SplashColors.primaryDark,
                      ),
                    ),
                  ),
                ],
              ),
              // Gap(12),
              Visibility(
                visible: false,
                child: Row(
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
              ),

              // Gap(12),
              // Text(
              //   AppString.invoiceType,
              //   style: TextStyle(
              //     fontFamily: FontFamily.medium,
              //     fontSize: FontSize.s16,
              //     color: Colors.black38,
              //   ),
              // ),
              // Gap(8),
              // DecoratedBox(
              //   decoration: BoxDecoration(
              //     border: Border.all(
              //         color: controller.isOpen.value
              //             ? Colors.blue
              //             : Colors.black38),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Theme(
              //     data: ThemeData(dividerColor: Colors.transparent),
              //     child: ExpansionTile(
              //       childrenPadding: EdgeInsets.zero,
              //       dense: true,
              //       key: Key(controller.key.toString()),
              //       onExpansionChanged: (value) {
              //         print("value -- $value");
              //         controller.isOpen.value = value;
              //         controller.update();
              //       },
              //       title: Text(
              //         controller.addInvoiceTypeController.text,
              //       ),
              //       children: List.generate(
              //         controller.invoiceList.length,
              //         (index) {
              //           return GestureDetector(
              //             onTap: () {
              //               controller.addInvoiceTypeController.text =
              //                   controller.invoiceList[index];
              //               controller.nextSerialNoApi();
              //               controller.collapse();
              //               controller.isOpen.value = false;
              //               controller.update();
              //             },
              //             child: Padding(
              //               padding: EdgeInsets.all(8.0),
              //               child: Text(
              //                 controller.invoiceList[index],
              //               ),
              //             ),
              //           );
              //         },
              //       ),
              //     ),
              //   ),
              // ),
              // Gap(12),
              // CommonTextField(
              //   borderRadius: 12,
              //   controller: controller.customerController,
              //   title: AppString.customerName,
              //   isTitle: true,
              //   maxLength: 10,
              //   hintText: "Please Select...",
              //   showCursor: !controller.isCustomer,
              //   // Hide cursor if the user is a customer
              //   readOnly: controller.isCustomer,
              //   // Make the field read-only if the user is a customer
              //   onTap: controller.isCustomer
              //       ? null // Disable onTap if the user is a customer
              //       : () {
              //           controller.selectCustomer(); // Regular behavior
              //         },
              //   suffix: controller.isCustomer
              //       ? null // Hide the suffix icon if the user is a customer
              //       : RotatedBox(
              //           quarterTurns: 1,
              //           child: Icon(
              //             Icons.arrow_forward_ios,
              //             size: 20,
              //           ),
              //         ),
              // ),

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
              // Gap(12),
              // CommonTextField(
              //     borderRadius: 12,
              //     controller: controller.addCustomerNumberController,
              //     title: AppString.contactNumber,
              //     isTitle: true,
              //     maxLength: 12,
              //     textInputType: TextInputType.number,
              //     readOnly: controller.isCustomer,
              //     // Disable if the user is a customer
              //     showCursor: !controller.isCustomer,
              //     // This will make it not editable if the user is a customer
              //     onTap: controller.isCustomer
              //         ? null // Disable onTap if the user is a customer
              //         : () {
              //             controller.addCustomerNumberController;
              //           } // Regular behavior
              //     ),
              // Gap(12),
              // Text(
              //   AppString.status,
              //   style: TextStyle(
              //     fontFamily: FontFamily.medium,
              //     fontSize: FontSize.s16,
              //     color: Colors.black38,
              //   ),
              // ),
              // Gap(8),
              // DecoratedBox(
              //   decoration: BoxDecoration(
              //     border: Border.all(color: Colors.black38),
              //     borderRadius: BorderRadius.circular(12),
              //   ),
              //   child: Theme(
              //     data: ThemeData(dividerColor: Colors.transparent),
              //     child: ExpansionTile(
              //       childrenPadding: EdgeInsets.zero,
              //       dense: true,
              //       key: Key(controller.key.toString()),
              //       title: Text(
              //         controller.statusController.text,
              //       ),
              //       children: List.generate(
              //         controller.statusList.length,
              //         (index) {
              //           return GestureDetector(
              //             onTap: () {
              //               controller.statusController.text =
              //                   controller.statusList[index];
              //               controller.collapse();
              //               controller.update();
              //             },
              //             child: Padding(
              //               padding: EdgeInsets.all(8.0),
              //               child: Text(
              //                 controller.statusList[index],
              //               ),
              //             ),
              //           );
              //         },
              //       ),
              //     ),
              //   ),
              // ),

              const Gap(16),
              _PrimaryActionButton(
                label: AppString.addItem,
                icon: Icons.add_box_outlined,
                onTap: () {
                  controller.selectedItems.clear();
                  controller.itemQuantities.clear();
                  selectItemSheet();
                },
              ),
              if (controller.itemList.isNotEmpty) ...[
                const Gap(16),
                itemData(),
              ],
              const Gap(16),
              SalesOrderFormSection(
                title: 'Additional Details',
                icon: Icons.edit_note_rounded,
                children: [
                  CommonTextField(
                    borderRadius: 12,
                    controller: controller.addShippingAddressController,
                    title: AppString.shippingAddress,
                    isTitle: true,
                    maxLine: 2,
                    textInputType: TextInputType.streetAddress,
                  ),
              // Gap(12),
              // CommonTextField(
              //   borderRadius: 12,
              //   controller: controller.addDeliveryDateController,
              //   title: AppString.deliveryDate,
              //   isTitle: true,
              //   maxLength: 10,
              //   inputFormatters: [
              //     DateInputFormatter(),
              //   ],
              //   suffix: GestureDetector(
              //     onTap: () {
              //       controller.selectDate(context, "delivery");
              //     },
              //     child: Icon(Icons.calendar_month),
              //   ),
              // ),
              // Gap(12),
              // CommonTextField(
              //   borderRadius: 12,
              //   controller: controller.addPoDateController,
              //   title: AppString.poDate,
              //   isTitle: true,
              //   maxLength: 10,
              //   inputFormatters: [
              //     DateInputFormatter(),
              //   ],
              //   suffix: GestureDetector(
              //     onTap: () {
              //       controller.selectDate(context, "poDate");
              //     },
              //     child: Icon(Icons.calendar_month),
              //   ),
              // ),
              // Gap(12),
              // CommonTextField(
              //   borderRadius: 12,
              //   controller: controller.addPoNumberController,
              //   title: AppString.poNumber,
              //   isTitle: true,
              //   textInputType: TextInputType.number,
              // ),
              // Gap(12),
              // CommonTextField(
              //   borderRadius: 12,
              //   controller: controller.addTransportController,
              //   title: AppString.transport,
              //   isTitle: true,
              // ),
                  const Gap(12),
                  CommonTextField(
                    borderRadius: 12,
                    controller: controller.addRemarkController,
                    title: AppString.remark,
                    isTitle: true,
                  ),

                  const Gap(12),
                  if (controller.addInvoiceTypeController.text ==
                      controller.invoiceList[1]) ...[
                    Text(
                      AppString.gstType,
                      style: TextStyle(
                        fontFamily: FontFamily.medium,
                        fontSize: FontSize.s16,
                        color: Colors.black38,
                      ),
                    ),
                    const Gap(8),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: controller.isOpen.value
                              ? SplashColors.primary
                              : SplashColors.primary.withOpacity(0.25),
                        ),
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
                                  padding: const EdgeInsets.all(12),
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
                  ],
                ],
              ),
              // if (controller.invoiceController.text ==
              //     controller.invoiceList[1])
              //   Gap(12),

              // Gap(10),
              // Table(
              //   border: TableBorder.all(),
              //   children: [
              //     TableRow(
              //       children: [
              //         commonTableText(title: "Total"),
              //         commonTableText(title: controller.total, isEnd: true),
              //       ],
              //     ),
              //     // TableRow(
              //     //   children: [
              //     //     commonTableText(title: "(-)DiscountTotal"),
              //     //     commonTableText(
              //     //         title: controller.discountTotal,
              //     //         isLight: true,
              //     //         isEnd: true),
              //     //   ],
              //     // ),
              //     // TableRow(
              //     //   children: [
              //     //     commonTableText(title: "(+)CGSTTotal"),
              //     //     commonTableText(
              //     //         title: controller.cGstTotal,
              //     //         isLight: true,
              //     //         isEnd: true),
              //     //   ],
              //     // ),
              //     // TableRow(
              //     //   children: [
              //     //     commonTableText(title: "(+)SGSTTotal"),
              //     //     commonTableText(
              //     //         title: controller.sGstTotal,
              //     //         isLight: true,
              //     //         isEnd: true),
              //     //   ],
              //     // ),
              //     // TableRow(
              //     //   children: [
              //     //     commonTableText(title: "(+)IGSTTotal"),
              //     //     commonTableText(
              //     //         title: controller.iGstTotal,
              //     //         isLight: true,
              //     //         isEnd: true),
              //     //   ],
              //     // ),
              //     // TableRow(
              //     //   children: [
              //     //     commonTableText(title: "TotalItem"),
              //     //     commonTableText(
              //     //         title: controller.totalItem,
              //     //         isLight: true,
              //     //         isEnd: true),
              //     //   ],
              //     // ),
              //     // TableRow(
              //     //   children: [
              //     //     commonTableText(title: "NetTotal"),
              //     //     commonTableText(
              //     //         title: controller.netTotal,
              //     //         isLight: true,
              //     //         isEnd: true),
              //     //   ],
              //     // ),
              //   ],
              // ),
              // Gap(15),
              const Gap(16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CheckboxListTile(
                  title: Text(
                    "Order Later",
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: FontSize.s16,
                      color: SplashColors.primaryDark,
                    ),
                  ),
                  activeColor: SplashColors.primary,
                  value: controller.isOrderLaterChecked.value,
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.trailing,
                  onChanged: (value) {
                    controller.isOrderLaterChecked.value = value ?? false;
                    controller.update();
                  },
                ),
              ),

              // Obx(() => CheckboxListTile(
              //   title: Text("Order Later"),
              //   value: controller.isOrderLaterChecked.value,
              //   onChanged: (value) {
              //     controller.isOrderLaterChecked.value = value ?? false;
              //   },
              // )),

              const Gap(16),
              _PrimaryActionButton(
                label: AppString.save,
                icon: Icons.check_circle_outline_rounded,
                onTap: () {
                  // if (controller.deliveryDate.isEmpty) {
                  //   Utils().showSnackBar(
                  //       message: "Please enter Delivery Date",
                  //       context: context);
                  // } else if (controller.poDate.isEmpty) {
                  //   Utils().showSnackBar(
                  //       message: "Please enter PODate", context: context);
                  // } else {
                  //   controller.isAdd.value = false;
                  //   if (controller.isUpdate) {
                  //     controller.updateQuotationApi();
                  //   } else {
                  if(controller.isEdit == true){
                    controller.updateQuotationApi();
                  }else {
                    controller.createQuotationApi();
                  }
                  // }
                  // }
                  controller.isUpdate = false;
                  controller.update();
                },
              ),
              Gap(Platform.isIOS ? 25 : 20),
            ],
          ),
        );
      },
    );
  }

  Widget itemData() {
    return SalesOrderFormSection(
      title: 'Selected Items',
      icon: Icons.inventory_2_outlined,
      children: [
        ...List.generate(
          controller.itemList.length,
          (index) {
            final data = controller.itemList[index];
            return Container(
              margin: EdgeInsets.only(
                bottom: index == controller.itemList.length - 1 ? 0 : 12,
              ),
              decoration: BoxDecoration(
                color: SplashColors.scaffoldBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: SplashColors.primary.withOpacity(0.12),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 10, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.itemName ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: FontFamily.semiBold,
                                  fontSize: FontSize.s14,
                                  color: SplashColors.primaryDark,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                'Unit: ${data.unit ?? "-"}',
                                style: TextStyle(
                                  fontFamily: FontFamily.medium,
                                  fontSize: FontSize.s12,
                                  color: const Color(0xFF78829A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.removeItem(index);
                            controller.calculateGstAndDiscountForAllItems();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEF4444).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.delete_outline,
                              color: Color(0xFFEF4444),
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SalesOrderDetailRow(
                    label: 'Quantity',
                    value: data.qty.toString(),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _PrimaryActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              SplashColors.primaryDeep,
              SplashColors.primary,
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: SplashColors.primary.withOpacity(0.25),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const Gap(8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSize.s16,
                fontFamily: FontFamily.semiBold,
              ),
            ),
          ],
        ),
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
                    controller.categoryWiseFilterItems(value);
                  },
                  decoration: salesOrderSearchDecoration(),
                ),
              ),

              Obx(() {
                // bool hasSelectedItemsWithQty =
                //     controller.selectedItems.isNotEmpty &&
                //     controller.selectedItems.any((item) =>
                //     controller.itemQuantities[item] != null &&
                //         controller.itemQuantities[item]! > 0);

                // bool hasSelectedItemsWithQty =
                // controller.selectedItems.any(
                //       (item) => controller.itemQuantities[item] != null &&
                //       controller.itemQuantities[item]! > 0,
                // );

                List<ItemData> selectedItemsWithQty = controller.selectedItems
                    .where((item) =>
                controller.itemQuantities.containsKey(item) &&
                    controller.itemQuantities[item]! > 0)
                    .toList();

                bool hasSelectedItemsWithQty = controller.selectedItems.isNotEmpty;

                return
                //   hasSelectedItemsWithQty
                //     ? Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                //   child: SizedBox(
                //     height: 120, // Adjust as needed
                //     child: ListView(
                //       scrollDirection: Axis.horizontal,
                //       children: controller.selectedItems.map((item) {
                //         return Padding(
                //           padding: EdgeInsets.only(right: 8),
                //           child: ClipRRect(
                //             borderRadius: BorderRadius.circular(12),
                //             child: SizedBox(),
                //             // child: Image.network(
                //             //   item.imageUrl!,
                //             //   width: 120,
                //             //   height: 120,
                //             //   fit: BoxFit.fill,
                //             //   errorBuilder: (context, error, stackTrace) {
                //             //     return Padding(
                //             //       padding: const EdgeInsets.all(5.0),
                //             //       child: Image.asset(
                //             //         AppImages.appIcon_g, // Placeholder Image
                //             //         width: 110,
                //             //         height: 110,
                //             //         fit: BoxFit.fill,
                //             //       ),
                //             //     );
                //             //   },
                //             // ),
                //           ),
                //         );
                //       }).toList(),
                //     ),
                //   ),
                // )
                //     :
                Column(
                  children: [
                    // Category Selection
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: GestureDetector(
                        onTap: () {
                          openCategorySelection(controller);
                        },
                        child: DecoratedBox(
                          decoration: salesOrderDropdownDecoration(),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() {
                                  final selectedCategory =
                                      controller.selectedCategoryBrandData.value;
                                  return Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                                      child: Text(
                                        selectedCategory.categoryName ??
                                            "Select Category",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  );
                                }),
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
                                      hasCategory ? Icons.cancel : Icons.arrow_drop_down,
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

                    // Brand Selection
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                      child: GestureDetector(
                        onTap: () {
                          openBrandSelection(controller);
                        },
                        child: DecoratedBox(
                          decoration: salesOrderDropdownDecoration(),
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() {
                                  final selectedBrand = controller.selectedBrandData.value;
                                  return Padding(
                                    padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                                    child: Text(
                                      selectedBrand.brandName ?? "Select Brand",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }),
                                Obx(() {
                                  final hasBrand =
                                      controller.selectedBrandData.value.brandName !=
                                          null;
                                  return GestureDetector(
                                    onTap: () {
                                      if (hasBrand) {
                                        controller.selectedBrandData.value = BranddData();
                                        controller.validationForApiCall();
                                      }
                                    },
                                    child: Icon(
                                      hasBrand ? Icons.cancel : Icons.arrow_drop_down,
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
                  ],
                );
              }),



              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              //   child: GestureDetector(
              //     onTap: () {
              //       // Open Category Selection Bottom Sheet
              //       openCategorySelection(controller);
              //     },
              //     child: DecoratedBox(
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Colors.grey),
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       child: Padding(
              //         padding: EdgeInsets.all(5),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             // Use Obx to listen for changes in selectedCategoryBrandData
              //             Obx(() {
              //               final selectedCategory =
              //                   controller.selectedCategoryBrandData.value;
              //               return Expanded(
              //                 child: Padding(
              //                   padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
              //                   child: Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       // Display selected category name or the default text
              //                       Text(
              //                         selectedCategory.categoryName ??
              //                             "Select Category",
              //                         style: TextStyle(color: Colors.black),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               );
              //             }),
              //
              //             // Show either dropdown or cancel button based on selection
              //             Obx(() {
              //               final hasCategory = controller
              //                       .selectedCategoryBrandData
              //                       .value
              //                       .categoryName !=
              //                   null;
              //               return GestureDetector(
              //                 onTap: () {
              //                   if (hasCategory) {
              //                     // Reset category selection
              //                     controller.selectedCategoryBrandData.value =
              //                         CategoryBrandData();
              //                     controller.validationForApiCall();
              //                   }
              //                 },
              //                 child: Icon(
              //                   hasCategory
              //                       ? Icons.cancel
              //                       : Icons
              //                           .arrow_drop_down, // Change icon dynamically
              //                   color: Colors.black54,
              //                 ),
              //               );
              //             }),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // // Brand Selection TextField
              // Padding(
              //   padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              //   child: GestureDetector(
              //     onTap: () {
              //       // Open Category Selection Bottom Sheet
              //       openBrandSelection(controller);
              //     },
              //     child: DecoratedBox(
              //       decoration: BoxDecoration(
              //         border: Border.all(color: Colors.grey),
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       child: Padding(
              //         padding: EdgeInsets.all(5),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             // Use Obx to listen for changes in selectedCategoryBrandData
              //             Obx(() {
              //               final selectedCategory =
              //                   controller.selectedBrandData.value;
              //               return Padding(
              //                 padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
              //                 child: Row(
              //                   mainAxisAlignment:
              //                       MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     // Display selected category name or the default text
              //                     Text(
              //                       selectedCategory.brandName ??
              //                           "Select Brand",
              //                       style: TextStyle(color: Colors.black),
              //                     ),
              //                   ],
              //                 ),
              //               );
              //             }),
              //             Obx(() {
              //               final hasCategory =
              //                   controller.selectedBrandData.value.brandName !=
              //                       null;
              //               return GestureDetector(
              //                 onTap: () {
              //                   if (hasCategory) {
              //                     // Reset category selection
              //                     controller.selectedBrandData.value =
              //                         BranddData();
              //                     controller.validationForApiCall();
              //                   }
              //                 },
              //                 child: Icon(
              //                   hasCategory
              //                       ? Icons.cancel
              //                       : Icons
              //                           .arrow_drop_down, // Change icon dynamically
              //                   color: Colors.black54,
              //                 ),
              //               );
              //             }),
              //             // Icon(Icons.arrow_drop_down),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              SizedBox(height: 6),

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
                              _showAddQuantityDialog(context, controller, item);
                            }
                          },
                          child: Obx(() => Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: controller.isSelected(item)
                                        ? SplashColors.primary
                                        : SplashColors.primary.withOpacity(0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                  color: controller.isSelected(item)
                                      ? SplashColors.primary.withOpacity(0.08)
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
                                          // Text(
                                          //   "Price: ₹${item.price ?? "0.00"}",
                                          //   style: TextStyle(
                                          //       fontSize: 14,
                                          //       fontFamily: FontFamily.medium,
                                          //       fontWeight: FontWeight.w500,
                                          //       color: Colors.green),
                                          // ),
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
                                      activeColor: SplashColors.primary,
                                      value: controller.isSelected(item),
                                      onChanged: (value) {
                                        controller.toggleSelection(item);
                                        if (controller.isSelected(item)) {
                                          _showAddQuantityDialog(
                                            context,
                                            controller,
                                            item,
                                          );
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
                              if (controller.itemQuantities[item] == null ||
                                  controller.itemQuantities[item]! <= 0) {
                                Get.snackbar(
                                  "Error",
                                  "Please add Quantity. Quantity is missing!",
                                  snackPosition: SnackPosition.BOTTOM,
                                  margin: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 70),
                                  // Adjust to position above BottomSheet
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                                return; // Stop execution if quantity is invalid, but keep the bottom sheet open
                              }
                            }
                            controller
                                .calculateGstAndDiscountForSelectedItems();
                            Get.back();
                            // addItemSheet(selectedWithQty);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SplashColors.primary,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            "Add Items",
                            style: TextStyle(
                              color: Colors.white,
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

  void openCategorySelection(AddSalesOrderCustomerController controller) async {
    await controller.ensureFilterListsLoaded();
    controller.filteredCategoryBrands.value =
        Constants.categoryBrandList;

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

              // ✅ Use Obx to watch filteredCategoryBrands
              // Obx(() {
              //   return Expanded(
              //     child: ListView.builder(
              //       itemCount: controller.filteredCategoryBrands.length,
              //       // ✅ Correct observable usage
              //       padding: EdgeInsets.symmetric(horizontal: 20),
              //       itemBuilder: (context, index) {
              //         final category = controller.filteredCategoryBrands[
              //             index]; // ✅ Use observable list
              //
              //         return GestureDetector(
              //           onTap: () {
              //             controller.selectCategory(category);
              //             controller.validationForApiCall();
              //             Get.back();
              //           },
              //           child: Container(
              //             margin: EdgeInsets.only(bottom: 12),
              //             decoration: BoxDecoration(
              //               border: Border.all(color: Colors.grey),
              //               borderRadius: BorderRadius.circular(12),
              //             ),
              //             child: Row(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.all(3.0),
              //                   child: ClipRRect(
              //                     borderRadius: BorderRadius.circular(12),
              //                     child: Image.network(
              //                       category.imageUrl!,
              //                       width: 60,
              //                       height: 60,
              //                       fit: BoxFit.fill,
              //                       errorBuilder: (context, error, stackTrace) {
              //                         return Image.asset(
              //                           AppImages.appIcon_g,
              //                           width: 40,
              //                           height: 40,
              //                         );
              //                       },
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(width: 12),
              //                 Expanded(
              //                   child: Text(
              //                     category.categoryName!,
              //                     style: TextStyle(
              //                         fontSize: 16, color: Colors.black),
              //                   ),
              //                 ),
              //               ],
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
                              // ✅ Image at top
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
                              const SizedBox(height: 8),

                              // ✅ Name below image
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
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

  void openBrandSelection(AddSalesOrderCustomerController controller) async {
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
                    controller.brandFilter(value);
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
              //       // ✅ Correct observable usage
              //       padding: EdgeInsets.symmetric(horizontal: 20),
              //       itemBuilder: (context, index) {
              //         final brand = controller
              //             .filteredBrands[index]; // ✅ Use observable list
              //
              //         return GestureDetector(
              //           onTap: () {
              //             controller.selectBrand(brand);
              //             controller.validationForApiCall();
              //             Get.back();
              //           },
              //           child: Container(
              //             margin: EdgeInsets.only(bottom: 12),
              //             decoration: BoxDecoration(
              //               border: Border.all(color: Colors.grey),
              //               borderRadius: BorderRadius.circular(12),
              //             ),
              //             child: Row(
              //               children: [
              //                 Padding(
              //                   padding: const EdgeInsets.all(3.0),
              //                   child: ClipRRect(
              //                     borderRadius: BorderRadius.circular(12),
              //                     child: Image.network(
              //                       brand.imageUrl!,
              //                       width: 60,
              //                       height: 60,
              //                       fit: BoxFit.fill,
              //                       errorBuilder: (context, error, stackTrace) {
              //                         return Image.asset(
              //                           AppImages.appIcon_g,
              //                           width: 40,
              //                           height: 40,
              //                           fit: BoxFit.fill,
              //                         );
              //                       },
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(width: 12),
              //                 Expanded(
              //                   child: Text(
              //                     brand.brandName!,
              //                     style: TextStyle(
              //                         fontSize: 16, color: Colors.black),
              //                   ),
              //                 ),
              //               ],
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

  showItemList() {
    Get.bottomSheet(
      isScrollControlled: true,
      Padding(
        padding: EdgeInsets.only(top: AppBar().preferredSize.height),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            color: Colors.white,
          ),
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
              Divider(color: Colors.black),
              Gap(10),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 8),
                child: CommonTextField(
                  controller: controller.searchFieldController,
                  borderRadius: 12,
                  prefix: Icon(Icons.search),
                  onChanged: (value) {
                    controller.filterItems(value);
                  },
                ),
              ),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: controller.filteredItems.length,
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                            addItemSheet(
                                controller.filteredItems[index] as ItemData);
                          },
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: commonTableText(
                              title: controller.filteredItems[index] ?? "",
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addItemSheet(ItemData filteredItem) {
    filteredItem.toJson().forEach((key, value) {
      print('----------> $key: $value');
    });
    // print('addItemSheet:: ---- -----> ${filteredItem}');

    controller.itemUnitController.text = filteredItem.unitCode ?? "";
    controller.itemQtyController.text = "1";
    controller.itemDiscountPerController.text = "0";
    controller.itemDiscountController.text = "0";
    controller.itemTotalDiscountController.text = "0";
    controller.itemPriceController.text = filteredItem.price.toString();
    controller.itemGrossAmountController.text = filteredItem.price.toString();
    // for (int i = 0; i < Constants.gstList.length; i++) {
    //   if (Constants.gstList[i].gstCodeId == filteredItem.gstCodeId) {
    //     controller.addGstController.text =
    //         Constants.gstList[i].gstTaxName ?? "";
    //     controller.gstId = Constants.gstList[i].gstCodeId ?? 0;
    //   }
    // }
    controller.calculateGstAndDiscount();

    Get.bottomSheet(
      GetBuilder<AddSalesOrderCustomerController>(
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 0),
                  child: Text(
                    filteredItem.itemName ?? "",
                    style: TextStyle(
                      fontSize: FontSize.s18,
                      color: Colors.black,
                      fontFamily: FontFamily.medium,
                    ),
                  ),
                ),
                Gap(5),
                Divider(
                  color: Colors.black,
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Gap(7),
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
  AddSalesOrderCustomerController controller,
  ItemData item,
) {
  showDialog(
    context: context,
    builder: (context) {
      final existingQty = controller.itemQuantities.containsKey(item)
          ? controller.itemQuantities[item].toString()
          : '';

      final qtyController = TextEditingController(text: existingQty);
      return AddQuantityDialog(
        itemName: item.itemName ?? '',
        imageUrl: item.imageUrl ?? '',
        rate: (item.price ?? '').toString(),
        qtyController: qtyController,
        onConfirm: () {
          final qty = qtyController.text.trim();
          debugPrint('Updating quantity for item: ${item.itemName}, Qty: $qty');
          controller.updateQuantity(item, qty);

          if (qty.isEmpty || int.tryParse(qty) == null || int.parse(qty) <= 0) {
            Get.snackbar(
              'Error',
              'Please enter a valid quantity!',
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
