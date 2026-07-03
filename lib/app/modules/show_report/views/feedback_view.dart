import 'package:flutter/material.dart';
import 'package:gurukrupa/app/modules/show_report/controllers/feedback_controller.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../commons/all.dart';
import '../../../commons/font_family.dart';

import 'package:get/get.dart';

class ReportFeedbackView extends GetView<ReportFeedbackController> {
  const ReportFeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReportFeedbackController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),  // Custom AppBar height
            child: Container(
              color: Colors.white,  // AppBar background color
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Get.back(),
                    ),
                    const Spacer(),
                    Text(
                      "Feedback",
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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Feedback TextField
                Text(
                  "Enter your feedback:",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(8),
                TextField(
                  controller: controller.feedbackController,
                  maxLines: 5,  // Allow multiple lines
                  decoration: InputDecoration(
                    hintText: "Write your feedback here...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                Gap(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end, // Aligns the button to the right
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.validation(context);
                      },
                      child: Text(
                        'Save Feedback',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                        backgroundColor: Colors.blue[900], // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}