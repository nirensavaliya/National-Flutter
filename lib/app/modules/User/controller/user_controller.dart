import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gurukrupa/app/api_common/api_function.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/modules/bottom_bar/model/customer_model.dart';
import 'package:gurukrupa/app/modules/bottom_bar/model/get_branch_list_model.dart';
import 'package:gurukrupa/app/modules/bottom_bar/model/get_gst_model.dart';
import 'package:gurukrupa/app/modules/bottom_bar/model/get_item_list.dart';
import 'package:gurukrupa/app/modules/bottom_bar/model/get_permission_model.dart';
import 'package:gurukrupa/app/modules/bottom_bar/model/offer_image_model.dart';
import 'package:gurukrupa/app/modules/bottom_bar/views/main_home_view.dart';
import 'package:gurukrupa/app/modules/bottom_bar/views/report_view.dart';
import 'package:gurukrupa/app/modules/bottom_bar/views/transaction_view.dart';
import 'package:gurukrupa/app/modules/customer/model/brand_list_model.dart';

import '../../../commons/all.dart';
import '../../../commons/api_query_helper.dart';
import '../../customer/model/get_catefory_brand_list_model.dart';
import '../../customer/model/promo_message_model.dart';

class UserMainController extends GetxController {
  RxInt indexCount = 0.obs;
  String todaySale = "";
  String monthSale = "";
  String todayPurchase = "";
  String monthPurchase = "";
  bool isAdmin = true;
  bool isCustomer = false;

  List<Widget> screen = [
    MainHomeView(),
    TransactionView(),
    ReportView(),
  ];

  List<CommonModel> transactionTab = [];
  List<CommonModel> reportList = [];

  // List<CommonModel> transactionTab = [
  //   CommonModel(image: AppImages.quotation, name: AppString.quotation),
  //   CommonModel(image: AppImages.salesOrder, name: AppString.salesOrder),
  //   CommonModel(image: AppImages.invoice, name: AppString.salesInvoice)
  // ];
  //
  // List<CommonModel> forCustomerTransactionTab = [
  //   // CommonModel(image: AppImages.quotation, name: AppString.quotation),
  //   CommonModel(image: AppImages.salesOrder, name: AppString.salesOrder),
  //   // CommonModel(image: AppImages.invoice, name: AppString.salesInvoice)
  // ];

  List<CommonModel> CustomerPending = [
    CommonModel(image: AppImages.pending, name: AppString.customerPending),
    CommonModel(image: AppImages.feedback, name: AppString.customerFeedback),
  ];

  // List<CommonModel> reportList = [
  //   CommonModel(image: AppImages.itemList, name: AppString.itemList),
  //   CommonModel(
  //       image: AppImages.ledgerStatement, name: AppString.ledgerStatement),
  //   CommonModel(image: AppImages.saleReister, name: AppString.saleRegister),
  //   CommonModel(
  //       image: AppImages.purchaseRegister, name: AppString.purchaseRegister),
  //   CommonModel(
  //       image: AppImages.receivable, name: AppString.outstandingReceivable),
  //   CommonModel(image: AppImages.payable, name: AppString.outstandingPayables),
  // ];

