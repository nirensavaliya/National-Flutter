import 'package:gurukrupa/app/modules/ForAdmin/controllers/customer_controller.dart';
import 'package:get/get.dart';

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerController>(
      () => CustomerController(),
    );
  }
}
