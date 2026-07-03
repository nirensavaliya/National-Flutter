class DashboardModel {
  List<DashboardData>? data;
  int? statusCode;
  String? responseMsg;

  DashboardModel({this.data, this.statusCode, this.responseMsg});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DashboardData>[];
      json['data'].forEach((v) {
        data!.add(new DashboardData.fromJson(v));
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

class DashboardData {
  String? elementTitle;
  String? value;

  DashboardData({this.elementTitle, this.value});

  DashboardData.fromJson(Map<String, dynamic> json) {
    elementTitle = json['elementTitle'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['elementTitle'] = this.elementTitle;
    data['value'] = this.value;
    return data;
  }
}
