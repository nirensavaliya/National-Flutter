import '../../../commons/all.dart';

class CustomerController extends GetxController {
  RxInt indexCount = 0.obs;

  List<CommonModel> CustomerPending = [
    CommonModel(image: AppImages.pending, name: AppString.customerPending),
    CommonModel(image: AppImages.feedback, name: AppString.customerFeedback),
  ];


  @override
  void onInit() {
    super.onInit();
  }
}

class CommonModel {
  final String? image;
  final String? name;

  CommonModel({
    this.image,
    this.name,
  });
}

