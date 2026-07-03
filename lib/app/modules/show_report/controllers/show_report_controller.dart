import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gurukrupa/app/api_common/api_function.dart';
import '../../../commons/all.dart';
import '../monhtly_total_purchase_model.dart';
import '../monthly_sale_model.dart';
import '../todays_total_purchase_model.dart';

class ShowReportController extends GetxController {
  List<MonthlySaleData> monthlySaleList = [];
  List<TodayPurchaseData> todayPurchaseList = [];
  List<MonhtlyPurchaseData> monthlyPurchaseList = [];

  Future<void> monthlySaleApiCall() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.monthlyTotalsale,
      context: Get.context!,
      params: formData,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    MonthlyTotalSaleModel model = MonthlyTotalSaleModel.fromJson(responseData);
    if (model.statusCode == 200) {
      monthlySaleList = model.data ?? [];
      update();
    }
  }

  Future<void> todaySaleApiCall() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.todaysTotalsale,
      context: Get.context!,
      params: formData,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    MonthlyTotalSaleModel model = MonthlyTotalSaleModel.fromJson(responseData);
    log("--| ${jsonEncode(model)}");
    if (model.statusCode == 200) {
      monthlySaleList = model.data ?? [];
      update();
    }
  }

  Future<void> todayTotalPurchaseApiCall() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.todaysTotalpurchase,
      context: Get.context!,
      params: formData,
    );

    var responseData = data is String ? jsonDecode(data) : data;

    MonthlyTotalPurchaseModel model = MonthlyTotalPurchaseModel.fromJson(responseData);
    if (model.statusCode == 200) {
      monthlyPurchaseList = model.data ?? [];
      update();
    }
  }

  Future<void> monthlyTotalPurchaseApiCall() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.monthlyTotalpurchase,
      context: Get.context!,
      params: formData,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    MonthlyTotalPurchaseModel model = MonthlyTotalPurchaseModel.fromJson(responseData);
    if (model.statusCode == 200) {
      monthlyPurchaseList = model.data ?? [];
      update();
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments == AppString.todayTotal) {
        todaySaleApiCall();
      } else if (Get.arguments == AppString.monthlyTotal) {
        monthlySaleApiCall();
      }
      else if(Get.arguments == AppString.todayPurchase)
        {
          todayTotalPurchaseApiCall();
        }
      else{
        monthlyTotalPurchaseApiCall();
      }
    }
    super.onInit();
  }
}
