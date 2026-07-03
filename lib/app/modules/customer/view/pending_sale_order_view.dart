import 'package:flutter/material.dart';
import 'package:gurukrupa/app/commons/font_family.dart';
import 'package:gurukrupa/app/modules/customer/controllers/PendingSaleOrderController.dart';
import 'package:get/get.dart';

class PendingSaleOrderView extends GetView<PendingSaleOrderController> {
  const PendingSaleOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendingSaleOrderController>(builder: (controller) {
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
                    "Pending Sale Order",
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
        body: GetBuilder<PendingSaleOrderController>(
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
                          "Order No: ${order.orderNo}",
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
                          "Item: ${order.itemName}",
                          style: TextStyle(
                            fontFamily: FontFamily.regular,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Ordered: ${order.ordered}",
                          style: TextStyle(
                            fontFamily: FontFamily.regular,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Delivered: ${order.delivered}",
                          style: TextStyle(
                            fontFamily: FontFamily.regular,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Pending: ${order.pending}",
                          style: TextStyle(
                            fontFamily: FontFamily.regular,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Remarks: ${order.remarks?.isEmpty ?? true ? 'None' : order.remarks}",
                          style: TextStyle(
                            fontFamily: FontFamily.regular,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue[900],
          onPressed: () {
            controller.genaratePDFApi();
          },
          child: SizedBox(
            height: 30,
            width: 30,
            child: Icon(
              Icons.picture_as_pdf,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      );
    });
  }
}