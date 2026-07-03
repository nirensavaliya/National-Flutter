import 'package:gurukrupa/app/modules/ForAdmin/controllers/PendingCustomerController.dart';
import 'package:gurukrupa/app/modules/ForAdmin/controllers/customer_controller.dart';
import 'package:get/get.dart';

class PendingCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendingCustomerController>(
      () => PendingCustomerController(),
    );
  }
}
