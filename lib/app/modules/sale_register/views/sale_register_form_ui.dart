import 'package:flutter/gestures.dart';
import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';

import '../../../commons/all.dart';
import '../model/sale_register_model.dart';

class SaleRegisterFilterCard extends StatelessWidget {
  const SaleRegisterFilterCard({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: SplashColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.filter_list_rounded,
                  color: SplashColors.primary,
                  size: 18,
                ),
              ),
              const Gap(10),
              Text(
                'Filter',
                style: TextStyle(
                  fontFamily: FontFamily.semiBold,
                  fontSize: FontSize.s16,
                  color: SplashColors.primaryDark,
                ),
              ),
            ],
          ),
          const Gap(14),
          ...children,
        ],
      ),
    );
  }
}

Widget saleRegisterCalendarSuffix(VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: const Icon(
      Icons.calendar_month,
      color: SplashColors.primary,
    ),
  );
}

Widget saleRegisterDropdownSuffix() {
  return const RotatedBox(
    quarterTurns: 1,
    child: Icon(
      Icons.arrow_forward_ios,
      size: 18,
      color: SplashColors.primary,
    ),
  );
}

class SaleRegisterTable extends StatelessWidget {
  const SaleRegisterTable({
    super.key,
    required this.saleRegisterList,
  });

  final List<SaleRegisterData> saleRegisterList;

  @override
  Widget build(BuildContext context) {
    if (saleRegisterList.isEmpty) {
      return const SizedBox.shrink();
    }

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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        dragStartBehavior: DragStartBehavior.start,
        child: DataTable(
          showCheckboxColumn: false,
          headingRowColor: MaterialStateProperty.all(
            SplashColors.primary.withOpacity(0.1),
          ),
          dataRowMinHeight: 44,
          dataRowMaxHeight: 56,
          border: TableBorder(
            horizontalInside: BorderSide(
              color: SplashColors.primary.withOpacity(0.08),
            ),
            verticalInside: BorderSide(
              color: SplashColors.primary.withOpacity(0.08),
            ),
          ),
          columns: [
            _headerColumn('INVOICETYPE'),
            _headerColumn('BILLNO'),
            _headerColumn('BILLDATE'),
            _headerColumn('CUSTOMER'),
            _headerColumn('GSTINNUMBER'),
            _headerColumn('CONTACTNUMBER'),
            _headerColumn('TOTOTY'),
            _headerColumn('TEXABLEAMOUNT'),
            _headerColumn('NETPAYABLEAMOUNT'),
            _headerColumn('DUEDATE'),
            _headerColumn('SALEPERSON'),
            _headerColumn('TOTALOUTSTANDING'),
            _headerColumn('CRADITDAYS'),
            _headerColumn('STATE'),
            _headerColumn('CITY'),
            _headerColumn('BILLEDDAYS'),
            _headerColumn('REMARK'),
          ],
          rows: List.generate(saleRegisterList.length, (index) {
            final item = saleRegisterList[index];

            return DataRow(
              color: MaterialStateProperty.resolveWith<Color?>((states) {
                if (index.isOdd) {
                  return SplashColors.scaffoldBg;
                }
                return null;
              }),
              cells: [
                _dataCell(item.invoiceType ?? ''),
                _dataCell(item.billNo ?? ''),
                _dataCell(item.billDate ?? ''),
                _dataCell(item.customer ?? ''),
                _dataCell(item.gstinNumber ?? ''),
                _dataCell(item.contactNumber ?? ''),
                _dataCell(item.totQty.toString()),
                _dataCell(item.gstTaxableAmt.toString()),
                _dataCell(item.netPayableAmount.toString()),
                _dataCell(item.dueDate ?? ''),
                _dataCell(item.salesPerson ?? ''),
                _dataCell(item.totalOutstanding.toString()),
                _dataCell(item.creditDays.toString()),
                _dataCell(item.state ?? ''),
                _dataCell(item.city ?? ''),
                _dataCell(item.billedDays.toString()),
                _dataCell(item.remarks ?? ''),
              ],
            );
          }),
        ),
      ),
    );
  }

  DataColumn _headerColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: TextStyle(
          fontFamily: FontFamily.semiBold,
          fontSize: FontSize.s12,
          color: SplashColors.primaryDark,
        ),
      ),
    );
  }

  DataCell _dataCell(String value) {
    return DataCell(
      Text(
        value,
        style: TextStyle(
          fontFamily: FontFamily.medium,
          fontSize: FontSize.s14,
          color: SplashColors.primaryDark,
        ),
      ),
    );
  }
}

class SaleRegisterSheetHeader extends StatelessWidget {
  const SaleRegisterSheetHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 18),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            SplashColors.primaryDeep,
            SplashColors.primary,
            SplashColors.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Gap(12),
          Text(
            title,
            style: TextStyle(
              fontFamily: FontFamily.semiBold,
              fontSize: FontSize.s18,
              color: SplashColors.text,
            ),
          ),
        ],
      ),
    );
  }
}

class SaleRegisterSelectListTile extends StatelessWidget {
  const SaleRegisterSelectListTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String? title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: SplashColors.primary.withOpacity(0.15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            title ?? '',
            style: TextStyle(
              fontFamily: FontFamily.medium,
              fontSize: FontSize.s14,
              color: SplashColors.primaryDark,
            ),
          ),
        ),
      ),
    );
  }
}
