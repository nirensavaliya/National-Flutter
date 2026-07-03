import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../api_common/api_function.dart';
import '../../../commons/all.dart';
import '../model/CustomerFeedbackModel.dart';

class FeedbackController extends GetxController {
  RxList<CustomerFeedback> feedbackList = <CustomerFeedback>[].obs;

  @override
  void onInit() {
    super.onInit();
    apiCallCustomerFeedback(Get.context!);
  }

  Future<void> apiCallCustomerFeedback(BuildContext context) async {
    FormData formData = FormData.fromMap({});

    final String apiUrl;
    apiUrl = "${Constants.customerFeedbacks}";

    try {
      final data = await GetAPIFunction().apiCall(
        apiName: apiUrl,
        context: context,
        params: formData,
      );
      var responseData = data is String ? jsonDecode(data) : data;

      CustomerFeedbackResponse model = CustomerFeedbackResponse.fromJson(responseData);

      if (model.statusCode == 200) {
        feedbackList.value = model.data!;
      }
    } catch (e) {
      // Handle exceptions
      Utils().showToast(message: "Error: ${e.toString()}", context: context);
    }
  }
}
