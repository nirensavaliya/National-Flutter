import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gurukrupa/app/api_common/api_function.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/modules/company_code/controllers/company_code_controller.dart';
import 'package:gurukrupa/app/modules/login/model/login_model.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:telephony_info_plus/telephony_info_plus.dart';
import 'package:telephony_info_plus/telephony_info_plus_platform_interface.dart';

import '../../../commons/all.dart';
import '../../../routes/app_pages.dart';
import '../../company_code/model/company_code_model.dart';
import '../model/demo_response_model.dart';
import '../model/is_admin_model.dart';
import '../model/otp_model.dart';

class LoginController extends GetxController with CodeAutoFill {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  String token = "";
  String otp = "";
  String otpMsg = "";
  RxBool isLogin = false.obs;
  bool isEmployee = true;
  RxBool isListeningForOtp = false.obs;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController OtpController = TextEditingController();
  final RxString serverOtp = ''.obs;
  final RxString demoToken = ''.obs;

  CompanyCodeController companyCodeController = Get.find<
      CompanyCodeController>();


  @override
  void onInit() {
    final args = Get.arguments as Map<String, dynamic>?;

    if (args != null) {
      isEmployee = args['isEmployee'] ?? false;
    } else {
      isEmployee = false;
    }

    print('isEmployee:: ---- $isEmployee');

    // Initialize OTP listening
    initOtpAutofill();
    companyCodeController.autoLogin(Get.context!);

    super.onInit();
  }

  Future<void> initOtpAutofill() async {
    try {
      // Get app signature for debugging
      var appSignature = await SmsAutoFill().getAppSignature;
      print("App Signature: $appSignature");

      // Start listening for OTP
      await startOtpListening();
    } catch (e) {
      print("Error initializing OTP autofill: $e");
    }
  }

  Future<void> startOtpListening() async {
    try {
      if (!isListeningForOtp.value) {
        isListeningForOtp.value = true;

        // Method 1: Using CodeAutoFill mixin (Primary method)
        listenForCode(); // This will trigger codeUpdated() when OTP is received

        // Method 2: Using SmsAutoFill directly (Secondary method)
        SmsAutoFill().listenForCode();

        print("✅ Started listening for OTP messages");
        print("📱 Waiting for OTP SMS...");
      }
    } catch (e) {
      print("❌ Error starting OTP listener: $e");
      isListeningForOtp.value = false;
    }
  }

  @override
  void codeUpdated() {
    if (code != null && code!.isNotEmpty) {
      print("🎯 OTP DETECTED via codeUpdated(): $code");
      handleReceivedOtp(code!);
    }
  }

  void handleReceivedOtp(String receivedOtp) {
    print("=========================================");
    print("RAW OTP MESSAGE: $receivedOtp");

    final digitOnlyOtp = receivedOtp.replaceAll(RegExp(r'[^0-9]'), '');
    print("DIGITS EXTRACTED: $digitOnlyOtp");

    if (digitOnlyOtp.isNotEmpty) {
      final cleanOtp = digitOnlyOtp.length >= 6
          ? digitOnlyOtp.substring(0, 6)
          : digitOnlyOtp;

      print("CLEANED OTP: $cleanOtp");

      // Update the OTP in controller
      otp = cleanOtp;
      otpController.text = cleanOtp;

      print("📝 OTP CONTROLLER UPDATED: ${otpController.text}");

      // Force UI update
      update();

      // Auto-verify if we're on the OTP screen and OTP is complete
      if (isLogin.value && cleanOtp.length == 6) {
        print("🚀 AUTO-VERIFYING OTP...");
        autoVerifyOtp(cleanOtp);
      }
    } else {
      print("❌ No digits found in OTP message");
    }
    print("=========================================");
  }

  void autoVerifyOtp(String otpCode) {
    print("🔄 Auto-verification triggered in 2 seconds...");
    // Wait 2 seconds to allow user to see the auto-filled OTP
    Future.delayed(Duration(seconds: 2), () {
      verifyOtp(otpCode);
    });
  }

  void stopOtpListening() {
    try {
      cancel(); // Cancel the CodeAutoFill listener
      SmsAutoFill().unregisterListener(); // Cancel SmsAutoFill listener
      isListeningForOtp.value = false;
      print("🛑 Stopped listening for OTP");
    } catch (e) {
      print("❌ Error stopping OTP listener: $e");
    }
  }

  @override
  void dispose() {
    stopOtpListening();
    super.dispose();
  }

  void verifyOtp(String enteredOtp) async {
    print("VERIFYING OTP: $enteredOtp");

    Utils().showToast(message: "Verifying OTP...", context: Get.context!);

    GetStorageData.saveString(GetStorageData.isOtpVerified, "true");

    if (isEmployee == false) {
      await GetStorageData.saveString(GetStorageData.role, "Customer");
      await GetStorageData.saveBoolean(GetStorageData.isCustomer, true);
      Get.offAllNamed(Routes.CUSTOMER_Main_VIEW);
    } else {
      await apiCallIsUserIsAdmin(Get.context!);
    }
  }

