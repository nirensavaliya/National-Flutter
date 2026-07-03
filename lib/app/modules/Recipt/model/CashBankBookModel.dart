class CashBankBookModel {
  List<BookData>? data;
  int? statusCode;
  String? responseMsg;

  CashBankBookModel({this.data, this.statusCode, this.responseMsg});

  CashBankBookModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BookData>[];
      json['data'].forEach((v) {
        data!.add(BookData.fromJson(v));
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

class BookData {
  int? bookId;
  String? bookName;
  String? bookType;
  double? balance;
  String? crDr;
  int? glAccountNumber;

  BookData({
    this.bookId,
    this.bookName,
    this.bookType,
    this.balance,
    this.crDr,
    this.glAccountNumber,
  });

  BookData.fromJson(Map<String, dynamic> json) {
    bookId = json['bookId'];
    bookName = json['bookName'];
    bookType = json['bookType'];
    balance = json['balance']?.toDouble(); // Ensure balance is double
    crDr = json['crDr'];
    glAccountNumber = json['glAccountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bookId'] = this.bookId;
    data['bookName'] = this.bookName;
    data['bookType'] = this.bookType;
    data['balance'] = this.balance;
    data['crDr'] = this.crDr;
    data['glAccountNumber'] = this.glAccountNumber;
    return data;
  }
}