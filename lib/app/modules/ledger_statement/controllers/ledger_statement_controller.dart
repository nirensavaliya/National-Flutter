
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/data/common_widget/common_textfeild.dart';
import 'package:intl/intl.dart';

import '../../../api_common/api_function.dart';
import '../../../commons/all.dart';
import '../../../routes/app_pages.dart';
import '../../item_list/controllers/item_list_controller.dart';
import '../../quotation/model/quotation_pdf_model.dart';
import '../../sale_invoice/model/sales_invoice_detail_model.dart';
import '../model/gl_account_model.dart';
import '../model/ledger_statement_model.dart';
import '../views/ledger_statement_form_ui.dart';

class LedgerStatementController extends GetxController {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController ledgerController = TextEditingController();
  TextEditingController searchFieldController = TextEditingController();
  String fromDateV = "${DateFormat('yyyy-MM').format(DateTime.now())}-01";
  String todoDateV = DateFormat('yyyy-MM-dd').format(DateTime.now());

  TextEditingController addSerialController = TextEditingController();
  TextEditingController addInvoiceTypeController = TextEditingController(
      text: "Bill of Supply");
  TextEditingController customerController = TextEditingController();
  int customerId = 0;
  TextEditingController addDateController = TextEditingController();
  TextEditingController addCustomerNumberController = TextEditingController();
  TextEditingController addShippingAddressController = TextEditingController();
  TextEditingController addGSTinController = TextEditingController();
  TextEditingController addRemarkController = TextEditingController();
  TextEditingController addGstTypeController = TextEditingController();
  String total = "";
  String discountTotal = "";
  String cGstTotal = "";
  String sGstTotal = "";
  String iGstTotal = "";
  String totalItem = "";
  String netTotal = "";

  List<GlAccountData> filteredItems = [];
  List<GlAccountData> glAccountList = [];
  List<ledgerData> ledgerList = [];
  String searchText = "";
  int ledgerId = 10;
  ledgerData? selectedLedger;
  List<SaleDetails> itemList = [];

  void selectLedgerRow(ledgerData ledger) {
    selectedLedger = ledger;
    update();
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
        fromDateV = DateFormat("yyyy-MM-dd").format(picked).toString();
        fromDateController.text = date;
      } else {
        todoDateV = DateFormat("yyyy-MM-dd").format(picked).toString();
        toDateController.text = date;
      }
    }
  }

  void filterItems(String query) {
    searchText = query;
    if (query.isEmpty) {
      filteredItems = glAccountList;
    } else {
      filteredItems = glAccountList
          .where((item) => item.glAccountName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  void quotationDataApi(String id) async {
    final data = await GetAPIFunction().apiCall(
      apiName: "SaleInvoice/SaleInvoiceData/${id}",
      context: Get.context!,
    );

    SaleInvoiceModel model = SaleInvoiceModel.fromJson(data);
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
      update();
    }
  }


  void selectLedger() {
    searchFieldController.clear();
    Get.bottomSheet(
      GetBuilder<LedgerStatementController>(
        builder: (controller) {
          return SizedBox(
            height: Get.height * 0.75,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  const LedgerSelectSheetHeader(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: CommonTextField(
                      controller: searchFieldController,
                      borderRadius: 12,
                      prefix: const Icon(Icons.search, color: SplashColors.primary),
                      onChanged: (p0) {
                        filterItems(p0);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemBuilder: (context, index) {
                        return LedgerSelectListTile(
                          title: controller.filteredItems[index].glAccountName,
                          onTap: () {
                            ledgerController.text =
                                filteredItems[index].glAccountName ?? "";
                            ledgerId = filteredItems[index].glAccountNumber ?? 0;
                            ledgerListApi();
                            Get.back();
                          },
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

  @override
  void onInit() {

    final now = DateTime.now();

    late final financialYearStart = (now.month >= 4)
        ? DateTime(now.year, 4, 1) // April 1 of current year
        : DateTime(now.year - 1, 4, 1); // April 1 of previous year

    late final financialYearEnd = (now.month >= 4)
        ? DateTime(now.year + 1, 3, 31) // March 31 of next year
        : DateTime(now.year, 3, 31); // March 31 of current year

    final date = DateFormat("dd/MM/yyyy").format(financialYearStart).toString();
    final date1 = DateFormat("dd/MM/yyyy").format(financialYearEnd).toString();

    fromDateV = DateFormat("yyyy-MM-dd").format(financialYearStart).toString();
    fromDateController.text = date;
    todoDateV = DateFormat("yyyy-MM-dd").format(financialYearEnd).toString();
    toDateController.text = date1;

    apiCallSupplier();
    ledgerListApi();
    print("fromDateV --- ${fromDateV}");
    super.onInit();
  }

  Future<void> ledgerListApi() async {
    String url = "${Constants.ledgerStatement}?GLAccountNumber=$ledgerId&FromDate=$fromDateV&ToDate=$todoDateV";

    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    GetLedgerStatementModel model = GetLedgerStatementModel.fromJson(responseData);
    if(model.statusCode == 200)
    {
      ledgerList = model.data ?? [];
      update();
    }
  }


  void genaratePDFApi() async {
    String url = "Reports/LedgerStatementPDFurl?GLAccountNumber=$ledgerId&FromDate=$fromDateV&ToDate=$todoDateV";

    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );
    // var responseData = data is String ? jsonDecode(data) : data;
    Get.toNamed(Routes.PDF_VIEW,    arguments: {
      "html": data,
      "fileName": "Ledger_Statement"
    },);
    // QuotationModel model = QuotationModel.fromJson(data);
    // if (model.statusCode == 200) {
    //   downloadFile(model.data!.downloadurl!.split("/").last, model.data!.downloadurl);
    //   update();
    // }
  }

  downloadFile(var filePath, var documentUrl) async {
    try {
      print("downloadFile --- 1");
      /// setting filename
      final filename = filePath;
      String dir = "/storage/emulated/0/Download";
      print("downloadFile --- 2");
      if (await File('$dir/$filename').exists()) return File('$dir/$filename');

      String url = documentUrl;

      /// requesting http to get url
      var request = await HttpClient().getUrl(Uri.parse(url));

      /// closing request and getting response
      var response = await request.close();

      /// getting response data in bytes
      var bytes = await consolidateHttpClientResponseBytes(response);

      /// generating a local system file with name as 'filename' and path as '$dir/$filename'
      File file = new File('$dir/$filename');

      /// writing bytes data of response in the file.
      await file.writeAsBytes(bytes);

      print("file path --- ${file.path}");
    }
    catch (err) {
      print("=-=-=-=-=-= 12=-=-=-=-${err}");
    }
  }

  Future<void> apiCallSupplier() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getGlaccountList,
      context: Get.context!,
      params: formData,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    GlAccountModel model = GlAccountModel.fromJson(responseData);
    if(model.statusCode == 200)
    {
      glAccountList = model.data ?? [];
      filteredItems = model.data ?? [];
      update();
    }
  }
}
