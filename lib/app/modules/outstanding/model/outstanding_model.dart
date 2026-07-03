class GetOutstandingReceivablesModel {
  List<OutStandingData>? data;
  int? statusCode;
  String? responseMsg;

  GetOutstandingReceivablesModel(
      {this.data, this.statusCode, this.responseMsg});

  GetOutstandingReceivablesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <OutStandingData>[];
      json['data'].forEach((v) {
        data!.add(new OutStandingData.fromJson(v));
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

class OutStandingData {
  String? customerName;
  double? drBalance;
  double? crBalance;
  String? aliasName;
  String? contact1;
  String? city;

  OutStandingData(
      {this.customerName,
        this.drBalance,
        this.crBalance,
        this.aliasName,
        this.contact1,
        this.city});

  OutStandingData.fromJson(Map<String, dynamic> json) {
    customerName = json['customerName'];
    drBalance = json['drBalance'];
    crBalance = json['crBalance'];
    aliasName = json['aliasName'];
    contact1 = json['contact1'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerName'] = this.customerName;
    data['drBalance'] = this.drBalance;
    data['crBalance'] = this.crBalance;
    data['aliasName'] = this.aliasName;
    data['contact1'] = this.contact1;
    data['city'] = this.city;
    return data;
  }
}
