class GetSaleOrderRegisterModel {
  List<SaleOrderRegisterData>? data;
  int? statusCode;
  String? responseMsg;

  GetSaleOrderRegisterModel({this.data, this.statusCode, this.responseMsg});

  GetSaleOrderRegisterModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SaleOrderRegisterData>[];
      json['data'].forEach((v) {
        data!.add(SaleOrderRegisterData.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
    responseMsg = json['responseMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = statusCode;
    data['responseMsg'] = responseMsg;
    return data;
  }
}

class SaleOrderRegisterData {
  int? salesOrderID;
  String? orderNumber;
  String? date;
  String? customerName;
  String? contactNumber;
  String? invoiceType;
  double? netAmount;
  String? salesPerson;

  SaleOrderRegisterData({
    this.salesOrderID,
    this.orderNumber,
    this.date,
    this.customerName,
    this.contactNumber,
    this.invoiceType,
    this.netAmount,
    this.salesPerson,
  });

  SaleOrderRegisterData.fromJson(Map<String, dynamic> json) {
    salesOrderID = json['salesOrderID'];
    orderNumber = json['orderNumber'];
    date = json['date'];
    customerName = json['customerName'];
    contactNumber = json['contactNumber'];
    invoiceType = json['invoiceType'];
    netAmount =
    json['netAmount'] != null ? (json['netAmount'] as num).toDouble() : null;
    salesPerson = json['salesPerson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['salesOrderID'] = salesOrderID;
    data['orderNumber'] = orderNumber;
    data['date'] = date;
    data['customerName'] = customerName;
    data['contactNumber'] = contactNumber;
    data['invoiceType'] = invoiceType;
    data['netAmount'] = netAmount;
    data['salesPerson'] = salesPerson;
    return data;
  }
}