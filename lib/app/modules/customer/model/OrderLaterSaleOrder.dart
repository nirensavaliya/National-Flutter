class OrderLaterSaleOrder {
  int? salesOrderID;
  String? orderNumber;
  String? date;
  String? customerName;
  String? contactNumber;
  String? invoiceType;
  double? netAmount;
  bool? allowEditEntry;
  bool? allowDeleteEntry;

  OrderLaterSaleOrder({
    this.salesOrderID,
    this.orderNumber,
    this.date,
    this.customerName,
    this.contactNumber,
    this.invoiceType,
    this.netAmount,
    this.allowEditEntry,
    this.allowDeleteEntry,
  });

  factory OrderLaterSaleOrder.fromJson(Map<String, dynamic> json) {
    return OrderLaterSaleOrder(
      salesOrderID: json['salesOrderID'],
      orderNumber: json['orderNumber']?.toString(),
      date: json['date']?.toString(),
      customerName: json['customerName'],
      contactNumber: json['contactNumber'],
      invoiceType: json['invoiceType'],
      netAmount: (json['netAmount'] as num?)?.toDouble(),
      allowEditEntry: json['allowEditEntry'],
      allowDeleteEntry: json['allowDeleteEntry'],
    );
  }
}

class OrderLaterSaleOrderResponse {
  List<OrderLaterSaleOrder>? data;
  int? statusCode;
  String? responseMsg;

  OrderLaterSaleOrderResponse({this.data, this.statusCode, this.responseMsg});

  factory OrderLaterSaleOrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderLaterSaleOrderResponse(
      data: (json['data'] as List?)
          ?.map((e) => OrderLaterSaleOrder.fromJson(e))
          .toList(),
      statusCode: json['statusCode'],
      responseMsg: json['responseMsg'],
    );
  }
}