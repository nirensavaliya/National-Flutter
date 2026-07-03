import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gurukrupa/app/api_common/api_function.dart';
import 'package:gurukrupa/app/api_common/loading.dart';
import 'package:gurukrupa/app/data/common_widget/common_button.dart';
import 'package:gurukrupa/app/modules/quotation/model/new_serial_model.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
// import 'package:path_provider/path_provider.dart';

import '../../../commons/all.dart';
import '../../../commons/api_query_helper.dart';
import '../../../commons/get_storage_data.dart';
import '../../bottom_bar/model/get_item_list.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../item_list/controllers/item_list_controller.dart';
import '../model/quoation_list_model.dart';
import '../model/quotation_model.dart';
import '../model/quotation_pdf_model.dart';
import '../model/save_quotation_model.dart';

class QuotationController extends GetxController {
  RxBool isAdd = false.obs;
  TextEditingController searchFieldController = TextEditingController();
  TextEditingController addDateController = TextEditingController();
  TextEditingController addSerialController = TextEditingController();
  TextEditingController addInvoiceTypeController =
      TextEditingController(text: "Bill of Supply");
  TextEditingController addGstController = TextEditingController();
  TextEditingController addCustomerNumberController = TextEditingController();
  TextEditingController addShippingAddressController = TextEditingController();
  TextEditingController addGstTypeController = TextEditingController();
  TextEditingController addCreditDaysController =
      TextEditingController(text: "0");
  TextEditingController addGSTinController = TextEditingController();
  TextEditingController addRemarkController = TextEditingController();
  TextEditingController itemDesController = TextEditingController();
  TextEditingController itemUnitController = TextEditingController();
  TextEditingController itemQtyController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController itemDiscountPerController = TextEditingController();
  TextEditingController itemDiscountController = TextEditingController();
  TextEditingController itemTotalDiscountController = TextEditingController();
  TextEditingController itemNetPriceController = TextEditingController();
  TextEditingController itemCGstPerController = TextEditingController();
  TextEditingController itemCGstAmtController = TextEditingController();
  TextEditingController itemSGstPerController = TextEditingController();
  TextEditingController itemSGstAmtController = TextEditingController();
  TextEditingController itemIGstPerController = TextEditingController();
  TextEditingController itemIGstAmtController = TextEditingController();
  TextEditingController itemTaxablePriceController = TextEditingController();
  TextEditingController itemNetAmountController = TextEditingController();
  TextEditingController itemGrossAmountController = TextEditingController();

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController invoiceController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  RxBool isOpen = false.obs;
  int key = 0;
  bool isUpdate = true;
  String quId = "";
  int gstId = 0;
  String startDate = "";
  String endDate = "";
  int customerId = 0;
  String total = "";
  String discountTotal = "";
  String cGstTotal = "";
  String sGstTotal = "";
  String iGstTotal = "";
  String totalItem = "";
  String netTotal = "";

  List<QuotationDetails> itemList = [];

  int? expandedIndex;

  List invoiceList = [
    'Bill of Supply',
    'Tax',
  ];

  List gstTYpe = [
    'CGST_SGST',
    'IGST',
  ];

