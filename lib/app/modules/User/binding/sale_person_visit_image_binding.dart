import 'package:get/get.dart';
import 'package:gurukrupa/app/modules/User/controller/sale_person_visit_image_controller.dart';

class SalePersonVisitImageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalePersonVisitImageController>(
      () => SalePersonVisitImageController(),
    );
  }
}
