class CustomerFeedbackResponse {
  final int? statusCode;
  final String? responseMsg;
  final List<CustomerFeedback>? data;

  CustomerFeedbackResponse({this.statusCode, this.responseMsg, this.data});

  factory CustomerFeedbackResponse.fromJson(Map<String, dynamic> json) {
    return CustomerFeedbackResponse(
      statusCode: json['statusCode'],
      responseMsg: json['responseMsg'],
      data: (json['data'] as List?)
          ?.map((item) => CustomerFeedback.fromJson(item))
          .toList(),
    );
  }
}

class CustomerFeedback {
  final String? customerName;
  final String? mobileNumber;
  final String? feedback;
  final String? dateTime;

  CustomerFeedback({
    this.customerName,
    this.mobileNumber,
    this.feedback,
    this.dateTime,
  });

  factory CustomerFeedback.fromJson(Map<String, dynamic> json) {
    return CustomerFeedback(
      customerName: json['customerName'],
      mobileNumber: json['mobileNumber'],
      feedback: json['feedback'],
      dateTime: json['dateTime'],
    );
  }
}