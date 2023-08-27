import 'package:demo_getx_flutter/gen/fonts.gen.dart';
import 'package:demo_getx_flutter/presentation/controllers/demo_getx/demo_getx_controller.dart';
import 'package:demo_getx_flutter/presentation/pages/login/login_page.dart';
import 'package:demo_getx_flutter/presentation/pages/reset_password/reset_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class DemoGetXApp extends GetView<DemoGetXController> {
  const DemoGetXApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: FontFamily.sFProTextRegular),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ja'),
      ],
      locale: Locale('ja', 'JP'),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: LoginPage.new),
        GetPage(name: '/reset-password', page: ResetPasswordPage.new),
      ],
    );
  }
}
