class SalesInvoiceModel {
  List<SalesInvoiceData>? data;
  int? statusCode;
  String? responseMsg;

  SalesInvoiceModel({this.data, this.statusCode, this.responseMsg});

  SalesInvoiceModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SalesInvoiceData>[];
      json['data'].forEach((v) {
        data!.add(new SalesInvoiceData.fromJson(v));
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

class SalesInvoiceData {
  int? billId;
  String? invoiceSerialNo;
  String? date;
  String? customerName;
  String? contactNumber;
  String? invoiceType;
  String? gstType;
  double? netPayableAmount;
  String? gstinNumber;
  bool? allowEditEntry;
  bool? allowDeleteEntry;

  SalesInvoiceData(
      {this.billId,
        this.invoiceSerialNo,
        this.date,
        this.customerName,
        this.contactNumber,
        this.invoiceType,
        this.gstType,
        this.netPayableAmount,
        this.gstinNumber,
        this.allowEditEntry,
        this.allowDeleteEntry});

  SalesInvoiceData.fromJson(Map<String, dynamic> json) {
    billId = json['billId'];
    invoiceSerialNo = json['invoiceSerialNo'];
    date = json['date'];
    customerName = json['customerName'];
    contactNumber = json['contactNumber'];
    invoiceType = json['invoiceType'];
    gstType = json['gstType'];
    netPayableAmount = json['netPayableAmount'];
    gstinNumber = json['gstinNumber'];
    allowEditEntry = json['allowEditEntry'];
    allowDeleteEntry = json['allowDeleteEntry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billId'] = this.billId;
    data['invoiceSerialNo'] = this.invoiceSerialNo;
    data['date'] = this.date;
    data['customerName'] = this.customerName;
    data['contactNumber'] = this.contactNumber;
    data['invoiceType'] = this.invoiceType;
    data['gstType'] = this.gstType;
    data['netPayableAmount'] = this.netPayableAmount;
    data['gstinNumber'] = this.gstinNumber;
    data['allowEditEntry'] = this.allowEditEntry;
    data['allowDeleteEntry'] = this.allowDeleteEntry;
    return data;
  }
}
