import 'package:get/get.dart';
import 'package:gurukrupa/app/modules/bottom_bar/controllers/promo_message_controller.dart';

import '../controllers/bottom_bar_controller.dart';

class AddPromoMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PromoMessageController>(
      () => PromoMessageController(),
    );
  }
}
