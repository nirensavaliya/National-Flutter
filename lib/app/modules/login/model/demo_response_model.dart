class OtpApiResponse {
  final OtpData? data;
  final int? statusCode;
  final String? responseMsg;

  OtpApiResponse({
    this.data,
    this.statusCode,
    this.responseMsg,
  });

  factory OtpApiResponse.fromJson(Map<String, dynamic> json) {
    return OtpApiResponse(
      data: json['data'] != null ? OtpData.fromJson(json['data']) : null,
      statusCode: json['statusCode'],
      responseMsg: json['responseMsg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": data?.toJson(),
      "statusCode": statusCode,
      "responseMsg": responseMsg,
    };
  }
}

class OtpData {
  final String? otp;
  final String? otpResponse;
  final String? token;

  OtpData({
    this.otp,
    this.otpResponse,
    this.token,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) {
    return OtpData(
      otp: json['otp'],
      otpResponse: json['otpResponse'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "otp": otp,
      "otpResponse": otpResponse,
      "token": token,
    };
  }
}
