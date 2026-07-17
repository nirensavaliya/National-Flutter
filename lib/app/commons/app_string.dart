import 'package:gurukrupa/app/commons/all.dart';

class AppString {
  static String appName = "National Mattress";

  // Company code
  static String enterYouClientCode = "Enter Your Client Code";
  static String selectCompany = "Select Company";
  static String next = "NEXT";
  static String loadCompanyList = "Load Company List";

  //SignUp
  static String CustomerName = "Customer Name";
  static String Address1 = "Address 1";
  static String Address2 = "Address 2";
  static String State = "State";
  static String City = "City";
  static String Area = "Area";
  static String MobileNumber = "Mobile Number";
  static String AlternateMobileNumber = "Alternate Mobile Number";
  static String ContactPerson = "Contact Person";
  static String PANNumber = "PAN Number";
  static String GSTINNumber = "GSTIN Number";

  // LOG IN
  static String welcomeBack = "Welcome back!";
  static String pleaseLoginToContinue = "Please Login to Continue";
  static String userName = "User Name";
  static String password = "Password";
  static String mobileNumber = "Mobile Number";
  static String entermobileNumber = "Enter your Mobile Number";
  static String enterPassword = "Enter your password";
  static String enterUserName = "Enter your UserName";
  static String login = "Login";

  //Home
  static String main = "Main";
  static String hiWelcomeBack = "Hi, welcome to National!";
  static String salesAndPurchase = "Sales and Purchase monitoring dashboard.";
  static String transaction = "Transaction";
  static String reports = "Reports";
  static String orderFromImage = "Order From Image";
  static String salesVisitFromImage = "Sales Person Visit Image";
  static String receipt = "Receipt";

  //Main
  static String todayTotal = "Today's Total Sales:";
  static String monthlyTotal = "Monthly Total Sales:";
  static String todayPurchase = "Today's Total Purchase:";
  static String monthlyPurchase = "Monthly Total Purchase:";
  static String customerAction = "Customers Action";

  //CustomerPendingScreen
  static String customerPending = "Customer Pending";
  static String customerFeedback = "Customer Feedback";
  static String Feedback = "Give a Feedback";
  static String enterFeedback = "Feedback";
  static String orderLaterSales = "Order Later Sales List";

  //Transaction
  static String quotation = "Quotation";
  static String salesOrder = "Sales Order";
  static String salesInvoice = "Sales Invoice";
  static String recipt = "Receipt";

  //Reports
  static String itemList = "Item List";
  static String ledgerStatement = "Ledger Statement";
  static String saleRegister = "Sale Register";
  static String purchaseRegister = "Purchase Register";
  static String outstandingReceivable = "Outstanding Receivable";
  static String outstandingPayables = "Outstanding Payables";
  static String pendingSaleOrder = "Pending SaleOrder";
  static String saleOrderRegister = "Sale Order Register";

  //Ledger Statement
  static String fromDate = "From Date";
  static String toDate = "To Date";
  static String ledger = "Ledger";
  static String showReport = "Show Report";
  static String downloadPdf = "Download PDF";

  //Sale Register
  static String customer = "Customer";
  static String branch = "Branch";
  static String supplier = "Supplier";

  //Outstanding
  static String asPerDate = "AsPer Date";
  static String city = "City";

  static String itemName = "Item Name";
  static String brand = "Brand";
  static String category = "Category";

  //Quotation
  static String startDate = "Start Date";
  static String endDate = "End Date";
  static String date = "Date";
  static String textMode = "Tex Mode";
  static String ref_no = "Ref. No.";
  static String againstInvoice = "Against Invoice";
  static String advanceDeposit = "Advance Deposit";
  static String onAccount = "On Account";
  static String totalReceived = "Total Received";
  static String discountGiven = "Discount Given";
  static String totalAdjusted= "Total Adjusted";
  static String description= "Description";
  static String invoiceType = "Invoice Type";
  static String invoiceSerialNo = "Invoice Serial No.";
  static String customerName = "Customer Name";
  static String paidBy = "Paid By";
  static String cashBank = "Cash / Bank";
  static String channel = "Channel";
  static String contactNumber = "Contact Number";
  static String partyBankName = "Party Bank Name";
  static String chequeNo = "Cheque No";
  static String chequeDate = "Cheque Date";
  static String collectedBy = "Collected By";
  static String shippingAddress = "Shipping Address";
  static String CreditType = "Credit Type";
  static String gstIn = "GSTIN";
  static String remark = "Remark";
  static String gstType = "GST Type";
  static String gstTax = "GST Tax";
  static String addItem = "Add Item";
  static String save = "Save";
  static String itemDec = "Item Desc";
  static String unit = "Unit";
  static String qty = "Qty";
  static String price = "Price";
  static String discountPer = "Discount(%)";
  static String totalDiscount = "Total Discount";
  static String taxableAmount = "Taxable Amount";
  static String netPrice = "NetPrice(Inc Tax.)";
  static String netAmount = "Net Amount";
  static String grossAmount = "Gross Amount";
  static String discount = "Discount";
  static String CGSTPer = "CGSTPer";
  static String CGSTAmt = "CGSTAmt";
  static String SGSTPer = "SGSTPer";
  static String SGSTAmt = "SGSTAmt";
  static String IGSTPer = "IGSTPer";
  static String IGSTAmt = "IGSTAmt";
  static String deliveryDate = "Delivery Date";
  static String poDate = "PO Date";
  static String poNumber = "PO Number";
  static String transport = "Transport Name";
  static String status = "Status";
  static String remarks = "Remarks";
  static String salesPerson= "Sales Person";
  static String refDocChallanNo= "Ref Doc/Challan No.";

  static  pleaseEnter (String value) {
    return Utils().showSnackBar(context: Get.context!, message: "Please enter $value");
  }

}