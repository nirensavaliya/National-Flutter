class SalesPersonModel {
  List<SalesPersonData>? data;
  int? statusCode;
  String? responseMsg;

  SalesPersonModel({this.data, this.statusCode, this.responseMsg});

  SalesPersonModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <SalesPersonData>[];
      json['data'].forEach((v) {
        data!.add(new SalesPersonData.fromJson(v));
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

class SalesPersonData {
  int? salesPersonId;
  String? salesPerson;

  SalesPersonData({this.salesPersonId, this.salesPerson});

  SalesPersonData.fromJson(Map<String, dynamic> json) {
    salesPersonId = json['salesPersonId'];
    salesPerson = json['salesPerson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesPersonId'] = this.salesPersonId;
    data['salesPerson'] = this.salesPerson;
    return data;
  }
}
