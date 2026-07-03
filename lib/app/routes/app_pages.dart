import 'package:gurukrupa/app/modules/ForAdmin/views/PendingCustomerView.dart';
import 'package:gurukrupa/app/modules/ForAdmin/views/customer_view.dart';
import 'package:gurukrupa/app/modules/Recipt/binding/receipt_binding.dart';
import 'package:gurukrupa/app/modules/Recipt/views/receipt_add_view.dart';
import 'package:gurukrupa/app/modules/Recipt/views/receipt_view.dart';
import 'package:gurukrupa/app/modules/User/binding/order_from_image_binding.dart';
import 'package:gurukrupa/app/modules/User/binding/sale_person_visit_image_binding.dart';
import 'package:gurukrupa/app/modules/User/binding/user_main_binding.dart';
import 'package:gurukrupa/app/modules/User/controller/order_from_image_controller.dart';
import 'package:gurukrupa/app/modules/User/view/order_from_image_view.dart';
import 'package:gurukrupa/app/modules/User/view/sale_person_visit_image_view.dart';
import 'package:gurukrupa/app/modules/User/view/user_main_view.dart';
import 'package:gurukrupa/app/modules/bottom_bar/bindings/offer_image_binding.dart';
import 'package:gurukrupa/app/modules/bottom_bar/views/offer_image_view.dart';
import 'package:gurukrupa/app/modules/customer/bindings/add_sale_order_customer_binding.dart';
import 'package:gurukrupa/app/modules/customer/bindings/pending_sale_order_binding.dart';
import 'package:gurukrupa/app/modules/customer/view/add_sales_order_customer_view.dart';
import 'package:gurukrupa/app/modules/customer/view/order_later_sale_order_view.dart';
import 'package:gurukrupa/app/modules/customer/view/pending_sale_order_view.dart';
import 'package:gurukrupa/app/modules/profile/views/profile_view.dart';
import 'package:gurukrupa/app/modules/sale_order_register/views/sale_order_register_view.dart';
import 'package:gurukrupa/app/modules/show_report/views/feedback_view.dart';
import 'package:get/get.dart';

