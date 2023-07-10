import 'package:flutter/material.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/features/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRoute.splashScreen,
      home: HomeScreen(),
    );
  }
}
