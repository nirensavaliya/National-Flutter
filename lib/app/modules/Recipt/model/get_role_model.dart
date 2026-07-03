class GetRoleModel {
  final GetRoleData data;
  final int statusCode;
  final String responseMsg;

  GetRoleModel({
    required this.data,
    required this.statusCode,
    required this.responseMsg,
  });

  factory GetRoleModel.fromJson(Map<String, dynamic> json) {
    return GetRoleModel(
      data: GetRoleData.fromJson(json['data']),
      statusCode: json['statusCode'],
      responseMsg: json['responseMsg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'statusCode': statusCode,
      'responseMsg': responseMsg,
    };
  }
}

class GetRoleData {
  final int employeeId;
  final String employeeName;

  GetRoleData({
    required this.employeeId,
    required this.employeeName,
  });

  factory GetRoleData.fromJson(Map<String, dynamic> json) {
    return GetRoleData(
      employeeId: json['employeeId'],
      employeeName: json['employeeName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'employeeName': employeeName,
    };
  }
}
