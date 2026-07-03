import 'package:get/get.dart';

import '../controller/user_controller.dart';

class UserMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserMainController>(
      () => UserMainController(),
    );
  }
}
