import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gurukrupa/app/commons/all.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/modules/bottom_bar/controllers/bottom_bar_controller.dart';

import '../../../api_common/api_function.dart';
import '../../customer/model/promo_message_model.dart';
import '../../login/model/is_admin_model.dart';
import '../model/offer_image_model.dart';

class PromoMessageController extends GetxController {
  var promoMessage = "".obs;

  TextEditingController addPromoController = TextEditingController();
  BottomBarController bottomBarController = BottomBarController();

  @override
  void onInit() {
    super.onInit();
    apiPromotionalMessage();
    promoMessage.value = Constants.promoMessageModel.message.toString();
  }

  Future<void> apiSavePromotionalMessage(BuildContext context) async {
    var dataRaw = json.encode({
      "message": addPromoController.text.toString(),
    });

    final data = await APIFunction().apiCall(
      apiName: Constants.SavePromoMessage,
      context: Get.context!,
      rawData: dataRaw,
    );

    IsAdminModel model = IsAdminModel.fromJson(data);
    if (model.statusCode == 200) {
      Utils().showToast(message: "Promo message saved Successfully!", context: context);
      apiPromotionalMessage();
      // Get.back();
      // print('isAdmin:: ---- --- ${model.data}');
      // customerList.value = model.data!;
      // GetStorageData.saveBoolean(GetStorageData.isAdmin, model.data!);
      update();
    }
  }

  Future<void> apiPromotionalMessage() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.promoMessage,
      context: Get.context!,
      params: formData,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    PromotionalMessageModel model = PromotionalMessageModel.fromJson(responseData);
    if (model.statusCode == 200) {
      if (model.data?.message != null) {
        Constants.promoMessageModel = model.data!;
        addPromoController.text = model.data!.message!.toString();
        bottomBarController.updatePromoMessage(model.data!.message!);
        // Get.back(result: model.data!.message!);
        update();
      } else {
        Constants.promoMessageModel = PromotionalMessageData(message: "No promotional message available.");
        update();
        // Get.back();
      }
    } else {
      Constants.promoMessageModel = PromotionalMessageData(message: "Failed to load promotional message.");
      update();
    }
  }
}