import 'package:flutter/material.dart';
import 'package:unicorn_cafe/app/app_repository_provider.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/string/app_string.dart';

late Size size;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return AppRepositoryProvider(
      child: MaterialApp(
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRoute.splashScreen,
        theme: ThemeData(
          primarySwatch: AppMaterialColor.materialColor,
          fontFamily: AppString.fontFamily,
        ),
      ),
    );
  }
}
