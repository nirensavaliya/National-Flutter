import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gurukrupa/app/modules/User/controller/order_from_image_controller.dart';

import '../../../commons/app_string.dart';
import '../../../commons/font_family.dart';
import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../controllers/offer_image_controller.dart';

class OfferImageView extends GetView<OfferImageController> {
  const OfferImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfferImageController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70), // Custom AppBar height
          child: Container(
            color: Colors.white, // AppBar background color
            padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
            child: SafeArea(
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
                    "Order From Image",
                    style: TextStyle(
                      fontFamily: FontFamily.semiBold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Opacity(
                    opacity: 0.0,
                    // Set to 1.0 to make it visible, 0.0 to make it invisible.
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                      () => Container(
                    width: double.infinity,
                    height: 250, // Increased height for better visibility
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade600, width: 2),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                    ),
                    child: controller.selectedImage.value == null
                        ? const Center(
                      child: Text(
                        "No Image Selected",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        controller.selectedImage.value!,
                        width: double.infinity,
                        height: 250,
                        fit: BoxFit.contain, // Ensures full image is visible
                      ),
                    ),
                  ),
                ),

                Gap(15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: Icon(Icons.camera),
                      label: Text("Camera",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontFamily.semiBold,
                          )),
                      onPressed: controller.pickImageFromCamera,
                    ),
                    ElevatedButton.icon(
                      icon: Icon(Icons.photo_library),
                      label: Text("Gallery",
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: FontFamily.semiBold,
                          )),
                      onPressed: controller.pickImageFromGallery,
                    ),
                  ],
                ),
                Gap(20),
                // TextField(
                //   controller: controller.descriptionController,
                //   decoration: InputDecoration(
                //     labelText: "Enter Description",
                //     border: OutlineInputBorder(),
                //   ),
                //   maxLines: 2,
                // ),
                // Gap(15),
                CommonButton(
                  btnName: AppString.save,
                  onTap: () {
                    controller.saveData();
                  },
                ),
                Gap(15),
              ],
            ),
          ),
        ),
      );
    });
  }
}