import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gurukrupa/app/commons/app_colors.dart';
import '../commons/all.dart';

class Loading {
  static void init() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 48.0
      ..radius = 14.0
      ..lineWidth = 3.0
      ..progressColor = SplashColors.primary
      ..backgroundColor = Colors.white
      ..indicatorColor = SplashColors.primary
      ..textColor = SplashColors.primaryDark
      ..maskColor = SplashColors.primary.withOpacity(0.25)
      ..boxShadow = [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 50,
          offset: const Offset(0, 8),
        ),
      ]
      ..userInteractions = false
      ..dismissOnTap = false
      ..contentPadding = const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      );
  }

  static void show({String? message}) {
    if (message != null && message.isNotEmpty) {
      EasyLoading.show(status: message);
    } else {
      EasyLoading.show();
    }
  }

  static void dismiss() {
    EasyLoading.dismiss();
  }
}