import '../modules/ForAdmin/bindings/customer_binding.dart';
import '../modules/ForAdmin/bindings/customer_feedback_binding.dart';
import '../modules/ForAdmin/bindings/pending_customer_binding.dart';
import '../modules/ForAdmin/views/customer_feedback_view.dart';
import '../modules/SignUp/bindings/signup_binding.dart';
import '../modules/SignUp/views/signup_view.dart';
import '../modules/bottom_bar/bindings/add_promo_message.dart';
import '../modules/bottom_bar/bindings/bottom_bar_binding.dart';
import '../modules/bottom_bar/views/bottom_bar_view.dart';
import '../modules/bottom_bar/views/promo_message_view.dart';
import '../modules/claims/bindings/claims_binding.dart';
import '../modules/claims/views/claims_view.dart';
import '../modules/company_code/bindings/company_code_binding.dart';
import '../modules/company_code/views/company_code_view.dart';
import '../modules/customer/bindings/cus_ledger_statement_binding.dart';
import '../modules/customer/bindings/customer_main_binding.dart';
import '../modules/customer/bindings/order_later_sale_order_binding.dart';
import '../modules/customer/view/customer_ledger_statement_view.dart';
import '../modules/customer/view/customer_main_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/item_list/bindings/item_list_binding.dart';
import '../modules/item_list/views/item_list_view.dart';
import '../modules/ledger_statement/bindings/ledger_statement_binding.dart';
import '../modules/ledger_statement/views/ledger_statement_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/outstanding/bindings/outstanding_binding.dart';
import '../modules/outstanding/views/outstanding_view.dart';
import '../modules/pdf_view/bindings/pdf_view_binding.dart';
import '../modules/pdf_view/views/pdf_view_view.dart';
import '../modules/profile/binding/profile_binding.dart';
import '../modules/purchase_register/bindings/purchase_register_binding.dart';
import '../modules/purchase_register/views/purchase_register_view.dart';
import '../modules/quotation/bindings/quotation_binding.dart';
import '../modules/quotation/views/quotation_view.dart';
import '../modules/sale_invoice/bindings/sale_invoice_binding.dart';
import '../modules/sale_invoice/views/sale_invoice_view.dart';
import '../modules/sale_order_register/bindings/sale_order_binding.dart';
import '../modules/sale_register/bindings/sale_register_binding.dart';
import '../modules/sale_register/views/sale_register_view.dart';
import '../modules/sales_order/bindings/sales_order_binding.dart';
import '../modules/sales_order/views/sales_order_view.dart';
import '../modules/show_report/bindings/report_feedback_binding.dart';
import '../modules/show_report/bindings/show_report_binding.dart';
import '../modules/show_report/views/show_report_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () =>  LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_VIEW,
      page: () => const CustomerView(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_Main_VIEW,
      page: () => const CustomerMainHomeView(),
      binding: CustomerMainBinding(),
    ),
    GetPage(
      name: _Paths.USER_MAIN_VIEW,
      page: () => const UserMainHomeView(),
      binding: UserMainBinding(),
    ),
    GetPage(
      name: _Paths.CUS_LEDGER_STATEMENT,
      page: () => const CustomerLedgerStatementView(),
      binding: CusLedgerStatementBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_FROM_IMAGE,
      page: () => const OrderFromImageView(),
      binding: OrderFromImageBinding(),
    ),
    GetPage(
      name: _Paths.SALE_PERSON_VISIT_FROM_IMAGE,
      page: () => const SalePersonVisitImageView(),
      binding: SalePersonVisitImageBinding(),
    ),
    GetPage(
      name: _Paths.PENDING_CUSTOMER,
      page: () => const PendingCustomerView(),
      binding: PendingCustomerBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_FEEDBACK,
      page: () => const FeedbackView(),
      binding: CustomerFeedbackBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SALE_ORDER_CUSTOMER,
      page: () => const AddSalesOrderCustomerView(),
      binding: AddSaleOrderCustomerBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PROMO_MESSAGE,
      page: () => PromoMessageView(),
      binding: AddPromoMessageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_OFFER_IMAGE,
      page: () => OfferImageView(),
      binding: OfferImageBinding(),
    ),
    GetPage(
      name: _Paths.FEEDBACK,
      page: () => const ReportFeedbackView(),
      binding: ReportFeedbackBinding(),
    ),
    GetPage(
      name: _Paths.PENDING_SALE_ORDER,
      page: () => const PendingSaleOrderView(),
      binding: PendingSaleOrderBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_LATER_SALE,
      page: () => const OrderLaterSaleOrderView(),
      binding: OrderLaterSaleOrderBinding(),
    ),
    GetPage(
      name: _Paths.COMPANY_CODE,
      page: () => const CompanyCodeView(),
      binding: CompanyCodeBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_BAR,
      page: () => const BottomBarView(),
      binding: BottomBarBinding(),
    ),
    GetPage(
      name: _Paths.LEDGER_STATEMENT,
      page: () => const LedgerStatementView(),
      binding: LedgerStatementBinding(),
    ),
    GetPage(
      name: _Paths.SHOW_REPORT,
      page: () => const ShowReportView(),
      binding: ShowReportBinding(),
    ),
    GetPage(
      name: _Paths.SALE_REGISTER,
      page: () => const SaleRegisterView(),
      binding: SaleRegisterBinding(),
    ),
    GetPage(
      name: _Paths.PURCHASE_REGISTER,
      page: () => const PurchaseRegisterView(),
      binding: PurchaseRegisterBinding(),
    ),
    GetPage(
      name: _Paths.OUTSTANDING,
      page: () => const OutstandingView(),
      binding: OutstandingBinding(),
    ),
    GetPage(
      name: _Paths.ITEM_LIST,
      page: () => const ItemListView(),
      binding: ItemListBinding(),
    ),
    GetPage(
      name: _Paths.QUOTATION,
      page: () => const QuotationView(),
      binding: QuotationBinding(),
    ),
    GetPage(
      name: _Paths.RECEIPT,
      page: () => const ReceiptView(),
      binding: ReceiptBinding(),
    ),
    GetPage(
      name: _Paths.RECEIPTADDVIEW,
      page: () => const ReceiptAddView(),
      binding: ReceiptBinding(),
    ),
    GetPage(
      name: _Paths.SALES_ORDER,
      page: () => const SalesOrderView(),
      binding: SalesOrderBinding(),
    ),
    GetPage(
      name: _Paths.SALE_INVOICE,
      page: () => const SaleInvoiceView(),
      binding: SaleInvoiceBinding(),
    ),
    GetPage(
      name: _Paths.PDF_VIEW,
      page: () => const PdfViewView(),
      binding: PdfViewBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SALESORDERREGISTER,
      page: () => const SaleOrderRegisterView(),
      binding: SaleOrderRegisterBinding(),
    ),
    GetPage(
      name: _Paths.CLAIMS,
      page: () => const ClaimsView(),
      binding: ClaimsBinding(),
    ),
  ];
}
