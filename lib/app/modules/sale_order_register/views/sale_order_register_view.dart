
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gurukrupa/app/modules/sale_order_register/controllers/sale_order_register_controller.dart';

import '../../../commons/app_string.dart';
import '../../../commons/font_family.dart';
import '../../../commons/font_size.dart';
import '../../../commons/utils.dart';
import '../../../data/common_widget/common_screen.dart';

class SaleOrderRegisterView extends GetView<SaleOrderRegisterController> {
  const SaleOrderRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
   return GetBuilder<SaleOrderRegisterController>(
     builder: (controller) {
       return CommonScreen(
         title: AppString.saleOrderRegister,
         body: controller.saleOrderRegisterList.isEmpty
             ?  Utils().noDataFound(context, true)
             : ListView.builder(
           shrinkWrap: true,
           padding: const EdgeInsets.symmetric(vertical: 8),
           itemCount: controller.saleOrderRegisterList.length,
           itemBuilder: (context, index) {
             final item = controller.saleOrderRegisterList[index];
             return Card(
               margin: const EdgeInsets.all(8),
               color: Colors.white,
               elevation: 4,
               child: ListTile(
                 title: Text(
                   "Sales Order ID: ${item.salesOrderID ?? ""}",
                   style: const TextStyle(fontWeight: FontWeight.bold),
                 ),
                 subtitle: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("Order No: ${item.orderNumber ?? ""}"),
                     Text("Date: ${item.date ?? ""}"),
                     Text("Customer: ${item.customerName ?? ""}"),
                     Text("Contact: ${item.contactNumber ?? ""}"),
                     Text("Invoice Type: ${item.invoiceType ?? ""}"),
                     Text("Net Amount: ₹${item.netAmount ?? 0}"),
                     Text("Sales Person: ${item.salesPerson ?? ""}"),
                   ],
                 ),
               ),
             );
           },
         ),
       );
     },
   );
  }

}