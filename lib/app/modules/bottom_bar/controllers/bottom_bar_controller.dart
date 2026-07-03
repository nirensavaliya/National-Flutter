import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gurukrupa/app/api_common/api_function.dart';
import 'package:gurukrupa/app/commons/get_storage_data.dart';
import 'package:gurukrupa/app/modules/bottom_bar/views/main_home_view.dart';
import 'package:gurukrupa/app/modules/bottom_bar/views/report_view.dart';
import 'package:gurukrupa/app/modules/bottom_bar/views/transaction_view.dart';

import '../../../commons/all.dart';
import '../../../commons/api_query_helper.dart';
import '../../../routes/app_pages.dart';
import '../../customer/model/brand_list_model.dart';
import '../../customer/model/get_catefory_brand_list_model.dart';
import '../../customer/model/promo_message_model.dart';
import '../model/customer_model.dart';
import '../model/dashboard_model.dart';
import '../model/get_branch_list_model.dart';
import '../model/get_gst_model.dart';
import '../model/get_item_list.dart';
import '../model/get_permission_model.dart';
import '../model/offer_image_model.dart';

class BottomBarController extends GetxController {
  RxInt indexCount = 0.obs;
  List<DashboardData> dashBoardList = [];
  String todaySale = "";
  String monthSale = "";
  String todayPurchase = "";
  String monthPurchase = "";
  bool isAdmin = true;
  bool isCustomer = false;

  var promoMessage = "No promotional message available.".obs;

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

  Future<void> apiCallDashboard() async {
    FormData formData = FormData.fromMap({});

    final data = await GetAPIFunction().apiCall(
      apiName: Constants.dashboardElements,
      context: Get.context!,
      params: formData,
    );
    var responseData = data is String ? jsonDecode(data) : data;

    DashboardModel model = DashboardModel.fromJson(responseData);
    if (model.statusCode == 200) {
      model.data!.forEach(
        (element) {
          if (element.elementTitle == "Today's Total Sale") {
            todaySale = element.value ?? "0.00";
          } else if (element.elementTitle == "Monthly Total Sale") {
            monthSale = element.value ?? "0.00";
          } else if (element.elementTitle == "Today's Total Purchase") {
            todayPurchase = element.value ?? "0.00";
          } else if (element.elementTitle == "Monthly Total Purchase") {
            monthPurchase = element.value ?? "0.00";
          }
        },
      );
      update();
    } else if (model.statusCode == 401) {
      GetStorageData.saveString(GetStorageData.isOtpVerified, "false");
      Get.offAllNamed(Routes.COMPANY_CODE);
      GetStorageData.removeData(GetStorageData.token);
    }
  }

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
    } else if (model.statusCode == 401) {
      GetStorageData.saveString(GetStorageData.isOtpVerified, "false");
      Get.offAllNamed(Routes.COMPANY_CODE);
      GetStorageData.removeData(GetStorageData.token);
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
    } else if (model.statusCode == 401) {
      GetStorageData.saveString(GetStorageData.isOtpVerified, "false");
      Get.offAllNamed(Routes.COMPANY_CODE);
      GetStorageData.removeData(GetStorageData.token);
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
    } else if (model.statusCode == 401) {
      GetStorageData.saveString(GetStorageData.isOtpVerified, "false");
      Get.offAllNamed(Routes.COMPANY_CODE);
      GetStorageData.removeData(GetStorageData.token);
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
        promoMessage.value = model.data!.message!;
        updatePromoMessage(model.data!.message!);
        update();
      } else {
        Constants.promoMessageModel = PromotionalMessageData(message: "No promotional message available.");
        update();
      }
    } else {
      Constants.promoMessageModel = PromotionalMessageData(message: "Failed to load promotional message.");
      update();
    }
  }

  var offerImage = ''.obs;

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
      if (model.data != null) {
        Constants.offerImage = model.data!;
        offerImage.value = model.data!;
        // fetchOfferImage();
        update();
      } else {
        Constants.offerImage = "";
        update();
      }
    } else {
      Constants.offerImage = "";
      update();
    }
  }

  void updatePromoMessage(String message) {
    promoMessage.value = message;
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
    } else if (model.statusCode == 401) {
      GetStorageData.saveString(GetStorageData.isOtpVerified, "false");
      Get.offAllNamed(Routes.COMPANY_CODE);
      GetStorageData.removeData(GetStorageData.token);
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
    } else if (model.statusCode == 401) {
      GetStorageData.saveString(GetStorageData.isOtpVerified, "false");
      Get.offAllNamed(Routes.COMPANY_CODE);
      GetStorageData.removeData(GetStorageData.token);
    }
  }

  @override
  void onInit() {
    isAdmin = GetStorageData.readBoolean(GetStorageData.isAdmin);
    isCustomer = GetStorageData.readBoolean(GetStorageData.isCustomer);
    // isAdmin = false;

    if (isCustomer == false) {
      transactionTab = [
        // CommonModel(image: AppImages.quotation, name: AppString.quotation),
        CommonModel(image: AppImages.salesOrder, name: AppString.salesOrder),
        CommonModel(image: AppImages.invoice, name: AppString.salesInvoice),
        CommonModel(image: AppImages.recipt, name: AppString.recipt)
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
        CommonModel(image: AppImages.payable, name: AppString.outstandingPayables),
        CommonModel(image: AppImages.payable, name: AppString.saleOrderRegister),
      ];
    } else {
      transactionTab = [
        // CommonModel(image: AppImages.quotation, name: AppString.quotation),
        CommonModel(image: AppImages.salesOrder, name: AppString.salesOrder),
        // CommonModel(image: AppImages.recipt, name: AppString.recipt),
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
    apiCallDashboard();
    getBrandListApi();
    apiPromotionalMessage();
    apiOfferImageMessage();
    getCategoryListApi();
    apiCallGetPermission();
    apiCallGetGst();
    apiCallCustomer();
    apiCallBranch();
    apiCallGetItem();
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
