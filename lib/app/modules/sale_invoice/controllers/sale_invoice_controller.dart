import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../api_common/api_function.dart';
import '../../../api_common/loading.dart';
import '../../../commons/all.dart';
import '../../../commons/api_query_helper.dart';
import '../../../commons/get_storage_data.dart';
import '../../bottom_bar/model/get_item_list.dart';
import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../../routes/app_pages.dart';
import '../../item_list/controllers/item_list_controller.dart';
import '../../quotation/model/new_serial_model.dart';
import '../../quotation/model/quotation_model.dart';
import '../../quotation/model/quotation_pdf_model.dart';
import '../../quotation/model/save_quotation_model.dart';
import '../model/sales_invoice_detail_model.dart';
import '../model/sales_invoice_model.dart';
import '../model/sales_person_list_model.dart';

class SaleInvoiceController extends GetxController {
  RxBool isAdd = false.obs;
  TextEditingController addDateController = TextEditingController();
  TextEditingController addInvoiceTypeController = TextEditingController(text: "Bill of Supply");
  TextEditingController addCustomerNameController = TextEditingController();
  TextEditingController addCustomerNumberController = TextEditingController();
  TextEditingController addShippingAddressController = TextEditingController();
  TextEditingController addCreditDaysController = TextEditingController(text: "0");
  TextEditingController addGSTinController = TextEditingController();
  TextEditingController addSalesNameController = TextEditingController();
  TextEditingController addSerialController = TextEditingController();
  TextEditingController addRemarkController = TextEditingController();
  TextEditingController addGstTypeController = TextEditingController();
  TextEditingController addRefController = TextEditingController();
  TextEditingController itemDesController = TextEditingController();
  TextEditingController itemUnitController = TextEditingController();
  TextEditingController itemQtyController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController itemDiscountController = TextEditingController();

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController itemTaxablePriceController = TextEditingController();
  TextEditingController invoiceController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController itemNetPriceController = TextEditingController();
  TextEditingController addGstController = TextEditingController();
  TextEditingController searchFieldController = TextEditingController();
  TextEditingController itemDiscountPerController = TextEditingController();
  TextEditingController itemTotalDiscountController = TextEditingController();
  TextEditingController itemGrossAmountController = TextEditingController();
  TextEditingController itemCGstPerController = TextEditingController();
  TextEditingController itemSGstPerController = TextEditingController();
  TextEditingController itemIGstPerController = TextEditingController();
  TextEditingController itemCGstAmtController = TextEditingController();
  TextEditingController itemSGstAmtController = TextEditingController();
  TextEditingController itemIGstAmtController = TextEditingController();
  TextEditingController itemNetAmountController = TextEditingController();
  RxBool isOpen = false.obs;
  bool isUpdate = false;
  int key = 0;
  String startDate = "";
  String poDate = "";
  String deliveryDate = "";
  int gstId = 0;
  String endDate = "";
  int customerId = 0;
  String total = "";
  String discountTotal = "";
  String cGstTotal = "";
  String sGstTotal = "";
  String iGstTotal = "";
  String totalItem = "";
  String netTotal = "";
  int salesPersonId = 0;

  List invoiceList = [
    'Bill of Supply',
    'Tax',
  ];

  List gstTYpe = [
    'CGST_SGST',
    'IGST',
  ];

  List<SaleDetails> itemList = [];


  List<SalesInvoiceData> quotationList = [];

  List<SalesPersonData> salesList = [];

