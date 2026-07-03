import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';

import '../../../commons/all.dart';
import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../controllers/purchase_register_controller.dart';

class PurchaseRegisterView extends GetView<PurchaseRegisterController> {
  const PurchaseRegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return  CommonScreen(
      title: AppString.purchaseRegister,
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          CommonTextField(
            borderRadius: 12,
            controller: controller.fromDateController,
            title: AppString.fromDate,
            isTitle: true,
            maxLength: 10,
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
          Gap(15),
          CommonTextField(
            borderRadius: 12,
            controller: controller.toDateController,
            title: AppString.toDate,
            isTitle: true,
            maxLength: 10,
            readOnly: true,
            showCursor: false,
            onTap: (){
              controller.selectDate(context, "to");
            },
            inputFormatters: [
              DateInputFormatter(),
            ],
            suffix: GestureDetector(
              onTap: () {
                controller.selectDate(context, "to");
              },
              child: Icon(Icons.calendar_month),
            ),
          ),
          Gap(15),
          CommonTextField(
            borderRadius: 12,
            controller: controller.ledgerController,
            title: AppString.supplier,
            isTitle: true,
            maxLength: 10,
            hintText: "Please Select...",
            showCursor: false,
            readOnly: true,
            onTap: () {
              controller.selectLedger();
            },
            suffix: RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )),
          ),
          Gap(15),
          CommonTextField(
            borderRadius: 12,
            controller: controller.branchController,
            title: AppString.branch,
            isTitle: true,
            maxLength: 10,
            hintText: "Please Select...",
            showCursor: false,
            readOnly: true,
            onTap: () {
              controller.selectBranch();
            },
            suffix: RotatedBox(
                quarterTurns: 1,
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                )),
          ),
          Gap(20),
          CommonButton(
            btnName: AppString.downloadPdf,
            onTap: () {
              controller.genaratePDFApi();
              // Get.toNamed(Routes.SHOW_REPORT);
            },
          ),
          Gap(20),
          tableView(),
        ],
      ),
    );
  }

  Widget tableView () {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      dragStartBehavior: DragStartBehavior.start,
      child: DataTable(
        border: TableBorder.all(),
        columns: const <DataColumn>[
          DataColumn(label: Text('INVOICETYPE')),
          DataColumn(label: Text('VOUCHERNO')),
          DataColumn(label: Text('PURCHASEDATE')),
          DataColumn(label: Text('GSTINNUMBER')),
          DataColumn(label: Text('QTY')),
          DataColumn(label: Text('TAXABLEAMOUNT')),
          DataColumn(label: Text('GROSSAMOUNT')),
          DataColumn(label: Text('NETPAYABLEAMOUNT')),
          DataColumn(label: Text('TOTALOUTSTADING')),
          DataColumn(label: Text('BILLDAYS')),
          DataColumn(label: Text('REMARKS')),
          DataColumn(label: Text('SUPPLIERVOUCHERNO')),
          DataColumn(label: Text('SUPPLIERNAME')),
          DataColumn(label: Text('DUEDAYS')),
        ],
        rows: List.generate(
          controller.registerData.length,
              (index) {
            return DataRow(
              cells: <DataCell>[
                DataCell(
                    Text(controller.registerData[index].invoicetype ?? "")),
                DataCell(Text(controller.registerData[index].voucherno ?? "")),
                DataCell(
                    Text(controller.registerData[index].purdate ?? "")),
                DataCell(
                    Text(controller.registerData[index].gstinnumber ?? "")),
                DataCell(
                    Text(controller.registerData[index].qty.toString() ?? "")),
                DataCell(Text(
                    controller.registerData[index].taxableAmount.toString())),
                DataCell(
                    Text(controller.registerData[index].grossamount.toString())),
                DataCell(Text(controller.registerData[index].netpayable
                    .toString())),
                DataCell(Text(
                    controller.registerData[index].totaloutstanding
                        .toString())),
                DataCell(
                    Text(controller.registerData[index].billDays.toString() ?? "")),
                DataCell(
                    Text(controller.registerData[index].remarks ?? "")),
                DataCell(Text(
                    controller.registerData[index].suppliervoucherno
                        .toString())),
                DataCell(Text(
                    controller.registerData[index].supplierName.toString())),
                DataCell(Text(controller.registerData[index].dueDays.toString() ?? "")),
              ],
            );
          },
        ),
      ),
    );
  }
}
