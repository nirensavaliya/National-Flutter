
import 'dart:convert';

import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../api_common/api_function.dart';
import '../../../commons/all.dart';
import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../../routes/app_pages.dart';
import '../../Recipt/model/sales_person_list_model.dart';
import '../../item_list/controllers/item_list_controller.dart';
import '../model/sale_order_register_model.dart';

class SaleOrderRegisterController extends GetxController{

  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  String fromDateV = "${DateFormat('yyyy-MM').format(DateTime.now())}-01";
  String todoDateV = DateFormat('yyyy-MM-dd').format(DateTime.now());
  TextEditingController customerController = TextEditingController();
  TextEditingController searchFieldController = TextEditingController();
  TextEditingController salesPersonController = TextEditingController();

  int customerId = 0;

  String startDateIso = "";
  String endDateIso = "";
  List<SaleOrderRegisterData> saleOrderRegisterList = [];
  int salesPersonId = 0;
  List<SalesPersonData> filteredSalesList = [];
  List<SalesPersonData> salesList = [];


  Future<void> selectDate(BuildContext context, String fromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final displayDate = DateFormat("dd/MM/yyyy").format(picked);
      if (fromDate == "from") {
        fromDateV = DateFormat("yyyy-MM-dd").format(picked);
        fromDateController.text = displayDate;
        // API format: 2026-06-01T00:00:00.000Z
        startDateIso = DateTime.utc(picked.year, picked.month, picked.day)
            .toIso8601String();
      } else {
        todoDateV = DateFormat("yyyy-MM-dd").format(picked);
        toDateController.text = displayDate;
        // API format: 2026-06-22T23:59:59.999Z
        endDateIso = DateTime.utc(
          picked.year,
          picked.month,
          picked.day,
          23,
          59,
          59,
          999,
        ).toIso8601String();
      }
    }
  }

  Future<void> saleOrderRegisterListApi() async {
    final context = Get.context;
    if (context == null) return;
    try {
      final String dataRaw = jsonEncode({
        "startDate": startDateIso.isNotEmpty
            ? startDateIso
            : DateTime.utc(
          DateTime.now().year,
          DateTime.now().month,
          1,
        ).toIso8601String(),
        "endDate": endDateIso.isNotEmpty
            ? endDateIso
            : DateTime.utc(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          23,
          59,
          59,
          999,
        ).toIso8601String(),
        "salesPersonId": salesPersonId,
        "customerId": customerId,
      });
      final data = await APIFunction().apiCall(
        apiName: Constants.saleOrderRegister,
        context: context,
        rawData: dataRaw,
      );
      final responseData = data is String ? jsonDecode(data) : data;
      final GetSaleOrderRegisterModel model = GetSaleOrderRegisterModel.fromJson(responseData);
      if (model.statusCode == 200) {
        saleOrderRegisterList = model.data ?? [];
        print("===== Sale Order Register List =====");
        print("Total items: ${saleOrderRegisterList.length}");
        for (var item in saleOrderRegisterList) {
          print(
            "ID: ${item.salesOrderID}, "
                "Order: ${item.orderNumber}, "
                "Date: ${item.date}, "
                "Customer: ${item.customerName}, "
                "Contact: ${item.contactNumber}, "
                "Type: ${item.invoiceType}, "
                "Amount: ${item.netAmount}, "
                "SalesPerson: ${item.salesPerson}",
          );
        }
        print("====================================");
        update();
        Get.toNamed(Routes.SALESORDERREGISTER);
      }
    } catch (e) {
    }
  }

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

  void showFilterDialog(BuildContext context) {
    if (fromDateController.text.isEmpty) {
      final from = DateTime.parse(fromDateV);
      final to = DateTime.parse(todoDateV);
      fromDateController.text = DateFormat("dd/MM/yyyy").format(from);
      toDateController.text = DateFormat("dd/MM/yyyy").format(to);
      startDateIso =
          DateTime.utc(from.year, from.month, from.day).toIso8601String();
      endDateIso = DateTime.utc(to.year, to.month, to.day, 23, 59, 59, 999)
          .toIso8601String();
    }

    Get.dialog(
      Dialog(
        child: GetBuilder<SaleOrderRegisterController>(
          builder: (ctrl) {
            return DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Filter",
                          style: TextStyle(
                              fontSize: 18, fontFamily: FontFamily.semiBold)),
                      Gap(15),

                      // From Date
                      CommonTextField(
                        borderRadius: 12,
                        controller: fromDateController,
                        title: AppString.fromDate,
                        isTitle: true,
                        maxLength: 10,
                        showCursor: false,
                        readOnly: true,
                        inputFormatters: [DateInputFormatter()],
                        onTap: () => selectDate(context, "from"),
                        suffix: GestureDetector(
                          onTap: () => selectDate(context, "from"),
                          child: Icon(Icons.calendar_month),
                        ),
                      ),
                      Gap(15),

                      // To Date
                      CommonTextField(
                        borderRadius: 12,
                        controller: toDateController,
                        title: AppString.toDate,
                        isTitle: true,
                        maxLength: 10,
                        showCursor: false,
                        readOnly: true,
                        inputFormatters: [DateInputFormatter()],
                        onTap: () => selectDate(context, "to"),
                        suffix: GestureDetector(
                          onTap: () => selectDate(context, "to"),
                          child: Icon(Icons.calendar_month),
                        ),
                      ),
                      Gap(15),

                      // Customer
                      CommonTextField(
                        borderRadius: 12,
                        controller: salesPersonController,
                        title: AppString.salesPerson,
                        isTitle: true,
                        hintText: "Please Select...",
                        showCursor: false,
                        readOnly: true,
                        onTap: () => selectSalesPerson(),
                        suffix: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.arrow_forward_ios, size: 20),
                        ),
                      ),
                      Gap(20),

                      Row(
                        children: [
                          Expanded(
                            child: CommonButton(
                              btnName: "Cancel",
                              btnColor: Colors.transparent,
                              textColor: Colors.black87,
                              borderColor: Colors.blue,
                              onTap: () => Get.back(),
                            ),
                          ),
                          Gap(10),
                          Expanded(
                            child: CommonButton(
                              btnName: "Apply",
                              onTap: () async {
                                if (salesPersonId == 0) {
                                  Utils().showToast(
                                    message: "Please select customer",
                                    context: context,
                                  );
                                  return;
                                }
                                Get.back();
                                await saleOrderRegisterListApi();
                                // saleOrderRegisterListApi();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  void selectCustomer() {
    filteredCustomer = Constants.customerList;
    searchFieldController.clear();
    Get.bottomSheet(
      SizedBox(
        height: Get.height * 0.7,
        child: GetBuilder<SaleOrderRegisterController>(
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
                      controller: searchFieldController,
                      borderRadius: 12,
                      prefix: Icon(Icons.search),
                      onChanged: (p0) {
                        filterItems(p0);
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
                              onTap: () async {
                                customerController.text =
                                filteredCustomer[index].contactNo != null && filteredCustomer[index].contactNo!.isNotEmpty
                                    ? "${filteredCustomer[index].customerName ?? ""} - ${filteredCustomer[index].contactNo}"
                                    : "${filteredCustomer[index].customerName ?? ""}";

                                customerId = filteredCustomer[index].customerID ?? 0;
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
      ),
    );
  }

  Future<void> selectSalesPerson() async {
    searchFieldController.clear();

    if (salesList.isEmpty) {
      await getSalesPersonListAPI();
    }
    filteredSalesList = List.from(salesList);

    Get.bottomSheet(
      isScrollControlled: true,
      SizedBox(
        height: Get.height * 0.7,
        child: GetBuilder<SaleOrderRegisterController>(
          builder: (ctrl) {
            return DecoratedBox(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    CommonTextField(
                      controller: searchFieldController,
                      borderRadius: 12,
                      prefix: const Icon(Icons.search),
                      onChanged: filterSalesPerson,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredSalesList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final person = filteredSalesList[index];

                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: GestureDetector(
                              onTap: () {
                                salesPersonController.text =
                                    person.salesPerson ?? "";
                                salesPersonId = person.salesPersonId ?? 0;
                                Get.back();
                                update(); // dialog refresh
                              },
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: commonTableText(
                                  title: person.salesPerson ?? "",
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
      ),
    );
  }

  void filterSalesPerson(String query) {
    if (query.isEmpty) {
      filteredSalesList = List.from(salesList);
    } else {
      filteredSalesList = salesList
          .where((item) => (item.salesPerson ?? '')
          .toLowerCase()
          .contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  String searchText = "";

  void filterItems(String query) {
    searchText = query;
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

}