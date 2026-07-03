import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gurukrupa/app/api_common/loading.dart';
import 'package:gurukrupa/app/modules/SignUp/model/signup_model.dart';

import '../../../commons/all.dart';
import '../../../commons/get_storage_data.dart';
// import '../model/otp_model.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  String token = "";

  TextEditingController customerNameController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController alternateMobileNumberController =
      TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  TextEditingController gstinNumberController = TextEditingController();
  // TextEditingController userNameController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    if (Get.arguments != null) {
      token = Get.arguments;
    }
    super.onInit();
  }

  void validation(BuildContext context) {
    if (Utils().isValidationEmpty(customerNameController.text)) {
      AppString.pleaseEnter(AppString.CustomerName);
    }
    // else if (Utils().isValidationEmpty(userNameController.text)) {
    //   AppString.pleaseEnter(AppString.userName);
    // } else if (Utils().isValidationEmpty(passwordController.text)) {
    //   AppString.pleaseEnter(AppString.password);
    // }
    else if (Utils().isValidationEmpty(address1Controller.text)) {
      AppString.pleaseEnter(AppString.Address1);
    }
    // else if (Utils().isValidationEmpty(address2Controller.text)) {
    //   AppString.pleaseEnter(AppString.Address2);
    // }
    // else if (Utils().isValidationEmpty(stateController.text)) {
    //   AppString.pleaseEnter(AppString.State);
    // } else if (Utils().isValidationEmpty(cityController.text)) {
    //   AppString.pleaseEnter(AppString.City);
    // }
    // else if (Utils().isValidationEmpty(areaController.text)) {
    //   AppString.pleaseEnter(AppString.Area);
    // }
    else if (Utils().isValidationEmpty(mobileNumberController.text)) {
      AppString.pleaseEnter(AppString.MobileNumber);
    }
    // else if (Utils().isValidationEmpty(alternateMobileNumberController.text)) {
    //   AppString.pleaseEnter(AppString.AlternateMobileNumber);
    // }
    else if (Utils().isValidationEmpty(contactPersonController.text)) {
      AppString.pleaseEnter(AppString.ContactPerson);
    }
    // else if (Utils().isValidationEmpty(panNumberController.text)) {
    //   AppString.pleaseEnter(AppString.PANNumber);
    // } else if (Utils().isValidationEmpty(gstinNumberController.text)) {
    //   AppString.pleaseEnter(AppString.GSTINNumber);
    // }
    else {
      apiCallSignUp(context);
    }
  }

  Future<void> apiCallSignUp(BuildContext context) async {
    Loading.show();

    var headers = {
      'accept': '*/*',
      'Authorization': 'Bearer ${GetStorageData.readString(GetStorageData.token)}',
      'Content-Type': 'application/json',
      'Cookie':
          'ARRAffinity=ad26f9a6bd8a60cc0a709ea5aba83deeee69ecdeb9e8ed99f43a1cd50f09889a; ARRAffinitySameSite=ad26f9a6bd8a60cc0a709ea5aba83deeee69ecdeb9e8ed99f43a1cd50f09889a'
    };
    print('headers-------${headers}');

    var data = json.encode({
      "customerName": customerNameController.text,
      "address1": address1Controller.text,
      "address2": address2Controller.text,
      "state": stateController.text,
      "city": cityController.text,
      "area": areaController.text,
      "mobileNumber": mobileNumberController.text,
      "alternateMobileNumber": alternateMobileNumberController.text,
      "contactPerson": contactPersonController.text,
      "panNumber": panNumberController.text,
      "gstinNumber": gstinNumberController.text,
      // "userName": userNameController.text,
      // "password": passwordController.text,
    });
    var dio = Dio();
    var response = await dio.request(
      'https://gurukrupawebapis.azurewebsites.net/api/User/CustomerSignup',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    print("Status Code: ${response.statusCode}");
    print("Success Response: ${response.data}");


    SignUpModel model = SignUpModel.fromJson(response.data);

    if (model.statusCode == 200) {
      Loading.dismiss();
      update();
      Utils()
          .showToast(message: "Account Create Successfully!", context: context);
      Get.back();
    } else {
      Loading.dismiss();
      log(response.statusMessage ?? "");
    }
  }
}
