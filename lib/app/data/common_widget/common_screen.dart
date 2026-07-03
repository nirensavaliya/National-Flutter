import 'dart:io';

import 'package:gurukrupa/app/commons/app_colors.dart';

import '../../commons/all.dart';

class CommonScreen extends StatelessWidget {
  final Widget? body;
  final Widget? floatingActionButton;
  final String? title;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final bool brandAppBar;
  final Color? scaffoldColor;

  const CommonScreen({
    super.key,
    this.body,
    this.floatingActionButton,
    this.title,
    this.titleWidget,
    this.actions,
    this.brandAppBar = false,
    this.scaffoldColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor ?? Colors.white,
      floatingActionButton: floatingActionButton,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: GestureDetector(onTap: (){
          Get.back();
        },child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        backgroundColor: brandAppBar ? SplashColors.primary : Colors.white,
        foregroundColor: brandAppBar ? Colors.white : Colors.black,
        iconTheme: IconThemeData(
          color: brandAppBar ? Colors.white : Colors.black,
        ),
        centerTitle: true,
        elevation: brandAppBar ? 0 : null,
        title: titleWidget ??
            Text(
              title ?? '',
              style: TextStyle(
                fontSize: FontSize.s22,
                fontFamily: FontFamily.semiBold,
                color: brandAppBar ? Colors.white : Colors.black,
              ),
            ),
        actions: actions ?? [],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: Platform.isIOS ? 0 : 10),
        child: body,
      ),
    );
  }
}
