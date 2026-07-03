import 'package:get/get.dart';

import '../controllers/customer_controller.dart';


class CustomerMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerMainController>(
      () => CustomerMainController(),
    );
  }
}
