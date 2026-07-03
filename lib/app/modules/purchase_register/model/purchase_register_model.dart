class PurchaseRegisterModel {
  List<PurchaseData>? data;
  int? statusCode;
  String? responseMsg;

  PurchaseRegisterModel({this.data, this.statusCode, this.responseMsg});

  PurchaseRegisterModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PurchaseData>[];
      json['data'].forEach((v) {
        data!.add(new PurchaseData.fromJson(v));
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

class PurchaseData {
  int? supplierID;
  String? supplierName;

  PurchaseData({this.supplierID, this.supplierName});

  PurchaseData.fromJson(Map<String, dynamic> json) {
    supplierID = json['supplierID'];
    supplierName = json['supplierName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplierID'] = this.supplierID;
    data['supplierName'] = this.supplierName;
    return data;
  }
}
