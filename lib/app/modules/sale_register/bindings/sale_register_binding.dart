import 'package:get/get.dart';

import '../controllers/sale_register_controller.dart';

class SaleRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaleRegisterController>(
      () => SaleRegisterController(),
    );
  }
}
