import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';

import '../../../commons/all.dart';

class SaleInvoiceListCard extends StatelessWidget {
  const SaleInvoiceListCard({
    super.key,
    required this.billId,
    required this.customerName,
    required this.netAmount,
    required this.invoiceSerialNo,
    required this.date,
    required this.contactNumber,
    required this.invoiceType,
    required this.gstinNumber,
    required this.allowEditEntry,
    required this.allowDeleteEntry,
    required this.onExpansionChanged,
    required this.onEdit,
    required this.onPdf,
    required this.onDelete,
  });

  final String billId;
  final String? customerName;
  final String netAmount;
  final String? invoiceSerialNo;
  final String? date;
  final String? contactNumber;
  final String? invoiceType;
  final String? gstinNumber;
  final bool? allowEditEntry;
  final bool? allowDeleteEntry;
  final ValueChanged<bool> onExpansionChanged;
  final VoidCallback onEdit;
  final VoidCallback onPdf;
  final VoidCallback onDelete;

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
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.white,
            key: Key(billId),
            onExpansionChanged: onExpansionChanged,
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
                  child: const Icon(
                    Icons.receipt_long_outlined,
                    color: SplashColors.primary,
                    size: 22,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customerName ?? 'N/A',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: FontFamily.semiBold,
                          fontSize: FontSize.s14,
                          color: SplashColors.primaryDark,
                        ),
                      ),
                      if (date != null && date!.isNotEmpty) ...[
                        const Gap(2),
                        Text(
                          date!,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (invoiceSerialNo != null && invoiceSerialNo!.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(bottom: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: SplashColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '#$invoiceSerialNo',
                          style: TextStyle(
                            fontFamily: FontFamily.semiBold,
                            fontSize: FontSize.s10,
                            color: SplashColors.primary,
                          ),
                        ),
                      ),
                    Text(
                      netAmount,
                      style: TextStyle(
                        fontFamily: FontFamily.bold,
                        fontSize: FontSize.s16,
                        color: SplashColors.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            children: [
              Divider(
                color: SplashColors.primary.withOpacity(0.1),
                height: 1,
              ),
              SalesOrderDetailRow(
                label: 'Customer Name',
                value: customerName,
              ),
              SalesOrderDetailRow(
                label: 'Contact Number',
                value: contactNumber,
              ),
              SalesOrderDetailRow(
                label: 'Invoice Serial No.',
                value: invoiceSerialNo,
              ),
              SalesOrderDetailRow(
                label: 'Date',
                value: date,
              ),
              SalesOrderDetailRow(
                label: 'Invoice Type',
                value: invoiceType,
              ),
              SalesOrderDetailRow(
                label: 'Net Amount',
                value: netAmount,
                highlight: true,
              ),
              SalesOrderDetailRow(
                label: 'GstIn',
                value: gstinNumber,
              ),
              SalesOrderActionBar(
                onEdit: allowEditEntry == true ? onEdit : null,
                onPdf: onPdf,
                onDelete: allowDeleteEntry == true ? onDelete : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
