import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:gurukrupa/app/routes/app_pages.dart';
import '../../../api_common/api_function.dart';
import '../../../commons/all.dart';
import '../model/OrderLaterSaleOrder.dart';

class OrderLaterSaleOrderController extends GetxController {
  RxList<OrderLaterSaleOrder> orderList = <OrderLaterSaleOrder>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final String apiUrl = Constants.OrderLaterSaleOrderList;

    try {
      final data = await GetAPIFunction().apiCall(
        apiName: apiUrl,
        context: Get.context!,
        params: FormData(),
      );

      var responseData = data is String ? jsonDecode(data) : data;

      OrderLaterSaleOrderResponse orderResponse = OrderLaterSaleOrderResponse.fromJson(responseData);
      if (orderResponse.statusCode == 200) {
        orderList.value = orderResponse.data ?? [];
        update();
      } else {
        Utils().showToast(message: "Failed to load orders", context: Get.context!);
      }
    } catch (e) {
      Utils().showToast(message: "Error: $e", context: Get.context!);
    }
  }


  void genaratePDFApi() async {

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.pendingSalesOrderPDFurl,
      context: Get.context!,
    );

    print('data ---- ${data}');
    Get.toNamed(Routes.PDF_VIEW, arguments: {
      "html": data,
      "fileName": "Order_Later_Sales_Order"
    });
    // PdfModel model = PdfModel.fromJson(data);
    // Loading.show();
    // Future.delayed(
    //   Duration(seconds: 5),
    //       () {
    //     Loading.dismiss();
    //     Get.toNamed(Routes.PDF_VIEW, arguments: data);
    //   },
    // );
    // if (data.statusCode == 200) {
    //   update();
    // }
  }
}