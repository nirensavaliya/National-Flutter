import 'package:get/get.dart';

import '../controllers/claims_controller.dart';

class ClaimsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClaimsController>(() => ClaimsController());
  }
}