  Future<void> apiCallCustomer() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getCustomerList,
      context: Get.context!,
      params: formData,
    );

    var responseData = data is String ? jsonDecode(data) : data;

    CustomerModel model = CustomerModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Constants.customerList = model.data ?? [];
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
      // Check if message is available
      if (model.data?.message != null) {
        Constants.promoMessageModel = model.data!;
        update();
      } else {
        // Handle case where message is missing or empty
        Constants.promoMessageModel = PromotionalMessageData(message: "No promotional message available.");
        update();
      }
    } else {
      // Handle error or failed response
      Constants.promoMessageModel = PromotionalMessageData(message: "Failed to load promotional message.");
      update();
    }
  }

  var offerImage = ''.obs;  // Ensure it's an observable

  void updateOfferImage(String newImage) {
    offerImage.value = newImage;
  }

  Future<void> apiOfferImageMessage() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.GetOfferImage,
      context: Get.context!,
      params: formData,
    );

    var responseData = data is String ? jsonDecode(data) : data;

    OfferImageModel model = OfferImageModel.fromJson(responseData);
    if (model.statusCode == 200) {
      // Check if message is available
      if (model.data != null) {
        Constants.offerImage = model.data!;
        offerImage.value = model.data!;
        update();
      } else {
        // Handle case where message is missing or empty
        Constants.offerImage = "";
        update();
      }
    } else {
      // Handle error or failed response
      Constants.offerImage = "";
      update();
    }
  }

  Future<void> apiCallGetPermission() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getUserPermissions,
      context: Get.context!,
      params: formData,
    );

    var responseData = data is String ? jsonDecode(data) : data;

    GetUserPermissionsModel model = GetUserPermissionsModel.fromJson(responseData);

    if (model.statusCode == 200) {
      model.data!.forEach(
        (element) {
          Constants.isAddAllowed = element.allowAddEntry ?? false;
        },
      );
      update();
    }
  }

  Future<void> apiCallGetGst() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getGstTaxList,
      context: Get.context!,
      params: formData,
    );

    var responseData = data is String ? jsonDecode(data) : data;

    GetGstTaxListModel model = GetGstTaxListModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Constants.gstList = model.data ?? [];
      update();
    }
  }

  Future<void> apiCallGetItem({int customerId = 0}) async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: ApiQueryHelper.withCustomerId(Constants.getItemList, customerId),
      context: Get.context!,
      params: formData,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    GetItemListModel model = GetItemListModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Constants.itemList = model.data ?? [];
      update();
    }
  }

  Future<void> getCategoryListApi() async {
    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getCategoryList,
      context: Get.context!,
    );

    var responseData = data is String ? jsonDecode(data) : data;

    GetCategoryBrandListModel model = GetCategoryBrandListModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Constants.categoryBrandList = model.data ?? [];
      update();
    }
  }

  Future<void> getBrandListApi() async {
    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getBrandList,
      context: Get.context!,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    GetBranddListModel model = GetBranddListModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Constants.brandList = model.data ?? [];
      update();
    }
  }

  Future<void> apiCallBranch() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.getBranchList,
      context: Get.context!,
      params: formData,
    );

    var responseData = data is String ? jsonDecode(data) : data;

    GetBranchListModel model = GetBranchListModel.fromJson(responseData);
    if (model.statusCode == 200) {
      Constants.branchList = model.data ?? [];
      update();
    }
  }

  @override
  void onInit() {
    isAdmin = GetStorageData.readBoolean(GetStorageData.isAdmin);
    isCustomer = GetStorageData.readBoolean(GetStorageData.isCustomer);
    // isAdmin = false;

    if (isCustomer == false) {
      transactionTab = [
        CommonModel(image: AppImages.quotation, name: AppString.quotation),
        CommonModel(image: AppImages.salesOrder, name: AppString.salesOrder),
        CommonModel(image: AppImages.invoice, name: AppString.salesInvoice)
      ];

      reportList = [
        CommonModel(image: AppImages.itemList, name: AppString.itemList),
        CommonModel(
            image: AppImages.ledgerStatement, name: AppString.ledgerStatement),
        CommonModel(image: AppImages.saleReister, name: AppString.saleRegister),
        CommonModel(
            image: AppImages.purchaseRegister,
            name: AppString.purchaseRegister),
        CommonModel(
            image: AppImages.receivable, name: AppString.outstandingReceivable),
        CommonModel(
            image: AppImages.payable, name: AppString.outstandingPayables),
      ];
    } else {
      transactionTab = [
        // CommonModel(image: AppImages.quotation, name: AppString.quotation),
        CommonModel(image: AppImages.salesOrder, name: AppString.salesOrder),
        // CommonModel(image: AppImages.invoice, name: AppString.salesInvoice)
      ];

      reportList = [
        // CommonModel(image: AppImages.itemList, name: AppString.itemList),
        CommonModel(image: AppImages.pending, name: AppString.pendingSaleOrder),
        CommonModel(image: AppImages.feedback, name: AppString.Feedback),
        // CommonModel(image: AppImages.saleReister, name: AppString.saleRegister),
        // CommonModel(
        //     image: AppImages.purchaseRegister, name: AppString.purchaseRegister),
        // CommonModel(
        //     image: AppImages.receivable, name: AppString.outstandingReceivable),
        // CommonModel(image: AppImages.payable, name: AppString.outstandingPayables),
      ];
    }

    print("isAdmin -- $isAdmin");
    apiCallGetPermission();
    apiCallGetGst();
    apiPromotionalMessage();
    apiOfferImageMessage();
    apiCallCustomer();
    apiCallBranch();
    apiCallGetItem();
    getCategoryListApi();
    getBrandListApi();
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