  void simulateOtpReception() {
    print("TEST: Simulating OTP reception...");
    handleReceivedOtp("Your OTP is 123456");
    // handleReceivedOtp("Verification code: 789012");
    // handleReceivedOtp("123456 is your login OTP");
  }

  // Rest of your existing methods remain exactly the same...
  void setCustomer() {
    isEmployee = false;
    update();
  }

  void setEmployee() {
    isEmployee = true;
    update();
  }

  void validation(BuildContext context) async {
    if (isEmployee == true) {
      if (Utils().isValidationEmpty(userNameController.text)) {
        AppString.pleaseEnter(AppString.userName);
      } else if (Utils().isValidationEmpty(passwordController.text)) {
        AppString.pleaseEnter(AppString.password);
      } else {
        print('isEmployee:: if --- $isEmployee');
        await apiCallGetToken(context);
        await apiCallEmployeeLogin(context);
      }
    } else {
      if (Utils().isValidationEmpty(mobileNumberController.text)) {
        AppString.pleaseEnter(AppString.mobileNumber);
      } else {
        print('isEmployee:: else --- $isEmployee');
        await apiCallGetToken(context);
        await apiCallCustomerLogin(context);
      }
    }
  }

  Future<void> apiCallSendOtp(BuildContext context) async {
    FormData formData = FormData.fromMap({});
    final String apiUrl;
    if (isEmployee == true) {
      apiUrl = "${Constants.sendOTP}?UserType=Employee";
    } else {
      apiUrl = "${Constants.sendOTP}?UserType=Customer";
    }

    final data = await GetAPIFunction().apiCall(
      apiName: apiUrl,
      context: context,
      params: formData,
    );

    var responseData = safeJsonDecode(data);

    if (responseData == null || responseData is! Map<String, dynamic>) {
      Utils().showToast(
        message: "Invalid response from server",
        context: context,
      );
      return;
    }
    // var responseData = data is String ? jsonDecode(data) : data;

    OtpModel model = OtpModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Get.snackbar(
        "Success!",
        "OTP Sent to your mobile",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      );
      otp = model.data!.otp ?? "";
      otpMsg = model.data!.otpResponse ?? "";

    await startOtpListening();

    // print("📤 OTP Sent via API: $otp");

    update();
    }
  }

  dynamic safeJsonDecode(dynamic data) {
    try {
      if (data is String) {
        return jsonDecode(data);
      }
      return data;
    } catch (e) {
      print("❌ JSON Decode Error: $e");
      return null;
    }
  }

  Future<void> apiCallIsUserIsAdmin(BuildContext context) async {
    FormData formData = FormData.fromMap({});

    try {
      final data = await GetAPIFunction().apiCall(
        apiName: Constants.IsUserIsAdmin,
        context: context,
        params: formData,
      );
      var responseData = data is String ? jsonDecode(data) : data;

      IsAdminModel model = IsAdminModel.fromJson(responseData);

      if (model.statusCode == 200 && model.data != null) {
        print('isAdmin:: ---- ${model.data}');
        if (model.data == true) {
          GetStorageData.saveString(GetStorageData.role, "Admin");
          setRole("Admin");
          Get.offAllNamed(Routes.BOTTOM_BAR);
          print('isAdmin:: if---- ${model.data}');
        } else {
          GetStorageData.saveString(GetStorageData.role, "Employee");
          setRole("Employee");
          Get.offAllNamed(Routes.USER_MAIN_VIEW);
          print('isAdmin:: else---- ${model.data}');
        }
        update();
      }
    } catch (e) {
      Utils().showToast(message: "Error: ${e.toString()}", context: context);
    }
  }

  Future<void> apiCallEmployeeLogin(BuildContext context) async {
    try{
      var dataRaw = json.encode({
        "userName": userNameController.text.toString(),
        "password": passwordController.text.toString()
      });

      final data = await APIFunction().apiCall(
          apiName:
          "https://gurukrupawebapis.azurewebsites.net/api/User/UserLogin",
          context: Get.context!,
          rawData: dataRaw,
          token: token);

      print("RAW RESPONSE: $data");

      dynamic responseData;
      try {
        responseData = data is String ? jsonDecode(data) : data;
      } catch (e) {
        Utils().showToast(
          message: "Invalid server response",
          context: context,
        );
        return; // 🚨 STOP HERE
      }

      if (responseData is! Map<String, dynamic>) {
        Utils().showToast(
          message: "Unexpected response format",
          context: context,
        );
        return; // 🚨 STOP HERE
      }

      // var responseData = data is String ? jsonDecode(data) : data;

      LoginModel model = LoginModel.fromJson(responseData);

      if (model.statusCode == 200) {
        GetStorageData.saveString(GetStorageData.token, model.data!.token);
        GetStorageData.saveString(GetStorageData.role, "Employee");
        setRole("Employee");
        isLogin.value = true;
        await apiCallSendOtp(context);
        update();
      } else {
        Utils().showToast(
            message: model.responseMsg.toString(), context: context);
      }
    }catch (e) {
      Utils().showToast(
        message: "Something went wrong",
        context: context,
      );
    }
  }



  Future<void> apiCallCustomerLogin(BuildContext context) async {
    var dataRaw = json.encode({
      "mobileNo": mobileNumberController.text.toString(),
    });

    final data = await APIFunction().apiCall(
        apiName:
        "https://gurukrupawebapis.azurewebsites.net/api/User/CustomerLogin",
        context: Get.context!,
        rawData: dataRaw,
        token: token);
    var responseData = data is String ? jsonDecode(data) : data;

    LoginModel model = LoginModel.fromJson(responseData);

    if (model.statusCode == 200) {
      GetStorageData.saveString(GetStorageData.token, model.data!.token);
      GetStorageData.saveString(GetStorageData.role, "Customer");
      setRole("Customer");
      isLogin.value = true;
      await apiCallSendOtp(context);
      update();
    } else {
      Utils().showToast(
          message: model.responseMsg.toString(), context: context);
    }
  }

  Future<void> apiCallGetToken(BuildContext context) async {
    FormData formData = FormData.fromMap({});

    try {
      final data = await GetAPIFunction().apiCall(
        apiName:
        'https://gurukrupawebapis.azurewebsites.net/api/User/Selectcompany/YZ9645/48',
        context: context,
        params: formData,
      );
      var responseData = data is String ? jsonDecode(data) : data;

      CompanyCodeTokenModel model = CompanyCodeTokenModel.fromJson(responseData);

      if (model.statusCode == 200) {
        await GetStorageData.saveString(
            GetStorageData.token, model.data!.token);
        update();
      } else if (model.statusCode == 401) {
        print("Unauthorized access: Token expired or invalid");
        await GetStorageData.removeData(GetStorageData.token);
        await GetStorageData.saveBoolean(GetStorageData.isCustomer, false);
      } else {
        Utils().showToast(
            message: model.responseMsg ?? "Unknown error", context: context);
      }
    } catch (e) {
      Utils().showToast(message: "Error: ${e.toString()}", context: context);
    }
  }

  Future<bool> tryDemoCustomerAPI({
    required BuildContext context,
    required String mobileNumber,
  }) async {
    try {
      final url =
          'https://gurukrupawebapis.azurewebsites.net/api/User/SendOTP_DemoCustomer/$mobileNumber';

      final data = await GetAPIFunction().apiCall(
        apiName: url,
        context: context,
        params: null, // GET call
      );
      var responseData = data is String ? jsonDecode(data) : data;

      OtpApiResponse model = OtpApiResponse.fromJson(responseData);

      if (model.statusCode == 200 && model.data != null) {
        isLogin.value = true;
        serverOtp.value = model.data!.otp ?? '';

        demoToken.value = model.data!.token ?? '';
        await GetStorageData.saveString(
            GetStorageData.token, model.data!.token);
        await GetStorageData.saveBoolean(GetStorageData.demoCustomer, true);
        GetStorageData.saveString(GetStorageData.role, "Customer");
        setRole("Customer");
        await GetStorageData.saveString(GetStorageData.role, "Customer");
        await GetStorageData.saveBoolean(GetStorageData.isCustomer, true);
        Utils().showToast(message: model.data!.otp ?? "", context: context);

        return true;
      } else {
        Utils().showToast(message: model.responseMsg ?? "Failed to send OTP",
            context: context);
        return false;
      }
    } catch (e) {
      Utils().showToast(
          message: "Something went wrong while sending OTP", context: context);
      return false;
    }
  }

  void setRole(String role) {
    GetStorageData.saveBoolean(GetStorageData.isAdmin, false);
    GetStorageData.saveBoolean(GetStorageData.isCustomer, false);
    GetStorageData.saveBoolean(GetStorageData.isEmployee, false);

    if (role == "Admin") {
      GetStorageData.saveBoolean(GetStorageData.isAdmin, true);
    } else if (role == "Customer") {
      GetStorageData.saveBoolean(GetStorageData.isCustomer, true);
    } else if (role == "Employee") {
      GetStorageData.saveBoolean(GetStorageData.isEmployee, true);
    }

    GetStorageData.saveString(GetStorageData.role, role);
  }

  // void verifyOtp(String enteredOtp) async {
  //   print("Verifying OTP: $enteredOtp");
  //
  //   // Here you can add your OTP verification logic
  //   // For now, I'll assume the OTP is correct since it came from SMS
  //
  //   GetStorageData.saveString(GetStorageData.isOtpVerified, "true");
  //
  //   if (isEmployee == false) {
  //     await GetStorageData.saveString(GetStorageData.role, "Customer");
  //     await GetStorageData.saveBoolean(GetStorageData.isCustomer, true);
  //     Get.offAllNamed(Routes.CUSTOMER_Main_VIEW);
  //   } else {
  //     apiCallIsUserIsAdmin(Get.context!);
  //   }
  // }

  @override
  void onClose() {
    stopOtpListening();
    super.onClose();
  }
}
