import 'package:gurukrupa/app/modules/customer/controllers/OrderLaterSaleOrderController.dart';
import 'package:gurukrupa/app/modules/customer/controllers/PendingSaleOrderController.dart';
import 'package:get/get.dart';

import '../controllers/customer_controller.dart';


class OrderLaterSaleOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderLaterSaleOrderController>(
      () => OrderLaterSaleOrderController(),
    );
  }
}
