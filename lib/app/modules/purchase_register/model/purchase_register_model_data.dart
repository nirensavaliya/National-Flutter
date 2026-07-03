class PurchaseRegisterApiModel {
  List<Data>? data;
  int? statusCode;
  String? responseMsg;

  PurchaseRegisterApiModel({this.data, this.statusCode, this.responseMsg});

  PurchaseRegisterApiModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? supplierName;
  String? purdate;
  String? suppliervoucherno;
  double? qty;
  double? grossamount;
  double? totalfreight;
  double? tradediscounttotal;
  double? taxableAmount;
  String? gstTaxPer;
  double? cgstper;
  double? cgstamt;
  double? sgstper;
  double? sgstamt;
  double? igstper;
  double? igstamt;
  double? cessamt;
  double? additionalcessamt;
  double? netpayable;
  double? paidamt;
  String? debitnotes;
  String? challanno;
  double? additionaldiscount;
  double? totalroundoffamount;
  int? totalexciseamount;
  double? totaleducationaltax;
  double? totaloutstanding;
  String? voucherno;
  String? purchasetype;
  String? invoicetype;
  String? tinnumber;
  String? gstinnumber;
  String? suppliergsttype;
  String? remarks;
  int? billDays;
  int? dueDays;

  Data(
      {this.supplierName,
        this.purdate,
        this.suppliervoucherno,
        this.qty,
        this.grossamount,
        this.totalfreight,
        this.tradediscounttotal,
        this.taxableAmount,
        this.gstTaxPer,
        this.cgstper,
        this.cgstamt,
        this.sgstper,
        this.sgstamt,
        this.igstper,
        this.igstamt,
        this.cessamt,
        this.additionalcessamt,
        this.netpayable,
        this.paidamt,
        this.debitnotes,
        this.challanno,
        this.additionaldiscount,
        this.totalroundoffamount,
        this.totalexciseamount,
        this.totaleducationaltax,
        this.totaloutstanding,
        this.voucherno,
        this.purchasetype,
        this.invoicetype,
        this.tinnumber,
        this.gstinnumber,
        this.suppliergsttype,
        this.remarks,
        this.billDays,
        this.dueDays});

  Data.fromJson(Map<String, dynamic> json) {
    supplierName = json['supplierName'];
    purdate = json['purdate'];
    suppliervoucherno = json['suppliervoucherno'];
    qty = json['qty'];
    grossamount = json['grossamount'];
    totalfreight = json['totalfreight'];
    tradediscounttotal = json['tradediscounttotal'];
    taxableAmount = json['taxableAmount'];
    gstTaxPer = json['gstTaxPer'];
    cgstper = json['cgstper'];
    cgstamt = json['cgstamt'];
    sgstper = json['sgstper'];
    sgstamt = json['sgstamt'];
    igstper = json['igstper'];
    igstamt = json['igstamt'];
    cessamt = json['cessamt'];
    additionalcessamt = json['additionalcessamt'];
    netpayable = json['netpayable'];
    paidamt = json['paidamt'];
    debitnotes = json['debitnotes'];
    challanno = json['challanno'];
    additionaldiscount = json['additionaldiscount'];
    totalroundoffamount = json['totalroundoffamount'];
    totalexciseamount = json['totalexciseamount'];
    totaleducationaltax = json['totaleducationaltax'];
    totaloutstanding = json['totaloutstanding'];
    voucherno = json['voucherno'];
    purchasetype = json['purchasetype'];
    invoicetype = json['invoicetype'];
    tinnumber = json['tinnumber'];
    gstinnumber = json['gstinnumber'];
    suppliergsttype = json['suppliergsttype'];
    remarks = json['remarks'];
    billDays = json['billDays'];
    dueDays = json['dueDays'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplierName'] = this.supplierName;
    data['purdate'] = this.purdate;
    data['suppliervoucherno'] = this.suppliervoucherno;
    data['qty'] = this.qty;
    data['grossamount'] = this.grossamount;
    data['totalfreight'] = this.totalfreight;
    data['tradediscounttotal'] = this.tradediscounttotal;
    data['taxableAmount'] = this.taxableAmount;
    data['gstTaxPer'] = this.gstTaxPer;
    data['cgstper'] = this.cgstper;
    data['cgstamt'] = this.cgstamt;
    data['sgstper'] = this.sgstper;
    data['sgstamt'] = this.sgstamt;
    data['igstper'] = this.igstper;
    data['igstamt'] = this.igstamt;
    data['cessamt'] = this.cessamt;
    data['additionalcessamt'] = this.additionalcessamt;
    data['netpayable'] = this.netpayable;
    data['paidamt'] = this.paidamt;
    data['debitnotes'] = this.debitnotes;
    data['challanno'] = this.challanno;
    data['additionaldiscount'] = this.additionaldiscount;
    data['totalroundoffamount'] = this.totalroundoffamount;
    data['totalexciseamount'] = this.totalexciseamount;
    data['totaleducationaltax'] = this.totaleducationaltax;
    data['totaloutstanding'] = this.totaloutstanding;
    data['voucherno'] = this.voucherno;
    data['purchasetype'] = this.purchasetype;
    data['invoicetype'] = this.invoicetype;
    data['tinnumber'] = this.tinnumber;
    data['gstinnumber'] = this.gstinnumber;
    data['suppliergsttype'] = this.suppliergsttype;
    data['remarks'] = this.remarks;
    data['billDays'] = this.billDays;
    data['dueDays'] = this.dueDays;
    return data;
  }
}
