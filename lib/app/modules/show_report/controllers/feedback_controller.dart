import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gurukrupa/app/modules/login/model/is_admin_model.dart';
import '../../../api_common/api_function.dart';
import '../../../commons/all.dart';

class ReportFeedbackController extends GetxController {
  TextEditingController feedbackController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // fetchFeedback();
  }

  void validation(BuildContext context) {
    if (Utils().isValidationEmpty(feedbackController.text)) {
      AppString.pleaseEnter(AppString.enterFeedback);
    } else {
      apiCallReportFeedback(context);
    }
  }

  Future<void> apiCallReportFeedback(BuildContext context) async {
    FormData formData = FormData.fromMap({});

    final String apiUrl;
    apiUrl = "${Constants.customerFeedbacks}";

    var dataRaw = json.encode({
      "feedback": feedbackController.text.toString(),
    });

    final data = await APIFunction().apiCall(
      apiName: Constants.SaveFeedBack,
      context: Get.context!,
      rawData: dataRaw,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    IsAdminModel model = IsAdminModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Utils().showToast(message: "Feedback submit Successfully!", context: context);
      Get.back();
      // print('isAdmin:: ---- --- ${model.data}');
      // customerList.value = model.data!;
      // GetStorageData.saveBoolean(GetStorageData.isAdmin, model.data!);
      update();
    }
  }
}