import 'package:flutter/material.dart';
import 'package:unicorn_cafe/src/features/auth/login/login_screen.dart';
import 'package:unicorn_cafe/src/features/auth/register/register_screen.dart';
import 'package:unicorn_cafe/src/features/home/home_screen.dart';
import 'package:unicorn_cafe/src/features/onbording/onboarding_screen.dart';
import 'package:unicorn_cafe/src/features/splash/splash_screen.dart';

part 'app_route.dart';

abstract class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case AppRoute.onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const OnBoardingScreen(),
        );
      case AppRoute.loginScreen:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case AppRoute.registerScreen:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case AppRoute.homeScreen:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      default:
        return null;
    }
  }
}
