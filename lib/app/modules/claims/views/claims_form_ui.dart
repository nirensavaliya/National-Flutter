import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/data/common_widget/common_textfeild.dart';

import '../../../commons/all.dart';
import '../../bottom_bar/model/customer_model.dart';
import '../controllers/claims_controller.dart';
import '../models/claim_model.dart';

class ClaimsHeaderCard extends StatelessWidget {
  const ClaimsHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SplashColors.primary.withOpacity(0.1)),
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
            'Claims',
            style: TextStyle(
              fontFamily: FontFamily.semiBold,
              fontSize: FontSize.s20,
              color: SplashColors.primaryDark,
            ),
          ),
          const Gap(4),
          Text(
            'Manage mattress warranty claims',
            style: TextStyle(
              fontFamily: FontFamily.regular,
              fontSize: FontSize.s14,
              color: const Color(0xFF78829A),
            ),
          ),
        ],
      ),
    );
  }
}

class ClaimsToolbar extends GetView<ClaimsController> {
  const ClaimsToolbar({
    super.key,
    required this.onNewClaim,
  });

  final VoidCallback onNewClaim;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: SplashColors.primary.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: onNewClaim,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: SplashColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: 20),
                  label: Text(
                    'New Claim',
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: FontSize.s14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Gap(12),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: controller.searchController,
                  onChanged: controller.onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search by dealer, serial, invoice...',
                    hintStyle: TextStyle(
                      fontFamily: FontFamily.regular,
                      fontSize: FontSize.s12,
                      color: const Color(0xFF78829A),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF4F7F7),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: SplashColors.primary,
                      size: 22,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const Gap(10),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F7F7),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: SplashColors.primary.withOpacity(0.15),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedStatusFilter,
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: SplashColors.primary,
                      ),
                      items: controller.statusFilters
                          .map(
                            (status) => DropdownMenuItem(
                          value: status,
                          child: Text(
                            status,
                            style: TextStyle(
                              fontFamily: FontFamily.medium,
                              fontSize: FontSize.s12,
                              color: SplashColors.primaryDark,
                            ),
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: controller.onStatusFilterChanged,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ClaimStatusBadge extends StatelessWidget {
  const ClaimStatusBadge({super.key, required this.status});

  final String status;

  Color get _backgroundColor {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFFD1FAE5);
      case 'rejected':
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFFFEF3C7);
    }
  }

  Color get _textColor {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFF065F46);
      case 'rejected':
        return const Color(0xFF991B1B);
      default:
        return const Color(0xFF92400E);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontFamily: FontFamily.bold,
          fontSize: FontSize.s10,
          color: _textColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class ClaimListCard extends StatelessWidget {
  const ClaimListCard({super.key, required this.claim});

  final ClaimModel claim;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: SplashColors.primary.withOpacity(0.1)),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClaimStatusBadge(status: claim.status),
                    const Gap(8),
                    Text(
                      'Claim number: ${claim.claimNumber}',
                      style: TextStyle(
                        fontFamily: FontFamily.medium,
                        fontSize: FontSize.s12,
                        color: const Color(0xFF78829A),
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  claim.summaryTitle,
                  style: TextStyle(
                    fontFamily: FontFamily.semiBold,
                    fontSize: FontSize.s14,
                    color: SplashColors.primaryDark,
                  ),
                ),
                const Gap(6),
                Text(
                  'Customer: ${claim.customerName} · ${claim.customerMobile}',
                  style: TextStyle(
                    fontFamily: FontFamily.regular,
                    fontSize: FontSize.s12,
                    color: const Color(0xFF78829A),
                  ),
                ),
                const Gap(4),
                Text(
                  'Dealer: ${claim.dealerName}${claim.invoiceNumber != null ? ' · Invoice: ${claim.invoiceNumber}' : ''}',
                  style: TextStyle(
                    fontFamily: FontFamily.regular,
                    fontSize: FontSize.s12,
                    color: const Color(0xFF78829A),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: SplashColors.primary,
          ),
        ],
      ),
    );
  }
}

class SelectDealerField extends StatelessWidget {
  const SelectDealerField({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClaimsController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SELECT DEALER *',
          style: TextStyle(
            fontFamily: FontFamily.semiBold,
            fontSize: FontSize.s14,
            color: const Color(0xFF78829A),
            letterSpacing: 0.4,
          ),
        ),
        const Gap(8),
        CommonTextField(
          borderRadius: 12,
          controller: controller.dealerSearchController,
          hintText: 'Search dealer by name or mobile...',
          prefix: const Icon(Icons.search, color: SplashColors.primary),
          onTap: controller.openDealerDropdown,
          onChanged: controller.onDealerSearchChanged,
        ),
        GetBuilder<ClaimsController>(
          id: 'dealer_dropdown',
          builder: (controller) {
            if (!controller.showDealerDropdown) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.only(top: 6),
              child: _DealerDropdownPanel(controller: controller),
            );
          },
        ),
      ],
    );
  }
}

class _DealerDropdownPanel extends StatelessWidget {
  const _DealerDropdownPanel({required this.controller});

  final ClaimsController controller;

