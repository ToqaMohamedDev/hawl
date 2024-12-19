import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../presention/resorces/routes_manager.dart';
import '../presention/resorces/string_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: AppStrings.nameApp,
    onGenerateRoute: RouteGenerator.getRoute,
    initialRoute: Routes.splashRoute,
            );
  }
  static void setSystemUIOverlayStyle(SystemUiOverlayStyle style) {
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}