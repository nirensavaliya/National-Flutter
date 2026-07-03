import 'package:dio/dio.dart';
import 'package:get/get.dart' hide FormData;

import '../../../api_common/api_class.dart';
import '../../../api_common/loading.dart';
import '../../../commons/all.dart';
import '../../../commons/get_storage_data.dart';
import '../../../routes/app_pages.dart';
import '../model/profile_model.dart';

class ProfileController extends GetxController{
  var profile = Rxn<ProfileModel>();

  @override
  void onInit() {
    apiCallGetCustomerProfile();
    super.onInit();
  }

  Future<ProfileModel?> apiCallGetCustomerProfile() async {
    try {
      Loading.show();

      String token = "";
      if (GetStorageData.containKey(GetStorageData.token)) {
        token = GetStorageData.readString(GetStorageData.token);
      }
      final response = await Dio().get(
        "https://gurukrupawebapis.azurewebsites.net/api/Customer/GetCustomerProfile",
        options: Options(
          headers: {
            "accept": "*/*",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        ProfileModel model = ProfileModel.fromJson(response.data);
        print("Customer Profile Fetched: ${model.data?.customerName}");

        profile.value = model;
        update();

        return model;
      } else {
        print("API Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      Utils().showToast(message: "Error fetching profile", context: Get.context!);
      return null;
    }finally {
      Loading.dismiss();
    }
  }

  Future<void> apiCallDeleteCustomer({
    required BuildContext context,
  }) async {
    try {
      Loading.show();

      final token = GetStorageData.token;

      if (token == null || token.isEmpty) {
        Utils().showToast(
          message: "User not logged in",
          context: context,
        );
        return;
      }

      final httpUtil = HttpUtil(token, true, context);

      final response = await httpUtil.get(
        "http://app.anjalidiamonds.in/mobile-api/deletecustomer",
      );

      debugPrint("DELETE RESPONSE: $response");

      if (response != null && response["IsSuccess"] == true){
        Loading.dismiss();

        Utils().showToast(
          message: response["message"] ?? "Account deleted successfully",
          context: context,
        );

        /// clear local data
        GetStorageData.removeData(GetStorageData.token);
        GetStorageData.removeData(GetStorageData.role);

        Get.offAllNamed(Routes.LOGIN);
      } else {
        Loading.dismiss();
        Utils().showToast(
          message: response["message"] ?? "Unable to delete account",
          context: context,
        );
      }
    } catch (e) {
      Loading.dismiss();
      debugPrint("Delete Account Error: $e");
    }
  }




}