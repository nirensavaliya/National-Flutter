import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sales_order/controllers/sales_order_cart_controller.dart';
import 'package:gurukrupa/app/modules/sales_order/model/sale_order_model.dart';
import 'package:gurukrupa/app/modules/sales_order/model/sales_order_cart_model.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';

import '../../../commons/all.dart';

class SalesOrderCartView extends GetView<SalesOrderCartController> {
  const SalesOrderCartView({super.key});

  Map<String, String> _grandTotals(List<SalesOrderCartModel> carts) {
    double totalAmt = 0;
    double totalDiscount = 0;
    double totalCGST = 0;
    double totalSGST = 0;
    double totalIGST = 0;
    double totalNetAmount = 0;
    int totalItemCount = 0;

    for (final cart in carts) {
      for (final item in cart.items) {
        totalAmt += (item.price ?? 0) * (item.qty ?? 1);
        totalDiscount += item.totalDiscount ?? 0;
        totalCGST += item.cgstAmount ?? 0;
        totalSGST += item.sgstAmount ?? 0;
        totalIGST += item.igstAmount ?? 0;
        totalNetAmount += item.netAmount ?? 0;
      }
      totalItemCount += cart.items.length;
    }

    return {
      'total': totalAmt.toStringAsFixed(2),
      'discountTotal': totalDiscount.toStringAsFixed(2),
      'cGstTotal': totalCGST.toStringAsFixed(2),
      'sGstTotal': totalSGST.toStringAsFixed(2),
      'iGstTotal': totalIGST.toStringAsFixed(2),
      'totalItem': totalItemCount.toString(),
      'netTotal': totalNetAmount.toStringAsFixed(2),
    };
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalesOrderCartController>(
      builder: (controller) {
        final carts = controller.carts;
        final grandTotals = _grandTotals(carts);

        return CommonScreen(
          title: 'Cart',
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          body: carts.isEmpty
              ? Utils().noDataFound(context, true)
              : SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  child: Column(
                    children: [
                      // Text(
                      //   'Saved Carts (${carts.length})',
                      //   style: TextStyle(
                      //     fontFamily: FontFamily.semiBold,
                      //     fontSize: FontSize.s16,
                      //     color: SplashColors.primaryDark,
                      //   ),
                      // ),
                      const Gap(5),
                      ...List.generate(carts.length, (cartIndex) {
                        final cart = carts[cartIndex];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _CartGroupCard(
                            cart: cart,
                            onRemoveCart: () =>
                                controller.removeCart(cart.cartId),
                            onRemoveItem: (itemIndex) =>
                                controller.removeItem(cart.cartId, itemIndex),
                          ),
                        );
                      }),
                      const Gap(8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Final Total',
                          style: TextStyle(
                            fontFamily: FontFamily.semiBold,
                            fontSize: FontSize.s16,
                            color: SplashColors.primaryDark,
                          ),
                        ),
                      ),
                      const Gap(10),
                      _CartSummaryCard(totals: grandTotals),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _CartGroupCard extends StatefulWidget {
  const _CartGroupCard({
    required this.cart,
    required this.onRemoveCart,
    required this.onRemoveItem,
  });

  final SalesOrderCartModel cart;
  final VoidCallback onRemoveCart;
  final ValueChanged<int> onRemoveItem;

  @override
  State<_CartGroupCard> createState() => _CartGroupCardState();
}

class _CartGroupCardState extends State<_CartGroupCard> {
  bool isExpanded = false;

  SalesOrderCartModel get cart => widget.cart;

  Map<String, String> get _totals {
    double totalAmt = 0;
    double totalDiscount = 0;
    double totalCGST = 0;
    double totalSGST = 0;
    double totalIGST = 0;
    double totalNetAmount = 0;

    for (final item in cart.items) {
      totalAmt += (item.price ?? 0) * (item.qty ?? 1);
      totalDiscount += item.totalDiscount ?? 0;
      totalCGST += item.cgstAmount ?? 0;
      totalSGST += item.sgstAmount ?? 0;
      totalIGST += item.igstAmount ?? 0;
      totalNetAmount += item.netAmount ?? 0;
    }

    return {
      'total': totalAmt.toStringAsFixed(2),
      'discountTotal': totalDiscount.toStringAsFixed(2),
      'cGstTotal': totalCGST.toStringAsFixed(2),
      'sGstTotal': totalSGST.toStringAsFixed(2),
      'iGstTotal': totalIGST.toStringAsFixed(2),
      'totalItem': cart.items.length.toString(),
      'netTotal': totalNetAmount.toStringAsFixed(2),
    };
  }

  @override
  Widget build(BuildContext context) {
    final totals = _totals;

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
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cart.customerName?.isNotEmpty == true
                              ? cart.customerName!
                              : 'Saved Cart',
                          style: TextStyle(
                            fontFamily: FontFamily.semiBold,
                            fontSize: FontSize.s14,
                            color: SplashColors.primaryDark,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          'Items: ${totals['totalItem']}  •  Net: ${totals['netTotal']}',
                          style: TextStyle(
                            fontFamily: FontFamily.medium,
                            fontSize: FontSize.s12,
                            color: const Color(0xFF78829A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: SplashColors.primary,
                  ),
                  IconButton(
                    onPressed: widget.onRemoveCart,
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            Divider(height: 1, color: SplashColors.primary.withOpacity(0.1)),
            if ((cart.savedAt ?? '').isNotEmpty)
              SalesOrderDetailRow(
                label: 'Saved At',
                value: _formatSavedAt(cart.savedAt!),
              ),
            const Gap(4),
            ...List.generate(cart.items.length, (index) {
              final item = cart.items[index];
              return Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                child: _CartItemCard(item: item),
              );
            }),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: _CartSummaryCard(totals: totals),
            ),
          ],
        ],
      ),
    );
  }

  String _formatSavedAt(String value) {
    try {
      final dt = DateTime.parse(value).toLocal();
      final hour = dt.hour > 12 ? dt.hour - 12 : (dt.hour == 0 ? 12 : dt.hour);
      final minute = dt.minute.toString().padLeft(2, '0');
      final suffix = dt.hour >= 12 ? 'PM' : 'AM';
      return '${dt.day}/${dt.month}/${dt.year} $hour:$minute $suffix';
    } catch (_) {
      return value;
    }
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({required this.item});

  final SaleOrderDetails item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: SplashColors.scaffoldBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: SplashColors.primary.withOpacity(0.08),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item.itemName ?? '',
                style: TextStyle(
                  fontFamily: FontFamily.semiBold,
                  fontSize: FontSize.s14,
                  color: SplashColors.primaryDark,
                ),
              ),
            ),
          ),
          SalesOrderDetailRow(
            label: 'Quantity',
            value: item.qty?.toString(),
          ),
          SalesOrderDetailRow(
            label: 'Price',
            value: item.price?.toString(),
          ),
          SalesOrderDetailRow(
            label: 'Net Amount',
            value: item.netAmount?.toStringAsFixed(2),
            highlight: true,
          ),
          const Gap(6),
        ],
      ),
    );
  }
}

