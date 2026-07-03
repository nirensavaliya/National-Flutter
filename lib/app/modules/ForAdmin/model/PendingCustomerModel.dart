class PendingCustomerResponse {
  final int? statusCode;
  final String? responseMsg;
  final List<PendingCustomerModel>? data;

  PendingCustomerResponse({this.statusCode, this.responseMsg, this.data});

  factory PendingCustomerResponse.fromJson(Map<String, dynamic> json) {
    return PendingCustomerResponse(
      statusCode: json['statusCode'],
      responseMsg: json['responseMsg'],
      data: (json['data'] as List?)
          ?.map((item) => PendingCustomerModel.fromJson(item))
          .toList(),
    );
  }
}

class PendingCustomerModel {
  final int? customerId;
  final String? customerName;
  final String? address1;
  final String? address2;
  final String? state;
  final String? city;
  final String? area;
  final String? mobileNumber;
  final String? alternateMobileNumber;
  final String? contactPerson;
  final String? panNumber;
  final String? gstinNumber;

  PendingCustomerModel({
    this.customerId,
    this.customerName,
    this.address1,
    this.address2,
    this.state,
    this.city,
    this.area,
    this.mobileNumber,
    this.alternateMobileNumber,
    this.contactPerson,
    this.panNumber,
    this.gstinNumber,
  });

  factory PendingCustomerModel.fromJson(Map<String, dynamic> json) {
    return PendingCustomerModel(
      customerId: json['customerId'],
      customerName: json['customerName'],
      address1: json['address1'],
      address2: json['address2'],
      state: json['state'],
      city: json['city'],
      area: json['area'],
      mobileNumber: json['mobileNumber'],
      alternateMobileNumber: json['alternateMobileNumber'],
      contactPerson: json['contactPerson'],
      panNumber: json['panNumber'],
      gstinNumber: json['gstinNumber'],
    );
  }
}
