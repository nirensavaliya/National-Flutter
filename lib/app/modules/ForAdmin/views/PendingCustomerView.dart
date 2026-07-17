import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';

import '../../../commons/all.dart';
import '../../../data/common_widget/common_screen.dart';
import '../controllers/PendingCustomerController.dart';
import '../model/PendingCustomerModel.dart';

class PendingCustomerView extends GetView<PendingCustomerController> {
  const PendingCustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendingCustomerController>(
      builder: (controller) {
        return CommonScreen(
          title: 'Pending Customer',
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          body: controller.customerList.isEmpty
              ? Utils().noDataFound(context, true)
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: controller.customerList.length,
                  itemBuilder: (context, index) {
                    final customer = controller.customerList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _PendingCustomerCard(
                        customer: customer,
                        onApprove: () {
                          controller.approveCustomer(customer.customerId!);
                        },
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

class _PendingCustomerCard extends StatelessWidget {
  const _PendingCustomerCard({
    required this.customer,
    required this.onApprove,
  });

  final PendingCustomerModel customer;
  final VoidCallback onApprove;

  @override
  Widget build(BuildContext context) {
    final mobile = [
      customer.mobileNumber,
      customer.alternateMobileNumber,
    ].where((e) => e != null && e!.isNotEmpty).join(' ');

    final address = [
      customer.address1,
      customer.address2,
    ].where((e) => e != null && e!.isNotEmpty).join(' ');

    final location = [
      customer.city,
      customer.state,
    ].where((e) => e != null && e!.isNotEmpty).join(', ');

    return Container(
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: SplashColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: SplashColors.primary,
                    size: 22,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    customer.customerName ?? 'N/A',
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: FontSize.s16,
                      color: SplashColors.primaryDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: SplashColors.primary.withOpacity(0.1),
          ),
          if (mobile.isNotEmpty)
            SalesOrderDetailRow(
              label: 'Mobile No',
              value: mobile,
            ),
          if (address.isNotEmpty)
            SalesOrderDetailRow(
              label: 'Address',
              value: address,
            ),
          if (location.isNotEmpty)
            SalesOrderDetailRow(
              label: 'City',
              value: location,
            ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: SplashColors.scaffoldBg,
              border: Border(
                top: BorderSide(
                  color: SplashColors.primary.withOpacity(0.1),
                ),
              ),
            ),
            child: Material(
              color: const Color(0xFF22C55E).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onApprove,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle_outline_rounded,
                        color: Color(0xFF16A34A),
                        size: 20,
                      ),
                      const Gap(8),
                      Text(
                        'Approve Customer',
                        style: TextStyle(
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSize.s14,
                          color: const Color(0xFF16A34A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
