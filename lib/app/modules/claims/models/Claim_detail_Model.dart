class ClaimDetail {
  String itemBrand;
  String itemName;
  String serialNumber;

  ClaimDetail({
    required this.itemBrand,
    required this.itemName,
    required this.serialNumber,
  });

  factory ClaimDetail.fromJson(Map<String, dynamic> json) {
    return ClaimDetail(
      itemBrand: json["itemBrand"] ?? "",
      itemName: json["itemName"] ?? "",
      serialNumber: json["serialNumber"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "itemBrand": itemBrand,
      "itemName": itemName,
      "serialNumber": serialNumber,
    };
  }
}