import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/data/common_widget/common_button.dart';
import 'package:gurukrupa/app/data/common_widget/common_textfeild.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignUpController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          extendBodyBehindAppBar: false,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                    const Text(
                      "Customer Signup",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
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
          // appBar: AppBar(
          //   title: const Text("Customer Signup"),
          //   backgroundColor: Colors.white,
          // ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: controller.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextField(
                    isTitle: true,
                    controller: controller.customerNameController,
                    title: "Customer Name",
                    hintText: "Enter customer name",
                    textInputAction: TextInputAction.next,
                    // validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 10),
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
                    isTitle: true,
                    controller: controller.address1Controller,
                    title: "Address 1",
                    hintText: "Enter address 1",
                    textInputAction: TextInputAction.next,
                    // validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 10),
                  CommonTextField(
                    isTitle: true,
                    controller: controller.address2Controller,
                    title: "Address 2",
                    hintText: "Enter address 2",
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
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
                  CommonTextField(
                    isTitle: true,
                    controller: controller.mobileNumberController,
                    title: "Mobile Number",
                    hintText: "Enter mobile number",
                    textInputAction: TextInputAction.next,
                    // validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  const SizedBox(height: 10),
                  CommonTextField(
                    isTitle: true,
                    controller: controller.alternateMobileNumberController,
                    title: "Alternate Mobile Number",
                    hintText: "Enter alternate mobile number",
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 10),
                  CommonTextField(
                    isTitle: true,
                    controller: controller.contactPersonController,
                    title: "Contact Person",
                    hintText: "Enter contact person name",
                    textInputAction: TextInputAction.next,
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
                  const SizedBox(height: 20),
                  CommonButton(
                    btnName: "Signup",
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
