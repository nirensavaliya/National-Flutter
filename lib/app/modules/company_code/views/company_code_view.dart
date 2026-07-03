import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gurukrupa/app/data/common_widget/common_button.dart';
import 'package:gap/gap.dart';
import 'package:otp_pin_field/otp_pin_field.dart';

import '../../../api_common/loading.dart';
import '../../../commons/all.dart';
import '../controllers/company_code_controller.dart';

class CompanyCodeView extends GetView<CompanyCodeController> {
  const CompanyCodeView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompanyCodeController>(
      builder: (controller) {
        return Scaffold(
            backgroundColor: Colors.white,
            // body: Center(
            //   child: CircularProgressIndicator(), // optional loading indicator while APIs run
            // ),
            body: Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.appIcon_g, height: 250),
                        Gap(20),
                        Text(
                          "Enter Your Client Code",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: FontFamily.semiBold,
                            fontSize: FontSize.s20,
                          ),
                        ),
                        Gap(20),

                        // OtpPinField(
                        //   autoFocus: true,
                        //   showCursor: true,
                        //   maxLength: 6,
                        //   fieldHeight: 55,
                        //   fieldWidth: 50,
                        //   otpPinFieldDecoration: OtpPinFieldDecoration.defaultPinBoxDecoration,
                        //   keyboardType: TextInputType.text,
                        //   onSubmit: (String value) {
                        //     controller.otpCode.value = value;
                        //     debugPrint("OTP submitted: $value");
                        //     Get.snackbar(
                        //       "OTP Submitted",
                        //       "You entered: $value",
                        //       snackPosition: SnackPosition.BOTTOM,
                        //     );
                        //   },
                        //
                        //   otpPinFieldInputType: OtpPinFieldInputType.custom, // Required for custom controllers
                        //   onChange: (String value) {
                        //     controller.otpCode.value = value;
                        //     debugPrint("OTP so far: $value");
                        //   },
                        // ),
                        //
                        // OtpTextField(
                        //   numberOfFields: 6,
                        //   borderColor: Colors.grey,
                        //   showFieldAsBox: true,
                        //   fieldHeight: 55,
                        //   fieldWidth: 50,
                        //   cursorColor: Colors.black,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   alignment: Alignment.center,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   textStyle:  TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        //   borderRadius: BorderRadius.circular(8),
                        //   enabledBorderColor: Colors.grey,
                        //   focusedBorderColor: Colors.blue,
                        //   // handleControllers: (controllers) {
                        //   //   for (int i = 0; i < controllers.length; i++) {
                        //   //     controllers[i]?.text = controller.codeController[i].text;
                        //   //   }
                        //   // },
                        //   handleControllers: (controllers) {
                        //     // DO NOT set text here, it will overwrite user input!
                        //   },
                        //   onCodeChanged: (String code) {
                        //     controller.otpCode.value = code;
                        //     debugPrint("OTP so far: $code");
                        //   },
                        //   inputFormatters: [
                        //     UpperCaseTextFormatter(),
                        //   ],
                        //   clearText: true,
                        //   onSubmit: (String verificationCode) {
                        //     controller.otpCode.value = verificationCode;
                        //     debugPrint("OTP Entered: $verificationCode");
                        //     Get.snackbar(
                        //       "OTP Submitted",
                        //       "You entered: $verificationCode",
                        //       snackPosition: SnackPosition.BOTTOM,
                        //     );
                        //   },
                        // ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              6,
                              (index) =>
                                  controller.buildOtpField(context, index)),
                        ),
                        Gap(20),
                        CommonButton(
                          btnName: AppString.loadCompanyList,
                          onTap: () {
                            controller.isLoaded.value = true;
                            Utils().hideKeyboard();
                            controller.apiCallGetCompanyList(context);
                          },
                        ),
                        Gap(15),
                        if (controller.companyNameList.isNotEmpty)
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    AppString.selectCompany,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: FontFamily.semiBold,
                                      fontSize: FontSize.s20,
                                    ),
                                  ),
                                  Gap(12),
                                  DecoratedBox(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: controller.isOpen.value
                                              ? Colors.blue
                                              : Colors.black26),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Theme(
                                      data: ThemeData(
                                          dividerColor: Colors.transparent),
                                      child: ExpansionTile(
                                        key: Key(controller.key.toString()),
                                        onExpansionChanged: (value) {
                                          print("value -- $value");
                                          controller.isOpen.value = value;
                                          controller.update();
                                        },
                                        title: Text(
                                          controller.companyNameController.text,
                                        ),
                                        children: List.generate(
                                          controller.companyNameList.length,
                                          (index) {
                                            return GestureDetector(
                                              onTap: () {
                                                controller.companyNameController
                                                    .text = controller
                                                        .companyNameList[index]
                                                        .companyName ??
                                                    "";
                                                controller.companyId
                                                    .value = controller
                                                        .companyNameList[index]
                                                        .companyId ??
                                                    0;
                                                controller.collapse();
                                                controller.update();
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text(
                                                  controller
                                                          .companyNameList[
                                                              index]
                                                          .companyName ??
                                                      "",
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(15),
                                  CommonButton(
                                    btnName: AppString.next,
                                    onTap: () {
                                      controller.apiCallGetToken(context);
                                      // Get.offAllNamed(Routes.LOGIN);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            )
        );
      },
    );
  }
}
