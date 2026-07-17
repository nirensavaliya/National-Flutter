import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';
import 'package:gurukrupa/app/modules/Recipt/model/BillDataModel.dart';
import 'package:gurukrupa/app/modules/Recipt/model/CashBankBookModel.dart';
import 'package:gurukrupa/app/modules/Recipt/model/GLAccountModel.dart';
import 'package:gurukrupa/app/modules/Recipt/model/NextReceiptNoModel.dart';
import 'package:gurukrupa/app/modules/Recipt/model/ReceiptListModel.dart';
import 'package:gurukrupa/app/modules/Recipt/model/get_role_model.dart';
import 'package:intl/intl.dart';

import '../../../api_common/api_function.dart';
import '../../../commons/all.dart';
import '../../../commons/get_storage_data.dart';
import '../../quotation/model/save_quotation_model.dart';
import '../model/sales_invoice_model.dart';

class ReceiptController extends GetxController {
  RxBool isAdd = false.obs;
  TextEditingController addDateController = TextEditingController();
  TextEditingController addInvoiceTypeController = TextEditingController(text: "Bill of Supply");
  TextEditingController addCustomerNameController = TextEditingController();
  TextEditingController addCustomerNumberController = TextEditingController();
  TextEditingController addShippingAddressController = TextEditingController();
  TextEditingController addCreditDaysController =
      TextEditingController(text: "0");
  TextEditingController addGSTinController = TextEditingController();
  TextEditingController addSalesNameController = TextEditingController();

  TextEditingController addSerialController = TextEditingController();
  TextEditingController addRefNoController = TextEditingController();
  TextEditingController paidByController = TextEditingController();
  TextEditingController paidByAmountController = TextEditingController();
  TextEditingController cashBankController = TextEditingController();
  TextEditingController cashBankAmountController = TextEditingController();
  TextEditingController channelController = TextEditingController();
  TextEditingController partyBankNameController = TextEditingController();
  TextEditingController chequeNoController = TextEditingController();
  TextEditingController chequeDateController = TextEditingController();
  TextEditingController collectedByController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController againstInvoiceController = TextEditingController();
  TextEditingController advanceDepositeController = TextEditingController();
  TextEditingController onAccountController = TextEditingController();
  TextEditingController totalReceivedController = TextEditingController();
  TextEditingController discountGivenController = TextEditingController();
  TextEditingController totalAdjustedController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var totalReceived = TextEditingController();

  RxString cashBankText = ''.obs;
  RxString selectedBookType = "N/A".obs;

  RxString selectedOption = RxString('Auto');

  String selectedAmount = "0.00 Dr";
  String selectedPaidByGlAccountNumber = "0.00 Dr";
  int selectedCashBankID = 0;
  int selectedGLAccountNumber = 0;
  int selectedPartyId = 0;
  String selectedPaidByAmount = "0.00 Dr";
  String selectedPartyType = "";
  int selectedCashBankGLANumber = 0;
  var getRole = Rxn<GetRoleModel>();

  List<BillData> bills = [];

  List<TextEditingController> receivedAmountControllers = [];
  List<TextEditingController> discountPercentageControllers = [];
  List<TextEditingController> discountAmountControllers = [];

  TextEditingController addRemarkController = TextEditingController();
  TextEditingController customerController = TextEditingController();
  TextEditingController addGstTypeController = TextEditingController();
  TextEditingController addRefController = TextEditingController();
  TextEditingController itemDesController = TextEditingController();
  TextEditingController itemUnitController = TextEditingController();
  TextEditingController itemQtyController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController itemDiscountController = TextEditingController();

  //👆Add Screen
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController itemTaxablePriceController = TextEditingController();
  TextEditingController invoiceController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  TextEditingController searchCashBankController = TextEditingController();
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
  int key = 0;
  String startDate = "";
  String poDate = "";
  String deliveryDate = "";
  int gstId = 0;
  String endDate = "";

