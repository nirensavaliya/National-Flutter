/// Appends [customerId] as a query parameter to API paths.
class ApiQueryHelper {
  static String withCustomerId(String path, int customerId) {
    final sep = path.contains('?') ? '&' : '?';
    return '$path${sep}customerId=$customerId';
  }
}