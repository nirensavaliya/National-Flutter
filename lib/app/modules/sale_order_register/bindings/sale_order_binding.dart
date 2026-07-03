import 'package:get/get.dart';

import '../controllers/sale_order_register_controller.dart';


class SaleOrderRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SaleOrderRegisterController(),
    );
  }
}
