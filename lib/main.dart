import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gurukrupa/app/api_common/loading.dart';
import 'package:gurukrupa/my_app.dart';
import 'package:get_storage/get_storage.dart';
import 'app/modules/AppLifeCycle/app_lifecycle.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  Loading.init();
  WidgetsBinding.instance.addObserver(AppLifecycleObserver());
  // await initServices();

  runApp(
    // DemoScreen(),
    MyApp(),
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );
}