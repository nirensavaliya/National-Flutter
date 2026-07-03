class GetSaleRegisterModel {
  List<SaleRegisterData>? data;
  int? statusCode;
  String? responseMsg;

  GetSaleRegisterModel({this.data, this.statusCode, this.responseMsg});

  GetSaleRegisterModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SaleRegisterData>[];
      json['data'].forEach((v) {
        data!.add(new SaleRegisterData.fromJson(v));
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

class SaleRegisterData {
  String? customer;
  String? billDate;
  String? billNo;
  double? grossAmount;
  String? saleType;
  Null? shipTo;
  String? contactNumber;
  double? totalfreight;
  String? dueDate;
  String? salesPerson;
  int? totQty;
  String? soldItems;
  String? transportName;
  String? withoutPrefixBillSrNo;
  String? lrNumber;
  String? destination;
  double? gstTaxableAmt;
  String? vattinNumber;
  String? state;
  String? city;
  String? poNumber;
  String? poDate;
  double? totalroundoffamount;
  String? address1;
  String? address2;
  int? billedDays;
  String? remarks;
  String? customerGSTType;
  String? shippingState;
  double? additionalCessAmt;
  double? cessAmt;
  String? customerGroupName;
  String? jobworkChallanNo;
  int? creditDays;
  String? invoiceType;
  double? netPayableAmount;
  int? paid;
  double? totalOutstanding;
  double? igstAmt;
  double? cgstAmt;
  double? sgstAmt;
  String? gstinNumber;

  SaleRegisterData(
      {this.customer,
        this.billDate,
        this.billNo,
        this.grossAmount,
        this.saleType,
        this.shipTo,
        this.contactNumber,
        this.totalfreight,
        this.dueDate,
        this.salesPerson,
        this.totQty,
        this.soldItems,
        this.transportName,
        this.withoutPrefixBillSrNo,
        this.lrNumber,
        this.destination,
        this.gstTaxableAmt,
        this.vattinNumber,
        this.state,
        this.city,
        this.poNumber,
        this.poDate,
        this.totalroundoffamount,
        this.address1,
        this.address2,
        this.billedDays,
        this.remarks,
        this.customerGSTType,
        this.shippingState,
        this.additionalCessAmt,
        this.cessAmt,
        this.customerGroupName,
        this.jobworkChallanNo,
        this.creditDays,
        this.invoiceType,
        this.netPayableAmount,
        this.paid,
        this.totalOutstanding,
        this.igstAmt,
        this.cgstAmt,
        this.sgstAmt,
        this.gstinNumber});

  SaleRegisterData.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
    billDate = json['billDate'];
    billNo = json['billNo'];
    grossAmount = json['grossAmount'];
    saleType = json['saleType'];
    shipTo = json['shipTo'];
    contactNumber = json['contactNumber'];
    totalfreight = json['totalfreight'];
    dueDate = json['dueDate'];
    salesPerson = json['salesPerson'];
    totQty = json['totQty'];
    soldItems = json['soldItems'];
    transportName = json['transportName'];
    withoutPrefixBillSrNo = json['withoutPrefixBillSrNo'];
    lrNumber = json['lrNumber'];
    destination = json['destination'];
    gstTaxableAmt = json['gstTaxableAmt'];
    vattinNumber = json['vattinNumber'];
    state = json['state'];
    city = json['city'];
    poNumber = json['poNumber'];
    poDate = json['poDate'];
    totalroundoffamount = json['totalroundoffamount'];
    address1 = json['address1'];
    address2 = json['address2'];
    billedDays = json['billedDays'];
    remarks = json['remarks'];
    customerGSTType = json['customerGSTType'];
    shippingState = json['shippingState'];
    additionalCessAmt = json['additionalCessAmt'];
    cessAmt = json['cessAmt'];
    customerGroupName = json['customerGroupName'];
    jobworkChallanNo = json['jobworkChallanNo'];
    creditDays = json['creditDays'];
    invoiceType = json['invoiceType'];
    netPayableAmount = json['netPayableAmount'];
    paid = json['paid'];
    totalOutstanding = json['totalOutstanding'];
    igstAmt = json['igstAmt'];
    cgstAmt = json['cgstAmt'];
    sgstAmt = json['sgstAmt'];
    gstinNumber = json['gstinNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer'] = this.customer;
    data['billDate'] = this.billDate;
    data['billNo'] = this.billNo;
    data['grossAmount'] = this.grossAmount;
    data['saleType'] = this.saleType;
    data['shipTo'] = this.shipTo;
    data['contactNumber'] = this.contactNumber;
    data['totalfreight'] = this.totalfreight;
    data['dueDate'] = this.dueDate;
    data['salesPerson'] = this.salesPerson;
    data['totQty'] = this.totQty;
    data['soldItems'] = this.soldItems;
    data['transportName'] = this.transportName;
    data['withoutPrefixBillSrNo'] = this.withoutPrefixBillSrNo;
    data['lrNumber'] = this.lrNumber;
    data['destination'] = this.destination;
    data['gstTaxableAmt'] = this.gstTaxableAmt;
    data['vattinNumber'] = this.vattinNumber;
    data['state'] = this.state;
    data['city'] = this.city;
    data['poNumber'] = this.poNumber;
    data['poDate'] = this.poDate;
    data['totalroundoffamount'] = this.totalroundoffamount;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['billedDays'] = this.billedDays;
    data['remarks'] = this.remarks;
    data['customerGSTType'] = this.customerGSTType;
    data['shippingState'] = this.shippingState;
    data['additionalCessAmt'] = this.additionalCessAmt;
    data['cessAmt'] = this.cessAmt;
    data['customerGroupName'] = this.customerGroupName;
    data['jobworkChallanNo'] = this.jobworkChallanNo;
    data['creditDays'] = this.creditDays;
    data['invoiceType'] = this.invoiceType;
    data['netPayableAmount'] = this.netPayableAmount;
    data['paid'] = this.paid;
    data['totalOutstanding'] = this.totalOutstanding;
    data['igstAmt'] = this.igstAmt;
    data['cgstAmt'] = this.cgstAmt;
    data['sgstAmt'] = this.sgstAmt;
    data['gstinNumber'] = this.gstinNumber;
    return data;
  }
}
