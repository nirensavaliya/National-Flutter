class GLAccountModel {
  List<GLAccountData>? data;
  int? statusCode;
  String? responseMsg;

  GLAccountModel({this.data, this.statusCode, this.responseMsg});

  GLAccountModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GLAccountData>[];
      json['data'].forEach((v) {
        data!.add(GLAccountData.fromJson(v));
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
    data['statusCode'] = this.statusCode;
    data['responseMsg'] = this.responseMsg;
    return data;
  }
}

class GLAccountData {
  int? glAccountNumber;
  int? partyId;
  String? glAccountName;
  String? mobileNumber;
  double? balance;
  String? crDr;
  String? partyType;
  String? glGstinNumber;
  String? address;
  String? glAccountType;

  GLAccountData({
    this.glAccountNumber,
    this.partyId,
    this.glAccountName,
    this.mobileNumber,
    this.balance,
    this.crDr,
    this.partyType,
    this.glGstinNumber,
    this.address,
    this.glAccountType,
  });

  GLAccountData.fromJson(Map<String, dynamic> json) {
    glAccountNumber = json['glAccountNumber'];
    partyId = json['partyId'];
    glAccountName = json['glAccountName'];
    mobileNumber = json['mobileNumber'];
    balance = json['balance']?.toDouble(); // Ensuring balance is a double
    crDr = json['crDr'];
    partyType = json['partytype'];
    glGstinNumber = json['glgstinNumber'];
    address = json['address'];
    glAccountType = json['glAccountType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['glAccountNumber'] = this.glAccountNumber;
    data['partyId'] = this.partyId;
    data['glAccountName'] = this.glAccountName;
    data['mobileNumber'] = this.mobileNumber;
    data['balance'] = this.balance;
    data['crDr'] = this.crDr;
    data['partytype'] = this.partyType;
    data['glgstinNumber'] = this.glGstinNumber;
    data['address'] = this.address;
    data['glAccountType'] = this.glAccountType;
    return data;
  }
}