  List gstList = [
    '1%',
    '5%',
    '12%',
    '18%',
    '28%',
    'Exempted',
    '3%',
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
      filteredItems = Constants.itemList;
      update();
    }
  }

  void filterItems(String query) {
    filteredItems = Constants.itemList;
    if (query.isEmpty) {
      filteredItems = Constants.itemList;
    } else {
      filteredItems = Constants.itemList
          .where((item) =>
              item.itemName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    ;
    update();
  }

  List<QuotationData> quotationList = [];

  void filterSheet(BuildContext context) {
    Get.bottomSheet(isScrollControlled: true, GetBuilder<QuotationController>(
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
                "Search Quotation",
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
                    showCursor: false,
                    readOnly: true,
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
                      onTap: (){
                        selectDate(context, "to");
                      },
                    inputFormatters: [
                      DateInputFormatter(),
                    ],
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
                    // AppString.invoiceType,
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
                          color: isOpen.value ? Colors.blue : Colors.black38),
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
                        children: List.generate(
                          invoiceList.length,
                          (index) {
                            return GestureDetector(
                              onTap: () {
                                invoiceController.text = invoiceList[index];
                                collapse();
                                update();
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  invoiceList[index],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Gap(10),
                  CommonTextField(
                    borderRadius: 12,
                    controller: customerController,
                    title: AppString.customer,
                    isTitle: true,
                    maxLength: 10,
                    hintText: "Please Select...",
                    showCursor: false,
                    readOnly: true,
                    onTap: () {
                      selectCustomer();
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
                            quotationListApi();
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
        endDateController.text = date;
        endDate = picked.toIso8601String();
      }
    }
  }

  ///
  void filterCustomer(String query) {
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

  void selectCustomer() {
    filteredCustomer = Constants.customerList;
    searchController.clear();
    Get.bottomSheet(
      GetBuilder<QuotationController>(
        builder: (controller) {
          return DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: Column(
                children: [
                  CommonTextField(
                    controller: searchController,
                    borderRadius: 12,
                    prefix: Icon(Icons.search),
                    onChanged: (p0) {
                      filterCustomer(p0);
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredCustomer.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: GestureDetector(
                            onTap: () {
                              customerController.text =
                              filteredCustomer[index].contactNo != null && filteredCustomer[index].contactNo!.isNotEmpty
                                  ? "${filteredCustomer[index].customerName ?? ""} - ${filteredCustomer[index].contactNo}"
                                  : "${filteredCustomer[index].customerName ?? ""}";

                              customerId =
                                  filteredCustomer[index].customerID ?? 0;
                              addGSTinController.text = filteredCustomer[index].gstinNumber ?? "";
                              addCustomerNumberController.text = filteredCustomer[index].contactNo ?? "";
                              addGstTypeController.text = filteredCustomer[index].gstType ?? "";
                              apiCallGetItemForCustomer();
                              update();
                              Get.back();
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(7)),
                              child: commonTableText(
                                  title: filteredCustomer[index].contactNo != null && filteredCustomer[index].contactNo!.isNotEmpty
                                      ? "${filteredCustomer[index].customerName ?? ""} - ${filteredCustomer[index].contactNo}"
                                      : "${filteredCustomer[index].customerName ?? ""}"),

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

  Future<void> quotationListApi() async {
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
      apiName: Constants.quotationList,
      context: Get.context!,
      rawData: dataRaw,
    );

    QuotationListModel model = QuotationListModel.fromJson(data);
    if (model.statusCode == 200) {
      quotationList.clear();
      quotationList = model.data ?? [];
      update();
    }
  }

  void nextSerialNoApi() async {
    final data = await GetAPIFunction().apiCall(
      apiName: "${Constants.nextSerialNo}/${addInvoiceTypeController.text}",
      context: Get.context!,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    NextSerialNoModel model = NextSerialNoModel.fromJson(responseData);
    if (model.statusCode == 200) {
      addSerialController.text = model.data!.serialNumber.toString();
      update();
    }
  }

  void quotationDataApi(int id) async {
    final data = await GetAPIFunction().apiCall(
      apiName: "${Constants.quotationData}/${id}",
      context: Get.context!,
    );

    QuotationDataModel model = QuotationDataModel.fromJson(data);
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
          addCreditDaysController.text = element.creditDays.toString();
          addGSTinController.text = element.gstiNumber ?? "";
          addRemarkController.text = element.remarks ?? "";
          addGstTypeController.text = element.gstType ?? "";
          total = element.total.toString();
          discountTotal = element.discountTotal.toString();
          cGstTotal = element.cgstTotal.toString();
          sGstTotal = element.sgstTotal.toString();
          iGstTotal = element.igstTotal.toString();
          totalItem = (element.quotationDetails!.length + 1).toString();
          netTotal = element.netTotal.toString();
          itemList = element.quotationDetails ?? [];
        },
      );
      apiCallGetItemForCustomer();
      update();
    }
  }

  void quotationPDFApi(int id) async {
    final data = await GetAPIFunction().apiCall(
      apiName: "${Constants.quotationPDFurl}/${id}",
      context: Get.context!,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    QuotationModel model = QuotationModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Get.toNamed(Routes.PDF_VIEW, arguments: {
        "html": model.data!.downloadurl,
        "fileName": "Quotation"
      });
      // downloadFile(model.data!.downloadurl!.split("/").last, model.data!.downloadurl);
      update();
    }
  }



  @override
  void onInit() {
    quotationListApi();
    startDateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
    endDateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
    super.onInit();
  }


  calculateGstAndDiscount() {
    double itemPrice = double.tryParse(itemNetPriceController.text) ?? 0;
    double discountPercent = double.tryParse(itemDiscountPerController.text) ?? 0;
    double totalGstPercent = double.parse(addGstController.text.replaceAll("%", "")) ?? 0;
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

  double safeDouble(String? value) {
    return double.tryParse(value ?? "") ?? 0.0;
  }

  /// UTC ISO without fractional seconds — avoids SQL Server varchar→datetime errors
  /// from long microsecond tails / locale-sensitive parsing.
  String quotationSaveDateIsoUtc() {
    DateTime local = DateTime.now();
    final t = addDateController.text.trim();
    if (t.isNotEmpty) {
      try {
        final d = DateFormat('dd/MM/yyyy').parse(t);
        final n = DateTime.now();
        local = DateTime(d.year, d.month, d.day, n.hour, n.minute, n.second);
      } catch (_) {}
    }
    final u = local.toUtc();
    return '${u.year.toString().padLeft(4, '0')}-'
        '${u.month.toString().padLeft(2, '0')}-'
        '${u.day.toString().padLeft(2, '0')}T'
        '${u.hour.toString().padLeft(2, '0')}:'
        '${u.minute.toString().padLeft(2, '0')}:'
        '${u.second.toString().padLeft(2, '0')}Z';
  }

  Future<void> createQuotationApi() async {
    var dataRaw = json.encode({
      "date": quotationSaveDateIsoUtc(),
      "taxMode": "GST",
      "invoiceType": addInvoiceTypeController.text,
      "serialNo": int.parse(addSerialController.text),
      "customerId": customerId,
      "customerName": customerController.text,
      "contactNumber": addCustomerNumberController.text,
      "shippingAddress": addShippingAddressController.text,
      "creditDays": int.parse(addCreditDaysController.text),
      "gstiNumber": addGSTinController.text,
      "remarks": addRemarkController.text,
      "gstType": addGstTypeController.text,
      "total": safeDouble(total),
      "discountTotal": safeDouble(discountTotal),
      "cgstTotal": safeDouble(cGstTotal),
      "sgstTotal": safeDouble(sGstTotal),
      "igstTotal": safeDouble(iGstTotal),
      "netTotal": safeDouble(netTotal),
      "quotationDetails": itemList
    });

    final data = await APIFunction().apiCall(
      apiName: Constants.saveQuotation,
      context: Get.context!,
      rawData: dataRaw,
    );

    SaveQuotationModel model = SaveQuotationModel.fromJson(data);
    if (model.statusCode == 200) {
      // quotationList.add(
      //   QuotationData(
      //       quoteId: model.data!.quoteId ?? 0,
      //       serialNo: addSerialController.text,
      //       date: DateTime.now().toIso8601String(),
      //       customerName: customerController.text,
      //       contactNumber: addCustomerNumberController.text,
      //       invoiceType: addInvoiceTypeController.text,
      //       netPayableAmount: double.parse(netTotal),
      //       allowEditEntry: true,
      //       allowDeleteEntry: true,
      //   ),
      // );
      quotationListApi();
      update();
    }
  }

  Future<void> updateQuotationApi() async {
    var dataRaw = json.encode({
      "date": quotationSaveDateIsoUtc(),
      "taxMode": "GST",
      "invoiceType": addInvoiceTypeController.text,
      "serialNo": addSerialController.text,
      "customerId": customerId.toString(),
      "customerName": customerController.text,
      "contactNumber": addCustomerNumberController.text,
      "shippingAddress": addShippingAddressController.text,
      "creditDays": addCreditDaysController.text,
      "gstiNumber": addGSTinController.text,
      "remarks": addRemarkController.text,
      "gstType": addGstTypeController.text,
      "total": total,
      "discountTotal": discountTotal,
      "cgstTotal": cGstTotal,
      "sgstTotal": sGstTotal,
      "igstTotal": iGstTotal,
      "netTotal": netTotal,
      "quotationDetails": itemList
    });

    final data = await APIFunction().apiCall(
      apiName: "${Constants.updateQuotation}/${quId}",
      context: Get.context!,
      rawData: dataRaw,
    );

    SaveQuotationModel model = SaveQuotationModel.fromJson(data);
    if (model.statusCode == 200) {
      // quotationList.add(
      //   QuotationData(
      //     quoteId: model.data!.quoteId ?? 0,
      //     serialNo: addSerialController.text,
      //     date: DateTime.now().toIso8601String(),
      //     customerName: customerController.text,
      //     contactNumber: addCustomerNumberController.text,
      //     invoiceType: addInvoiceTypeController.text,
      //     netPayableAmount: double.parse(netTotal),
      //     allowEditEntry: true,
      //     allowDeleteEntry: true,
      //   ),
      // );
      quotationListApi();
      update();
    }
  }

 Future<void> deleteQuotationApi(id) async {
    Loading.show();
    String token = "";
    if(GetStorageData.containKey(GetStorageData.token))
    {
      token = GetStorageData.readString(GetStorageData.token);
    }
    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer $token',
      'Cookie': 'ARRAffinity=3adacca6c2f81875efead5591d2a8d02faa6e8843c1dd1a10e8da178ce234c0c; ARRAffinitySameSite=3adacca6c2f81875efead5591d2a8d02faa6e8843c1dd1a10e8da178ce234c0c'
    };
    var dio = Dio();
    var response = await dio.request(
      'https://gurukrupawebapis.azurewebsites.net/api/Quotation/DeleteQuotation/$id',
      options: Options(
        method: 'PUT',
        headers: headers,
      ),
    );

    SaveQuotationModel model = SaveQuotationModel.fromJson(response.data);
    if (model.statusCode == 200) {
      await quotationListApi();
      Loading.dismiss();
    }
    else {
      print(response.statusMessage);
    }
  }
}

class commonModel {
  final String? itemName;
  final String? itemCode;
  final String? unitCode;
  final String? basicPrice;
  final String? subBrand;
  final String? purchasePrice;
  final String? purchaseVatAmt;
  final String? stockQty;
  final String? category;
  final String? discount;
  final String? branchName;
  final String? subcategory;
  final String? barCodeNo;
  final String? itemValue;
  final String? action;
  final String? invoiceSerial;
  final String? date;
  final String? customerName;
  final String? contactNumber;
  final String? invoiceType;
  final String? netAmount;
  final String? gstIn;

  commonModel({
    this.itemName,
    this.itemCode,
    this.barCodeNo,
    this.unitCode,
    this.purchasePrice,
    this.subcategory,
    this.category,
    this.subBrand,
    this.discount,
    this.itemValue,
    this.basicPrice,
    this.branchName,
    this.stockQty,
    this.purchaseVatAmt,
    this.action,
    this.invoiceSerial,
    this.date,
    this.customerName,
    this.contactNumber,
    this.invoiceType,
    this.netAmount,
    this.gstIn,
  });
}
