import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading/screen_loading_controller.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/images/app_image.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/utils/formz_status.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/features/auth/googlelogin/bloc/google_login_bloc.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';
import 'package:unicorn_cafe/src/widget/app_button.dart';
import 'package:unicorn_cafe/src/widget/gap.dart';

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
        if (state.status.isLoading) {
          ScreenLoadingController.instance.show(context);
        } else {
          ScreenLoadingController.instance.hide();
        }
        if (state.status.isSuccess) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(AppRoute.homeScreen, (route) => false);
        } else if (state.status.isFailed) {
          Fluttertoast.showToast(msg: state.error);
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.scaffoldBackgroundColor,
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
                  color: AppColor.primaryColor,
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
                    Expanded(
                      child: AppButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoute.registerScreen,
                          );
                        },
                        text: 'Sigh Up',
                      ),
                    ),
                    const GapW(5),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoute.loginScreen,
                            );
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                width: 2,
                                color: AppColor.primaryColor,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'Sigh In',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: AppColor.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
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
                child: Material(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(30),
                  child: InkWell(
                    onTap: () {
                      context.read<GoogleLoginBloc>().add(GoogleLoginEvent());
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: const SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.google,
                            size: 27,
                            color: AppColor.white,
                          ),
                          GapW(2.5),
                          Text(
                            'Continue With Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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
