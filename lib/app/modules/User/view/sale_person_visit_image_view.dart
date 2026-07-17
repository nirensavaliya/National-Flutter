import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';

import '../../../commons/all.dart';
import '../../../data/common_widget/common_button.dart';
import '../../../data/common_widget/common_textfeild.dart';
import '../controller/sale_person_visit_image_controller.dart';

class SalePersonVisitImageView extends GetView<SalePersonVisitImageController> {
  const SalePersonVisitImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalePersonVisitImageController>(
      builder: (controller) {
        return CommonScreen(
          title: AppString.salesVisitFromImage,
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
                                    color:
                                        SplashColors.primary.withOpacity(0.4),
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
                        // const Gap(10),
                        // ImageSourceButton(
                        //   icon: Icons.photo_library_outlined,
                        //   label: 'Gallery',
                        //   onTap: controller.pickImageFromGallery,
                        // ),
                      ],
                    ),
                  ],
                ),
                const Gap(16),
                SalesOrderFormSection(
                  title: 'Description',
                  icon: Icons.notes_outlined,
                  children: [
                    CommonTextField(
                      controller: controller.descriptionController,
                      borderRadius: 12,
                      title: 'Enter Description',
                      isTitle: true,
                      maxLine: 3,
                      hintText: 'Enter description...',
                    ),
                  ],
                ),
                const Gap(20),
                CommonButton(
                  btnName: AppString.save,
                  btnColor: SplashColors.primary,
                  onTap: () {
                    controller.saveData();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ImageSourceButton extends StatelessWidget {
  const ImageSourceButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: SplashColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: SplashColors.primary, size: 20),
                const Gap(8),
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: FontFamily.semiBold,
                    fontSize: FontSize.s14,
                    color: SplashColors.primaryDark,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
