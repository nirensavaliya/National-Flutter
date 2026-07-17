import 'package:gap/gap.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/data/common_widget/common_button.dart';
import 'package:gurukrupa/app/data/common_widget/common_textfeild.dart';
import 'package:gurukrupa/app/modules/sales_order/views/sales_order_form_ui.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignUpController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (controller) {
        return CommonScreen(
          title: 'Customer Signup',
          brandAppBar: true,
          scaffoldColor: SplashColors.scaffoldBg,
          body: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  SalesOrderFormSection(
                    title: 'Customer Information',
                    icon: Icons.person_outline,
                    children: [
                      CommonTextField(
                        borderRadius: 12,
                        isTitle: true,
                        controller: controller.customerNameController,
                        title: 'Customer Name',
                        hintText: 'Enter customer name',
                        textInputAction: TextInputAction.next,
                        // validator: (value) => value!.isEmpty ? "Required" : null,
                      ),
                      const Gap(12),
                      // CommonTextField(
                      //   isTitle: true,
                      //   controller: controller.userNameController,
                      //   title: "Username",
                      //   hintText: "Enter username",
                      //   // validator: (value) => value!.isEmpty ? "Required" : null,
                      // ),
                      // const SizedBox(height: 10),
                      // CommonTextField(
                      //   isTitle: true,
                      //   controller: controller.passwordController,
                      //   title: "Password",
                      //   hintText: "Enter password",
                      //   obscureText: true,
                      //   // validator: (value) => value!.isEmpty ? "Required" : null,
                      // ),
                      // const SizedBox(height: 10),
                      CommonTextField(
                        borderRadius: 12,
                        isTitle: true,
                        controller: controller.mobileNumberController,
                        title: 'Mobile Number',
                        hintText: 'Enter mobile number',
                        textInputAction: TextInputAction.next,
                        // validator: (value) => value!.isEmpty ? "Required" : null,
                      ),
                      const Gap(12),
                      CommonTextField(
                        borderRadius: 12,
                        isTitle: true,
                        controller: controller.alternateMobileNumberController,
                        title: 'Alternate Mobile Number',
                        hintText: 'Enter alternate mobile number',
                        textInputAction: TextInputAction.next,
                      ),
                      const Gap(12),
                      CommonTextField(
                        borderRadius: 12,
                        isTitle: true,
                        controller: controller.contactPersonController,
                        title: 'Contact Person',
                        hintText: 'Enter contact person name',
                        textInputAction: TextInputAction.next,
                      ),
                    ],
                  ),
                  const Gap(12),
                  SalesOrderFormSection(
                    title: 'Address',
                    icon: Icons.location_on_outlined,
                    children: [
                      CommonTextField(
                        borderRadius: 12,
                        isTitle: true,
                        controller: controller.address1Controller,
                        title: 'Address 1',
                        hintText: 'Enter address 1',
                        textInputAction: TextInputAction.next,
                        // validator: (value) => value!.isEmpty ? "Required" : null,
                      ),
                      const Gap(12),
                      CommonTextField(
                        borderRadius: 12,
                        isTitle: true,
                        controller: controller.address2Controller,
                        title: 'Address 2',
                        hintText: 'Enter address 2',
                        textInputAction: TextInputAction.next,
                      ),
                      const Gap(12),
                      // CommonTextField(
                      //   isTitle: true,
                      //   controller: controller.areaController,
                      //   title: "Area",
                      //   hintText: "Enter area",
                      //   textInputAction: TextInputAction.next,
                      // ),
                      // const SizedBox(height: 10),
                      // CommonTextField(
                      //   isTitle: true,
                      //   controller: controller.cityController,
                      //   title: "City",
                      //   hintText: "Enter city",
                      //   textInputAction: TextInputAction.next,
                      //   // validator: (value) => value!.isEmpty ? "Required" : null,
                      // ),
                      // const SizedBox(height: 10),
                      // CommonTextField(
                      //   isTitle: true,
                      //   controller: controller.stateController,
                      //   title: "State",
                      //   hintText: "Enter state",
                      //   textInputAction: TextInputAction.next,
                      //   // validator: (value) => value!.isEmpty ? "Required" : null,
                      // ),
                      // const SizedBox(height: 10),
                    ],
                  ),
                  // const SizedBox(height: 10),
                  // CommonTextField(
                  //   isTitle: true,
                  //   controller: controller.panNumberController,
                  //   title: "PAN Number",
                  //   hintText: "Enter PAN number",
                  //   textInputAction: TextInputAction.next,
                  // ),
                  // const SizedBox(height: 10),
                  // CommonTextField(
                  //   isTitle: true,
                  //   controller: controller.gstinNumberController,
                  //   title: "GSTIN Number",
                  //   hintText: "Enter GSTIN number",
                  //   textInputAction: TextInputAction.done,
                  // ),
                  const Gap(20),
                  CommonButton(
                    btnName: 'Signup',
                    btnColor: SplashColors.primary,
                    onTap: () {
                      if (controller.formKey.currentState!.validate()) {
                        // controller.signup(context);
                        controller.validation(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
