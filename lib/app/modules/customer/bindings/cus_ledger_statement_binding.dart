import 'package:get/get.dart';

import '../controllers/cus_ledger_statement_controller.dart';

class CusLedgerStatementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CusLedgerStatementController>(
      () => CusLedgerStatementController(),
    );
  }
}