class _CartSummaryCard extends StatelessWidget {
  const _CartSummaryCard({required this.totals});

  final Map<String, String> totals;

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
      child: Column(
        children: [
          _summaryRow('Total', totals['total'] ?? '0.00'),
          _summaryRow(
            '(-)DiscountTotal',
            totals['discountTotal'] ?? '0.00',
            muted: true,
          ),
          _summaryRow(
            '(+)CGSTTotal',
            totals['cGstTotal'] ?? '0.00',
            muted: true,
          ),
          _summaryRow(
            '(+)SGSTTotal',
            totals['sGstTotal'] ?? '0.00',
            muted: true,
          ),
          _summaryRow(
            '(+)IGSTTotal',
            totals['iGstTotal'] ?? '0.00',
            muted: true,
          ),
          _summaryRow(
            'TotalItem',
            totals['totalItem'] ?? '0',
            muted: true,
          ),
          Divider(color: SplashColors.primary.withOpacity(0.12), height: 1),
          _summaryRow(
            'NetTotal',
            totals['netTotal'] ?? '0.00',
            bold: true,
            highlight: true,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(
    String label,
    String value, {
    bool muted = false,
    bool bold = false,
    bool highlight = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: bold ? FontFamily.bold : FontFamily.medium,
                fontSize: FontSize.s14,
                color: muted ? Colors.black54 : SplashColors.primaryDark,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontFamily: bold ? FontFamily.bold : FontFamily.semiBold,
              fontSize: bold ? FontSize.s16 : FontSize.s14,
              color: highlight ? SplashColors.primary : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
