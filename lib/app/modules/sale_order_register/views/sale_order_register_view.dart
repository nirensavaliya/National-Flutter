import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sale_order_register/controllers/sale_order_register_controller.dart';

import '../../../commons/app_string.dart';
import '../../../commons/font_family.dart';
import '../../../commons/utils.dart';
import '../../../data/common_widget/common_screen.dart';

class SaleOrderRegisterView extends GetView<SaleOrderRegisterController> {
  const SaleOrderRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaleOrderRegisterController>(
      builder: (controller) {
        return CommonScreen(
          title: AppString.saleOrderRegister,
          brandAppBar: true,
          scaffoldColor: const Color(0xFFF3F5FA),
          body: controller.saleOrderRegisterList.isEmpty
              ? Utils().noDataFound(context, true)
              : ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: controller.saleOrderRegisterList.length,
                  itemBuilder: (context, index) {
                    final item = controller.saleOrderRegisterList[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: SplashColors.accent.withOpacity(0.16),
                        ),
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
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Sales Order ID: ${item.salesOrderID ?? ""}',
                                  style: TextStyle(
                                    fontFamily: FontFamily.bold,
                                    fontSize: 16,
                                    color: SplashColors.nightSky,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: SplashColors.accent.withOpacity(0.14),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '₹${item.netAmount ?? 0}',
                                  style: TextStyle(
                                    fontFamily: FontFamily.semiBold,
                                    fontSize: 12,
                                    color: SplashColors.nightSky,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _infoRow('Order No', item.orderNumber ?? ''),
                          _infoRow('Date', item.date ?? ''),
                          _infoRow('Customer', item.customerName ?? ''),
                          _infoRow('Contact', item.contactNumber ?? ''),
                          _infoRow('Invoice Type', item.invoiceType ?? ''),
                          _infoRow('Sales Person', item.salesPerson ?? ''),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: TextStyle(
            fontFamily: FontFamily.semiBold,
            fontSize: 13,
            color: const Color(0xFF78829A),
          ),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(
                fontFamily: FontFamily.medium,
                fontSize: 13,
                color: SplashColors.nightSky,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
