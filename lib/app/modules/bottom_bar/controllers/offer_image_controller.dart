import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api_common/api_function.dart';
import '../../../commons/constants.dart';
import '../../../commons/utils.dart';
import '../../login/model/is_admin_model.dart';

class OfferImageController extends GetxController {
  var selectedImage = Rx<File?>(null);
  var descriptionController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<String?> convertImageToBase64(File? imageFile) async {
    if (imageFile == null) return null;
    final bytes = await imageFile.readAsBytes();
    return base64Encode(bytes);
  }

  Future<void> saveData() async {
    if (selectedImage.value == null) {
      Get.snackbar("Error", "Please select an image");
      return;
    }

    // if (descriptionController.text.isEmpty) {
    //   Get.snackbar("Error", "Please enter a description");
    //   return;
    // }

    if (selectedImage.value != null) {
      String? base64String = await convertImageToBase64(selectedImage.value);

      if (base64String != null && base64String.isNotEmpty) {
        print("Base64 String::: $base64String");
        await apiCallOrderFromImage(Get.context!, base64String);
      } else {
        print("Error: Could not convert image to Base64.");
      }
    } else {
      print("Error: No image selected.");
    }
  }

  Future<void> apiCallOrderFromImage(BuildContext context, String base64string) async {
    var dataRaw = json.encode({
      "imageBase64string": base64string.toString(),
      // "description": descriptionController.text.toString(),
    });

    final data = await APIFunction().apiCall(
      apiName: Constants.saveOfferImage,
      context: Get.context!,
      rawData: dataRaw,
    );

    IsAdminModel model = IsAdminModel.fromJson(data);
    print('statusCode:::: ---- --- ${model.statusCode}');
    if (model.statusCode == 200) {
      Utils().showToast(message: "Image Save Successfully!", context: context);
      Get.back();
      update();
    }
  }
}