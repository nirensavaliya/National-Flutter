import 'package:get/get.dart';

import '../controller/order_from_image_controller.dart';

class OrderFromImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderFromImageController>(
      () => OrderFromImageController(),
    );
  }
}
