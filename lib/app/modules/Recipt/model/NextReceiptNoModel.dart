class NextReceiptNoModel {
  SerialData? data;
  int? statusCode;
  String? responseMsg;

  NextReceiptNoModel({this.data, this.statusCode, this.responseMsg});

  NextReceiptNoModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new SerialData.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
    responseMsg = json['responseMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = this.statusCode;
    data['responseMsg'] = this.responseMsg;
    return data;
  }
}

class SerialData {
  int? receiptNumber;

  SerialData({this.receiptNumber});

  SerialData.fromJson(Map<String, dynamic> json) {
    receiptNumber = json['receiptNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receiptNumber'] = this.receiptNumber;
    return data;
  }
}