import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:gurukrupa/app/api_common/api_function.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/modules/claims/models/Claim_detail_Model.dart';
import 'package:gurukrupa/app/modules/claims/views/claims_form_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';

import '../../../commons/all.dart';
import '../../../commons/constants.dart';
import '../../bottom_bar/model/customer_model.dart';
import '../models/claim_model.dart';

class ClaimsController extends GetxController {
  final searchController = TextEditingController();
  final dealerSearchController = TextEditingController();
  final customerNameController = TextEditingController();
  final customerMobileController = TextEditingController();
  final billNumberContact = TextEditingController();
  final billDateController = TextEditingController();
  final companyDescriptionController = TextEditingController();


  final itemBrandController = TextEditingController();
  final itemNameController = TextEditingController();
  final serialNumberController = TextEditingController();
  String selectedStatusFilter = 'All';
  String? selectedDealerName;
  String? selectedDealerMobile;
  int? selectedDealerId;
  bool showDealerDropdown = false;
  List<CustomerData> dealerSearchResults = [];
  List<ClaimDetail> claimDetailsList = [];
  Timer? _dealerSearchTimer;
  static const int _maxDealerResults = 40;
  static const _dealerDropdownId = 'dealer_dropdown';

  final List<ClaimModel> claims = [];
  int claimCounter = 1;
  List<ClaimModel> claimList = [];
  bool isLoading = false;
  bool isEditMode = false;
  int? editingClaimId;
  bool showItemFields = false;
  int? editingItemIndex;
  final ImagePicker picker = ImagePicker();
  File? selectedImage;
  String imageBase64 = "";
  String editingStatus = "";
  final List<String> statusFilters = [
    'All',
    'Pending',
    'Approved',
    'Rejected',
  ];
  final bool isCustomer =
      GetStorageData.readString(GetStorageData.role) == "Customer";
  CustomerData? loggedInCustomer;
  List<ClaimModel> get filteredClaims {
    // Iterable<ClaimModel> list = claims;
    Iterable<ClaimModel> list = claimList;
    final query = searchController.text.trim().toLowerCase();
    if (query.isNotEmpty) {
      list = list.where((claim) {
        return claim.dealerName.toLowerCase().contains(query) ||
            claim.customerName.toLowerCase().contains(query) ||
            (claim.invoiceNumber ?? '').toLowerCase().contains(query) ||
            claim.claimNumber.toString().contains(query) ||
            claim.customerMobile.contains(query);
      });
    }

    if (selectedStatusFilter != "All") {
      list = list.where((claim) {
        final status = claim.status.toLowerCase();

        switch (selectedStatusFilter) {
          case "Pending":
            return status == "pending";

          case "Approved":
            return status == "approved" ||
                status == "completed" ||
                status == "complate";

          case "Rejected":
            return status == "rejected";

          default:
            return true;
        }
      });
    }

    return list.toList().reversed.toList();
  }

  @override
  void onInit() {
    super.onInit();
    getClaimList();
    if (GetStorageData.readString(GetStorageData.role) == "Customer") {
      getCustomerDetails();
    }
  }

  void onSearchChanged(String _) {
    update();
  }

  void onStatusFilterChanged(String? value) {
    if (value == null) return;
    selectedStatusFilter = value;
    update();
  }
  Future<void> getCustomerDetails() async {
    final context = Get.context;
    if (context == null) return;

    final response = await GetAPIFunction().apiCall(
      apiName: Constants.GetCustomerDetails,
      context: context,
    );

    final json =
    response is String ? jsonDecode(response) : response.data ?? response;

    if (json["statusCode"] == 200) {
      loggedInCustomer = CustomerData.fromJson(json["data"]);

      dealerSearchResults.clear();
      dealerSearchResults.add(loggedInCustomer!);

      selectedDealerId = loggedInCustomer!.customerID;
      selectedDealerName = loggedInCustomer!.customerName;
      selectedDealerMobile = loggedInCustomer!.contactNo;

      dealerSearchController.text = loggedInCustomer!.customerName ?? "";
      customerNameController.text = loggedInCustomer!.customerName ?? "";
      customerMobileController.text = loggedInCustomer!.contactNo ?? "";

      update();
    }
  }

