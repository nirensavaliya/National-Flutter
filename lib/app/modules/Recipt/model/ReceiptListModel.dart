import 'dart:convert';

import 'package:intl/intl.dart';

class ReceiptListModel {
  List<ReceiptData> data;
  int statusCode;
  String responseMsg;

  ReceiptListModel({
    required this.data,
    required this.statusCode,
    required this.responseMsg,
  });

  factory ReceiptListModel.fromJson(Map<String, dynamic> json) {
    return ReceiptListModel(
      data: List<ReceiptData>.from(
          json["data"].map((x) => ReceiptData.fromJson(x))),
      statusCode: json["statusCode"],
      responseMsg: json["responseMsg"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": List<dynamic>.from(data.map((x) => x.toJson())),
      "statusCode": statusCode,
      "responseMsg": responseMsg,
    };
  }
}

class ReceiptData {
  int receiptId;
  String serialNo;
  DateTime receiptDate;
  String party;
  String chqNo;
  String transactionid;
  double totalReceived;
  double totalAdjusted;
  String bookName;
  String glAccountType;
  String description;
  String? salesPerson;

  ReceiptData({
    required this.receiptId,
    required this.serialNo,
    required this.receiptDate,
    required this.party,
    required this.chqNo,
    required this.transactionid,
    required this.totalReceived,
    required this.totalAdjusted,
    required this.bookName,
    required this.glAccountType,
    required this.description,
    this.salesPerson
  });

  factory ReceiptData.fromJson(Map<String, dynamic> json) {
    return ReceiptData(
      receiptId: json["receiptId"],
      serialNo: json["serialNo"],
      receiptDate:
      DateFormat("M/d/yyyy h:mm:ss a").parse(json["receiptDate"]),
      party: json["party"],
      chqNo: json["chqNo"] ?? "",
      transactionid: json["transactionid"] ?? "",
      totalReceived: (json["totalReceived"] ?? 0).toDouble(),
      totalAdjusted: (json["totalAdjusted"] ?? 0).toDouble(),
      bookName: json["bookName"],
      glAccountType: json["glAccountType"],
      description: json["description"] ?? "",
      salesPerson: json["salesPerson"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "receiptId": receiptId,
      "serialNo": serialNo,
      "receiptDate": receiptDate.toIso8601String(),
      "party": party,
      "chqNo": chqNo,
      "transactionid": transactionid,
      "totalReceived": totalReceived,
      "totalAdjusted": totalAdjusted,
      "bookName": bookName,
      "glAccountType": glAccountType,
      "description": description,
      "salesPerson": salesPerson,
    };
  }
}
