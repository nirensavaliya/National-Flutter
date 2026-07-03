class SaleInvoiceModel {
  List<SaleInvoiceData>? data;
  int? statusCode;
  String? responseMsg;

  SaleInvoiceModel({this.data, this.statusCode, this.responseMsg});

  SaleInvoiceModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SaleInvoiceData>[];
      json['data'].forEach((v) {
        data!.add(new SaleInvoiceData.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    responseMsg = json['responseMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    data['responseMsg'] = this.responseMsg;
    return data;
  }
}

class SaleInvoiceData {
  String? date;
  String? taxMode;
  String? invoiceType;
  int? serialNo;
  int? customerId;
  String? customerName;
  String? contactNumber;
  String? shippingAddress;
  int? creditDays;
  String? gstiNumber;
  int? salesPersonId;
  String? remarks;
  String? refDocNo;
  String? gstType;
  double? total;
  double? discountTotal;
  double? cgstTotal;
  double? sgstTotal;
  double? igstTotal;
  double? netTotal;
  List<SaleDetails>? saleDetails;

  SaleInvoiceData(
      {this.date,
        this.taxMode,
        this.invoiceType,
        this.serialNo,
        this.customerId,
        this.customerName,
        this.contactNumber,
        this.shippingAddress,
        this.creditDays,
        this.gstiNumber,
        this.salesPersonId,
        this.remarks,
        this.refDocNo,
        this.gstType,
        this.total,
        this.discountTotal,
        this.cgstTotal,
        this.sgstTotal,
        this.igstTotal,
        this.netTotal,
        this.saleDetails});

  SaleInvoiceData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    taxMode = json['taxMode'];
    invoiceType = json['invoiceType'];
    serialNo = json['serialNo'];
    customerId = json['customerId'];
    customerName = json['customerName'];
    contactNumber = json['contactNumber'];
    shippingAddress = json['shippingAddress'];
    creditDays = json['creditDays'];
    gstiNumber = json['gstiNumber'];
    salesPersonId = json['salesPersonId'];
    remarks = json['remarks'];
    refDocNo = json['refDocNo'];
    gstType = json['gstType'];
    total = json['total'];
    discountTotal = json['discountTotal'];
    cgstTotal = json['cgstTotal'];
    sgstTotal = json['sgstTotal'];
    igstTotal = json['igstTotal'];
    netTotal = json['netTotal'];
    if (json['saleDetails'] != null) {
      saleDetails = <SaleDetails>[];
      json['saleDetails'].forEach((v) {
        saleDetails!.add(new SaleDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['taxMode'] = this.taxMode;
    data['invoiceType'] = this.invoiceType;
    data['serialNo'] = this.serialNo;
    data['customerId'] = this.customerId;
    data['customerName'] = this.customerName;
    data['contactNumber'] = this.contactNumber;
    data['shippingAddress'] = this.shippingAddress;
    data['creditDays'] = this.creditDays;
    data['gstiNumber'] = this.gstiNumber;
    data['salesPersonId'] = this.salesPersonId;
    data['remarks'] = this.remarks;
    data['refDocNo'] = this.refDocNo;
    data['gstType'] = this.gstType;
    data['total'] = this.total;
    data['discountTotal'] = this.discountTotal;
    data['cgstTotal'] = this.cgstTotal;
    data['sgstTotal'] = this.sgstTotal;
    data['igstTotal'] = this.igstTotal;
    data['netTotal'] = this.netTotal;
    if (this.saleDetails != null) {
      data['saleDetails'] = this.saleDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaleDetails {
  int? itemId;
  String? itemName;
  String? itemDescription;
  String? unit;
  double? qty;
  double? price;
  double? discountPer;
  double? discount;
  double? totalDiscount;
  int? gstcodeId;
  double? netPriceINCTax;
  double? cgstPer;
  double? cgstAmount;
  double? sgstPer;
  double? sgstAmount;
  double? igstPer;
  double? igstAmount;
  double? taxableAmount;
  double? netAmount;
  double? grossAmount;

  SaleDetails(
      {this.itemId,
        this.itemName,
        this.itemDescription,
        this.unit,
        this.qty,
        this.price,
        this.discountPer,
        this.discount,
        this.totalDiscount,
        this.gstcodeId,
        this.netPriceINCTax,
        this.cgstPer,
        this.cgstAmount,
        this.sgstPer,
        this.sgstAmount,
        this.igstPer,
        this.igstAmount,
        this.taxableAmount,
        this.netAmount,
        this.grossAmount});

  SaleDetails.fromJson(Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemName = json['itemName'];
    itemDescription = json['itemDescription'];
    unit = json['unit'];
    qty = json['qty'];
    price = json['price'];
    discountPer = json['discountPer'];
    discount = json['discount'];
    totalDiscount = json['totalDiscount'];
    gstcodeId = json['gstcodeId'];
    netPriceINCTax = json['netPriceINCTax'];
    cgstPer = json['cgstPer'];
    cgstAmount = json['cgstAmount'];
    sgstPer = json['sgstPer'];
    sgstAmount = json['sgstAmount'];
    igstPer = json['igstPer'];
    igstAmount = json['igstAmount'];
    taxableAmount = json['taxableAmount'];
    netAmount = json['netAmount'];
    grossAmount = json['grossAmount'];
  }

  Map<String, dynamic> toJson() {
    final p = price ?? 0.0;
    final g = grossAmount ?? p;
    return {
      'itemId': itemId,
      'itemName': itemName,
      'itemDescription': itemDescription ?? '',
      'unit': unit,
      'qty': qty ?? 0.0,
      'price': p,
      'discountPer': discountPer ?? 0.0,
      'discount': discount ?? 0.0,
      'totalDiscount': totalDiscount ?? 0.0,
      'gstcodeId': gstcodeId ?? 0,
      'netPriceINCTax': netPriceINCTax ?? p,
      'cgstPer': cgstPer ?? 0.0,
      'cgstAmount': cgstAmount ?? 0.0,
      'sgstPer': sgstPer ?? 0.0,
      'sgstAmount': sgstAmount ?? 0.0,
      'igstPer': igstPer ?? 0.0,
      'igstAmount': igstAmount ?? 0.0,
      'taxableAmount': taxableAmount ?? g,
      'netAmount': netAmount ?? g,
      'grossAmount': g,
    };
  }
}
