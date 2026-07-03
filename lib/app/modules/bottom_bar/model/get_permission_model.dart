class GetUserPermissionsModel {
  List<PermissionData>? data;
  int? statusCode;
  String? responseMsg;

  GetUserPermissionsModel({this.data, this.statusCode, this.responseMsg});

  GetUserPermissionsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PermissionData>[];
      json['data'].forEach((v) {
        data!.add(new PermissionData.fromJson(v));
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

class PermissionData {
  bool? allowAddEntry;
  bool? allowEditEntry;
  bool? allowDeleteEntry;

  PermissionData({this.allowAddEntry, this.allowEditEntry, this.allowDeleteEntry});

  PermissionData.fromJson(Map<String, dynamic> json) {
    allowAddEntry = json['allowAddEntry'];
    allowEditEntry = json['allowEditEntry'];
    allowDeleteEntry = json['allowDeleteEntry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allowAddEntry'] = this.allowAddEntry;
    data['allowEditEntry'] = this.allowEditEntry;
    data['allowDeleteEntry'] = this.allowDeleteEntry;
    return data;
  }
}
