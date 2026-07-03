import 'package:gurukrupa/app/modules/customer/controllers/PendingSaleOrderController.dart';
import 'package:get/get.dart';

import '../controllers/customer_controller.dart';


class PendingSaleOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PendingSaleOrderController>(
      () => PendingSaleOrderController(),
    );
  }
}
