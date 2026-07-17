import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/customer/controllers/PendingSaleOrderController.dart';
import 'package:gurukrupa/app/modules/customer/model/PendingSaleOrder.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';

import '../../../commons/all.dart';

class PendingSaleOrderView extends GetView<PendingSaleOrderController> {
  const PendingSaleOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendingSaleOrderController>(
      builder: (controller) {
        return CommonScreen(
          title: 'Pending Sale Order',
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          floatingActionButton: FloatingActionButton(
            backgroundColor: SplashColors.primary,
            onPressed: () {
              controller.genaratePDFApi();
            },
            child: const Icon(
              Icons.picture_as_pdf_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
          body: controller.orderList.isEmpty
              ? Utils().noDataFound(context, true)
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                  itemCount: controller.orderList.length,
                  itemBuilder: (context, index) {
                    final order = controller.orderList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _PendingSaleOrderCard(order: order),
                    );
                  },
                ),
        );
      },
    );
  }
}

class _PendingSaleOrderCard extends StatelessWidget {
  const _PendingSaleOrderCard({required this.order});

  final PendingSaleOrder order;

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
                    Icons.pending_actions_outlined,
                    color: SplashColors.primary,
                    size: 22,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    'Order No: ${order.orderNo ?? ''}',
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
            label: 'Item',
            value: order.itemName,
          ),
          SalesOrderDetailRow(
            label: 'Ordered',
            value: order.ordered?.toString(),
          ),
          SalesOrderDetailRow(
            label: 'Delivered',
            value: order.delivered?.toString(),
          ),
          SalesOrderDetailRow(
            label: 'Pending',
            value: order.pending?.toString(),
            highlight: true,
          ),
          SalesOrderDetailRow(
            label: 'Remarks',
            value: order.remarks?.isEmpty ?? true ? 'None' : order.remarks,
          ),
        ],
      ),
    );
  }
}
