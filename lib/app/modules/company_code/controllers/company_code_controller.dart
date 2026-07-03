import 'dart:convert';
import 'dart:math';

// import 'package:dio/dio.dart' ;
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gurukrupa/app/api_common/api_function.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';

import '../../../commons/all.dart';
import '../../../routes/app_pages.dart';
import '../../splash/controllers/splash_controller.dart';
import '../model/company_code_model.dart';
import '../model/company_model.dart';

class CompanyCodeController extends GetxController {
  int key = 0;
  final List<TextEditingController> codeController =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  TextEditingController companyNameController =
      TextEditingController(text: "Select Company");
  RxBool isLoaded = false.obs;
  RxBool isOpen = false.obs;
  RxInt companyId = 0.obs;
  var otpCode = "".obs;
  bool isInitial = true;

  collapse() {
    int newKey = 0;
    do {
      key = new Random().nextInt(10000);
    } while (newKey == key);
  }


  // List companyNameList = [
  //   '1 Tech',
  //   '2 Tech',
  //   '3 Tech',
  // ];

  List<CompanyData> companyNameList = [];

  @override
  void onInit() {
    super.onInit();
    collapse();
    companyId.value = 48;
    // String staticCode = "DE0909";
    // for (int i = 0; i < codeController.length; i++) {
    //   codeController[i].text = staticCode[i];
    // }
    // super.onClose();
  }


  Future<void> autoLogin(BuildContext context) async {

    await apiCallGetCompanyList(context);

    await apiCallGetToken(context);
  }

  Widget buildOtpField(BuildContext context, int index) {
    return SizedBox(
      width: 50,
      height: 55,
      child: Center(
        child: TextField(
          controller: codeController[index],
          focusNode: focusNodes[index],
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.top,
          inputFormatters: [
            UpperCaseTextFormatter(),
          ],
          maxLength: 1,
          cursorHeight: 20,
          style: const TextStyle(fontSize: 24),
          decoration: const InputDecoration(
            counterText: '',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              if (index < codeController.length - 1) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              } else {
                focusNodes[index].unfocus();
              }
            } else {
              if (index > 0) {
                FocusScope.of(context).requestFocus(focusNodes[index - 1]);
              }
            }
            // if (value.isNotEmpty) {
            //   if (index < 5) {
            //     FocusScope.of(context).requestFocus(focusNodes[index + 1]);
            //   }
            // } else if (index > 0) {
            //   FocusScope.of(context).requestFocus(focusNodes[index - 1]);
            // }
          },
        ),
      ),
    );
  }

  String getOtpCode() {
    String otp = '';
    for (var controller in codeController) {
      otp += controller.text;
    }
    return otp;
  }

    var code = "";

  Future<void> apiCallGetCompanyList(BuildContext context) async {
    code = "YZ9645";
    codeController.forEach((element) {
      if(code.isEmpty)
        {
          code = element.text;
        }
      else
        {
          code = code + element.text;
        }
    },);
    FormData formData = FormData.fromMap({});
//DE0909
    final data = await GetAPIFunction().apiCall(
      apiName:
          'https://gurukrupawebapis.azurewebsites.net/api/User/Companylist/YZ9645',
      context: context,
      params: formData,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    CompanyListModel model = CompanyListModel.fromJson(responseData);
    if (model.statusCode == 200) {
      GetStorageData.saveString(GetStorageData.companyCode, code);
        companyNameList = model.data ?? [];
      update();
    }
  }

  // Future<void> apiCallGetToken(BuildContext context) async {
  //   FormData formData = FormData.fromMap({});
  //
  //   final data = await GetAPIFunction().apiCall(
  //     apiName: 'https://gurukrupawebapis.azurewebsites.net/api/User/Selectcompany/YZ9645/48',
  //     // apiName: 'https://gurukrupawebapis.azurewebsites.net/api/User/Selectcompany/$code/$companyId',
  //     context: context,
  //     params: formData,
  //   );
  //   CompanyCodeTokenModel model = CompanyCodeTokenModel.fromJson(data);
  //   if (model.statusCode == 200) {
  //     // showCustomDialog(context,model.data!.token);
  //     GetStorageData.saveBoolean(GetStorageData.isCustomer, false);
  //     GetStorageData.saveString(GetStorageData.token, model.data!.token);
  //
  //     // Get.offAllNamed(
  //     //   Routes.LOGIN,
  //     //   arguments: {
  //     //     'token': model.data!.token,
  //     //     'isEmployee': true,
  //     //   },
  //     // );
  //     update();
  //   }
  // }

  Future<void> apiCallGetToken(BuildContext context) async {
    FormData formData = FormData.fromMap({});

    try {
      final data = await GetAPIFunction().apiCall(
        apiName: 'https://gurukrupawebapis.azurewebsites.net/api/User/Selectcompany/YZ9645/48',
        context: context,
        params: formData,
      );
      var responseData = data is String ? jsonDecode(data) : data;

      CompanyCodeTokenModel model = CompanyCodeTokenModel.fromJson(responseData);

      if (model.statusCode == 200) {
        // Token fetched successfully
        await GetStorageData.saveString(GetStorageData.token, model.data!.token);
        // Optionally save expiry if available here

        await GetStorageData.saveBoolean(GetStorageData.isCustomer, false);
        // navigateToNextScreen();

        update();
      } else if (model.statusCode == 401) {
        // Unauthorized: Token invalid or expired
        print("Unauthorized access: Token expired or invalid");

        // Clear token and other related data
        await GetStorageData.removeData(GetStorageData.token);
        await GetStorageData.saveBoolean(GetStorageData.isCustomer, false);

        // Redirect to login forcing user to authenticate
        Get.offAllNamed(Routes.LOGIN);
      } else {
        // Handle other errors
        Utils().showToast(message: model.responseMsg ?? "Unknown error", context: context);
      }
    } catch (e) {
      // Network error or other exceptions
      Utils().showToast(message: "Error: ${e.toString()}", context: context);
    }
  }

}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

void showCustomDialog(BuildContext context, String? token) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap content
            children: [
              Icon(
                Icons.person,
                size: 70,
                color: Colors.blue[900],
              ),
              const SizedBox(height: 10),
              const Text(
                'Choose Login Type',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Are you a Customer or an Employee?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      // Get.offAllNamed(Routes.LOGIN,arguments: token);
                      GetStorageData.saveBoolean(GetStorageData.isCustomer, true);
                      Get.offAllNamed(
                        Routes.LOGIN,
                        arguments: {
                          'token': token,
                          'isEmployee': false, // Replace with the appropriate boolean value
                        },
                      );
                      // update();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Customer',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16,color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Get.offAllNamed(Routes.LOGIN,arguments: token);
                      GetStorageData.saveBoolean(GetStorageData.isCustomer, false);
                      Get.offAllNamed(
                        Routes.LOGIN,
                        arguments: {
                          'token': token,
                          'isEmployee': true,
                        },
                      );
                      // update();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Employee',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16,color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}