  List channelList = [
    'Cheque',
    'Credit Card',
    'NEFT',
    'RTGS',
    'Cash',
    'TT',
    'Demand Draft',
    'UPI',
    'IMPS ',
  ];

  List<SalesInvoiceData> quotationList = [];

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
        chequeDateController.text = date;
      } else {
        endDate = picked.toIso8601String();
        endDateController.text = date;
        chequeDateController.text = date;
      }
    }
  }

  Future<void> apiCallPaidBy() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getPaidBy,
      context: Get.context!,
      params: formData,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    GLAccountModel model = GLAccountModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Constants.PaidByList = model.data ?? [];
      update();
    }
  }

  Future<void> apiCallOutStandingBillList() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getOutStaningBillList +
          "?PartyId=" +
          selectedPartyId.toString(),
      context: Get.context!,
      params: formData,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    BillDataModel model = BillDataModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Constants.BillDataList = model.data ?? [];
      receivedAmountControllers = List.generate(
        Constants.BillDataList.length,
        (index) => TextEditingController(),
      );

      discountPercentageControllers = List.generate(
        Constants.BillDataList.length,
        (index) => TextEditingController(),
      );

      discountAmountControllers = List.generate(
        Constants.BillDataList.length,
        (index) => TextEditingController(),
      );

      update();
    }
  }

  void updateBillAmount(int index) {
    double originalBillAmount = Constants.BillDataList[index].billAmount ?? 0.0;
    double receivedAmount =
        double.tryParse(receivedAmountControllers[index].text) ?? 0.0;
    double discountPercentage =
        double.tryParse(discountPercentageControllers[index].text) ?? 0.0;

    double discountAmount = (originalBillAmount * discountPercentage) / 100;
    discountAmountControllers[index].text = discountAmount.toStringAsFixed(2);

    Constants.BillDataList[index].outstanding =
        (originalBillAmount - receivedAmount - discountAmount)
            .clamp(0.0, double.infinity);

    updateTotalReceivedAmount();

    update(); // Refresh UI
  }

  void updateTotalReceivedAmount() {
    double totalReceived = receivedAmountControllers.fold(0, (sum, controller) {
      return sum + (double.tryParse(controller.text) ?? 0.0);
    });

    againstInvoiceController.text = totalReceived.toStringAsFixed(2);
    totalReceivedController.text = againstInvoiceController.text;
    totalAdjustedController.text = totalReceivedController.text;
  }

  void selectPaidByList() {
    filteredPaidByList = Constants.PaidByList; // Ensure this is updated
    Get.bottomSheet(
      isScrollControlled: true,
      GetBuilder<ReceiptController>(
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
                  title: 'Select Paid By',
                  subtitle: 'Search and choose a party',
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  child: TextField(
                    controller: searchCashBankController,
                    onChanged: (query) {
                      final q = query.toLowerCase().trim();
                      if (q.isEmpty) {
                        filteredPaidByList = Constants.PaidByList;
                      } else {
                        filteredPaidByList = Constants.PaidByList.where((book) {
                          final name = (book.glAccountName ?? '').toLowerCase();
                          final mobile = (book.mobileNumber ?? '').toLowerCase();
                          return name.contains(q) || mobile.contains(q);
                        }).toList();
                      }
                      update();
                    },
                    decoration: salesOrderSearchDecoration().copyWith(
                      hintText: 'Search paid by...',
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredPaidByList.length,
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                    itemBuilder: (context, index) {
                      final book = filteredPaidByList[index];
                      final name = book.mobileNumber != null &&
                              book.mobileNumber!.isNotEmpty
                          ? "${book.glAccountName ?? ""} - ${book.mobileNumber}"
                          : "${book.glAccountName ?? ""}";
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            print("${book.glAccountNumber.toString()}");
                            selectedPaidByAmount =
                                "${book.balance ?? 0} ${book.crDr}";
                            paidByController.text = book.mobileNumber != null &&
                                    book.mobileNumber!.isNotEmpty
                                ? "${book.glAccountName ?? ""} - ${book.mobileNumber}"
                                : "${book.glAccountName ?? ""}";
                            selectedGLAccountNumber = book.glAccountNumber!;
                            selectedPartyId = book.partyId!;
                            selectedPartyType = book.partyType!;
                            apiCallOutStandingBillList();
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        SplashColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.account_balance_wallet_outlined,
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
                                      const Gap(4),
                                      Text(
                                        "Type: ${book.glAccountType ?? "N/A"}",
                                        style: TextStyle(
                                          fontFamily: FontFamily.regular,
                                          fontSize: FontSize.s12,
                                          color: const Color(0xFF78829A),
                                        ),
                                      ),
                                      Text(
                                        "Balance: ${book.balance ?? 0} ${book.crDr ?? ""}",
                                        style: TextStyle(
                                          fontFamily: FontFamily.medium,
                                          fontSize: FontSize.s12,
                                          color: const Color(0xFF78829A),
                                        ),
                                      ),
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

  Future<void> apiCallCashBankBook() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getCashBankBook,
      context: Get.context!,
      params: formData,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    CashBankBookModel model = CashBankBookModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Constants.cashBankBookList = model.data ?? [];
      update();
    }
  }

  Future<void> apiCallReceiptList() async {
    FormData formData = FormData.fromMap({});

    DateTime now = DateTime.now(); // Current date and time
    DateTime oneMonthAgo = DateTime(now.year, now.month - 1, now.day);

    String formattedDate = oneMonthAgo.toIso8601String();

    var dataRaw = json.encode({
      "startDate": formattedDate,
      "endDate": DateTime.now().toIso8601String(),
      "glaccountnumber": 0,
    });

    final data = await APIFunction().apiCall(
      apiName: Constants.getReceiptList,
      context: Get.context!,
      rawData: dataRaw,
    );

    ReceiptListModel model = ReceiptListModel.fromJson(data);
    if (model.statusCode == 200) {
      Constants.receiptList = model.data ?? [];
      update();
    }
  }

  void selectCashBankBookList() {
    filteredCashBankBookList = Constants.cashBankBookList;
    searchController.clear();
    Get.bottomSheet(
      isScrollControlled: true,
      GetBuilder<ReceiptController>(
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
                  title: 'Select Cash/Bank Book',
                  subtitle: 'Search and choose a book',
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  child: TextField(
                    controller: searchController,
                    onChanged: (query) {
                      filteredCashBankBookList = Constants.cashBankBookList
                          .where((book) => book.bookName!
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                          .toList();
                      update();
                    },
                    decoration: salesOrderSearchDecoration().copyWith(
                      hintText: 'Search cash/bank book...',
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCashBankBookList.length,
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                    itemBuilder: (context, index) {
                      final book = filteredCashBankBookList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            // Handle item selection
                            selectedAmount =
                                "${book.balance ?? 0} ${book.crDr}";
                            cashBankController.text = book.bookName ?? "";
                            selectedCashBankID = book.bookId!;
                            selectedBookType.value = book.bookType ?? "N/A";
                            selectedCashBankGLANumber = book.glAccountNumber!;
                            cashBankController.addListener(() {
                              cashBankText.value = cashBankController.text;
                            });
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        SplashColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.account_balance_outlined,
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
                                        book.bookName ?? "N/A",
                                        style: TextStyle(
                                          fontFamily: FontFamily.semiBold,
                                          fontSize: FontSize.s14,
                                          color: SplashColors.primaryDark,
                                        ),
                                      ),
                                      const Gap(4),
                                      Text(
                                        "Type: ${book.bookType ?? "N/A"}",
                                        style: TextStyle(
                                          fontFamily: FontFamily.regular,
                                          fontSize: FontSize.s12,
                                          color: const Color(0xFF78829A),
                                        ),
                                      ),
                                      Text(
                                        "Balance: ${book.balance ?? 0} ${book.crDr ?? ""}",
                                        style: TextStyle(
                                          fontFamily: FontFamily.medium,
                                          fontSize: FontSize.s12,
                                          color: const Color(0xFF78829A),
                                        ),
                                      ),
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

  void updateReceivedAmount() {
    if (selectedOption.value == "Auto") {
      double enteredAmount =
          double.tryParse(againstInvoiceController.text) ?? 0;
      double remainingAmount = enteredAmount;

      for (int i = 0; i < Constants.BillDataList.length; i++) {
        var bill = Constants.BillDataList[i];

        if (remainingAmount > 0) {
          double assignableAmount = remainingAmount! > bill.billAmount!
              ? bill.billAmount!
              : remainingAmount;
          bill.outstanding = bill.billAmount! - assignableAmount;
          remainingAmount -= assignableAmount;
          receivedAmountControllers[i].text =
              assignableAmount.toStringAsFixed(2);
        } else {
          bill.outstanding = bill.billAmount;
          receivedAmountControllers[i].text =
              "0"; // Reset if nothing is assigned
        }
      }

      double againstInvoice =
          double.tryParse(againstInvoiceController.text) ?? 0;
      double advanceDeposit =
          double.tryParse(advanceDepositeController.text) ?? 0;
      double onAccount = double.tryParse(onAccountController.text) ?? 0;
      double total = againstInvoice + advanceDeposit;

      totalReceivedController.text = total.toStringAsFixed(2);
      // double discountValue =
      //     double.tryParse(discountGivenController.text) ?? 0;
      // double discountAmount = (againstInvoice * discountValue) / 100;
      //
      // totalAdjustedController.text =
      //     (againstInvoice + discountAmount).toStringAsFixed(2);

      // totalReceivedController.text = againstInvoiceController.text.toString();
      double discountPercent = double.tryParse(discountGivenController.text) ?? 0;
      print('discountPercent --- ${discountGivenController.text}');

      double discountAmount = (total * discountPercent) / 100;
      print('discountAmount --- ${discountAmount.toStringAsFixed(2)}');

      double adjustedTotal = total - discountAmount;
      totalAdjustedController.text = adjustedTotal.toStringAsFixed(2);

      print('totalAdjustedController---${adjustedTotal}');



      // advanceDepositeController.text = (remainingAmount > 0 ? remainingAmount.toString() : "");

      update(); // Update UI
    }
  }

  List<SaveReceiptDetails> itemList = [];

  Future<void> saveReceiptApi() async {
    for (int i = 0; i < Constants.BillDataList.length; i++) {
      var item = Constants.BillDataList[i];

      String inputDate = item.billDate!;
      DateTime parsedDate = DateFormat("M/d/yyyy h:mm:ss a").parse(inputDate);
      String formattedDate = parsedDate.toIso8601String();

      itemList.add(SaveReceiptDetails(
          billId: item.billID,
          billNo: item.billNo,
          billAmount: item.billAmount,
          billDate: formattedDate,
          receivedAmount: (receivedAmountControllers[i].text.isEmpty)
          ? 0.0
          : (double.tryParse(receivedAmountControllers[i].text) ?? 0.0),
          discountAmount: (discountAmountControllers[i].text.isEmpty)
          ? 0.0
          : (double.tryParse(discountAmountControllers[i].text) ?? 0.0),
          discountPer: (discountPercentageControllers[i].text.isEmpty)
          ? 0.0
          : (double.tryParse(discountPercentageControllers[i].text) ?? 0.0),
          outstanding: item.outstanding));
    }

    var dataRaw = json.encode({
      "date": DateTime.now().toIso8601String(),
      "refNo": addRefNoController.text,
      "serialNo": addSerialController.text,
      "partyType": selectedPartyType,
      "paidBy": paidByController.text,
      "paidById": selectedPartyId,
      "paidByGlaccountnumber": selectedGLAccountNumber,
      "cashBank": cashBankController.text,
      "cashBankId": selectedCashBankID,
      "cashBankGlaccountnumber": selectedCashBankGLANumber,
      "channel": channelController.text,
      "partyBankName": partyBankNameController.text,
      "chequeNo": chequeNoController.text,
      "chequeDate": chequeDateController.text,
      "againstOpening": 0,
      "againstInvoice": (againstInvoiceController.text.isEmpty)
          ? 0.0
          : (double.tryParse(againstInvoiceController.text) ?? 0.0),
      "advanceDeposite": (advanceDepositeController.text.isEmpty)
          ? 0.0
          : (double.tryParse(advanceDepositeController.text) ?? 0.0),
      "onAccount": (onAccountController.text.isEmpty)
          ? 0.0
          : (double.tryParse(onAccountController.text) ?? 0.0),
      "totalReceived": (totalReceivedController.text.isEmpty)
          ? 0.0
          : (double.tryParse(totalReceivedController.text) ?? 0.0),
      "discountGiven": (discountGivenController.text.isEmpty)
          ? 0.0
          : (double.tryParse(discountGivenController.text) ?? 0.0),
      "totalAdjusted": (totalAdjustedController.text.isEmpty)
          ? 0.0
          : (double.tryParse(totalAdjustedController.text) ?? 0.0),
      "receiptType": "",
      "receiptDetail": itemList,
      "description":descriptionController.text
    });

    print("idsbabdas--------------${dataRaw}");

    final data = await APIFunction().apiCall(
      apiName: Constants.getSaveReceipt,
      context: Get.context!,
      rawData: dataRaw,
    );

    SaveQuotationModel model = SaveQuotationModel.fromJson(data);
    if (model.statusCode == 200) {
      Get.back();
      update();
    }
  }

  // API calling...
  bool isData = false;

  void nextSerialNoApi() async {
    final data = await GetAPIFunction().apiCall(
      apiName: "${Constants.receiptNextSerialNo}",
      context: Get.context!,
    );

    var responseData = data is String ? jsonDecode(data) : data;

    NextReceiptNoModel model = NextReceiptNoModel.fromJson(responseData);
    if (model.statusCode == 200) {
      addSerialController.text = model.data!.receiptNumber.toString();
      update();
    }
  }


  Future<GetRoleModel?> getRoleApi() async {
    try {
      // Loading.show();

      String token = "";
      if (GetStorageData.containKey(GetStorageData.token)) {
        token = GetStorageData.readString(GetStorageData.token);
      }

      print("Making GET request to: ${'https://gurukrupawebapis.azurewebsites.net/api/User/UserDetails'}");  // ✅ This prints the URL

      final response = await Dio().get(
        "https://gurukrupawebapis.azurewebsites.net/api/User/UserDetails",
        options: Options(
          headers: {
            "accept": "*/*",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        GetRoleModel model = GetRoleModel.fromJson(response.data);
        print("get Profile FetchedDDDDDDD: ${model.data?.employeeName}");

        getRole.value = model;
        update();

        return model;
      } else {
        print("API Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      Utils().showToast(message: "Error fetching profile", context: Get.context!);
      return null;
    }finally {
      // Loading.dismiss();
    }
  }

  void fetchAndSetRole() async {
    final roleModel = await getRoleApi();
    if (roleModel != null && roleModel.data != null) {
      collectedByController.text = roleModel.data!.employeeName;
    }
  }

  @override
  void onInit() {
    apiCallReceiptList();
    apiCallCashBankBook();
    apiCallPaidBy();
    fetchAndSetRole();
    Constants.BillDataList.clear();
    startDateController.text =
        DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
    endDateController.text =
        DateFormat("dd/MM/yyyy").format(DateTime.now()).toString();
    // print("Role at ReceiptController onInit: ${GetStorageData.readString(GetStorageData.role)}");
    //
    // updateCollectedBy();


    branchController.text = "Main Branch";
    super.onInit();
  }
}
