import 'package:get/get.dart';

import '../controllers/purchase_register_controller.dart';

class PurchaseRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseRegisterController>(
      () => PurchaseRegisterController(),
    );
  }
}
