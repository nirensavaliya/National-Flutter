import 'package:flutter/gestures.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/data/common_widget/common_button.dart';
import 'package:gurukrupa/app/modules/outstanding/controllers/outstanding_controller.dart';
import 'package:gap/gap.dart';

import '../../../data/common_widget/common_textfeild.dart';
import '../../../routes/app_pages.dart';

class ReceivableView extends GetView<OutstandingController> {
  const ReceivableView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OutstandingController>(
      builder: (controller) {
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
            if(controller.outStandingList.isNotEmpty)
            Gap(20),
            if(controller.outStandingList.isNotEmpty)
            CommonButton(
              btnName: AppString.downloadPdf,
              onTap: () {
                controller.genarateRecivePDFApi();
                // Get.toNamed(Routes.SHOW_REPORT);
              },
            ),
            Gap(20),
            tableView(),
          ],
        );
      },
    );
  }

  Widget tableView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      dragStartBehavior: DragStartBehavior.start,
      child: DataTable(
        border: TableBorder.all(),
        columns: const <DataColumn>[
          DataColumn(label: Text('CUSTOMER NAME')),
          DataColumn(label: Text('DRBALANCE')),
          DataColumn(label: Text('CRBALANCE')),
          DataColumn(label: Text('ALIAS NAME')),
          DataColumn(label: Text('CONTACT')),
          DataColumn(label: Text('CITY')),
        ],
        rows: List.generate(
          controller.outStandingList.length,
              (index) {
            return DataRow(
              cells: <DataCell>[
                DataCell(
                    Text(controller.outStandingList[index].customerName ?? "")),
                DataCell(Text(
                    controller.outStandingList[index].drBalance.toString())),
                DataCell(Text(
                    controller.outStandingList[index].crBalance.toString())),
                DataCell(
                    Text(controller.outStandingList[index].aliasName ?? "")),
                DataCell(
                    Text(controller.outStandingList[index].contact1 ?? "")),
                DataCell(Text(controller.outStandingList[index].city ?? "")),
              ],
            );
          },
        ),
      ),
    );
  }
}
