class GetOutstandingPayablesModel {
  List<PayableData>? data;
  int? statusCode;
  String? responseMsg;

  GetOutstandingPayablesModel({this.data, this.statusCode, this.responseMsg});

  GetOutstandingPayablesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PayableData>[];
      json['data'].forEach((v) {
        data!.add(new PayableData.fromJson(v));
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

class PayableData {
  String? supplierName;
  double? outstanding;
  double? advancePaid;
  String? city;
  String? group;

  PayableData(
      {this.supplierName,
        this.outstanding,
        this.advancePaid,
        this.city,
        this.group});

  PayableData.fromJson(Map<String, dynamic> json) {
    supplierName = json['supplierName'];
    outstanding = json['outstanding'];
    advancePaid = json['advancePaid'];
    city = json['city'];
    group = json['group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplierName'] = this.supplierName;
    data['outstanding'] = this.outstanding;
    data['advancePaid'] = this.advancePaid;
    data['city'] = this.city;
    data['group'] = this.group;
    return data;
  }
}
