import 'package:flutter/gestures.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';

import '../../../commons/all.dart';
import '../model/purchase_register_model_data.dart';

class PurchaseRegisterTable extends StatelessWidget {
  const PurchaseRegisterTable({
    super.key,
    required this.registerData,
  });

  final List<Data> registerData;

  @override
  Widget build(BuildContext context) {
    if (registerData.isEmpty) {
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
            _headerColumn('VOUCHERNO'),
            _headerColumn('PURCHASEDATE'),
            _headerColumn('GSTINNUMBER'),
            _headerColumn('QTY'),
            _headerColumn('TAXABLEAMOUNT'),
            _headerColumn('GROSSAMOUNT'),
            _headerColumn('NETPAYABLEAMOUNT'),
            _headerColumn('TOTALOUTSTADING'),
            _headerColumn('BILLDAYS'),
            _headerColumn('REMARKS'),
            _headerColumn('SUPPLIERVOUCHERNO'),
            _headerColumn('SUPPLIERNAME'),
            _headerColumn('DUEDAYS'),
          ],
          rows: List.generate(registerData.length, (index) {
            final item = registerData[index];

            return DataRow(
              color: MaterialStateProperty.resolveWith<Color?>((states) {
                if (index.isOdd) {
                  return SplashColors.scaffoldBg;
                }
                return null;
              }),
              cells: [
                _dataCell(item.invoicetype ?? ''),
                _dataCell(item.voucherno ?? ''),
                _dataCell(item.purdate ?? ''),
                _dataCell(item.gstinnumber ?? ''),
                _dataCell(item.qty.toString()),
                _dataCell(item.taxableAmount.toString()),
                _dataCell(item.grossamount.toString()),
                _dataCell(item.netpayable.toString()),
                _dataCell(item.totaloutstanding.toString()),
                _dataCell(item.billDays.toString()),
                _dataCell(item.remarks ?? ''),
                _dataCell(item.suppliervoucherno ?? ''),
                _dataCell(item.supplierName ?? ''),
                _dataCell(item.dueDays.toString()),
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
