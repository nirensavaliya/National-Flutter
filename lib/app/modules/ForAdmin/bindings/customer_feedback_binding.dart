import 'package:gurukrupa/app/modules/ForAdmin/controllers/CustomerFeedbackController.dart';
import 'package:gurukrupa/app/modules/ForAdmin/controllers/customer_controller.dart';
import 'package:get/get.dart';

class CustomerFeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FeedbackController>(
      () => FeedbackController(),
    );
  }
}
