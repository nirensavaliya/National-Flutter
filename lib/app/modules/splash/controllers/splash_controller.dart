import 'dart:async';

import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';
import 'package:get/get.dart' hide FormData;
import 'dart:math';
import 'package:dio/dio.dart';

import '../../../api_common/api_function.dart';
import '../../../commons/all.dart';
import '../../../commons/constants.dart';
import '../../company_code/controllers/company_code_controller.dart';
import '../../company_code/model/company_code_model.dart';
import '../../company_code/model/company_model.dart';

class SplashController extends GetxController {

  @override
  void onInit() {

    super.onInit();
    navigateToNextScreen();
    print("SplashController onInit started");

    print("Reading storage data...");
    print("isOtpVerified: ${GetStorageData.readString(GetStorageData.isOtpVerified)}");
    print("role: ${GetStorageData.readString(GetStorageData.role)}");
    print("isCustomer: ${GetStorageData.readBoolean(GetStorageData.isCustomer)}");
    print("isAdmin: ${GetStorageData.readBoolean(GetStorageData.isAdmin)}");
    print("isEmployee: ${GetStorageData.readBoolean(GetStorageData.isEmployee)}");
  }

  // Future<void> checkSheetValue() async {
  //   DateTime startTime = DateTime.now();
  //
  //   try {
  //     final data = await GetAPIFunction()
  //         .apiCall(
  //       apiName:
  //       "https://script.google.com/macros/s/AKfycbzRnaYIoPBUZjNYlk2yho7Iu09SqAp8A5Hi9DaZoMbtD57cJoX9vuoES3tCbyvfPt_b/exec",
  //       context: Get.context!,
  //       isLoading: false
  //     )
  //         .timeout(Duration(seconds: 5)); // Set timeout limit
  //
  //     DateTime responseTime = DateTime.now();
  //     Duration elapsedTime = responseTime.difference(startTime);
  //
  //     // Ensure a minimum splash duration of 3 seconds
  //     int remainingTime = 3000 - elapsedTime.inMilliseconds;
  //     if (remainingTime > 0) {
  //       await Future.delayed(Duration(milliseconds: remainingTime));
  //     }
  //
  //     if (data != null && data['data'] != null) {
  //       bool sheetValue = data['data'].toString().toLowerCase() == "true";
  //
  //       if (sheetValue) {
  //         print("Splash screen to next screen, value is TRUE");
  //         navigateToNextScreen();
  //       } else {
  //         print("Stay on splash screen, value is FALSE");
  //       }
  //     } else {
  //       print("API returned null data, navigating to next screen");
  //       navigateToNextScreen();
  //     }
  //   } catch (e) {
  //     print("API call failed or timed out: $e");
  //
  //     DateTime endTime = DateTime.now();
  //     Duration elapsedTime = endTime.difference(startTime);
  //     int remainingTime = 3000 - elapsedTime.inMilliseconds;
  //     if (remainingTime > 0) {
  //       await Future.delayed(Duration(milliseconds: remainingTime));
  //     }
  //
  //     navigateToNextScreen(); // Navigate even if API fails
  //   }
  // }




  // getToken() {
  //   if (GetStorageData.containKey(GetStorageData.token)) {
  //     print(
  //         "if gettoken-- ${GetStorageData.readString(GetStorageData.token)}");
  //     Get.offAllNamed(Routes.BOTTOM_BAR);
  //   } else {
  //     print(
  //         "ese get token-- ${GetStorageData.readString(GetStorageData.token)}");
  //     Get.offAllNamed(Routes.COMPANY_CODE);
  //   }
  // }

  // void navigateToNextScreen() {
  //   Timer(Duration(seconds: 3), () {
  //     bool isCustomer = GetStorageData.readBoolean(GetStorageData.isCustomer) ?? false;
  //     bool isAdmin = GetStorageData.readBoolean(GetStorageData.isAdmin) ?? false;
  //     bool isEmployee = GetStorageData.readBoolean(GetStorageData.isEmployee) ?? false;
  //
  //     print("Splash navigation check -> isCustomer: $isCustomer, isAdmin: $isAdmin, isEmployee: $isEmployee");
  //
  //     if (GetStorageData.readString(GetStorageData.isOtpVerified) == "true") {
  //       if (isCustomer) {
  //         Get.offAllNamed(Routes.CUSTOMER_Main_VIEW);
  //       } else if (isAdmin) {
  //         Get.offAllNamed(Routes.BOTTOM_BAR);
  //       } else  {
  //         Get.offAllNamed(Routes.USER_MAIN_VIEW);
  //       }
  //     } else {
  //       Get.offAllNamed(Routes.LOGIN);
  //     }
  //   });
  // }


  void navigateToNextScreen()async {
    Timer(Duration(seconds: 3), () {
      print(
          "GetStorageData-- ${GetStorageData.readString(GetStorageData.token)}");
      print(
          "GetStorageData-- ${GetStorageData.readString(GetStorageData.isOtpVerified)}");

   if (GetStorageData.readString(GetStorageData.isOtpVerified) == "true") {
    if (GetStorageData.readBoolean(GetStorageData.isCustomer) == true) {
      Get.offAllNamed(Routes.CUSTOMER_Main_VIEW);
    } else {
      if (GetStorageData.readBoolean(GetStorageData.isAdmin) == true) {
        Get.offAllNamed(Routes.BOTTOM_BAR);
      } else {
        Get.offAllNamed(Routes.USER_MAIN_VIEW);
      }
    }
  } else {
         GetStorageData.saveBoolean(GetStorageData.isCustomer, false);
        Get.offAllNamed(Routes.LOGIN ,  arguments: {
        'isEmployee': true,
        },);
        // getToken();
        // Get.offAllNamed(Routes.COMPANY_CODE);
      }
    });
  }


}




// void navigateToNextScreen() {
//   print(
//       "GetStorageData-- ${GetStorageData.readString(GetStorageData.token)}");
//   print(
//       "GetStorageData-- ${GetStorageData.readString(GetStorageData.isOtpVerified)}");
//
//   if (GetStorageData.readString(GetStorageData.isOtpVerified) == "true") {
//     if (GetStorageData.readBoolean(GetStorageData.isCustomer) == true) {
//       Get.offAllNamed(Routes.CUSTOMER_Main_VIEW);
//     } else {
//       if (GetStorageData.readBoolean(GetStorageData.isAdmin) == true) {
//         Get.offAllNamed(Routes.BOTTOM_BAR);
//       } else {
//         Get.offAllNamed(Routes.USER_MAIN_VIEW);
//       }
//     }
//   } else {
//     Get.offAllNamed(Routes.LOGIN);
//     print("else-- ${GetStorageData.readString(GetStorageData.token)}");
//     // getToken();
//   }
// }
