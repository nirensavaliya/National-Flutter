
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gurukrupa/app/modules/login/model/is_admin_model.dart';

import '../../../api_common/api_function.dart';
import '../../../commons/all.dart';
import '../model/PendingCustomerModel.dart';

class PendingCustomerController extends GetxController {
  RxList<PendingCustomerModel> customerList = <PendingCustomerModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    apiCallPendingCustomer(Get.context!);
  }

  void approveCustomer(int customerId) {
    print("Customer $customerId approved");
    apiCallApproveCustomer(Get.context!,customerId);
  }

  Future<void> apiCallApproveCustomer(BuildContext context, int customerId) async {
    FormData formData = FormData.fromMap({});

    final String apiUrl;
      apiUrl = "${Constants.getApprovedCustomer}?CustomerId=${customerId}";

    try {
      final data = await GetAPIFunction().apiCall(
        apiName: apiUrl,
        context: context,
        params: formData,
      );
      var responseData = data is String ? jsonDecode(data) : data;

      IsAdminModel model = IsAdminModel.fromJson(responseData);

      if (model.statusCode == 200) {

        Utils().showToast(message: "Customer Approved Successfully!", context: context);
        apiCallPendingCustomer(Get.context!);

        // print('isAdmin:: ---- --- ${model.data}');
        // customerList.value = model.data!;
        // GetStorageData.saveBoolean(GetStorageData.isAdmin, model.data!);
        update();
      }
    } catch (e) {
      Utils().showToast(message: "Error: ${e.toString()}", context: context);
    }
  }

  Future<void> apiCallPendingCustomer(BuildContext context) async {
    FormData formData = FormData.fromMap({});

    try {
      final data = await GetAPIFunction().apiCall(
        apiName: Constants.getPendingCustomerList,
        context: context,
        params: formData,
      );

      var responseData = data is String ? jsonDecode(data) : data;

      PendingCustomerResponse model = PendingCustomerResponse.fromJson(responseData);

      if (model.statusCode == 200 && model.data != null) {
        // print('isAdmin:: ---- --- ${model.data}');
        customerList.value = model.data!;
        // GetStorageData.saveBoolean(GetStorageData.isAdmin, model.data!);
        update();
      }
    } catch (e) {
      Utils().showToast(message: "Error: ${e.toString()}", context: context);
    }
  }

}