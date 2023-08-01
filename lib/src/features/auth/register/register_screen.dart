import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading/screen_loading_controller.dart';
import 'package:unicorn_cafe/src/config/color/app_color.dart';
import 'package:unicorn_cafe/src/config/router/app_router.dart';
import 'package:unicorn_cafe/src/config/utils/formz_status.dart';
import 'package:unicorn_cafe/src/config/utils/size_extension.dart';
import 'package:unicorn_cafe/src/features/auth/register/bloc/register_bloc.dart';
import 'package:unicorn_cafe/src/services/firebase_auth_services.dart';
import 'package:unicorn_cafe/src/widget/app_button.dart';
import 'package:unicorn_cafe/src/widget/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        firebaseAuthService: context.read<FirebaseAuthService>(),
      ),
      child: _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  _RegisterView();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.keyboard_arrow_left,
              color: AppColor.primaryColor,
              size: 30,
            ),
          ),
          title: const Text(
            'Sign Up',
            style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (notification) {
            notification.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.5.w),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _FullNameTextField(),
                    const GapH(3.5),
                    const _EmailTextField(),
                    const GapH(3.5),
                    const _MobileNumberTextField(),
                    const GapH(3.5),
                    const _PasswordTextField(),
                    const GapH(3.5),
                    const _ConfirmPasswordTextField(),
                    const GapH(5),
                    AppButton(
                      text: 'Sign up',
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          context
                              .read<RegisterBloc>()
                              .add(RegisterSubmitEvent());
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FullNameTextField extends StatelessWidget {
  const _FullNameTextField();

  @override
  Widget build(BuildContext context) {
    context.select((RegisterBloc bloc) => bloc.state.username);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.text,
      onChanged: (value) {
        context.read<RegisterBloc>().add(UsernameChangedEvent(value.trim()));
      },
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Enter valid username';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Enter Username',
      ),
    );
  }
}

class _EmailTextField extends StatelessWidget {
  const _EmailTextField();

  @override
  Widget build(BuildContext context) {
    context.select((RegisterBloc bloc) => bloc.state.email);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        context.read<RegisterBloc>().add(EmailChangedEvent(value.trim()));
      },
      validator: (value) {
        final regExp = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
        );
        if (value == null || !regExp.hasMatch(value)) {
          return 'Enter valid email';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Enter Email',
      ),
    );
  }
}

class _MobileNumberTextField extends StatelessWidget {
  const _MobileNumberTextField();

  @override
  Widget build(BuildContext context) {
    context.select((RegisterBloc bloc) => bloc.state.phoneNo);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
      onChanged: (value) {
        context.read<RegisterBloc>().add(PhoneNoChangedEvent(value.trim()));
      },
      validator: (value) {
        final regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10}$)');
        if (value == null || !regExp.hasMatch(value)) {
          return 'Enter valid phone no';
        }
        return null;
      },
      decoration: const InputDecoration(
        hintText: 'Enter Mobile Number',
      ),
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  const _PasswordTextField();

  @override
  Widget build(BuildContext context) {
    context.select((RegisterBloc bloc) => bloc.state.password);
    bool obscureText =
        context.select((RegisterBloc bloc) => bloc.state.passwordObscureText);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      onChanged: (value) {
        context.read<RegisterBloc>().add(PasswordChangedEvent(value.trim()));
      },
      validator: (value) {
        if (value == null || value.contains(' ')) {
          return 'Enter valid password';
        } else if (value.length < 8) {
          return 'Password length must be greater than 8';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter Password',
        suffixIcon: IconButton(
          onPressed: () {
            context.read<RegisterBloc>().add(PasswordToggleEvent());
          },
          icon: obscureText
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
      ),
    );
  }
}

class _ConfirmPasswordTextField extends StatelessWidget {
  const _ConfirmPasswordTextField();

  @override
  Widget build(BuildContext context) {
    context.select((RegisterBloc bloc) => bloc.state.confirmPassword);
    bool obscureText = context
        .select((RegisterBloc bloc) => bloc.state.confirmPasswordObscureText);
    String password =
        context.select((RegisterBloc bloc) => bloc.state.password);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      onChanged: (value) {
        context
            .read<RegisterBloc>()
            .add(ConfirmPasswordChangedEvent(value.trim()));
      },
      validator: (value) {
        if (value != password) {
          return 'Password is not match';
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: 'Enter Confirm Password',
        suffixIcon: IconButton(
          onPressed: () {
            context.read<RegisterBloc>().add(ConfirmPasswordToggleEvent());
          },
          icon: obscureText
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
      ),
    );
  }
}
