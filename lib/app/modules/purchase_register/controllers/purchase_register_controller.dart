import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:intl/intl.dart';

import '../../../api_common/api_function.dart';
import '../../../commons/all.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../../routes/app_pages.dart';
import '../../item_list/controllers/item_list_controller.dart';
import '../../sale_register/views/sale_register_form_ui.dart';
import '../model/purchase_register_model.dart';
import '../model/purchase_register_model_data.dart';

class PurchaseRegisterController extends GetxController {
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  TextEditingController ledgerController = TextEditingController();
  TextEditingController searchFieldController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  String fromDateV = "${DateFormat('yyyy-MM').format(DateTime.now())}-01";
  String todoDateV = DateFormat('yyyy-MM-dd').format(DateTime.now());
  int supplierId = 0;
  int branchId = 0;
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

  List<PurchaseData> filteredItems = [];
  String searchText = "";

  void filterItems(String query) {
    searchText = query;
    if (query.isEmpty) {
      filteredItems = supplierList;
    } else {
      filteredItems = supplierList
          .where((item) => item.supplierName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  void selectLedger() {
    filteredItems = supplierList;
    searchFieldController.clear();
    Get.bottomSheet(
      GetBuilder<PurchaseRegisterController>(
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
                  const SaleRegisterSheetHeader(title: 'Select Supplier'),
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
                        return SaleRegisterSelectListTile(
                          title: filteredItems[index].supplierName,
                          onTap: () {
                            ledgerController.text =
                                filteredItems[index].supplierName ?? "";
                            supplierId = filteredItems[index].supplierID ?? 0;
                            purchaseRegisterListApi();
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

  void filterBranch(String query) {
    searchText = query;
    if (query.isEmpty) {
      filteredBranch = Constants.branchList;
    } else {
      filteredBranch = Constants.branchList
          .where((item) => item.branchName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }
  void selectBranch() {
    filteredBranch = Constants.branchList;
    searchFieldController.clear();
    Get.bottomSheet(
      GetBuilder<PurchaseRegisterController>(
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
                  const SaleRegisterSheetHeader(title: 'Select Branch'),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: CommonTextField(
                      controller: searchFieldController,
                      borderRadius: 12,
                      prefix: const Icon(Icons.search, color: SplashColors.primary),
                      onChanged: (p0) {
                        filterBranch(p0);
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredBranch.length,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      itemBuilder: (context, index) {
                        return SaleRegisterSelectListTile(
                          title: filteredBranch[index].branchName,
                          onTap: () {
                            branchController.text =
                                filteredBranch[index].branchName ?? "";
                            branchId = filteredBranch[index].branchID ?? 0;
                            purchaseRegisterListApi();
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
    apiCallSupplier();
    purchaseRegisterListApi();
    super.onInit();
  }

  List<PurchaseData> supplierList = [];
  List<Data> registerData = [];

  Future<void> apiCallSupplier() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getSupplierList,
      context: Get.context!,
      params: formData,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    PurchaseRegisterModel model = PurchaseRegisterModel.fromJson(responseData);
    if(model.statusCode == 200)
    {
      supplierList = model.data ?? [];
      filteredItems = model.data ?? [];
      purchaseRegisterListApi();
      update();
    }
  }

  Future<void> purchaseRegisterListApi() async {
    String url =
        "${Constants.purchaseRegister}?FromDate=$fromDateV&ToDate=$todoDateV";

    if (supplierId != 0) {
      url = url + "&" + "SupplierID=$supplierId";
    }
    if (branchId != 0) {
      url = url + "&" + "BranchID=$branchId";
    }

    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    PurchaseRegisterApiModel model = PurchaseRegisterApiModel.fromJson(responseData);
    if (model.statusCode == 200) {
      registerData = model.data ?? [];
      update();
    }
  }
  void genaratePDFApi() async {
    String url =
        "Reports/PurchaseRegisterPDFurl?FromDate=$fromDateV&ToDate=$todoDateV";

    if (supplierId != 0) {
      url = url + "&" + "SupplierID=$supplierId";
    }
    if (branchId != 0) {
      url = url + "&" + "BranchID=$branchId";
    }
    final data = await GetAPIFunction().apiCall(
      apiName: url,
      context: Get.context!,
    );
    // var responseData = data is String ? jsonDecode(data) : data;

    Get.toNamed(Routes.PDF_VIEW, arguments: {
      "html": data,
      "fileName": "Purchase_Register"
    });

    // QuotationModel model = QuotationModel.fromJson(responseData);
    // if (model.statusCode == 200) {
    //
    //   // downloadFile(model.data!.downloadurl!.split("/").last, model.data!.downloadurl);
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
}
