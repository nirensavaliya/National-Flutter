import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../commons/font_family.dart';
import '../controllers/CustomerFeedbackController.dart';

class FeedbackView extends GetView<FeedbackController> {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  "Customer Feedback",
                  style: TextStyle(
                    fontFamily: FontFamily.bold,
                    fontSize: 20,
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
      body: Obx(() {
        final feedbackList = Get.find<FeedbackController>().feedbackList;

        if (feedbackList.isEmpty) {
          return Center(
              child: Text(
            "No feedback available",
            style: TextStyle(
                fontFamily: FontFamily.semiBold,
                fontSize: 20,
                color: Colors.black),
          ));
        }

        return ListView.builder(
          itemCount: feedbackList.length,
          itemBuilder: (context, index) {
            var feedback = feedbackList[index];
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
                        feedback.customerName ?? "Unknown Customer",
                        style: TextStyle(
                          fontFamily: FontFamily.semiBold,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text("Mobile: ${feedback.mobileNumber ?? 'N/A'}",
                          style: TextStyle(
                              fontFamily: FontFamily.regular,
                              fontSize: 14,
                              color: Colors.black)),
                      SizedBox(height: 4),
                      Text("Feedback: ${feedback.feedback ?? 'N/A'}",
                          style: TextStyle(
                              fontFamily: FontFamily.regular,
                              fontSize: 14,
                              color: Colors.black)),
                      SizedBox(height: 4),
                      Text("Date: ${feedback.dateTime ?? 'N/A'}",
                          style: TextStyle(
                              fontFamily: FontFamily.regular,
                              fontSize: 14,
                              color: Colors.black)),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
