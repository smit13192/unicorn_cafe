import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/images/app_image.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/utils/formz_status.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/features/auth/googlelogin/bloc/google_login_bloc.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';

class GoogleLoginScreen extends StatelessWidget {
  const GoogleLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GoogleLoginBloc(
        firebaseAuthService:
            RepositoryProvider.of<FirebaseAuthService>(context),
      ),
      child: const _GoogleLoginView(),
    );
  }
}

class _GoogleLoginView extends StatelessWidget {
  const _GoogleLoginView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleLoginBloc, GoogleLoginState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoute.homeScreen, (route) => false);
        } else if (state.status.isFailed) {
          Fluttertoast.showToast(msg: state.error);
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppImage.googleLogin,
                fit: BoxFit.fitWidth,
              ),
              const Text(
                'Get The Best Caffee In Town!',
                style: TextStyle(
                  color: AppColor.kE8B35A,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5.50.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.registerScreen,
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        side: MaterialStateProperty.all(
                          BorderSide.none,
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 8.5.w,
                            vertical: 2.h,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.loginScreen,
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                        side: MaterialStateProperty.all(
                          const BorderSide(color: AppColor.kE8B35A),
                        ),
                        padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(
                            horizontal: 8.5.w,
                            vertical: 2.h,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<GoogleLoginBloc>().add(GoogleLoginEvent());
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide.none,
                    ),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        horizontal: 8.5.w,
                        vertical: 1.5.h,
                      ),
                    ),
                  ),
                  icon: const Icon(
                    FontAwesomeIcons.google,
                    size: 35,
                    color: AppColor.white,
                  ),
                  label: const Text(
                    'Continue With Google',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
