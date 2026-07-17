import 'package:flutter/gestures.dart';
import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';

import '../../../commons/all.dart';
import '../model/ledger_statement_model.dart';

class LedgerStatementFilterCard extends StatelessWidget {
  const LedgerStatementFilterCard({
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

Widget ledgerCalendarSuffix(VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: const Icon(
      Icons.calendar_month,
      color: SplashColors.primary,
    ),
  );
}

Widget ledgerDropdownSuffix() {
  return const RotatedBox(
    quarterTurns: 1,
    child: Icon(
      Icons.arrow_forward_ios,
      size: 18,
      color: SplashColors.primary,
    ),
  );
}

class LedgerStatementTable extends StatelessWidget {
  const LedgerStatementTable({
    super.key,
    required this.ledgerList,
    required this.selectedLedger,
    this.onRowSelected,
  });

  final List<ledgerData> ledgerList;
  final ledgerData? selectedLedger;
  final ValueChanged<ledgerData>? onRowSelected;

  @override
  Widget build(BuildContext context) {
    if (ledgerList.isEmpty) {
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
            _headerColumn('GLDATE'),
            _headerColumn('DESCRIPTION'),
            _headerColumn('ACCOUNT'),
            _headerColumn('TRANSACTION'),
            _headerColumn('TRANSCHANNEL'),
            _headerColumn('SRNO'),
            _headerColumn('CR'),
            _headerColumn('DR'),
            _headerColumn('REMARK'),
            _headerColumn('BALANCE'),
          ],
          rows: List.generate(ledgerList.length, (index) {
            final ledger = ledgerList[index];
            final isSelected = selectedLedger == ledger;

            return DataRow(
              color: MaterialStateProperty.resolveWith<Color?>((states) {
                if (isSelected) {
                  return SplashColors.primary.withOpacity(0.12);
                }
                if (index.isOdd) {
                  return SplashColors.scaffoldBg;
                }
                return null;
              }),
              cells: [
                _dataCell(ledger.glDate ?? ''),
                _dataCell(ledger.description ?? ''),
                _dataCell(ledger.account ?? ''),
                DataCell(
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: Text(
                      ledger.transaction ?? '',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: FontSize.s14,
                        fontFamily: FontFamily.medium,
                        color: SplashColors.primary,
                      ),
                    ),
                  ),
                ),
                _dataCell(ledger.transChannel ?? ''),
                _dataCell(ledger.serialNumber ?? ''),
                _dataCell(ledger.cr.toString()),
                _dataCell(ledger.dr.toString()),
                _dataCell(ledger.remarks ?? ''),
                _dataCell(ledger.balance ?? ''),
              ],
              onSelectChanged: onRowSelected == null
                  ? null
                  : (selected) {
                if (selected != null && selected) {
                  onRowSelected!(ledger);
                }
              },
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

class LedgerSelectSheetHeader extends StatelessWidget {
  const LedgerSelectSheetHeader({super.key});

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
            'Select Ledger',
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

InputDecoration ledgerSearchDecoration() {
  return InputDecoration(
    hintText: 'Search ledger...',
    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
    filled: true,
    fillColor: SplashColors.scaffoldBg,
    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    prefixIcon: const Padding(
      padding: EdgeInsets.only(left: 10, right: 6),
      child: Icon(Icons.search, size: 24, color: SplashColors.primary),
    ),
    prefixIconConstraints: const BoxConstraints(minWidth: 30, minHeight: 30),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: SplashColors.primary.withOpacity(0.25)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: SplashColors.primary.withOpacity(0.25)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: SplashColors.primary, width: 1.5),
    ),
  );
}

class LedgerSelectListTile extends StatelessWidget {
  const LedgerSelectListTile({
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