  Future<void> saveClaim() async {
    final billDate =
    DateFormat('dd/MM/yyyy').parse(billDateController.text);
    final context = Get.context;
    if (context == null) return;
    try {
      final String dataRaw = jsonEncode({
        "dealerId": selectedDealerId ?? 0,
        "customerName": customerNameController.text.trim(),
        "customerMobileNo": customerMobileController.text.trim(),
        "billNumber": billNumberContact.text.trim(),
        "billDate": billDate.toUtc().toIso8601String(),
        "description": companyDescriptionController.text.trim(),
        "status": "Pending",
        "rejectReason": "",
        "claimDetails": claimDetailsList
            .map(
              (e) => {
            "itemBrand": e.itemBrand,
            "itemName": e.itemName,
            "serialNumber": e.serialNumber,
          },
        ).toList(),
      });
      print("Claim Details Length : ${claimDetailsList.length}");
      print("boddyyyy---${jsonEncode(dataRaw)}");
      print("Claim Details : ${jsonEncode(
        claimDetailsList.map((e) => e.toJson()).toList(),
      )}");
      final data = await APIFunction().apiCall(
        apiName: Constants.saveClaim,
        context: context,
        rawData: dataRaw,
      );

      final responseData = data is String ? jsonDecode(data) : data;
      print("Claim Response------${responseData}");
      print(responseData["statusCode"]);
      if (responseData["statusCode"] == 200) {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        clearForm();
        await getClaimList();
        Get.snackbar(
          "Success",
          responseData["responseMsg"] ?? "Claim saved successfully",
          snackPosition: SnackPosition.TOP,

        );
        update();
      } else {
        Get.snackbar(
          "Error",
          responseData["responseMsg"] ?? "Something went wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar("Save Claim Error", e.toString());
    }
  }


  void addCurrentItemToList() {
    if (itemBrandController.text.trim().isEmpty ||
        itemNameController.text.trim().isEmpty ||
        serialNumberController.text.trim().isEmpty) {
      return;
    }

    claimDetailsList.add(
      ClaimDetail(
        itemBrand: itemBrandController.text.trim(),
        itemName: itemNameController.text.trim(),
        serialNumber: serialNumberController.text.trim(),
      ),
    );

    update();
  }
  void saveSameItem() {
    if (itemBrandController.text.trim().isEmpty ||
        itemNameController.text.trim().isEmpty ||
        serialNumberController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    if (editingItemIndex != null) {
      claimDetailsList[editingItemIndex!] = ClaimDetail(
        itemBrand: itemBrandController.text.trim(),
        itemName: itemNameController.text.trim(),
        serialNumber: serialNumberController.text.trim(),
      );

      editingItemIndex = null;
    } else {
      claimDetailsList.add(
        ClaimDetail(
          itemBrand: itemBrandController.text.trim(),
          itemName: itemNameController.text.trim(),
          serialNumber: serialNumberController.text.trim(),
        ),
      );
    }

    showItemFields = true;

    update();
  }
  void onAddItemClick() {

    if (!showItemFields) {
      showItemFields = true;
      update();
      return;
    }

    if (itemBrandController.text.trim().isEmpty ||
        itemNameController.text.trim().isEmpty ||
        serialNumberController.text.trim().isEmpty) {
      return;
    }

    if (editingItemIndex != null) {
      claimDetailsList[editingItemIndex!] = ClaimDetail(
        itemBrand: itemBrandController.text.trim(),
        itemName: itemNameController.text.trim(),
        serialNumber: serialNumberController.text.trim(),
      );
    } else {
      claimDetailsList.add(
        ClaimDetail(
          itemBrand: itemBrandController.text.trim(),
          itemName: itemNameController.text.trim(),
          serialNumber: serialNumberController.text.trim(),
        ),
      );
    }

    editingItemIndex = null;

    itemBrandController.clear();
    itemNameController.clear();
    serialNumberController.clear();

    showItemFields = true;

    update();
  }
  void editItem(int index) {
    editingItemIndex = index;

    itemBrandController.text = claimDetailsList[index].itemBrand;
    itemNameController.text = claimDetailsList[index].itemName;
    serialNumberController.text = claimDetailsList[index].serialNumber;

    showItemFields = true;
    update();
  }


  Future<void> updateClaim(int claimId) async {
    final context = Get.context;
    if (context == null) return;

    try {
      final billDate =
      DateFormat('dd/MM/yyyy').parse(billDateController.text.trim());

      final body = jsonEncode({
        "dealerId": selectedDealerId ?? 0,
        "customerName": customerNameController.text.trim(),
        "customerMobileNo": customerMobileController.text.trim(),
        "billNumber": billNumberContact.text.trim(),
        "billDate": billDate.toUtc().toIso8601String(),
        "description": companyDescriptionController.text.trim(),
        "status": editingStatus,
        "rejectReason": "",
        "claimDetails": claimDetailsList
            .map((e) => {
          "itemBrand": e.itemBrand,
          "itemName": e.itemName,
          "serialNumber": e.serialNumber,
        })
            .toList(),
      });
       print("updated bodyyy------${body}");
      final data = await APIFunction().apiCall(
        apiName: "${Constants.updateClaim}/$claimId",
        context: context,
        rawData: body,
      );

      final response = data is String ? jsonDecode(data) : data;

      if (response["statusCode"] == 200) {

        isEditMode = false;
        editingClaimId = null;

        if (Get.isDialogOpen ?? false) {
          Get.back();
        }

        clearForm();

        await getClaimList();

        Get.snackbar(
          "Success",
          response["responseMsg"] ?? "Claim updated successfully",
        );

        update();
      }else {
        Get.snackbar(
          "Error",
          response["responseMsg"] ?? "Something went wrong",
        );
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
  void openEditDialog(ClaimModel claim) {

    isEditMode = true;
    editingClaimId = claim.claimId;
    selectedDealerId = claim.dealerId;
    customerNameController.text = claim.customerName;
    customerMobileController.text = claim.customerMobile;
    billNumberContact.text = claim.invoiceNumber ?? "";
    if (claim.billDate != null && claim.billDate!.isNotEmpty) {
      try {
        billDateController.text = DateFormat(
          'dd/MM/yyyy',
        ).format(DateTime.parse(claim.billDate!));
      } catch (e) {
        billDateController.text = "";
      }
    } else {
      billDateController.text = "";
    }
    companyDescriptionController.text = claim.companyDescription;
    editingStatus = claim.status;
    dealerSearchController.text = claim.dealerName;

    claimDetailsList.clear();
    claimDetailsList.addAll(claim.claimDetails);

    showItemFields = false;

    Get.dialog(
      const NewClaimDialog(),
      barrierDismissible: false,
    );

    update();
  }




  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      selectedImage = File(image.path);
      update();
    }
  }

  Future<String> getBase64Image() async {
    if (selectedImage == null) {
      return "";
    }

    final bytes = await selectedImage!.readAsBytes();
    return base64Encode(bytes);
  }
  Future<void> updateClaimStatus(
      int claimId,
      String status,
      double expenseAmount,
      ) async {

    final context = Get.context;
    if (context == null) return;

    String imageBase64 = "";

    if (selectedImage != null) {
      final bytes = await selectedImage!.readAsBytes();
      imageBase64 = base64Encode(bytes);
    }

    final body = jsonEncode({
      "status": status,
      "expenseAmount": expenseAmount,
      "imageBase64string": imageBase64,
    });

    print("body----${body}");

    final data = await APIFunction().apiCall(
      apiName: "${Constants.updateClaimStatus}/$claimId",
      context: context,
      rawData: body,
    );

    final response = data is String ? jsonDecode(data) : data;

    print("Status response----${response}");
    if (response["statusCode"] == 200) {
      Get.back();
      await getClaimList();
      Get.snackbar(
        "Success",
        response["responseMsg"] ?? "Status Updated",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Error",
        response["responseMsg"] ?? "Something went wrong",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
  Future<void> getClaimList() async {
    final context = Get.context;
    if (context == null) return;

    try {
      isLoading = true;
      update();

      final body = jsonEncode({
        "fromDate": DateTime.now()
            .subtract(const Duration(days: 30))
            .toUtc()
            .toIso8601String(),
        "toDate": DateTime.now()
            .toUtc()
            .toIso8601String(),
        "dealerId": 0,
        "salesPersonId": 0,
        "status": ""
      });

      final data = await APIFunction().apiCall(
        apiName: Constants.claimList,
        context: context,
        rawData: body,
      );

      final response = data is String ? jsonDecode(data) : data;
      print("claim list-------${response}");
      print(response["data"]);
      print(response["data"].runtimeType);
      for (var e in response["data"]) {
        print("ClaimId: ${e["claimId"]} Status: '${e["status"]}'");
      }
      if (response["statusCode"] == 200) {
        claimList = (response["data"] as List)
            .map((e) => ClaimModel.fromJson(e))
            .toList()
            .reversed
            .toList();
      }
      else {
        claimList.clear();
      }
    } catch (e) {
      update();
      Get.snackbar("Error", e.toString());
    }
    finally {
      isLoading = false;
      update();
    }
  }


  void openDealerDropdown() {
    showDealerDropdown = true;
    _refreshDealerResults(dealerSearchController.text);
  }

  void closeDealerDropdown() {
    showDealerDropdown = false;
    update([_dealerDropdownId]);
  }

  void onDealerSearchChanged(String value) {
    if (selectedDealerName != null && value.trim() != selectedDealerName) {
      selectedDealerId = null;
      selectedDealerName = null;
      selectedDealerMobile = null;
    }

    showDealerDropdown = true;
    _dealerSearchTimer?.cancel();
    _dealerSearchTimer = Timer(const Duration(milliseconds: 280), () {
      _refreshDealerResults(value);
    });
  }

  void _refreshDealerResults(String query) {
    if (isCustomer) {
      dealerSearchResults.clear();

      if (loggedInCustomer != null) {
        dealerSearchResults.add(loggedInCustomer!);
      }

      update(['dealer_dropdown']);
      return;
    }


    final q = query.trim().toLowerCase();

    if (q.isEmpty) {
      dealerSearchResults = [];
    } else {
      dealerSearchResults = Constants.customerList
          .where((customer) {
        final name = (customer.customerName ?? '').toLowerCase();
        final mobile = customer.contactNo ?? '';
        return name.contains(q) || mobile.contains(q);
      })
          .take(_maxDealerResults)
          .toList();
    }

    update(['dealer_dropdown']);
  }
  void selectDealer(CustomerData dealer) {
    selectedDealerId = dealer.customerID;
    selectedDealerName = dealer.customerName;

    dealerSearchController.text = dealer.customerName ?? "";

    customerNameController.text = dealer.customerName ?? "";
    customerMobileController.text = dealer.contactNo ?? "";

    showDealerDropdown = false;

    update(['dealer_dropdown']);
    update();
  }

  void clearForm() {
    _dealerSearchTimer?.cancel();
    dealerSearchController.clear();
    customerNameController.clear();
    customerMobileController.clear();
    billNumberContact.clear();
    billDateController.clear();
    companyDescriptionController.clear();
    selectedDealerId = null;
    selectedDealerName = null;
    selectedDealerMobile = null;
    showDealerDropdown = false;
    dealerSearchResults = [];
    showItemFields = false;
    claimDetailsList.clear();

    itemBrandController.clear();
    itemNameController.clear();
    serialNumberController.clear();
  }

  Future<void> selectBillDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      billDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      update();
    }
  }

  void prepareNewClaimForm() {
    clearForm();

    if (isCustomer && loggedInCustomer != null) {
      dealerSearchController.text = loggedInCustomer!.customerName ?? "";
      customerNameController.text = loggedInCustomer!.customerName ?? "";
      customerMobileController.text = loggedInCustomer!.contactNo ?? "";
      selectedDealerId = loggedInCustomer!.customerID;
      dealerSearchResults = [loggedInCustomer!];
    }

    update();
  }

  // void submitClaim() {
  //   final dealer = selectedDealerName ?? dealerSearchController.text.trim();
  //   final customerName = customerNameController.text.trim();
  //   final customerMobile = customerMobileController.text.trim();
  //   final description = companyDescriptionController.text.trim();
  //
  //   if (dealer.isEmpty) {
  //     _showError('Please select a dealer.');
  //     return;
  //   }
  //   if (customerName.isEmpty) {
  //     _showError('Please enter customer name.');
  //     return;
  //   }
  //   if (customerMobile.isEmpty || customerMobile.length != 10) {
  //     _showError('Please enter a valid 10 digit mobile number.');
  //     return;
  //   }
  //   if (description.isEmpty) {
  //     _showError('Please enter company description.');
  //     return;
  //   }
  //
  //   claims.add(
  //     ClaimModel(
  //       claimNumber: claimCounter,
  //       status: 'pending',
  //       dealerName: dealer,
  //       customerName: customerName,
  //       customerMobile: customerMobile,
  //       invoiceNumber: billNumberContact.text.trim().isEmpty
  //           ? null

  //           : billNumberContact.text.trim(),
  //       billDate: billDateController.text.trim().isEmpty
  //           ? null
  //           : billDateController.text.trim(),
  //       companyDescription: description,
  //       createdAt: DateTime.now(), claimDetails: [],
  //     ),
  //   );
  //   claimCounter++;
  //   Get.back();
  //   Get.snackbar(
  //     'Success',
  //     'Claim submitted successfully.',
  //     snackPosition: SnackPosition.BOTTOM,
  //     margin: const EdgeInsets.only(left: 10, right: 10, bottom: 70),
  //     backgroundColor: SplashColors.primary,
  //     colorText: Colors.white,
  //   );
  //   update();
  // }

  // void _showError(String message) {
  //   Get.snackbar(
  //     'Error',
  //     message,
  //     snackPosition: SnackPosition.BOTTOM,
  //     margin: const EdgeInsets.only(left: 10, right: 10, bottom: 70),
  //     backgroundColor: Colors.red,
  //     colorText: Colors.white,
  //   );
  // }

  @override
  void onClose() {
    _dealerSearchTimer?.cancel();
    searchController.dispose();
    dealerSearchController.dispose();
    customerNameController.dispose();
    customerMobileController.dispose();
    billNumberContact.dispose();
    billDateController.dispose();
    companyDescriptionController.dispose();
    super.onClose();
  }
}
