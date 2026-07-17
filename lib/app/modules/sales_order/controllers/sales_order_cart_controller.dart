import 'package:get/get.dart';

import '../model/sales_order_cart_model.dart';
import '../services/sales_order_cart_service.dart';

class SalesOrderCartController extends GetxController {
  List<SalesOrderCartModel> carts = [];

  @override
  void onInit() {
    loadCarts();
    super.onInit();
  }

  void loadCarts() {
    carts = SalesOrderCartService.loadAll();
    update();
  }

  Future<void> removeCart(String cartId) async {
    await SalesOrderCartService.removeCart(cartId);
    loadCarts();
  }

  Future<void> removeItem(String cartId, int itemIndex) async {
    await SalesOrderCartService.removeItem(cartId, itemIndex);
    loadCarts();
  }

  int get itemCount => carts.length;
}
