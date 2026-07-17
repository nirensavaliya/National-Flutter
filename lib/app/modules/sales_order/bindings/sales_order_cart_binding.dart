import 'package:get/get.dart';

import '../controllers/sales_order_cart_controller.dart';
import '../controllers/sales_order_controller.dart';

class SalesOrderCartBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<SalesOrderController>()) {
      Get.lazyPut<SalesOrderController>(() => SalesOrderController());
    }
    Get.lazyPut<SalesOrderCartController>(() => SalesOrderCartController());
  }
}
