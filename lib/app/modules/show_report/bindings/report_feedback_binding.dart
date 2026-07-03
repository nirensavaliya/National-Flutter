import 'package:gurukrupa/app/modules/show_report/controllers/feedback_controller.dart';
import 'package:get/get.dart';

import '../controllers/show_report_controller.dart';

class ReportFeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportFeedbackController>(
      () => ReportFeedbackController(),
    );
  }
}
