import 'package:flutter/gestures.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/modules/outstanding/controllers/outstanding_controller.dart';
import 'package:gap/gap.dart';

import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../../routes/app_pages.dart';

class PayableView extends GetView<OutstandingController> {
  const PayableView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      children: [
        CommonTextField(
          borderRadius: 12,
          controller: controller.asPerDateController,
          title: AppString.asPerDate,
          isTitle: true,
          maxLength: 10,
          hintText: "day-month-year",
          readOnly: true,
          showCursor: false,
          onTap: (){
            controller.selectDate(context, "from");
          },
          inputFormatters: [
            DateInputFormatter(),
          ],
          suffix: GestureDetector(
            onTap: () {
              controller.selectDate(context, "from");
            },
            child: Icon(Icons.calendar_month),
          ),
        ),
        if(controller.outStandingPayableList.isNotEmpty)
        Gap(20),
        if(controller.outStandingPayableList.isNotEmpty)
        CommonButton(
          btnName: AppString.downloadPdf,
          onTap: () {
            controller.genaratePDFApi();
            // Get.toNamed(Routes.SHOW_REPORT);
          },
        ),
        Gap(30),
        tableView(),
      ],
    );
  }

  Widget tableView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      dragStartBehavior: DragStartBehavior.start,
      child: DataTable(
        border: TableBorder.all(),
        columns: const <DataColumn>[
          DataColumn(label: Text('SUPPLIER NAME')),
          DataColumn(label: Text('OTUSTANDING')),
          DataColumn(label: Text('ADVANCED PAID')),
          DataColumn(label: Text('CITY')),
       // DataColumn(label: Text('ZOOM ID')),
          DataColumn(label: Text('GROUP')),
        ],
        rows: List.generate(
          controller.outStandingPayableList.length,
          (index) {
            return DataRow(
              cells: <DataCell>[
                DataCell(Text(controller.outStandingPayableList[index].supplierName ?? "")),
                DataCell(Text(controller.outStandingPayableList[index].outstanding.toString())),
                DataCell(Text(controller.outStandingPayableList[index].advancePaid.toString())),
                DataCell(Text(controller.outStandingPayableList[index].city ?? "")),
                // DataCell(Text("")),
                DataCell(Text(controller.outStandingPayableList[index].group ?? "")),
              ],
            );
          },
        ),
      ),
    );
  }
}