  @override
  Widget build(BuildContext context) {
    final query = controller.dealerSearchController.text.trim();
    final dealers = controller.dealerSearchResults;

    return Material(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.12),
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 220),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: SplashColors.primary.withOpacity(0.12)),
        ),
        child: query.isEmpty
            ? _emptyHint('Type dealer name or mobile to search')
            : dealers.isEmpty
            ? _emptyHint('No dealer found')
            : ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemCount: dealers.length,
          separatorBuilder: (_, __) => Divider(
            height: 1,
            color: SplashColors.primary.withOpacity(0.08),
          ),
          itemBuilder: (context, index) {
            final dealer = dealers[index];
            final isSelected =
                controller.selectedDealerId == dealer.customerID;

            return _DealerListTile(
              dealer: dealer,
              isSelected: isSelected,
              onTap: () => controller.selectDealer(dealer),
            );
          },
        ),
      ),
    );
  }

  Widget _emptyHint(String message) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
      child: Text(
        message,
        style: TextStyle(
          fontFamily: FontFamily.regular,
          fontSize: FontSize.s14,
          color: const Color(0xFF78829A),
        ),
      ),
    );
  }
}

class _DealerListTile extends StatelessWidget {
  const _DealerListTile({
    required this.dealer,
    required this.isSelected,
    required this.onTap,
  });

  final CustomerData dealer;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final name = dealer.customerName ?? '';
    final mobile = dealer.contactNo ?? '';

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        splashColor: SplashColors.primary.withOpacity(0.12),
        highlightColor: SplashColors.primary.withOpacity(0.08),
        child: Ink(
          decoration: BoxDecoration(
            color: isSelected
                ? SplashColors.primary.withOpacity(0.15)
                : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                if (isSelected)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.check_circle,
                      color: SplashColors.primary,
                      size: 18,
                    ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSize.s14,
                          color: isSelected
                              ? SplashColors.primary
                              : SplashColors.primaryDark,
                        ),
                      ),
                      if (mobile.isNotEmpty) ...[
                        const Gap(2),
                        Text(
                          mobile,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewClaimDialog extends GetView<ClaimsController> {
  const NewClaimDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final maxScrollHeight = MediaQuery.of(context).size.height * 0.72;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: SplashColors.primaryDeep.withOpacity(0.2),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 12, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Submit New Claim',
                      style: TextStyle(
                        fontFamily: FontFamily.semiBold,
                        fontSize: FontSize.s18,
                        color: SplashColors.primaryDark,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.close,
                      color: SplashColors.primaryDark,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 20),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SelectDealerField(),
                    const Gap(20),
                    _sectionDivider('Customer Details'),
                    const Gap(14),
                    _sectionLabel('CUSTOMER NAME *'),
                    const Gap(6),
                    CommonTextField(
                      borderRadius: 12,
                      controller: controller.customerNameController,
                      hintText: 'Enter customer name',
                    ),
                    const Gap(12),
                    _sectionLabel('CUSTOMER MOBILE NUMBER *'),
                    const Gap(6),
                    CommonTextField(
                      borderRadius: 12,
                      controller: controller.customerMobileController,
                      hintText: '10 digit mobile number',
                      maxLength: 10,
                      textInputType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                    const Gap(20),
                    _sectionDivider('Invoice Details'),
                    const Gap(10),
                    _sectionLabel('INVOICE NUMBER / BILL NUMBER (OPTIONAL)'),
                    const Gap(6),
                    CommonTextField(
                      borderRadius: 12,
                      controller: controller.invoiceNumberController,
                      hintText: 'Invoice #',
                    ),
                    const Gap(12),
                    _sectionLabel('BILL DATE (OPTIONAL)'),
                    const Gap(6),
                    CommonTextField(
                      borderRadius: 12,
                      controller: controller.billDateController,
                      hintText: 'dd/mm/yyyy',
                      readOnly: true,
                      showCursor: false,
                      onTap: () => controller.selectBillDate(context),
                      suffix: GestureDetector(
                        onTap: () => controller.selectBillDate(context),
                        child: const Icon(
                          Icons.calendar_month,
                          color: SplashColors.primary,
                        ),
                      ),
                    ),
                    const Gap(20),
                    _sectionLabel('COMPANY DESCRIPTION *'),
                    const Gap(8),
                    CommonTextField(
                      borderRadius: 12,
                      controller: controller.companyDescriptionController,
                      hintText: 'Describe the issue in detail...',
                      maxLine: 4,
                    ),
                    const Gap(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () => Get.back(),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: SplashColors.primary.withOpacity(0.4),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontFamily: FontFamily.medium,
                              color: SplashColors.primaryDark,
                            ),
                          ),
                        ),
                        const Gap(12),
                        ElevatedButton(
                          onPressed: controller.submitClaim,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: SplashColors.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Submit Claim',
                            style: TextStyle(
                              fontFamily: FontFamily.semiBold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: FontFamily.semiBold,
        fontSize: FontSize.s14,
        color: const Color(0xFF78829A),
        letterSpacing: 0.4,
      ),
    );
  }

  Widget _sectionDivider(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Color(0xFFE8EDED)),
        const Gap(12),
        Text(
          title,
          style: TextStyle(
            fontFamily: FontFamily.semiBold,
            fontSize: FontSize.s18,
            color: SplashColors.primaryDark,
          ),
        ),
      ],
    );
  }
}

void showNewClaimDialog(ClaimsController controller) {
  controller.prepareNewClaimForm();
  Get.dialog(
    const NewClaimDialog(),
    barrierDismissible: false,
  );
}
