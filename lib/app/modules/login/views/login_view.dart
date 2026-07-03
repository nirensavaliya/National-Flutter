import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/data/common_widget/common_button.dart';
import 'package:gurukrupa/app/data/common_widget/common_textfeild.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../commons/app_colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              // ── Splash jaisa background ──
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.3),
                    radius: 1.2,
                    colors: [
                      SplashColors.primaryLight,
                      SplashColors.primary,
                      SplashColors.primaryDeep,
                    ],
                    stops: [0.0, 0.5, 1.0],
                  ),
                ),
              ),

              // Optional: subtle bed texture (splash jaisa)
              Positioned.fill(
                child: Image.asset(
                  'assets/images/img_bed.png',
                  fit: BoxFit.cover,
                  color: SplashColors.primaryDeep.withOpacity(0.35),
                  colorBlendMode: BlendMode.hardLight,
                ),
              ),

              // Dark vignette — card readable rahe
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      SplashColors.primaryDeep.withOpacity(0.3),
                      Colors.transparent,
                      SplashColors.primaryDeep.withOpacity(0.45),
                    ],
                  ),
                ),
              ),

              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
                    child: Column(
                      children: [
                        // Container(
                        //   width: 72,
                        //   height: 72,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(16),
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.black.withOpacity(0.15),
                        //         blurRadius: 20,
                        //         offset: const Offset(0, 8),
                        //       ),
                        //     ],
                        //   ),
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(16),
                        //     child: Image.asset(
                        //       AppImages.appIcon_g,
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                        // const Gap(5),
                        Text(
                          AppString.appName.toUpperCase(),
                          style: TextStyle(
                            fontFamily: FontFamily.bold,
                            fontSize: 20,
                            color: SplashColors.text,
                            letterSpacing: 4,
                          ),
                        ),
                        Text(
                          'Premium Mattresses',
                          style: TextStyle(
                            fontFamily: FontFamily.medium,
                            fontSize: 11,
                            color: SplashColors.subText.withOpacity(0.9),
                            letterSpacing: 3,
                          ),
                        ),
                        const Gap(24),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(22, 28, 22, 24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 30,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppString.welcomeBack,
                                style: TextStyle(
                                  fontFamily: FontFamily.PlayfairDisplayBold,
                                  fontSize: 26,
                                  color: SplashColors.primaryDark,
                                ),
                              ),
                              const Gap(4),
                              Text(
                                AppString.pleaseLoginToContinue,
                                style: TextStyle(
                                  fontFamily: FontFamily.regular,
                                  fontSize: FontSize.s14,
                                  color: Colors.black54,
                                ),
                              ),

                              if (controller.isEmployee == true) const Gap(24),
                              if (controller.isEmployee == true)
                                CommonTextField(
                                  isTitle: true,
                                  controller: controller.userNameController,
                                  borderRadius: 12,
                                  hintText: AppString.enterUserName,
                                  title: AppString.userName,
                                  textInputAction: TextInputAction.next,
                                ),
                              if (controller.isEmployee == true) const Gap(14),
                              if (controller.isEmployee == true)
                                CommonTextField(
                                  isTitle: true,
                                  controller: controller.passwordController,
                                  borderRadius: 12,
                                  hintText: AppString.enterPassword,
                                  title: AppString.password,
                                  obscureText: true,
                                  textInputAction: TextInputAction.done,
                                ),
                              if (controller.isEmployee == false) const Gap(20),
                              if (controller.isEmployee == false)
                                CommonTextField(
                                  isTitle: true,
                                  controller: controller.mobileNumberController,
                                  borderRadius: 12,
                                  hintText: AppString.entermobileNumber,
                                  title: AppString.mobileNumber,
                                  textInputAction: TextInputAction.done,
                                ),

                              const Gap(22),
                              CommonButton(
                                btnName: AppString.login,
                                btnColor: SplashColors.primaryDark,
                                textColor: Colors.white,
                                onTap: () {
                                  Utils().hideKeyboard();
                                  controller.validation(context);
                                },
                              ),

                              const Gap(18),
                              GestureDetector(
                                onTap: () {
                                  if (controller.isEmployee) {
                                    GetStorageData.saveBoolean(
                                        GetStorageData.isCustomer, true);
                                    controller.setCustomer();
                                  } else {
                                    GetStorageData.saveBoolean(
                                        GetStorageData.isEmployee, true);
                                    controller.setEmployee();
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    controller.isEmployee
                                        ? "Are you a customer?"
                                        : "Are you a employee?",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: FontFamily.PlayfairDisplayBlack,
                                      color: SplashColors.primary,
                                    ),
                                  ),
                                ),
                              ),

                              if (Platform.isIOS || !kReleaseMode) ...[
                                const Gap(10),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      constraints: BoxConstraints(
                                        maxHeight: MediaQuery.of(context).size.height,
                                        minHeight: 380,
                                      ),
                                      useSafeArea: false,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      builder: (_) => tryDemoView(context),
                                    );
                                  },
                                  child: Center(
                                    child: Text(
                                      "Try Demo",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: SplashColors.primaryDark,
                                        fontFamily: FontFamily.medium,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],

                              // OTP section — card ke andar hi
                              if (controller.isLogin.value) ...[
                                const Gap(18),
                                Text(
                                  controller.otpMsg,
                                  style: TextStyle(
                                    fontFamily: FontFamily.medium,
                                    fontSize: FontSize.s14,
                                    color: SplashColors.primary,
                                  ),
                                ),
                                const Gap(12),
                                _buildOtpBox(context: context, controller:controller.otpController),
                                // CommonTextField(
                                //   isTitle: true,
                                //   controller: controller.otpController,
                                //   borderRadius: 12,
                                //   hintText: "Enter OTP",
                                //   title: "OTP",
                                //   textInputAction: TextInputAction.done,
                                //   onChanged: (value) => controller.otp = value,
                                // ),
                                const Gap(10),
                                Row(
                                  children: [
                                    Icon(
                                      controller.isListeningForOtp.value
                                          ? Icons.check_circle
                                          : Icons.error_outline,
                                      color: controller.isListeningForOtp.value
                                          ? Colors.green
                                          : Colors.grey,
                                      size: 16,
                                    ),
                                    const Gap(6),
                                    Expanded(
                                      child: Text(
                                        controller.isListeningForOtp.value
                                            ? "Listening for OTP messages..."
                                            : "OTP auto-fill not available",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: FontFamily.PlayfairDisplayMedium,
                                          color: controller.isListeningForOtp.value
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(16),
                                CommonButton(
                                  btnName: "Verify OTP",
                                  btnColor: SplashColors.primaryDark,
                                  textColor: Colors.white,
                                  onTap: () {
                                    if (controller.otpController.text.trim().isNotEmpty) {
                                      controller.verifyOtp(
                                          controller.otpController.text.trim());
                                    } else {
                                      Utils().showToast(
                                          message: "Please enter OTP",
                                          context: context);
                                    }
                                  },
                                ),
                              ],

                              if (controller.isEmployee == false) ...[
                                const Gap(8),
                                Center(
                                  child: TextButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.SIGNUP,
                                          arguments: controller.token);
                                    },
                                    child: Text(
                                      "Don't have an account? Create one now.",
                                      style: TextStyle(
                                        color: SplashColors.primary,
                                        fontFamily: FontFamily.semiBold,
                                        fontSize: FontSize.s14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }


  // @override
  // Widget build(BuildContext context) {
  //   return GetBuilder<LoginController>(
  //     builder: (controller) {
  //       return Scaffold(
  //         backgroundColor: Colors.white,
  //         body: ListView(
  //           padding: EdgeInsets.only(
  //               top: MediaQuery.of(context).padding.top + 10,
  //               left: 20,
  //               right: 20),
  //           shrinkWrap: true,
  //           children: [
  //             Gap(25),
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Image.asset(
  //                   AppImages.appIcon_g,
  //                   height: 200,
  //                 ),
  //               ],
  //             ),
  //             Gap(25),
  //             Text(
  //               AppString.welcomeBack,
  //               style: TextStyle(
  //                 fontFamily: FontFamily.bold,
  //                 fontSize: 28,
  //                 color: Colors.indigo,
  //               ),
  //             ),
  //             Text(
  //               AppString.pleaseLoginToContinue,
  //               style: TextStyle(
  //                 fontFamily: FontFamily.semiBold,
  //                 fontSize: FontSize.s18,
  //                 color: Colors.black,
  //               ),
  //             ),
  //             if (controller.isEmployee == true) Gap(30),
  //             if (controller.isEmployee == true)
  //               CommonTextField(
  //                 isTitle: true,
  //                 controller: controller.userNameController,
  //                 borderRadius: 8,
  //                 hintText: AppString.enterUserName,
  //                 title: AppString.userName,
  //                 textInputAction: TextInputAction.next,
  //               ),
  //             if (controller.isEmployee == true) Gap(15),
  //             if (controller.isEmployee == true)
  //               CommonTextField(
  //                 isTitle: true,
  //                 controller: controller.passwordController,
  //                 borderRadius: 8,
  //                 hintText: AppString.enterPassword,
  //                 title: AppString.password,
  //                 obscureText: true,
  //                 textInputAction: TextInputAction.done,
  //               ),
  //             if (controller.isEmployee == false) Gap(15),
  //             if (controller.isEmployee == false)
  //               CommonTextField(
  //                 isTitle: true,
  //                 controller: controller.mobileNumberController,
  //                 borderRadius: 8,
  //                 hintText: AppString.entermobileNumber,
  //                 title: AppString.mobileNumber,
  //                 textInputAction: TextInputAction.done,
  //               ),
  //             Gap(20),
  //             CommonButton(
  //               btnName: AppString.login,
  //               onTap: () {
  //                 Utils().hideKeyboard();
  //                 controller.validation(context);
  //               },
  //             ),
  //             Gap(20),
  //             controller.isEmployee
  //                 ? GestureDetector(
  //               onTap: () {
  //                 GetStorageData.saveBoolean(
  //                     GetStorageData.isCustomer, true);
  //                 controller.setCustomer();
  //               },
  //               child: Center(
  //                 child: Text(
  //                   "Are you a customer?",
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w700,
  //                     color: Colors.indigo,
  //                   ),
  //                 ),
  //               ),
  //             )
  //                 : GestureDetector(
  //               onTap: () {
  //                 GetStorageData.saveBoolean(
  //                     GetStorageData.isEmployee, true);
  //                 controller.setEmployee();
  //               },
  //               child: Center(
  //                 child: Text(
  //                   "Are you a employee?",
  //                   style: TextStyle(
  //                     fontSize: 16,
  //                     fontWeight: FontWeight.w700,
  //                     color: Colors.indigo,
  //                   ),
  //                 ),
  //               ),
  //             ),
  //
  //             Gap(10),
  //             if (Platform.isIOS || !kReleaseMode)
  //               GestureDetector(
  //                 onTap: (){
  //                   showModalBottomSheet(
  //                     context: context,
  //                     constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height, minHeight: 380),
  //                     useSafeArea: false,
  //                     isScrollControlled: true,
  //                     shape: const RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //                     ),
  //                     builder: (_) => tryDemoView(context),
  //                   );
  //                 },
  //                 child: Center(
  //                   child: Text(
  //                     "Try Demo",
  //                     style: TextStyle(
  //                       decoration: TextDecoration.underline,
  //                       color: Colors.black,
  //                       fontFamily: FontFamily.medium,
  //                       fontWeight: FontWeight.w500,
  //                       fontSize: 15,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //
  //             if (controller.isLogin.value) Gap(15),
  //             if (controller.isLogin.value)
  //               Text(
  //                 controller.otpMsg,
  //                 style: TextStyle(
  //                   fontFamily: FontFamily.medium,
  //                   fontSize: FontSize.s16,
  //                   color: Colors.indigo,
  //                 ),
  //               ),
  //             if (controller.isLogin.value) Gap(15),
  //
  //             // OTP Input Section with Auto-fill
  //             if (controller.isLogin.value)
  //               Column(
  //                 children: [
  //                   // OTP Text Field
  //                   CommonTextField(
  //                     isTitle: true,
  //                     controller: controller.otpController,
  //                     borderRadius: 8,
  //                     hintText: "Enter OTP",
  //                     title: "OTP",
  //                     textInputAction: TextInputAction.done,
  //                     onChanged: (value) {
  //                       controller.otp = value;
  //                     },
  //                   ),
  //
  //                   Gap(10),
  //
  //                   // Auto-fill Status Indicator
  //                   Row(
  //                     children: [
  //                       Icon(
  //                         controller.isListeningForOtp.value
  //                             ? Icons.check_circle
  //                             : Icons.error,
  //                         color: controller.isListeningForOtp.value
  //                             ? Colors.green
  //                             : Colors.grey,
  //                         size: 16,
  //                       ),
  //                       Gap(5),
  //                       Text(
  //                         controller.isListeningForOtp.value
  //                             ? "Listening for OTP messages..."
  //                             : "OTP auto-fill not available",
  //                         style: TextStyle(
  //                           fontSize: 12,
  //                           color: controller.isListeningForOtp.value
  //                               ? Colors.green
  //                               : Colors.grey,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //
  //                   Gap(10),
  //
  //                   // Manual OTP Entry Hint
  //                   Text(
  //                     "OTP will be auto-filled when received via SMS",
  //                     style: TextStyle(
  //                       fontSize: 12,
  //                       color: Colors.grey[600],
  //                       fontStyle: FontStyle.italic,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //
  //             if (controller.isLogin.value) Gap(20),
  //             if (controller.isLogin.value)
  //               CommonButton(
  //                 btnName: "Verify OTP",
  //                 onTap: () {
  //                   if (controller.otpController.text.trim().isNotEmpty) {
  //                     controller.verifyOtp(controller.otpController.text.trim());
  //                   } else {
  //                     Utils().showToast(message: "Please enter OTP", context: context);
  //                   }
  //                 },
  //               ),
  //
  //             Gap(2),
  //             if (controller.isEmployee == false)
  //               Center(
  //                 child: TextButton(
  //                   onPressed: () {
  //                     Get.toNamed(Routes.SIGNUP, arguments: controller.token);
  //                   },
  //                   child: Text(
  //                     "Don't have an account? Create one now.",
  //                     style: TextStyle(
  //                       color: Colors.blue[900],
  //                       fontFamily: FontFamily.semiBold,
  //                       fontSize: FontSize.s16,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget tryDemoView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),

      // padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [

            Center(
              child: Container(
                width: 55,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            SizedBox(height: 35),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone Number*',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: FontFamily.bold,
                    ),
                  ),
                  Gap(8),
                  CommonTextField(
                    prefixIconConstraints: const BoxConstraints(
                      minWidth: 0,
                      minHeight: 0,
                    ),
                    isTitle: false,
                    controller: controller.phoneNumberController,
                    borderRadius: 8,
                    textInputType: TextInputType.number,
                    maxLength: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mobile number is required';
                      } else if (value.length != 10) {
                        return 'Mobile number must be 10 digits';
                      } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Mobile number can contain only digits';
                      }
                      return null;
                    },
                    prefix: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        '+91',
                        style: TextStyle(
                          color: Colors.indigo,
                          fontFamily: FontFamily.bold,
                        ),
                      ),
                    ),
                    hintText: 'Enter mobile number',
                  ),
                ],
              ),
            ),

            SizedBox(height: Get.height * 0.14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Obx(
                    () => Stack(
                  children: [
                    CommonButton(
                      textColor: const Color(0xFFF8F8FF),
                      btnName: "Submit",
                      onTap: controller.isLogin.value
                          ? null
                          : () async {
                        Utils().hideKeyboard();

                        if (!_formKey.currentState!.validate()) return;

                        final mobile =
                        controller.phoneNumberController.text.trim();

                        if (mobile.length != 10) {
                          Utils().showToast(
                              message: "Please enter valid mobile number",
                              context: context
                          );
                          return;
                        }

                        controller.isLogin.value = true;

                        final isSuccess =
                        await controller.tryDemoCustomerAPI(
                          context: Get.context!,
                          mobileNumber: mobile,
                        );

                        controller.isLogin.value = false;

                        if (isSuccess == true) {
                          showOtpBottomSheet(Get.context!);
                        }
                      },
                    ),

                    if (controller.isLogin.value)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  void showOtpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height, minHeight: 350),
      isScrollControlled: true,
      useSafeArea: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => otpBottomSheetView(context),
    );
  }

  Widget otpBottomSheetView(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Drag handle
            Center(
              child: Container(
                width: 55,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            Text(
              "Enter OTP",
              style: TextStyle(
                fontSize: 16,
                fontFamily: FontFamily.bold,
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Center(child: _buildOtpBox(context: context,controller: controller.OtpController)),
            ),

            SizedBox(height: Get.height * 0.12),

            CommonButton(
              textColor: const Color(0xFFF8F8FF),
              btnName: "Verify OTP",
              onTap: () async {

                final enteredOtp = controller.OtpController.text.trim();

                if (enteredOtp.isEmpty) {
                  Utils().showToast(
                      message: "OTP required",
                      context: Get.context!
                  );
                  return;
                }

                if (enteredOtp.length != 5) {
                  Utils().showToast(
                      message: "Enter 5 digit OTP",
                      context: Get.context!
                  );
                  return;
                }

                if (!RegExp(r'^[0-9]{5}$').hasMatch(enteredOtp)) {
                  Utils().showToast(
                      message: "OTP must contain only digits",
                      context: Get.context!
                  );
                  return;
                }

                if (enteredOtp != controller.serverOtp.value) {
                  Utils().showToast(
                      message: "Invalid OTP. Please try again.",
                      context: Get.context!
                  );
                  return;
                }

                Utils().showToast(
                    message: "OTP verified successfully",
                    context: Get.context!

                );

                Navigator.pop(context);
                await GetStorageData.saveString(GetStorageData.role, "Customer");
                await GetStorageData.saveBoolean(GetStorageData.isCustomer, true);
                await GetStorageData.saveString(GetStorageData.isOtpVerified, "true");

                /// Redirect to HOME screen
                Get.offAllNamed(Routes.CUSTOMER_Main_VIEW);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox({required BuildContext context,required TextEditingController controller}) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 55,
      textStyle: TextStyle(
        fontSize: 20,
        fontFamily: FontFamily.PlayfairDisplayBlack,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: SplashColors.primary),
      ),
    );

    return Pinput(
      controller: controller,
      length: 5,
      keyboardType: TextInputType.number,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!
            .copyWith(border: Border.all(color: SplashColors.primary, width: 2)),
      ),
      errorPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!
            .copyWith(border: Border.all(color: Colors.red)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'OTP required';
        } else if (value.length != 5) {
          return 'Enter 5 digits';
        }
        return null;
      },
    );
  }


}