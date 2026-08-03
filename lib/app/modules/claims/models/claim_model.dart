import 'package:gurukrupa/app/modules/claims/models/Claim_detail_Model.dart';

class ClaimModel {
  ClaimModel({
    this.claimId,
    this.dealerId,
    required this.claimNumber,
    required this.status,
    required this.dealerName,
    required this.customerName,
    required this.customerMobile,
    this.invoiceNumber,
    this.billDate,
    required this.companyDescription,
    required this.createdAt,
    required this.claimDetails,
  });

  final int? claimId;
  final int? dealerId;
  final int claimNumber;
  final String status;
  final String dealerName;
  final String customerName;
  final String customerMobile;
  final String? invoiceNumber;
  final String? billDate;
  final String companyDescription;
  final DateTime createdAt;
  final List<ClaimDetail> claimDetails;

  factory ClaimModel.fromJson(Map<String, dynamic> json) {
    return ClaimModel(
      claimId: json["claimId"],
      dealerId: json["dealerId"],
      claimNumber: json["claimId"] ?? 0,
      status: json["status"] ?? "",
      dealerName: json["dealerName"] ?? "",
      customerName: json["customerName"] ?? "",
      customerMobile: json["customerMobileNo"] ?? "",
      invoiceNumber: json["billNumber"] ?? "",
      billDate: json["billDate"] ?? "",
      companyDescription: json["description"] ?? "",
      createdAt:
      DateTime.tryParse(json["entryDateTime"] ?? "") ?? DateTime.now(),

      claimDetails: (json["claimDetails"] as List? ?? [])
          .map(
            (e) => ClaimDetail.fromJson(
          e as Map<String, dynamic>,
        ),
      ).toList(),
    );
  }

  String get summaryTitle => companyDescription.length > 40
      ? '${companyDescription.substring(0, 40)}...'
      : companyDescription;
}