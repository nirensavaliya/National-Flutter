class BillDataModel {
  List<BillData>? data;
  int? statusCode;
  String? responseMsg;

  BillDataModel({this.data, this.statusCode, this.responseMsg});

  BillDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BillData>[];
      json['data'].forEach((v) {
        data!.add(BillData.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    responseMsg = json['responseMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    if (data != null) {
      json['data'] = data!.map((v) => v.toJson()).toList();
    }
    json['statusCode'] = statusCode;
    json['responseMsg'] = responseMsg;
    return json;
  }
}

class BillData {
  int? billID;
  String? billNo;
  String? billDate;
  double? billAmount;
  double? outstanding;
  String? saleType;
  String? salesPerson;
  String? challanNo;
  String? broker;

  BillData({
    this.billID,
    this.billNo,
    this.billDate,
    this.billAmount,
    this.outstanding,
    this.saleType,
    this.salesPerson,
    this.challanNo,
    this.broker,
  });

  BillData.fromJson(Map<String, dynamic> json) {
    billID = json['billID'];
    billNo = json['billNo'];
    billDate = json['billDate'];
    billAmount = json['billAmount']?.toDouble();
    outstanding = json['outstanding']?.toDouble();
    saleType = json['saletype'];
    salesPerson = json['salesPerson'];
    challanNo = json['challanno'];
    broker = json['broker'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['billID'] = billID;
    json['billNo'] = billNo;
    json['billDate'] = billDate;
    json['billAmount'] = billAmount;
    json['outstanding'] = outstanding;
    json['saletype'] = saleType;
    json['salesPerson'] = salesPerson;
    json['challanno'] = challanNo;
    json['broker'] = broker;
    return json;
  }
}

class SaveReceiptDetails {
  int? billId;
  String? billNo;
  double? receivedAmount;
  double? discountPer;
  double? discountAmount;
  double? billAmount;
  double? outstanding;
  String? billDate;

  SaveReceiptDetails(
      {this.billId,
      this.billNo,
      this.receivedAmount,
      this.discountPer,
      this.discountAmount,
      this.billAmount,
      this.outstanding,
      this.billDate});

  SaveReceiptDetails.fromJson(Map<String, dynamic> json) {
    billId = json['billId'];
    billNo = json['billNo'];
    receivedAmount = json['receivedAmount'];
    discountPer = json['discountPer'];
    discountAmount = json['discountAmount'];
    billAmount = json['billAmount'];
    outstanding = json['outstanding'];
    billDate = json['billDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billId'] = this.billId;
    data['billNo'] = this.billNo;
    data['receivedAmount'] = this.receivedAmount;
    data['discountPer'] = this.discountPer;
    data['discountAmount'] = this.discountAmount;
    data['billAmount'] = this.billAmount;
    data['outstanding'] = this.outstanding;
    data['billDate'] = this.billDate;
    return data;
  }
}
