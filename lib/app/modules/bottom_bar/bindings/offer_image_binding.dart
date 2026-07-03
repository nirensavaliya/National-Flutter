import 'package:get/get.dart';
import 'package:gurukrupa/app/modules/bottom_bar/controllers/offer_image_controller.dart';

class OfferImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferImageController>(
      () => OfferImageController(),
    );
  }
}