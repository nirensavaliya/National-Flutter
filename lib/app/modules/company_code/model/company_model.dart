class CompanyListModel {
  List<CompanyData>? data;
  int? statusCode;
  String? responseMsg;

  CompanyListModel({this.data, this.statusCode, this.responseMsg});

  CompanyListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CompanyData>[];
      json['data'].forEach((v) {
        data!.add(new CompanyData.fromJson(v));
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

class CompanyData {
  int? companyId;
  String? companyName;

  CompanyData({this.companyId, this.companyName});

  CompanyData.fromJson(Map<String, dynamic> json) {
    companyId = json['companyId'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this.companyId;
    data['companyName'] = this.companyName;
    return data;
  }
}
