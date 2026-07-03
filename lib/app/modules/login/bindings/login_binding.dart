import 'package:get/get.dart';
import 'package:gurukrupa/app/modules/company_code/controllers/company_code_controller.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => CompanyCodeController(), fenix: true);
  }
}
