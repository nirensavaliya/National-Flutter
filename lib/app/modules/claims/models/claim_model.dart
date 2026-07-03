class ClaimModel {
  ClaimModel({
    required this.claimNumber,
    required this.status,
    required this.dealerName,
    required this.customerName,
    required this.customerMobile,
    this.invoiceNumber,
    this.billDate,
    required this.companyDescription,
    required this.createdAt,
  });

  final int claimNumber;
  final String status;
  final String dealerName;
  final String customerName;
  final String customerMobile;
  final String? invoiceNumber;
  final String? billDate;
  final String companyDescription;
  final DateTime createdAt;

  String get summaryTitle => companyDescription.length > 40
      ? '${companyDescription.substring(0, 40)}...'
      : companyDescription;
}
