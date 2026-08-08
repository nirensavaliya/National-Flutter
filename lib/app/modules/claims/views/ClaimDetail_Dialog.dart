import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/commons/font_family.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/data/common_widget/common_button.dart';
import 'package:gurukrupa/app/modules/claims/controllers/claims_controller.dart';
import 'package:gurukrupa/app/modules/claims/models/claim_model.dart';
import 'package:intl/intl.dart';

class ClaimDetailsDialog extends StatelessWidget {
  ClaimDetailsDialog({
    super.key,
    required this.claim,
  });

  final ClaimModel claim;
  final controller = Get.find<ClaimsController>();
  final bool isCustomer =
      GetStorageData.readString(GetStorageData.role) == "Customer";
  final TextEditingController expenseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(18),
      child: GetBuilder<ClaimsController>(
        builder: (_) {
          return Container(
            width: 560,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.18),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 12, 18),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        SplashColors.nightSkyMid,
                        SplashColors.nightSky,
                        SplashColors.nightSkyDeep,
                      ],
                    ),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Claim Details",
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: FontFamily.PlayfairDisplayBold,
                                color: SplashColors.text,
                              ),
                            ),
                            const Gap(6),
                            Container(
                              width: 42,
                              height: 3,
                              decoration: BoxDecoration(
                                color: SplashColors.accent,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: _InfoTile(
                                title: "Claim Number",
                                value: claim.claimNumber.toString(),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: _InfoTile(
                                title: "Status",
                                value: claim.status,
                                isHighlight: true,
                              ),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            Expanded(
                              child: _InfoTile(
                                title: "Dealer",
                                value: claim.dealerName,
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: _InfoTile(
                                title: "Customer Name",
                                value: claim.customerName,
                              ),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            Expanded(
                              child: _InfoTile(
                                title: "Customer Mobile",
                                value: claim.customerMobile,
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: _InfoTile(
                                title: "Invoice Number",
                                value: claim.invoiceNumber ?? "-",
                              ),
                            ),
                          ],
                        ),
                        const Gap(10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _InfoTile(
                                title: "Bill Date",
                                value: formatBillDate(claim.billDate),
                              ),
                            ),
                            const Gap(10),
                            Expanded(
                              child: _InfoTile(
                                title: "Description",
                                value: claim.companyDescription,
                              ),
                            ),
                          ],
                        ),
                        const Gap(18),
                        _SectionTitle(title: 'Claim Items'),
                        const Gap(10),
                        ...claim.claimDetails.map(
                          (e) => Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: SplashColors.accent.withOpacity(0.18),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: _InfoTile(
                                        title: "Brand",
                                        value: "${e.itemBrand}",
                                        compact: true,
                                      ),
                                    ),
                                    const Gap(10),
                                    Expanded(
                                      child: _InfoTile(
                                        title: "Item",
                                        value: "${e.itemName}",
                                        compact: true,
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(10),
                                _InfoTile(
                                  title: "Serial",
                                  value: "${e.serialNumber}",
                                  compact: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (!isCustomer) ...[
                          const Gap(8),
                          _SectionTitle(title: 'Expense'),
                          const Gap(10),
                          ExpenseField(controller: expenseController),
                          const Gap(18),
                          Text(
                            "Image",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: FontFamily.semiBold,
                              color: SplashColors.nightSky,
                            ),
                          ),
                          const Gap(8),
                          Row(
                            children: [
                              Expanded(
                                child: CommonButton(
                                  btnName: "Choose File",
                                  btnColor: SplashColors.accent,
                                  textColor: SplashColors.nightSkyDeep,
                                  onTap: () async {
                                    await controller.pickImage();
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  controller.selectedImage == null
                                      ? "No file chosen"
                                      : controller.selectedImage!.path.split('/').last,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                          if (controller.selectedImage != null) ...[
                            const SizedBox(height: 12),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                controller.selectedImage!,
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (controller.selectedImage == null) {
                                  Get.snackbar(
                                    "Image Required",
                                    "Please select claim image",
                                    snackPosition: SnackPosition.TOP,
                                  );
                                  return;
                                }

                                await controller.updateClaimStatus(
                                  claim.claimId!,
                                  "Complate",
                                  double.tryParse(expenseController.text.trim()) ?? 0,
                                );

                                Get.back();
                                controller.getClaimList();

                                Get.snackbar(
                                  "Success",
                                  "Claim Approved Successfully",
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: SplashColors.accent,
                                foregroundColor: SplashColors.nightSkyDeep,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Approve",
                                style: TextStyle(
                                  color: SplashColors.nightSkyDeep,
                                  fontFamily: FontFamily.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SizedBox(
                            width: double.infinity,
                            height: 48,
                            child: OutlinedButton(
                              onPressed: () async {
                                await controller.updateClaimStatus(
                                  claim.claimId!,
                                  "Rejected",
                                  double.tryParse(expenseController.text.trim()) ?? 0,
                                );

                                Get.back();
                                controller.getClaimList();

                                Get.snackbar(
                                  "Success",
                                  "Claim Rejected Successfully",
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: SplashColors.nightSky,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                "Reject",
                                style: TextStyle(
                                  color: SplashColors.nightSky,
                                  fontFamily: FontFamily.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String formatBillDate(String? date) {
    if (date == null || date.isEmpty) return "-";

    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat("dd-MM-yyyy").format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: FontFamily.PlayfairDisplayBold,
        fontSize: 18,
        color: SplashColors.nightSky,
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.title,
    required this.value,
    this.isHighlight = false,
    this.compact = false,
  });

  final String title;
  final String value;
  final bool isHighlight;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(compact ? 12 : 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isHighlight
              ? SplashColors.accent.withOpacity(0.35)
              : SplashColors.nightSky.withOpacity(0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: FontFamily.bold,
              color: const Color(0xFF78829A),
              fontSize: 12,
            ),
          ),
          const Gap(4),
          Text(
            value,
            style: TextStyle(
              fontFamily: FontFamily.medium,
              fontSize: 14,
              color: isHighlight ? SplashColors.accent : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpenseField extends StatefulWidget {
  final TextEditingController controller;

  const ExpenseField({
    super.key,
    required this.controller,
  });

  @override
  State<ExpenseField> createState() => _ExpenseFieldState();
}

class _ExpenseFieldState extends State<ExpenseField> {
  double get value => double.tryParse(widget.controller.text) ?? 0.00;

  void increment() {
    widget.controller.text = (value + 1).toStringAsFixed(2);
    setState(() {});
  }

  void decrement() {
    if (value > 0) {
      widget.controller.text = (value - 1).toStringAsFixed(2);
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isEmpty) {
      widget.controller.text = "0.00";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextField(
        controller: widget.controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF8FAFC),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: SplashColors.nightSky.withOpacity(0.12)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: SplashColors.nightSky.withOpacity(0.12)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: SplashColors.accent, width: 1.4),
          ),
          contentPadding: const EdgeInsets.only(
            left: 12,
            right: 45,
            top: 16,
            bottom: 16,
          ),
          suffixIcon: SizedBox(
            width: 30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: increment,
                  child: const Icon(
                    Icons.keyboard_arrow_up,
                    size: 18,
                    color: SplashColors.nightSky,
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.grey.shade300,
                ),
                InkWell(
                  onTap: decrement,
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: SplashColors.nightSky,
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
