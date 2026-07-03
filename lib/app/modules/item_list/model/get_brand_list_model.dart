class GetBrandListModel {
  List<BrandData>? data;
  int? statusCode;
  String? responseMsg;

  GetBrandListModel({this.data, this.statusCode, this.responseMsg});

  GetBrandListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BrandData>[];
      json['data'].forEach((v) {
        data!.add(new BrandData.fromJson(v));
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

class BrandData {
  int? brandID;
  int? categoryID;
  String? brandName;
  String? categoryName;

  BrandData({this.brandID, this.brandName});

  BrandData.fromJson(Map<String, dynamic> json) {
    brandID = json['brandID'];
    brandName = json['brandName'];
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brandID'] = this.brandID;
    data['brandName'] = this.brandName;
    data['categoryID'] = this.categoryID;
    data['categoryName'] = this.categoryName;
    return data;
  }
}
