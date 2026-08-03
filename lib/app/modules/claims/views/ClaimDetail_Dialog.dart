import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
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
  double expenseAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: GetBuilder<ClaimsController>(
        builder: (_) {
          return Container(
            width: 550,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Claim Details",
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: FontFamily.PlayfairDisplayBold,
                            color: SplashColors.primaryDark,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(Icons.close),
                      ),
                    ],
                  ),
                  Divider(),
                  Gap(15),
                  Row(
                    children: [
                      Expanded(
                        child: buildTile(
                          "Claim Number",
                          claim.claimNumber.toString(),
                        ),
                      ),
                      Expanded(
                        child: buildTile(
                          "Status",
                          claim.status,
                        ),
                      ),
                    ],
                  ),
                  Gap(8),
                  Row(
                    children: [
                      Expanded(
                        child: buildTile(
                          "Dealer",
                          claim.dealerName,
                        ),
                      ),
                      Expanded(
                        child: buildTile(
                          "Customer Name",
                          claim.customerName,
                        ),
                      ),
                    ],
                  ),
                  Gap(8),
                  Row(
                    children: [
                      Expanded(
                        child: buildTile(
                          "Customer Mobile",
                          claim.customerMobile,
                        ),
                      ),
                      Expanded(
                        child: buildTile(
                          "Invoice Number",
                          claim.invoiceNumber ?? "-",
                        ),
                      ),
                    ],
                  ),
                  Gap(8),
                  Row(
                    children: [
                      Expanded(
                        child: buildTile(
                          "Bill Date",
                          formatBillDate(claim.billDate),
                        ),
                      ),
                      Expanded(
                        child: buildTile(
                          "Description",
                          claim.companyDescription,
                        ),
                      ),
                    ],
                  ),
                  Gap(15),
                  Text(
                    "Claim Items",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: SplashColors.primaryDark,
                      fontFamily: FontFamily.PlayfairDisplayBold,

                    ),
                  ),
                  Divider(),
                  ...claim.claimDetails.map(
                    (e) => Card(
                      elevation: 1,
                      margin: const EdgeInsets.only(top: 10,bottom: 10),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[100],
                          border: Border.all(
                            color: Colors.black,
                            width: 1
                          )
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: buildTile(
                                    "Brand",
                                    "${e.itemBrand}",
                                  ),
                                ),
                                Expanded(
                                  child: buildTile(
                                    "Item",
                                    "${e.itemName}",
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                buildTile(
                                  "Serial",
                                  "${e.serialNumber}",
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(15),
                  if(!isCustomer)...[
                  Text(
                    "Expense",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: FontFamily.PlayfairDisplayBold,
                      color: SplashColors.primaryDark,
                    ),
                  ),

                  Divider(),
                  ExpenseField(
                    controller: expenseController,
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Image",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: FontFamily.PlayfairDisplayBold,
                          color: SplashColors.primaryDark,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          CommonButton(
                            btnName: "Choose File",
                            onTap: () async {
                              await controller.pickImage();
                            },
                          ),

                          const SizedBox(width: 12),

                          Expanded(
                            child: Text(
                              controller.selectedImage == null
                                  ? "No file chosen"
                                  : controller.selectedImage!.path.split('/').last,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (controller.selectedImage != null) ...[
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            controller.selectedImage!,
                            height: 120,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     InkWell(
                  //       child: Container(),
                  //     ),
                  //     const SizedBox(height: 12),
                  //     if (controller.selectedImage != null)
                  //       Align(
                  //         alignment: Alignment.centerRight,
                  //         child: TextButton.icon(
                  //           onPressed: () async {
                  //             await controller.pickImage();
                  //           },
                  //           icon: const Icon(Icons.edit),
                  //           label: const Text("Change Image"),
                  //         ),
                  //       ),
                  //     const SizedBox(height: 30),
                  //   ],
                  // ),
                  const SizedBox(height: 30),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: OutlinedButton(
                  //         onPressed: () => Get.back(),
                  //         style: OutlinedButton.styleFrom(
                  //           padding: const EdgeInsets.symmetric(vertical: 14),
                  //         ),
                  //         child: const Text("Cancel"),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 15),
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: Colors.red,
                  //           padding: const EdgeInsets.symmetric(vertical: 14),
                  //         ),
                  //         onPressed: () async {
                  //           await controller.updateClaimStatus(
                  //             claim.claimId!,
                  //             "Rejected",
                  //             double.tryParse(expenseController.text.trim()) ??
                  //                 0,
                  //           );
                  //
                  //           Get.back();
                  //
                  //           controller.getClaimList();
                  //
                  //           Get.snackbar(
                  //             "Success",
                  //             "Claim Rejected Successfully",
                  //             snackPosition: SnackPosition.BOTTOM,
                  //           );
                  //         },
                  //         child: const Text(
                  //           "Reject",
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 15),
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         style: ElevatedButton.styleFrom(
                  //           backgroundColor: Colors.green,
                  //           padding: const EdgeInsets.symmetric(vertical: 14),
                  //         ),
                  //         onPressed: () async {
                  //           if (controller.selectedImage == null) {
                  //             Get.snackbar(
                  //               "Image Required",
                  //               "Please select claim image",
                  //               snackPosition: SnackPosition.TOP,
                  //             );
                  //             return;
                  //           }
                  //
                  //           await controller.updateClaimStatus(
                  //             claim.claimId!,
                  //             "Complate",
                  //             double.tryParse(expenseController.text.trim()) ??
                  //                 0,
                  //           );
                  //
                  //           Get.back();
                  //
                  //           controller.getClaimList();
                  //
                  //           Get.snackbar(
                  //             "Success",
                  //             "Claim Approved Successfully",
                  //             snackPosition: SnackPosition.BOTTOM,
                  //           );
                  //         },
                  //         child: const Text(
                  //           "Approve",
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Column(
                    children: [
                      /// Approve Button
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
                            backgroundColor: SplashColors.primaryDark,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Approve",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: FontFamily.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
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
                              color: SplashColors.primaryDark,
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Reject",
                            style: TextStyle(
                              color: Colors.black87,
                              fontFamily: FontFamily.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                 ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontFamily: FontFamily.bold,color: const Color(0xFF78829A),fontSize: 12),
          ),
          Text(
            value,
            style: TextStyle(fontFamily: FontFamily.medium,fontSize: 14),
          ),
        ],
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
  double get value =>
      double.tryParse(widget.controller.text) ?? 0.00;

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
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
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