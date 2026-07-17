import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/customer/controllers/OrderLaterSaleOrderController.dart';
import 'package:gurukrupa/app/modules/customer/model/OrderLaterSaleOrder.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';

import '../../../commons/all.dart';
import '../../../routes/app_pages.dart';

class OrderLaterSaleOrderView extends GetView<OrderLaterSaleOrderController> {
  const OrderLaterSaleOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderLaterSaleOrderController>(
      builder: (controller) {
        return CommonScreen(
          title: 'Order Later Sales',
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          body: controller.orderList.isEmpty
              ? Utils().noDataFound(context, true)
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  itemCount: controller.orderList.length,
                  itemBuilder: (context, index) {
                    final order = controller.orderList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _OrderLaterSaleCard(
                        order: order,
                        onEdit: () async {
                          final result = await Get.toNamed(
                            Routes.ADD_SALE_ORDER_CUSTOMER,
                            arguments: {
                              'order': order,
                              'isEdit': true,
                            },
                          );

                          if (result == true) {
                            controller.fetchOrders();
                          }
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

class _OrderLaterSaleCard extends StatelessWidget {
  const _OrderLaterSaleCard({
    required this.order,
    required this.onEdit,
  });

  final OrderLaterSaleOrder order;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
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
                    Icons.schedule_outlined,
                    color: SplashColors.primary,
                    size: 22,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    'Order No: ${order.orderNumber ?? ''}',
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
          SalesOrderDetailRow(
            label: 'Customer',
            value: order.customerName,
          ),
          SalesOrderDetailRow(
            label: 'Contact Number',
            value: order.contactNumber,
          ),
          SalesOrderDetailRow(
            label: 'Date',
            value: order.date,
          ),
          SalesOrderDetailRow(
            label: 'Net Amount',
            value: order.netAmount?.toString(),
            highlight: true,
          ),
          SalesOrderDetailRow(
            label: 'Invoice Type',
            value: order.invoiceType,
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
              color: SplashColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onEdit,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.edit_outlined,
                        color: SplashColors.primary,
                        size: 20,
                      ),
                      const Gap(8),
                      Text(
                        'Edit Order',
                        style: TextStyle(
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSize.s14,
                          color: SplashColors.primary,
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
