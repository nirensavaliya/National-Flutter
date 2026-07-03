import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commons/font_family.dart';
import '../controllers/PendingCustomerController.dart';

class PendingCustomerView extends GetView<PendingCustomerController> {
  const PendingCustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PendingCustomerController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70), // Custom AppBar height
          child: Container(
            color: Colors.white, // AppBar background color
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SafeArea(
              // Ensure AppBar contents don't overlap system UI
              child: Row(
                children: [
                  // Custom Back Button
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Get.back(); // Navigate to the previous screen
                      },
                    ),
                  const Spacer(),
                  // Custom Title
                  Text(
                    "Pending Customer",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: FontFamily.semiBold,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Opacity(
                    opacity: 0.0, // Set to 1.0 to make it visible, 0.0 to make it invisible.
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        Get.back(); // Navigate to the previous screen
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: GetBuilder<PendingCustomerController>(
          builder: (controller) {
            return ListView.builder(
              itemCount: controller.customerList.length,
              itemBuilder: (context, index) {
                var customer = controller.customerList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: Colors.white,
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customer.customerName ?? "",
                            style: TextStyle(
                                fontFamily: FontFamily.semiBold,
                                fontSize: 18),
                          ),
                          Text("Mobile No: ${customer.mobileNumber ?? ''} ${customer.alternateMobileNumber ?? ''}",
                            style: TextStyle(
                              fontFamily: FontFamily.regular,
                              fontSize: 14),),
                          Text("Address: ${customer.address1 ?? ''}  ${customer.address2 ?? ''}",
                            style: TextStyle(
                              fontFamily: FontFamily.regular,
                              fontSize: 14),),
                          Text("City: ${customer.city ?? ''} ${customer.state ?? ''}",
                            style: TextStyle(
                              fontFamily: FontFamily.regular,
                              fontSize: 14),),
                          SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  controller.approveCustomer(customer.customerId!);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green, // Set the button background color
                                ),
                                child: Text('Approve',
                                  style: TextStyle(
                                    color:  Colors.white,
                                      fontFamily: FontFamily.semiBold,
                                      fontSize: 17),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }
}
