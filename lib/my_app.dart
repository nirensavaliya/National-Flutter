import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gurukrupa/app/commons/font_family.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "GuruKrupa",
        initialRoute: AppPages.INITIAL,
        theme: ThemeData(
          fontFamily: FontFamily.medium,
        ),
        getPages: AppPages.routes,
        builder: EasyLoading.init(),
      ),
    );
  }
}
