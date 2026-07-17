import '../../../commons/get_storage_data.dart';
import '../model/sale_order_model.dart';
import '../model/sales_order_cart_model.dart';

class SalesOrderCartService {
  static const String _storageKey = 'sales_order_cart';

  static Future<void> save({
    required List<SaleOrderDetails> items,
    required String total,
    required String discountTotal,
    required String cGstTotal,
    required String sGstTotal,
    required String iGstTotal,
    required String totalItem,
    required String netTotal,
    String? orderNo,
    int? customerId,
    String? customerName,
  }) {
    if (items.isEmpty) {
      return Future.value();
    }

    final cart = SalesOrderCartModel(
      cartId: DateTime.now().microsecondsSinceEpoch.toString(),
      items: items,
      total: total,
      discountTotal: discountTotal,
      cGstTotal: cGstTotal,
      sGstTotal: sGstTotal,
      iGstTotal: iGstTotal,
      totalItem: totalItem,
      netTotal: netTotal,
      orderNo: orderNo,
      customerId: customerId,
      customerName: customerName,
      savedAt: DateTime.now().toIso8601String(),
    );
    final carts = loadAll();
    carts.insert(0, cart);
    return GetStorageData.saveObject(
      _storageKey,
      carts.map((e) => e.toJson()).toList(),
    );
  }

  static List<SalesOrderCartModel> loadAll() {
    if (!GetStorageData.containKey(_storageKey)) {
      return [];
    }

    try {
      final raw = GetStorageData.readObject(_storageKey);
      if (raw is List) {
        return raw
            .map((item) => item is Map<String, dynamic>
                ? SalesOrderCartModel.fromJson(item)
                : SalesOrderCartModel.fromJson(
                    Map<String, dynamic>.from(item as Map),
                  ))
            .toList();
      }
      if (raw is Map) {
        return [
          SalesOrderCartModel.fromJson(Map<String, dynamic>.from(raw)),
        ];
      }
    } catch (_) {
      return [];
    }
    return [];
  }

  static SalesOrderCartModel? loadLatest() {
    final carts = loadAll();
    return carts.isEmpty ? null : carts.first;
  }

  static Future<void> removeCart(String cartId) async {
    final carts = loadAll()..removeWhere((cart) => cart.cartId == cartId);
    if (carts.isEmpty) {
      clear();
      return;
    }
    await GetStorageData.saveObject(
      _storageKey,
      carts.map((e) => e.toJson()).toList(),
    );
  }

  static Future<void> removeItem(String cartId, int itemIndex) async {
    final carts = loadAll();
    final cartIndex = carts.indexWhere((cart) => cart.cartId == cartId);
    if (cartIndex == -1) return;

    final cart = carts[cartIndex];
    if (itemIndex < 0 || itemIndex >= cart.items.length) return;

    final items = List<SaleOrderDetails>.from(cart.items)..removeAt(itemIndex);
    if (items.isEmpty) {
      await removeCart(cartId);
      return;
    }

    double totalAmt = 0;
    double totalDiscount = 0;
    double totalCGST = 0;
    double totalSGST = 0;
    double totalIGST = 0;
    double totalNetAmount = 0;
    for (final item in items) {
      totalAmt += (item.price ?? 0) * (item.qty ?? 1);
      totalDiscount += item.totalDiscount ?? 0;
      totalCGST += item.cgstAmount ?? 0;
      totalSGST += item.sgstAmount ?? 0;
      totalIGST += item.igstAmount ?? 0;
      totalNetAmount += item.netAmount ?? 0;
    }

    carts[cartIndex] = SalesOrderCartModel(
      cartId: cart.cartId,
      items: items,
      total: totalAmt.toStringAsFixed(2),
      discountTotal: totalDiscount.toStringAsFixed(2),
      cGstTotal: totalCGST.toStringAsFixed(2),
      sGstTotal: totalSGST.toStringAsFixed(2),
      iGstTotal: totalIGST.toStringAsFixed(2),
      totalItem: items.length.toString(),
      netTotal: totalNetAmount.toStringAsFixed(2),
      orderNo: cart.orderNo,
      customerId: cart.customerId,
      customerName: cart.customerName,
      savedAt: cart.savedAt,
    );

    await GetStorageData.saveObject(
      _storageKey,
      carts.map((e) => e.toJson()).toList(),
    );
  }

  static void clear() {
    if (GetStorageData.containKey(_storageKey)) {
      GetStorageData.removeData(_storageKey);
    }
  }

  static int itemCount() => loadAll().length;
}
