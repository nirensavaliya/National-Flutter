class GetBranchListModel {
  List<BranchData>? data;
  int? statusCode;
  String? responseMsg;

  GetBranchListModel({this.data, this.statusCode, this.responseMsg});

  GetBranchListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BranchData>[];
      json['data'].forEach((v) {
        data!.add(new BranchData.fromJson(v));
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

class BranchData {
  int? branchID;
  String? branchName;

  BranchData({this.branchID, this.branchName});

  BranchData.fromJson(Map<String, dynamic> json) {
    branchID = json['branchID'];
    branchName = json['branchName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branchID'] = this.branchID;
    data['branchName'] = this.branchName;
    return data;
  }
}
