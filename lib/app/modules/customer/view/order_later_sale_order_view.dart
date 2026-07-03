import 'package:flutter/material.dart';
import 'package:gurukrupa/app/commons/font_family.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/OrderLaterSaleOrderController.dart';

class OrderLaterSaleOrderView extends GetView<OrderLaterSaleOrderController> {
  const OrderLaterSaleOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderLaterSaleOrderController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  const Spacer(),
                  Text(
                    "Order Later Sales",
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Opacity(
                    opacity: 0.0,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: GetBuilder<OrderLaterSaleOrderController>(
          builder: (controller) {
            if (controller.orderList.isEmpty) {
              return Center(
                child: Text("No orders available"),
              );
            }
            return ListView.builder(
              itemCount: controller.orderList.length,
              itemBuilder: (context, index) {
                final order = controller.orderList[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order No: ${order.orderNumber}",
                          style: TextStyle(
                            fontFamily: FontFamily.semiBold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Customer: ${order.customerName}",
                          style: TextStyle(
                            fontFamily: FontFamily.regular,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Contact Number: ${order.contactNumber}",
                          style: TextStyle(
                            fontFamily: FontFamily.regular,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Date: ${order.date}",
                          style: TextStyle(
                            fontFamily: FontFamily.regular,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Net Amount: ${order.netAmount}",
                          style: TextStyle(
                            fontFamily: FontFamily.regular,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Invoice Type: ${order.invoiceType}",
                          style: TextStyle(
                            fontFamily: FontFamily.regular,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed:() async {
                                final result = await Get.toNamed(
                                  Routes.ADD_SALE_ORDER_CUSTOMER,
                                  arguments: {
                                    "order": order,
                                    "isEdit": true
                                  },
                                );

                                if (result == true) {
                                  controller.fetchOrders();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.edit, color: Colors.white),
                                  SizedBox(width: 4),
                                  Text("Edit",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: FontFamily.semiBold)),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.blue[900],
        //   onPressed: () {
        //     controller.genaratePDFApi();
        //   },
        //   child: SizedBox(
        //     height: 30,
        //     width: 30,
        //     child: Icon(
        //       Icons.picture_as_pdf,
        //       color: Colors.white,
        //       size: 28,
        //     ),
        //   ),
        // ),
      );
    });
  }
}
