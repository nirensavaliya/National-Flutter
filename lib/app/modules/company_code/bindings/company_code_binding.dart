import 'package:get/get.dart';

import '../controllers/company_code_controller.dart';

class CompanyCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyCodeController>(
      () => CompanyCodeController(),
    );
  }
}
