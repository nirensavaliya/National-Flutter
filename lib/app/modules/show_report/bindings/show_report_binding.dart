import 'package:get/get.dart';

import '../controllers/show_report_controller.dart';

class ShowReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShowReportController>(
      () => ShowReportController(),
    );
  }
}
