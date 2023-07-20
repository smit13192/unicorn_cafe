import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/images/app_image.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/storage/app_storage.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween(begin: 0.0, end: 250.0).animate(animationController);
    animationController.forward();
    goToNextPage();
  }

  goToNextPage() async {
    AppStorage appStorage = AppStorage();
    NavigatorState navigatorState = Navigator.of(context);
    FirebaseAuthService firebaseAuthService =
        RepositoryProvider.of<FirebaseAuthService>(context);
    Timer(const Duration(seconds: 3), () async {
      bool value = await appStorage.getOnBordingCompelete();
      if (!value) {
        navigatorState.pushReplacementNamed(AppRoute.onBoardingScreen);
        return;
      }
      if (!firebaseAuthService.isLogin) {
        navigatorState.pushReplacementNamed(AppRoute.googlelogin);
        return;
      }
      navigatorState.pushNamedAndRemoveUntil(
        AppRoute.homeScreen,
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Center(
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Image.asset(
              AppImage.logo,
              height: animation.value,
            );
          },
        ),
      ),
    );
  }
}
