import 'package:get/get.dart';
import 'package:gurukrupa/app/modules/profile/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController(),
    );
  }
}