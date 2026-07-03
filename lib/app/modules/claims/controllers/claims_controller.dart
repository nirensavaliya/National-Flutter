import 'dart:async';

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
  final invoiceNumberController = TextEditingController();
  final billDateController = TextEditingController();
  final companyDescriptionController = TextEditingController();

  String selectedStatusFilter = 'Pending';
  String? selectedDealerName;
  String? selectedDealerMobile;
  int? selectedDealerId;
  bool showDealerDropdown = false;
  List<CustomerData> dealerSearchResults = [];

  Timer? _dealerSearchTimer;
  static const int _maxDealerResults = 40;
  static const _dealerDropdownId = 'dealer_dropdown';

  final List<ClaimModel> claims = [];
  int claimCounter = 1;

  final List<String> statusFilters = [
    'All',
    'Pending',
    'Approved',
    'Rejected',
  ];

  List<ClaimModel> get filteredClaims {
    Iterable<ClaimModel> list = claims;

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

    if (selectedStatusFilter != 'All') {
      list = list.where(
            (claim) =>
        claim.status.toLowerCase() == selectedStatusFilter.toLowerCase(),
      );
    }

    return list.toList().reversed.toList();
  }

  void onSearchChanged(String _) {
    update();
  }

  void onStatusFilterChanged(String? value) {
    if (value == null) return;
    selectedStatusFilter = value;
    update();
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

    update([_dealerDropdownId]);
  }

  void selectDealer(CustomerData dealer) {
    selectedDealerId = dealer.customerID;
    selectedDealerName = dealer.customerName ?? '';
    selectedDealerMobile = dealer.contactNo ?? '';
    dealerSearchController.text = selectedDealerName ?? '';
    showDealerDropdown = false;
    dealerSearchResults = [];
    update([_dealerDropdownId]);
  }

  void clearForm() {
    _dealerSearchTimer?.cancel();
    dealerSearchController.clear();
    customerNameController.clear();
    customerMobileController.clear();
    invoiceNumberController.clear();
    billDateController.clear();
    companyDescriptionController.clear();
    selectedDealerId = null;
    selectedDealerName = null;
    selectedDealerMobile = null;
    showDealerDropdown = false;
    dealerSearchResults = [];
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
    update([_dealerDropdownId]);
  }

  void submitClaim() {
    final dealer = selectedDealerName ?? dealerSearchController.text.trim();
    final customerName = customerNameController.text.trim();
    final customerMobile = customerMobileController.text.trim();
    final description = companyDescriptionController.text.trim();

    if (dealer.isEmpty) {
      _showError('Please select a dealer.');
      return;
    }
    if (customerName.isEmpty) {
      _showError('Please enter customer name.');
      return;
    }
    if (customerMobile.isEmpty || customerMobile.length != 10) {
      _showError('Please enter a valid 10 digit mobile number.');
      return;
    }
    if (description.isEmpty) {
      _showError('Please enter company description.');
      return;
    }

    claims.add(
      ClaimModel(
        claimNumber: claimCounter,
        status: 'pending',
        dealerName: dealer,
        customerName: customerName,
        customerMobile: customerMobile,
        invoiceNumber: invoiceNumberController.text.trim().isEmpty
            ? null
            : invoiceNumberController.text.trim(),
        billDate: billDateController.text.trim().isEmpty
            ? null
            : billDateController.text.trim(),
        companyDescription: description,
        createdAt: DateTime.now(),
      ),
    );
    claimCounter++;
    Get.back();
    Get.snackbar(
      'Success',
      'Claim submitted successfully.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 70),
      backgroundColor: SplashColors.primary,
      colorText: Colors.white,
    );
    update();
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 70),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  @override
  void onClose() {
    _dealerSearchTimer?.cancel();
    searchController.dispose();
    dealerSearchController.dispose();
    customerNameController.dispose();
    customerMobileController.dispose();
    invoiceNumberController.dispose();
    billDateController.dispose();
    companyDescriptionController.dispose();
    super.onClose();
  }
}
