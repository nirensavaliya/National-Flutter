import '../../commons/all.dart';
import '../../commons/get_storage_data.dart';
import '../../routes/app_pages.dart';

class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      final token = GetStorageData.readString(GetStorageData.token);
      if (token.isEmpty) {
        Get.offAllNamed(Routes.LOGIN);
      }
    }
  }
}
