class CompanyCodeTokenModel {
  CompanyCodeData? data;
  int? statusCode;
  String? responseMsg;

  CompanyCodeTokenModel({this.data, this.statusCode, this.responseMsg});

  CompanyCodeTokenModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new CompanyCodeData.fromJson(json['data']) : null;
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

class CompanyCodeData {
  String? token;

  CompanyCodeData({this.token});

  CompanyCodeData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}
