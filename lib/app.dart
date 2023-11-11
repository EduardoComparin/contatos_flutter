import 'package:contatos_flutter/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "APP_TITLE".tr(),
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
