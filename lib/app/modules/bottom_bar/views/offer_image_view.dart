import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/User/view/order_from_image_view.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';

import '../../../commons/all.dart';
import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_screen.dart';
import '../controllers/offer_image_controller.dart';

class OfferImageView extends GetView<OfferImageController> {
  const OfferImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfferImageController>(
      builder: (controller) {
        return CommonScreen(
          title: 'Offer Image',
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Column(
              children: [
                SalesOrderFormSection(
                  title: 'Upload Image',
                  icon: Icons.image_outlined,
                  children: [
                    Obx(
                      () => Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          color: SplashColors.scaffoldBg,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: SplashColors.primary.withOpacity(0.15),
                          ),
                        ),
                        child: controller.selectedImage.value == null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate_outlined,
                                    size: 48,
                                    color: SplashColors.primary.withOpacity(0.4),
                                  ),
                                  const Gap(10),
                                  Text(
                                    'No Image Selected',
                                    style: TextStyle(
                                      fontFamily: FontFamily.medium,
                                      fontSize: FontSize.s14,
                                      color: const Color(0xFF78829A),
                                    ),
                                  ),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(13),
                                child: Image.file(
                                  controller.selectedImage.value!,
                                  width: double.infinity,
                                  height: 250,
                                  fit: BoxFit.contain,
                                ),
                              ),
                      ),
                    ),
                    const Gap(14),
                    Row(
                      children: [
                        ImageSourceButton(
                          icon: Icons.camera_alt_outlined,
                          label: 'Camera',
                          onTap: controller.pickImageFromCamera,
                        ),
                        const Gap(10),
                        ImageSourceButton(
                          icon: Icons.photo_library_outlined,
                          label: 'Gallery',
                          onTap: controller.pickImageFromGallery,
                        ),
                      ],
                    ),
                  ],
                ),
                const Gap(20),
                CommonButton(
                  btnName: AppString.save,
                  btnColor: SplashColors.primary,
                  onTap: controller.saveData,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
