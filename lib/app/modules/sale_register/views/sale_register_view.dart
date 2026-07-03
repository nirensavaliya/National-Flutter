import 'package:flutter/gestures.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gap/gap.dart';

import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../../../routes/app_pages.dart';
import '../controllers/sale_register_controller.dart';

class SaleRegisterView extends GetView<SaleRegisterController> {
  const SaleRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaleRegisterController>(
      builder: (controller) {
        return CommonScreen(
          title: AppString.saleRegister,
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              CommonTextField(
                borderRadius: 12,
                controller: controller.fromDateController,
                title: AppString.fromDate,
                isTitle: true,
                maxLength: 10,
                showCursor: false,
                readOnly: true,
                inputFormatters: [
                  DateInputFormatter(),
                ],
                onTap: (){
                  controller.selectDate(context, "from");
                },
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
                showCursor: false,
                readOnly: true,
                inputFormatters: [
                  DateInputFormatter(),
                ],
                onTap: (){
                  controller.selectDate(context, "to");
                },
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
                controller: controller.customerController,
                title: AppString.customer,
                isTitle: true,
                maxLength: 10,
                hintText: "Please Select...",
                showCursor: false,
                readOnly: true,
                onTap: () {
                  controller.selectCustomer();
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
              if(controller.saleRegisterList.isNotEmpty)
              Gap(20),
              if(controller.saleRegisterList.isNotEmpty)
              CommonButton(
                btnName: AppString.downloadPdf,
                onTap: () {
                  controller.genaratePDFApi();
                },
              ),
              Gap(20),
              tableView(),
            ],
          ),
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
          DataColumn(label: Text('INVOICETYPE')),
          DataColumn(label: Text('BILLNO')),
          DataColumn(label: Text('BILLDATE')),
          DataColumn(label: Text('CUSTOMER')),
          DataColumn(label: Text('GSTINNUMBER')),
          DataColumn(label: Text('CONTACTNUMBER')),
          DataColumn(label: Text('TOTOTY')),
          DataColumn(label: Text('TEXABLEAMOUNT')),
          DataColumn(label: Text('NETPAYABLEAMOUNT')),
          DataColumn(label: Text('DUEDATE')),
          DataColumn(label: Text('SALEPERSON')),
          DataColumn(label: Text('TOTALOUTSTANDING')),
          DataColumn(label: Text('CRADITDAYS')),
          DataColumn(label: Text('STATE')),
          DataColumn(label: Text('CITY')),
          DataColumn(label: Text('BILLEDDAYS')),
          DataColumn(label: Text('REMARK')),
        ],
        rows: List.generate(
          controller.saleRegisterList.length,
              (index) {
            return DataRow(
              cells: <DataCell>[
                DataCell(
                    Text(controller.saleRegisterList[index].invoiceType ?? "")),
                DataCell(Text(controller.saleRegisterList[index].billNo ?? "")),
                DataCell(
                    Text(controller.saleRegisterList[index].billDate ?? "")),
                DataCell(
                    Text(controller.saleRegisterList[index].customer ?? "")),
                DataCell(
                    Text(controller.saleRegisterList[index].gstinNumber ?? "")),
                DataCell(Text(
                    controller.saleRegisterList[index].contactNumber ?? "")),
                DataCell(
                    Text(controller.saleRegisterList[index].totQty.toString())),
                DataCell(Text(controller.saleRegisterList[index].gstTaxableAmt
                    .toString())),
                DataCell(Text(
                    controller.saleRegisterList[index].netPayableAmount
                        .toString())),
                DataCell(
                    Text(controller.saleRegisterList[index].dueDate ?? "")),
                DataCell(
                    Text(controller.saleRegisterList[index].salesPerson ?? "")),
                DataCell(Text(
                    controller.saleRegisterList[index].totalOutstanding
                        .toString())),
                DataCell(Text(
                    controller.saleRegisterList[index].creditDays.toString())),
                DataCell(Text(controller.saleRegisterList[index].state ?? "")),
                DataCell(Text(controller.saleRegisterList[index].city ?? "")),
                DataCell(Text(
                    controller.saleRegisterList[index].billedDays.toString())),
                DataCell(
                    Text(controller.saleRegisterList[index].remarks ?? "")),
              ],
            );
          },
        ),
      ),
    );
  }
}
