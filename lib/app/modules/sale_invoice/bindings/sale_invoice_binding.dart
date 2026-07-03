import 'package:get/get.dart';

import '../controllers/sale_invoice_controller.dart';

class SaleInvoiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaleInvoiceController>(
      () => SaleInvoiceController(),
    );
  }
}
