import 'package:flutter/material.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/images/app_image.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/storage/app_storage.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/widget/app_button.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  AppStorage appStorage = AppStorage();
  final PageController pageController = PageController(initialPage: 0);

  int currentPosition = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPressed() {
    NavigatorState navigatorState = Navigator.of(context);
    if (currentPosition == 2) {
      appStorage.setOnBordingCompelete(true);
      navigatorState.pushReplacementNamed(AppRoute.loginScreen);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 70.h,
              child: PageView(
                onPageChanged: (value) => setState(() {
                  currentPosition = value;
                }),
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  _FirstView(),
                  _SecondView(),
                  _ThirdView(),
                ],
              ),
            ),
            const Spacer(flex: 2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: AppButton(
                text: currentPosition == 2 ? 'Get Started' : 'Next',
                onPressed: onPressed,
              ),
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}

class _FirstView extends StatefulWidget {
  const _FirstView();

  @override
  State<_FirstView> createState() => __FirstViewState();
}

class __FirstViewState extends State<_FirstView> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = Tween<double>(begin: -1000.0, end: 10.0).animate(controller);
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 100.w / (100.w * 1.29),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: fadeAnimation,
                builder: (context, child) {
                  return Positioned.fill(
                    top: -50 + (fadeAnimation.value * 50),
                    child: FadeTransition(
                      opacity: fadeAnimation,
                      child: Image.asset(
                        AppImage.bg1,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Positioned.fill(
                    top: animation.value,
                    child: Transform.rotate(
                      angle: -0.1,
                      child: Image.asset(AppImage.coffeeCup1),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const Spacer(),
        const Text(
          'All You Need Coffee',
          style: TextStyle(
            color: AppColor.kE8B35A,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 1.2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: const Text(
            'The flavour that brings life to your body in the morning',
            style: TextStyle(
              color: AppColor.white,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _SecondView extends StatefulWidget {
  const _SecondView();

  @override
  State<_SecondView> createState() => __SecondViewState();
}

class __SecondViewState extends State<_SecondView>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = Tween<double>(begin: -1000.0, end: -70.0).animate(controller);
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 100.w / (100.w * 1.29),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: fadeAnimation,
                builder: (context, child) {
                  return Positioned.fill(
                    top: -50 + (fadeAnimation.value * 50),
                    child: FadeTransition(
                      opacity: fadeAnimation,
                      child: Image.asset(
                        AppImage.bg2,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  return Positioned.fill(
                    top: animation.value,
                    child: Transform.rotate(
                      angle: -0.15,
                      child: Image.asset(AppImage.coffeeCup2),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const Spacer(),
        const Text(
          'Unicorn Dark9',
          style: TextStyle(
            color: AppColor.kE8B35A,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 1.2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: const Text(
            'Coffee cups set vector top view different types of coffee',
            style: TextStyle(
              color: AppColor.white,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _ThirdView extends StatefulWidget {
  const _ThirdView();

  @override
  State<_ThirdView> createState() => __ThirdViewState();
}

class __ThirdViewState extends State<_ThirdView> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController rotationController;
  late Animation<double> animation;
  late Animation<double> fadeAnimation;
  late Animation<double> rotationAnimation;

  @override
  void initState() {
    super.initState();
    rotationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    rotationAnimation =
        CurvedAnimation(parent: rotationController, curve: Curves.linear);
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animation = Tween<double>(begin: -1000.0, end: -70.0).animate(controller);
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
    rotationController.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AspectRatio(
          aspectRatio: 100.w / (100.w * 1.29),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: fadeAnimation,
                builder: (context, child) {
                  return Positioned.fill(
                    child: FadeTransition(
                      opacity: fadeAnimation,
                      child: Image.asset(
                        AppImage.bg3,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  );
                },
              ),
              Positioned.fill(
                child: Transform.scale(
                  scale: 0.93,
                  child: RotationTransition(
                    turns: rotationAnimation,
                    child: Image.asset(AppImage.coffeeCup3),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        const Text(
          'Life happens, coffee helps',
          style: TextStyle(
            color: AppColor.kE8B35A,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 1.2.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: const Text(
            'May your coffee be strong and your Monday be short` Sip sip, hooray!',
            style: TextStyle(
              color: AppColor.white,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
