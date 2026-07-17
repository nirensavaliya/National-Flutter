import 'package:flutter/gestures.dart';
import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';

import '../../../commons/all.dart';
import '../model/outstanding_model.dart';
import '../model/outstanding_payables_model.dart';

class OutstandingReceivableTable extends StatelessWidget {
  const OutstandingReceivableTable({
    super.key,
    required this.outStandingList,
  });

  final List<OutStandingData> outStandingList;

  @override
  Widget build(BuildContext context) {
    if (outStandingList.isEmpty) {
      return const SizedBox.shrink();
    }

    final totalDr = outStandingList.fold<double>(
      0,
          (sum, item) => sum + (item.drBalance ?? 0),
    );
    final totalCr = outStandingList.fold<double>(
      0,
          (sum, item) => sum + (item.crBalance ?? 0),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ReceivableSummaryStrip(
          customerCount: outStandingList.length,
          totalDr: totalDr,
          totalCr: totalCr,
        ),
        const Gap(12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: outStandingList.length,
          separatorBuilder: (_, __) => const Gap(10),
          itemBuilder: (context, index) {
            return _ReceivableCustomerCard(item: outStandingList[index]);
          },
        ),
      ],
    );
  }
}

class _ReceivableSummaryStrip extends StatelessWidget {
  const _ReceivableSummaryStrip({
    required this.customerCount,
    required this.totalDr,
    required this.totalCr,
  });

  final int customerCount;
  final double totalDr;
  final double totalCr;

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
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _SummaryTile(
              label: 'Customers',
              value: customerCount.toString(),
              icon: Icons.people_outline_rounded,
              color: SplashColors.primary,
            ),
          ),
          Container(
            width: 1,
            height: 44,
            color: SplashColors.primary.withOpacity(0.12),
          ),
          Expanded(
            child: _SummaryTile(
              label: 'Total DR',
              value: _formatAmount(totalDr),
              icon: Icons.arrow_downward_rounded,
              color: const Color(0xFFEF4444),
            ),
          ),
          Container(
            width: 1,
            height: 44,
            color: SplashColors.primary.withOpacity(0.12),
          ),
          Expanded(
            child: _SummaryTile(
              label: 'Total CR',
              value: _formatAmount(totalCr),
              icon: Icons.arrow_upward_rounded,
              color: const Color(0xFF22C55E),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(2);
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 18, color: color),
        const Gap(4),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: FontFamily.bold,
            fontSize: FontSize.s14,
            color: SplashColors.primaryDark,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: FontFamily.medium,
            fontSize: FontSize.s10,
            color: const Color(0xFF78829A),
          ),
        ),
      ],
    );
  }
}

class _ReceivableCustomerCard extends StatelessWidget {
  const _ReceivableCustomerCard({required this.item});

  final OutStandingData item;

  @override
  Widget build(BuildContext context) {
    final dr = item.drBalance ?? 0;
    final cr = item.crBalance ?? 0;

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
            tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
            childrenPadding: EdgeInsets.zero,
            iconColor: SplashColors.primary,
            collapsedIconColor: SplashColors.primary,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: SplashColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: SplashColors.primary,
                    size: 20,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Text(
                    item.customerName ?? 'N/A',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: FontSize.s14,
                      color: SplashColors.primaryDark,
                    ),
                  ),
                ),
                const Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (dr > 0)
                      _BalanceChip(
                        label: 'DR',
                        amount: dr,
                        color: const Color(0xFFEF4444),
                      ),
                    if (cr > 0) ...[
                      if (dr > 0) const Gap(4),
                      _BalanceChip(
                        label: 'CR',
                        amount: cr,
                        color: const Color(0xFF22C55E),
                      ),
                    ],
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
                label: 'DR Balance',
                value: dr.toString(),
                highlight: dr > 0,
              ),
              SalesOrderDetailRow(
                label: 'CR Balance',
                value: cr.toString(),
                highlight: cr > 0,
              ),
              SalesOrderDetailRow(
                label: 'Alias Name',
                value: item.aliasName,
              ),
              SalesOrderDetailRow(
                label: 'Contact',
                value: item.contact1,
              ),
              SalesOrderDetailRow(
                label: 'City',
                value: item.city,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BalanceChip extends StatelessWidget {
  const _BalanceChip({
    required this.label,
    required this.amount,
    required this.color,
  });

  final String label;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$label ${amount == amount.roundToDouble() ? amount.toStringAsFixed(0) : amount.toStringAsFixed(2)}',
        style: TextStyle(
          fontFamily: FontFamily.semiBold,
          fontSize: FontSize.s10,
          color: color,
        ),
      ),
    );
  }
}

class OutstandingPayableTable extends StatelessWidget {
  const OutstandingPayableTable({
    super.key,
    required this.outStandingPayableList,
  });

  final List<PayableData> outStandingPayableList;

  @override
  Widget build(BuildContext context) {
    if (outStandingPayableList.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: outStandingPayableList.length,
      separatorBuilder: (_, __) => const Gap(10),
      itemBuilder: (context, index) {
        return _PayableSupplierCard(item: outStandingPayableList[index]);
      },
    );
  }
}

class _PayableSupplierCard extends StatelessWidget {
  const _PayableSupplierCard({required this.item});

  final PayableData item;

  @override
  Widget build(BuildContext context) {
    final outstanding = item.outstanding ?? 0;
    final advancePaid = item.advancePaid ?? 0;

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
            tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
            childrenPadding: EdgeInsets.zero,
            iconColor: SplashColors.primary,
            collapsedIconColor: SplashColors.primary,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: SplashColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.store_outlined,
                    color: SplashColors.primary,
                    size: 20,
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Text(
                    item.supplierName ?? 'N/A',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      fontSize: FontSize.s14,
                      color: SplashColors.primaryDark,
                    ),
                  ),
                ),
                const Gap(8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (outstanding > 0)
                      _BalanceChip(
                        label: 'OUT',
                        amount: outstanding,
                        color: const Color(0xFFEF4444),
                      ),
                    if (advancePaid > 0) ...[
                      if (outstanding > 0) const Gap(4),
                      _BalanceChip(
                        label: 'ADV',
                        amount: advancePaid,
                        color: const Color(0xFF22C55E),
                      ),
                    ],
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
                label: 'Outstanding',
                value: outstanding.toString(),
                highlight: outstanding > 0,
              ),
              SalesOrderDetailRow(
                label: 'Advance Paid',
                value: advancePaid.toString(),
                highlight: advancePaid > 0,
              ),
              SalesOrderDetailRow(
                label: 'City',
                value: item.city,
              ),
              SalesOrderDetailRow(
                label: 'Group',
                value: item.group,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
