import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';

import '../../../commons/all.dart';
import '../monhtly_total_purchase_model.dart';
import '../monthly_sale_model.dart';

class ShowReportSaleCard extends StatelessWidget {
  const ShowReportSaleCard({
    super.key,
    required this.model,
    required this.index,
  });

  final MonthlySaleData model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return _ReportExpansionCard(
      cardKey: Key('sale_$index'),
      title: model.custName ?? 'N/A',
      subtitle: 'Serial No. ${model.billSrNo ?? ''}',
      amount: model.netAmount?.toString() ?? '',
      icon: Icons.receipt_long_outlined,
      children: [
        _detail('Customer Name', model.custName),
        _detail('DT', model.date),
        _detail('Bill Sr No.', model.billSrNo),
        _detail('Gross Amount', model.grossAmount),
        _detail('Sale Type', model.saleType),
        _detail('Discount', model.discount),
        _detail('Ship To', model.shipTo),
        _detail('Contact No.', model.contactNo),
        _detail('Credit Days', model.creditDays),
        _detail('Invoice Type', model.invoiceType),
        _detail('Paid', model.paid),
        _detail('Total Outstanding', model.totalOutstanding),
        _detail('Netpayable Amount', model.netPayableAmount),
        _detail('Sale Amount Ex. Discount', model.saleAmountExDiscount),
        _detail('Total Item Discount', model.totalItemDiscount),
        _detail('Net Amount', model.netAmount, highlight: true),
        _detail('Sale Amount inc. Discount', model.saleAmountIncDiscount),
        _detail('IGST Per', model.igstPer),
        _detail('IGST Amt', model.igstAmt),
        _detail('CGST Per', model.cgstPer),
        _detail('CGST Amt', model.cgstAmt),
        _detail('SGST Per', model.sgstPer),
        _detail('SGST Amt', model.sgstAmt),
        _detail('Tax Mode', model.taxMode),
        _detail('GST Type', model.gstType),
        _detail('GSTIN Number', model.gstinNumber),
        _detail('Customer GST Type', model.customerGSTType),
        _detail('Sale Taxable AMT', model.saleTaxableAmt),
      ],
    );
  }
}

class ShowReportPurchaseCard extends StatelessWidget {
  const ShowReportPurchaseCard({
    super.key,
    required this.model,
    required this.index,
  });

  final MonhtlyPurchaseData model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return _ReportExpansionCard(
      cardKey: Key('purchase_$index'),
      title: model.partyname ?? 'N/A',
      subtitle: 'Voucher No. ${model.voucherNo ?? ''}',
      amount: model.purchaseAmount?.toString() ?? '',
      icon: Icons.shopping_cart_outlined,
      children: [
        _detail('Party Name', model.partyname),
        _detail('Voucher No.', model.voucherNo),
        _detail('DT', model.date),
        _detail('Gross Amount', model.paid),
        _detail('Discount', model.discount),
        _detail('Invoice Type', model.invoiceType),
        _detail('Paid', model.paid),
        _detail('Total Outstanding', model.totalOutstanding),
        _detail('IGST Per', model.igstPer),
        _detail('IGST Amt', model.igstAmt),
        _detail('CGST Per', model.cgstPer),
        _detail('CGST Amt', model.cgstAmt),
        _detail('SGST Per', model.sgstPer),
        _detail('SGST Amt', model.sgstAmt),
        _detail('Tax Mode', model.taxMode),
        _detail('GST Type', model.gstType),
      ],
    );
  }
}

class _ReportExpansionCard extends StatelessWidget {
  const _ReportExpansionCard({
    required this.cardKey,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    required this.children,
  });

  final Key cardKey;
  final String title;
  final String subtitle;
  final String amount;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: SplashColors.primary.withOpacity(0.1)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Theme(
          data: ThemeData(
            dividerColor: Colors.transparent,
            splashColor: SplashColors.primary.withOpacity(0.08),
            highlightColor: SplashColors.primary.withOpacity(0.05),
          ),
          child: ExpansionTile(
            key: cardKey,
            tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            childrenPadding: EdgeInsets.zero,
            iconColor: SplashColors.primary,
            collapsedIconColor: SplashColors.primary,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: SplashColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: SplashColors.primary, size: 22),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSize.s14,
                          color: SplashColors.primaryDark,
                        ),
                      ),
                      if (subtitle.isNotEmpty) ...[
                        const Gap(2),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontFamily: FontFamily.medium,
                            fontSize: FontSize.s12,
                            color: const Color(0xFF78829A),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Gap(8),
                Text(
                  amount,
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: FontSize.s16,
                    color: SplashColors.primary,
                  ),
                ),
              ],
            ),
            children: [
              Divider(
                color: SplashColors.primary.withOpacity(0.1),
                height: 1,
              ),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

Widget _detail(String label, dynamic value, {bool highlight = false}) {
  return SalesOrderDetailRow(
    label: label,
    value: value?.toString(),
    highlight: highlight,
  );
}
