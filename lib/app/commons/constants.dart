import 'package:gurukrupa/app/modules/ForAdmin/model/PendingCustomerModel.dart';
import 'package:gurukrupa/app/modules/Recipt/model/BillDataModel.dart';
import 'package:gurukrupa/app/modules/Recipt/model/CashBankBookModel.dart';
import 'package:gurukrupa/app/modules/Recipt/model/GLAccountModel.dart';
import 'package:gurukrupa/app/modules/Recipt/model/ReceiptListModel.dart';
import 'package:gurukrupa/app/modules/customer/model/brand_list_model.dart';
import 'package:gurukrupa/app/modules/customer/model/get_catefory_brand_list_model.dart';
import 'package:gurukrupa/app/modules/customer/model/promo_message_model.dart';

import '../modules/bottom_bar/model/customer_model.dart';
import '../modules/bottom_bar/model/get_branch_list_model.dart';
import '../modules/bottom_bar/model/get_gst_model.dart';
import '../modules/bottom_bar/model/get_item_list.dart';
import 'all.dart';

class Constants {
  // static String baseUrl = 'https://fraxinuswebapis.azurewebsites.net/api/';
  static String baseUrl = 'https://gurukrupawebapis.azurewebsites.net/api/';
  static String apiKey = '';
  static String dashboardElements = 'Dashboard/DashboardElements';
  static String todaysTotalsale = 'Dashboard/TodaysTotalsale';
  static String monthlyTotalsale = 'Dashboard/MonthlyTotalsale';
  static String todaysTotalpurchase = 'Dashboard/TodaysTotalpurchase';
  static String monthlyTotalpurchase = 'Dashboard/MonthlyTotalpurchase';
  static String customerFeedbacks = '/Dashboard/CustomerFeedbacks';
  static String orderFromImage = '/SaleOrder/OrderFromImage';
  static String GetOfferImage = '/Dashboard/GetOfferImage';
  static String saveOfferImage = 'Master/Admin/SaveOfferImage';
  static String salesPersonVisitImage = '/User/SalesPersonVisitImage';
  static String promoMessage = '/Dashboard/PromoMessage';
  static String sendOTP = 'User/SendOTP';
  static String IsUserIsAdmin = 'User/IsUserIsAdmin';
  static String SaveFeedBack = 'Customer/SaveFeedback';
  static String GetItemListByBrandandCategory = 'Master/GetItemListByBrandandCategory';
  static String GetItemListByBrandandCategoryPaging =
      'Master/GetItemListByBrandandCategory_paging';
  static String SavePromoMessage = 'Master/Admin/SavePromoMessage';
  static String SaveSaleOrderfromcustomer = 'Customer/SaveSaleOrderfromcustomer';
  static String OrderLaterSaleOrderList = 'Customer/OrderLaterSaleOrderList';
  static String pendingSalesOrderPDFurl = 'Customer/Report/PendingSalesOrderPDFurl';
  static String CustomerSignup = 'User/CustomerSignup';
  static String PendingSalesOrder = 'Customer/Report/PendingSalesOrder';
  static String GetCustomerDetails = 'Customer/GetCustomerDetails';
  static String getCustomerList = 'Master/GetCustomerList';
  static String getCashBankBook = 'Receipt/Cash_BankBook';
  static String getReceiptList = 'Receipt/ReceiptList';
  static String getSaveReceipt = 'Receipt/SaveReceipt';
  static String getPaidBy = 'Receipt/PaidBy';
  static String getOutStaningBillList = 'Receipt/OutstandingBillList';
  static String getPromotionalMessage = 'Master/GetCustomerList';
  static String getPendingCustomerList = 'Master/Admin/PendingCustomerList';
  static String getApprovedCustomer = 'Master/Admin/ApprovedCustomer';
  static String getGstTaxList = 'Master/GetGstTaxList';
  static String getItemList = 'Master/GetItemList';
  static String getBranchList = 'Master/GetBranchList';
  static String quotationList = 'Quotation/QuotationList';
  static String nextSerialNo = 'Quotation/NextSerialNo';
  static String salesNextSerialNo = 'SaleInvoice/NextSerialNo';
  static String receiptNextSerialNo = 'Receipt/NextReceiptNo';
  static String quotationData = 'Quotation/QuotationData';
  static String quotationPDFurl = 'Quotation/QuotationPDFurl';
  static String getUserPermissions = 'Master/GetUserPermissions';
  static String saveQuotation = 'Quotation/SaveQuotation';
  static String saveSaleInvoice = 'SaleInvoice/SaveSaleInvoice';
  static String saleInvoicePDFUrl = 'SaleInvoice/SaleInvoicePDFurl';
  static String MyLedgerStatementPDFUrl = 'Customer/MyLedgerStatementPDFurl';
  static String getSalesPersonList = 'Master/GetSalesPersonList';
  static String updateQuotation = 'Quotation/UpdateQuotation';
  static String saleOrderList = 'SaleOrder/SaleOrderList';
  static String saveSaleOrder = 'SaleOrder/SaveSaleOrder';
  static String saleInvoiceList = 'SaleInvoice/SaleInvoiceList';
  static String nextOrderNo = 'SaleOrder/NextOrderNo';
  static String getBrandList = 'Master/GetBrandList';
  static String getCategoryList = 'Master/GetCategoryList';
  static String getSupplierList = 'Master/GetSupplierList';
  static String itemListApi = 'Reports/ItemList';
  static String ledgerStatement = 'Reports/LedgerStatement';
  static String getLedgerStatementCustomer = 'Customer/MyLedgerStatement';
  static String saleRegister = 'Reports/SaleRegister';
  static String outstandingReceivables = 'Reports/OutstandingReceivables';
  static String purchaseRegister = 'Reports/PurchaseRegister';
  static String outstandingPayables = 'Reports/OutstandingPayables';
  static String getGlaccountList = 'Master/GetGlaccountList';
  static String YYYY_MM_DD_HH_MM_SS_24 = 'YYYY_MM_DD_HH_MM_SS_24';
  static String saleOrderRegister = 'Reports/SaleOrderRegister';
  // static String login = 'https://fraxinuswebapis.azurewebsites.net/api/User/UserLogin';
  static String login = 'https://gurukrupawebapis.azurewebsites.net/api/User/UserLogin';


  static List<CustomerData> customerList = [];
  static List<BookData> cashBankBookList = [];
  static List<ReceiptData> receiptList = [];
  static List<GLAccountData> PaidByList = [];
  static List<BillData> BillDataList = [];
  static String offerImage = "";
  static PromotionalMessageData promoMessageModel = PromotionalMessageData(message: "No promotional message available.");
  static List<GetGstData> gstList = [];
  static List<ItemData> itemList = [];
  static List<ItemData> categoryWiseItemList = [];
  static List<CategoryBrandData> categoryBrandList = [];
  static List<BranddData> brandList = [];
  static List<BranchData> branchList = [];
  static List<PendingCustomerModel> pendingCustomerList = [];

  static bool isAddAllowed = false;
}

List<ItemData> filteredItems = [];
List<CategoryBrandData> filteredCategoryBrands = [];
List<BranddData> filteredBrands = [];
List<CustomerData> filteredCustomer = [];
List<GLAccountData> filteredPaidByList = [];
List<BookData> filteredCashBankBookList = [];
List<BillData> filteredBillDataList = [];
List<GetGstData> filteredGst = [];
List<BranchData> filteredBranch = [];


