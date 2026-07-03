import 'package:gurukrupa/app/modules/customer/controllers/add_sales_order_customer_controller.dart';
import 'package:get/get.dart';

import '../controllers/PendingSaleOrderController.dart';

class AddSaleOrderCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSalesOrderCustomerController>(
      () => AddSalesOrderCustomerController(),
    );
    Get.lazyPut<PendingSaleOrderController>(
          () => PendingSaleOrderController(),
    );
  }
}
