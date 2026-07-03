import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../commons/font_family.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../controllers/promo_message_controller.dart';

class PromoMessageView extends StatelessWidget {
  const PromoMessageView({super.key});

  // Create an instance of the controller
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PromoMessageController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Change Promo Message'),
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter New Promo Message',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: FontFamily.semiBold,
                    color: Colors.black,
                  ),
                ),
                // TextField(
                //   controller:
                //       TextEditingController(text: controller.promoMessage.value),
                //   decoration: InputDecoration(
                //     border: OutlineInputBorder(),
                //     labelText: 'Promo Message',
                //   ),
                //   maxLines: 3,
                //   onChanged: (value) {
                //     controller.updatePromoMessage(value);
                //   },
                // ),
                CommonTextField(
                  borderRadius: 12,
                  controller: controller.addPromoController,
                  isTitle: true,
                  maxLine: 5,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.back();
                          // addItemSheet(selectedWithQty);
                          controller.apiSavePromotionalMessage(Get.context!);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          "Save Promo Message",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: FontFamily.semiBold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}