  void filterSheet(BuildContext context) {
    Get.bottomSheet(
        isScrollControlled: true,
        GetBuilder<SaleInvoiceController>(
          builder: (controller) {
            return DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Gap(20),
                  Text(
                    "Sales Invoice",
                    // "Search Quotation",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: FontFamily.semiBold,
                      fontSize: FontSize.s24,
                    ),
                  ),
                  Gap(10),
                  Divider(
                    color: Colors.black38,
                    thickness: 1,
                  ),
                  ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    children: [
                      CommonTextField(
                        borderRadius: 12,
                        controller: startDateController,
                        title: AppString.startDate,
                        isTitle: true,
                        maxLength: 10,
                        readOnly: true,
                        showCursor: false,
                        onTap: (){
                          selectDate(context, "from");
                        },
                        inputFormatters: [
                          DateInputFormatter(),
                        ],
                        suffix: GestureDetector(
                          onTap: () {
                            selectDate(context, "from");
                          },
                          child: Icon(Icons.calendar_month),
                        ),
                      ),
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: endDateController,
                        title: AppString.endDate,
                        isTitle: true,
                        maxLength: 10,
                        showCursor: false,
                        readOnly: true,
                        inputFormatters: [
                          DateInputFormatter(),
                        ],
                        onTap: (){
                          selectDate(context, "to");
                        },
                        suffix: GestureDetector(
                          onTap: () {
                            selectDate(context, "to");
                          },
                          child: Icon(Icons.calendar_month),
                        ),
                      ),
                      Gap(10),
                      Text(
                        "Sale Type",
                        // AppString.selectCompany,
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
                              color: isOpen.value ? Colors.blue : Colors
                                  .black38),
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
                              isOpen.value = value;
                              update();
                            },
                            title: Text(
                              invoiceController.text,
                            ),
                            children: List.generate(invoiceList.length, (
                                index) {
                              return GestureDetector(
                                onTap: () {
                                  invoiceController.text = invoiceList[index];
                                  collapse();
                                  update();
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 4), // item spacing
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(7), // 👈 rounded corners
                                  ),
                                  child: Text(
                                    invoiceList[index],
                                  ),
                                ),
                              );
                            },),
                          ),
                        ),
                      ),
                      Gap(10),
                      CommonTextField(
                        borderRadius: 12,
                        controller: customerController,
                        title: AppString.customer,
                        // AppString.supplier,
                        isTitle: true,
                        maxLength: 10,
                        hintText: "Please Select...",
                        showCursor: false,
                        readOnly: true,
                        onTap: () {
                          selectCustomer();
                          // selectLedger();
                        },
                        suffix: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                            )),
                      ),
                      Gap(20),
                      Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              btnName: "Search",
                              onTap: () {
                                salesInvoiceListApi();
                                Get.back();
                              },
                            ),
                          ),
                          Gap(10),
                          Expanded(
                            child: CommonButton(
                              btnName: "Reset",
                              btnColor: Colors.deepPurple,
                              onTap: () {
                                Get.back();
                                customerController.clear();
                                invoiceController.clear();
                              },
                            ),
                          )
                        ],
                      ),
                      Gap(20),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }

  List<String> filteredItems = [];
  List<String> customerName = [
    '3 STAR ADVERTISING',
    'A.JITENDERKUMAR & CO.',
    'AADARSH ASSOCIATES',
  ];

  Future<void> apiCallGetItemForCustomer() async {
    if (customerId == 0) return;
    print('ITEM API customerId: $customerId');

    FormData formData = FormData.fromMap({});
    final data = await GetAPIFunction().apiCall(
      apiName: ApiQueryHelper.withCustomerId(Constants.getItemList, customerId),
      context: Get.context!,
      params: formData,
    );
    var responseData = data is String ? jsonDecode(data) : data;
    final model = GetItemListModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Constants.itemList = model.data ?? [];
      update();
    }
  }

  void filterItems(String query) {
    if (query.isEmpty) {
      filteredItems = customerName;
    } else {
      filteredItems = customerName
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  void customerNameFilterItems(String query) {
    if (query.isEmpty) {
      filteredCustomer = Constants.customerList;
    } else {
      final q = query.toLowerCase().trim();
      filteredCustomer = Constants.customerList
          .where((item) =>
      (item.customerName ?? '').toLowerCase().contains(q) ||
          (item.contactNo ?? '').toLowerCase().contains(q))
          .toList();
    }
    update();
  }

  void selectLedger() {
    filteredItems = customerName;
    searchController.clear();
    Get.bottomSheet(
      GetBuilder<SaleInvoiceController>(
        builder: (controller) {
          return DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                children: [
                  CommonTextField(
                    controller: searchController,
                    borderRadius: 12,
                    prefix: Icon(Icons.search),
                    onChanged: (p0) {
                      // filterItems(p0);
                      customerNameFilterItems(p0);
                    },
                  ),
                  SizedBox(height: 6),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return GestureDetector(onTap: () {
                          customerController.text = filteredItems[index];
                          controller.update();
                          Get.back();
                        }, child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Text(filteredItems[index])));
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

  collapse() {
    int newKey = 0;
    do {
      key = new Random().nextInt(10000);
    } while (newKey == key);
  }

  Future<void> selectDate(BuildContext context, String fromDate) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      final date = DateFormat("dd/MM/yyyy").format(picked).toString();
      if (fromDate == "from") {
        startDate = picked.toIso8601String();
        startDateController.text = date;
      } else if (fromDate.toLowerCase() == "add") {
        addDateController.text = date;
      } else {
        endDate = picked.toIso8601String();
        endDateController.text = date;
      }
    }
  }


  void filterCustomer(String query) {
    if (query.isEmpty) {
      filteredCustomer = Constants.customerList;
    } else {
      filteredCustomer = Constants.customerList
          .where((item) =>
          item.customerName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  void selectCustomer() {
    filteredCustomer = Constants.customerList;
    searchController.clear();

    Get.bottomSheet(
      isScrollControlled: true,
      GetBuilder<SaleInvoiceController>(
        builder: (controller) {
          return Container(
            height: Get.height * 0.78,
            decoration: const BoxDecoration(
              color: SplashColors.scaffoldBg,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              children: [
                const SalesOrderSheetHeader(
                  title: 'Select Customer',
                  subtitle: 'Search and choose a customer',
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  child: TextField(
                    controller: searchController,
                    onChanged: (p0) {
                      customerNameFilterItems(p0);
                    },
                    decoration: salesOrderSearchDecoration().copyWith(
                      hintText: 'Search customer name...',
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCustomer.length,
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                    itemBuilder: (context, index) {
                      final customer = filteredCustomer[index];
                      final name = customer.customerName ?? '';
                      final phone = customer.contactNo ?? '';
                      final displayTitle = customer.contactNo != null &&
                              customer.contactNo!.isNotEmpty
                          ? "${customer.customerName ?? ""} - ${customer.contactNo}"
                          : "${customer.customerName ?? ""}";
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            customerController.text = displayTitle;
                            customerId = customer.customerID ?? 0;
                            addCustomerNumberController.text =
                                customer.contactNo ?? "";
                            addGSTinController.text =
                                customer.gstinNumber ?? "";
                            if (addInvoiceTypeController.text !=
                                "Bill of Supply") {
                              addGstTypeController.text =
                                  customer.gstType ?? "";
                            }
                            apiCallGetItemForCustomer();
                            Get.back();
                            update();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: SplashColors.primary.withOpacity(0.1),
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
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        SplashColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.person_outline_rounded,
                                    color: SplashColors.primary,
                                    size: 22,
                                  ),
                                ),
                                const Gap(12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        name,
                                        style: TextStyle(
                                          fontFamily: FontFamily.semiBold,
                                          fontSize: FontSize.s14,
                                          color: SplashColors.primaryDark,
                                        ),
                                      ),
                                      if (phone.isNotEmpty) ...[
                                        const Gap(4),
                                        Text(
                                          phone,
                                          style: TextStyle(
                                            fontFamily: FontFamily.regular,
                                            fontSize: FontSize.s12,
                                            color: const Color(0xFF78829A),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 14,
                                  color: SplashColors.primary,
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
          );
        },
      ),
    );
  }

  calculateGstAndDiscount() {
    double itemPrice = double.tryParse(itemNetPriceController.text.isEmpty ? "0" : itemNetPriceController.text) ?? 0;
    double discountPercent = double.tryParse(itemDiscountPerController.text.isEmpty ? "0" : itemDiscountPerController.text) ?? 0;
    double totalGstPercent = double.tryParse(addGstController.text.isEmpty ? "0" : addGstController.text.replaceAll("%", "")) ?? 0;
    double discountAmount = discountPercent / 100 * double.parse(itemPriceController.text);
    double temp = itemPrice * totalGstPercent / 100;
    itemDiscountController.text = (discountAmount.toStringAsFixed(3)).toString();
    itemTotalDiscountController.text = (int.parse(itemQtyController.text.isEmpty ? "0" : itemQtyController.text) * discountAmount).toStringAsFixed(3).toString();
    itemNetPriceController.text = (double.parse(itemPriceController.text.isEmpty? "0" :itemPriceController.text) - discountAmount).toString();

    double cgstPercent = (totalGstPercent / 2);
    double cgstAmount = double.parse(itemNetPriceController.text.isEmpty? "0" :itemNetPriceController.text) * cgstPercent / 100;
    double sgstAmount = double.parse(itemNetPriceController.text.isEmpty ? "0" : itemNetPriceController.text) * cgstPercent / 100;
    double igstAmount = double.parse(itemNetPriceController.text.isEmpty ? "0" :itemNetPriceController.text) * totalGstPercent / 100;

    itemCGstPerController.text = cgstPercent.toStringAsFixed(2).toString();

    itemSGstPerController.text = cgstPercent.toStringAsFixed(2).toString();

    itemIGstPerController.text = igstAmount.toStringAsFixed(2).toString();

    itemCGstAmtController.text = (int.parse(itemQtyController.text.isEmpty ? "0" : itemQtyController.text) * cgstAmount).toStringAsFixed(2).toString();

    itemSGstAmtController.text = (int.parse(itemQtyController.text.isEmpty ? "0" : itemQtyController.text) * sgstAmount).toStringAsFixed(2).toString();

    itemIGstAmtController.text = (int.parse(itemQtyController.text.isEmpty ? "0" : itemQtyController.text) * igstAmount).toStringAsFixed(2).toString();
    itemGrossAmountController.text = (int.parse(itemQtyController.text.isEmpty ? "0" : itemQtyController.text) * double.parse(itemPriceController.text)).toStringAsFixed(3).toString();
    double discountPerItem = double.parse(itemNetPriceController.text.isEmpty ? "0" : itemNetPriceController.text) * cgstPercent / 100;
    print('discountPerItem --- ${discountPerItem}');
    itemNetPriceController.text = (double.parse(itemNetPriceController.text.isEmpty ? "0" : itemNetPriceController.text) + discountPerItem + discountPerItem).toString();
    itemNetAmountController.text = (double.parse(itemNetPriceController.text.isEmpty ? "0" : itemNetPriceController.text) * int.parse(itemQtyController.text.isEmpty ? "0" : itemQtyController.text)).toStringAsFixed(2).toString();
    itemTaxablePriceController.text =
        (double.parse(itemGrossAmountController.text.isEmpty ? "0" : itemGrossAmountController.text) - discountAmount)
            .toStringAsFixed(3)
            .toString();

    update();
  }

  // API calling...
  bool isData = false;
  Future<void> salesInvoiceListApi() async {
    isData = false;
    String dataRaw = jsonEncode({
      "startDate":
      startDate.isNotEmpty ? startDate : DateTime.now().toIso8601String(),
      "endDate":
      endDate.isNotEmpty ? endDate : DateTime.now().toIso8601String(),
      "invoiceType":
      invoiceController.text.isNotEmpty ? invoiceController.text : "",
      "customerId": customerId
    });

    final data = await APIFunction().apiCall(
      apiName: Constants.saleInvoiceList,
      context: Get.context!,
      rawData: dataRaw,
    );

    SalesInvoiceModel model = SalesInvoiceModel.fromJson(data);
    if (model.statusCode == 200) {
      isData = true;
      quotationList.clear();
      quotationList = model.data ?? [];
      update();
    }
  }

  void quotationDataApi(int id) async {
    final data = await GetAPIFunction().apiCall(
      apiName: "SaleInvoice/SaleInvoiceData/${id}",
      context: Get.context!,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    SaleInvoiceModel model = SaleInvoiceModel.fromJson(responseData);
    if (model.statusCode == 200) {
      model.data!.forEach(
            (element) {
          addDateController.text = DateFormat("dd/MM/yyyy")
              .format(DateTime.parse(element.date ?? ""))
              .toString();
          addSerialController.text = element.serialNo.toString();
          addInvoiceTypeController.text = element.invoiceType ?? "";
          customerController.text = element.customerName ?? "";
          customerId = element.customerId ?? 0;
          addCustomerNumberController.text = element.contactNumber ?? "";
          addShippingAddressController.text = element.shippingAddress ?? "";
          addGSTinController.text = element.gstiNumber ?? "";
          addRemarkController.text = element.remarks ?? "";
          addGstTypeController.text = element.gstType ?? "";
          total = element.total.toString();
          discountTotal = element.discountTotal.toString();
          cGstTotal = element.cgstTotal.toString();
          sGstTotal = element.sgstTotal.toString();
          iGstTotal = element.igstTotal.toString();
          totalItem = (element.saleDetails!.length + 1).toString();
          netTotal = element.netTotal.toString();
          itemList = element.saleDetails ?? [];
        },
      );
      apiCallGetItemForCustomer();
      update();
    }
  }

  void nextSerialNoApi() async {
    final data = await GetAPIFunction().apiCall(
      apiName: "${Constants.salesNextSerialNo}/${addInvoiceTypeController
          .text}",
      context: Get.context!,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    NextSerialNoModel model = NextSerialNoModel.fromJson(responseData);
    if (model.statusCode == 200) {
      addSerialController.text = model.data!.serialNumber.toString();
      update();
    }
  }

  String sanitizeNumber(String value) {
    return value.replaceAll(',', '').trim();
  }

  Future<void> createQuotationApi() async {
    if (itemList.isNotEmpty) {
      double sumNet = 0;
      double sumGross = 0;
      for (final item in itemList) {
        sumNet += item.netAmount ?? item.grossAmount ?? item.price ?? 0;
        sumGross += item.grossAmount ?? item.price ?? 0;
      }
      netTotal = sumNet.toStringAsFixed(2);
      total = sumGross.toStringAsFixed(2);
    }
    var dataRaw = json.encode({
      "date": DateTime.now().toIso8601String(),
      "taxMode": "GST",
      "invoiceType": addInvoiceTypeController.text,
      "serialNo": int.parse(addSerialController.text),
      "customerId": customerId,
      "customerName": customerController.text,
      "contactNumber": addCustomerNumberController.text,
      "shippingAddress": addShippingAddressController.text,
      "creditDays": int.parse(addCreditDaysController.text),
      "gstiNumber": addGSTinController.text,
      "salesPersonId": salesPersonId,
      "remarks": addRemarkController.text,
      "gstType": addGstTypeController.text,
      "total": double.tryParse(total)?? 0.0,
      "discountTotal": double.tryParse(sanitizeNumber(discountTotal)) ?? 0.0,
      "cgstTotal": double.tryParse(sanitizeNumber(cGstTotal))?? 0.0,
      "sgstTotal": double.tryParse(sGstTotal)?? 0.0,
      "igstTotal": double.tryParse(iGstTotal)?? 0.0,
      "netTotal": double.tryParse(sanitizeNumber(netTotal))?? 0.0,
      "saleDetails": itemList.map((e) => e.toJson()).toList(),
    });

    final data = await APIFunction().apiCall(
      apiName: Constants.saveSaleInvoice,
      context: Get.context!,
      rawData: dataRaw,
    );

    SaveQuotationModel model = SaveQuotationModel.fromJson(data);
    if (model.statusCode == 200) {
      isAdd.value = false;
      // quotationList.add(
      //   SalesInvoiceData(
      //     billId: model.data!.quoteId ?? 0,
      //     invoiceSerialNo: addSerialController.text,
      //     date: DateTime.now().toIso8601String(),
      //     customerName: customerController.text,
      //     contactNumber: addCustomerNumberController.text,
      //     invoiceType: addInvoiceTypeController.text,
      //     netPayableAmount: double.parse(netTotal),
      //     allowEditEntry: true,
      //     allowDeleteEntry: true,
      //   ),
      // );
      salesInvoiceListApi();
      update();
    }
  }

  // Future<void> createQuotationApi() async {
  //   // updateTotals();
  //   //
  //   // if (isDemoUser) {
  //   //   final int localId = DateTime.now().millisecondsSinceEpoch;
  //   //
  //   //   quotationList.insert(
  //   //     0,
  //   //     SalesInvoiceData(
  //   //       billId: localId,
  //   //       invoiceSerialNo: addSerialController.text,
  //   //       date: DateTime.now().toIso8601String(),
  //   //       customerName: customerController.text,
  //   //       contactNumber: addCustomerNumberController.text,
  //   //       invoiceType: addInvoiceTypeController.text,
  //   //       netPayableAmount: double.tryParse(netTotal) ?? 0.0,
  //   //       allowEditEntry: true,
  //   //       allowDeleteEntry: true,
  //   //       gstinNumber: addGSTinController.text,
  //   //     ),
  //   //   );
  //   //
  //   //   /// Optional: local cache if edit needs full details later
  //   //   _invoiceItemCache[localId] = List.from(itemList);
  //   //
  //   //   resetForm();
  //   //   isAdd.value = false;
  //   //   update();
  //   //   return;
  //   // }
  //
  //   var dataRaw = json.encode({
  //     "date": DateTime.now().toIso8601String(),
  //     "taxMode": "GST",
  //     "invoiceType": addInvoiceTypeController.text,
  //     "serialNo": int.parse(addSerialController.text),
  //     "customerId": customerId,
  //     "customerName": customerController.text,
  //     "contactNumber": addCustomerNumberController.text,
  //     "shippingAddress": addShippingAddressController.text,
  //     "creditDays": int.parse(addCreditDaysController.text),
  //     "gstiNumber": addGSTinController.text,
  //     "salesPersonId": salesPersonId,
  //     "remarks": addRemarkController.text,
  //     "gstType": addGstTypeController.text,
  //     "total": double.tryParse(total) ?? 0.0,
  //     "discountTotal": double.tryParse(discountTotal),
  //     "cgstTotal": double.tryParse(cGstTotal) ?? 0.0,
  //     "sgstTotal": double.tryParse(sGstTotal) ?? 0.0,
  //     "igstTotal": double.tryParse(iGstTotal) ?? 0.0,
  //     "netTotal": double.tryParse(netTotal) ?? 0.0,
  //     "saleDetails": itemList
  //   });
  //
  //   final data = await APIFunction().apiCall(
  //     apiName: Constants.saveSaleInvoice,
  //     context: Get.context!,
  //     rawData: dataRaw,
  //   );
  //
  //   SaveQuotationModel model = SaveQuotationModel.fromJson(data);
  //   if (model.statusCode == 200) {
  //     isAdd.value = false;
  //
  //     quotationList.insert(
  //         0,
  //         SalesInvoiceData(
  //           billId: model.data!.quoteId ?? 0,
  //           invoiceSerialNo: addSerialController.text,
  //           date: DateTime.now().toIso8601String(),
  //           customerName: customerController.text,
  //           contactNumber: addCustomerNumberController.text,
  //           invoiceType: addInvoiceTypeController.text,
  //           netPayableAmount: double.parse(netTotal),
  //           allowEditEntry: true,
  //           allowDeleteEntry: true,
  //         ));
  //
  //     update();
  //   }
  // }

  Future<void> getSalesPersonListAPI() async {
    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getSalesPersonList,
      context: Get.context!,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    SalesPersonModel model = SalesPersonModel.fromJson(responseData);
    if (model.statusCode == 200) {
      salesList = model.data ?? [];
      update();
    }
  }

  @override
  void onInit() {
    salesInvoiceListApi();
    getSalesPersonListAPI();
    startDateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
    endDateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
    super.onInit();
  }

  Future<void> deleteInvoiceApi(id) async {
    Loading.show();
    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer ${GetStorageData.readString(GetStorageData.token)}'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://gurukrupawebapis.azurewebsites.net/api/SaleInvoice/DeleteSaleInvoice/$id',
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
    );

    SaveQuotationModel model = SaveQuotationModel.fromJson(response.data);
    if (model.statusCode == 200) {
      await salesInvoiceListApi();
      Loading.dismiss();
    }
    else {
      print(response.statusMessage);
    }
  }

  Future<void> downloadPath() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.storage.request();
      }
      if (status.isGranted) {
        const downloadsFolderPath = '/storage/emulated/0/Download/';
        Directory dir = Directory(downloadsFolderPath);
        // file = File('${dir.path}/$fileName');
      }
    }
  }

  void quotationPDFApi(int id) async {
    final data = await GetAPIFunction().apiCall(
      apiName: "SaleInvoice/SaleInvoicePDFUrl/${id}",
      context: Get.context!,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    QuotationModel model = QuotationModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Get.toNamed(Routes.PDF_VIEW, arguments: {
        "html": model.data!.downloadurl,
        "fileName": "Sale_Invoice"
      });
      // downloadFile(model.data!.downloadurl!.split("/").last, model.data!.downloadurl);
      update();
    }
  }

  Future<void> downloadFile(var filePath, var documentUrl) async {
    try {
      print("downloadFile --- 1");
      final filename = filePath;
      String dir = "/storage/emulated/0/Download";
      print("downloadFile --- 2");

      if (await File('$dir/$filename').exists()) {
        print("File already exists at $dir/$filename");
        return;
      }

      String url = documentUrl;
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();

      if (response.statusCode == 200) {
        final totalBytes = response.contentLength;
        int receivedBytes = 0;

        File file = File('$dir/$filename');
        var fileSink = file.openWrite();

        await for (var chunk in response) {
          fileSink.add(chunk);

          receivedBytes += chunk.length;

          double progress = (receivedBytes / totalBytes) * 100;
          print("Download progress: ${progress.toStringAsFixed(2)}%");
        }

        await fileSink.close();

        print("File downloaded successfully to ${file.path}");
        Utils().showToast(message: "File downloaded successfully to ${file.path}", context: Get.context!);
      } else {
        print("Failed to download file: ${response.statusCode}");
      }
    } catch (err) {
      print("Error: $err");
    }
  }
}
