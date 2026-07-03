import 'package:get/get.dart';
import 'package:gurukrupa/app/modules/Recipt/controllers/receipt_controller.dart';

class ReceiptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiptController>(
      () => ReceiptController(),
    );
  }
}
